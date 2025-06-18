import ujson
import random
import asyncio


from houdini import handlers
from houdini.penguin import Penguin
from houdini.handlers import XTPacket
from houdini.constants import ClientType
from houdini.data.pet import PuffleItem
from houdini.data.item import Item
from houdini.data.igloo import Location, Furniture
from houdini.handlers.play.navigation import handle_join_server
from houdini.handlers.play.avatar import handle_player_transformation
from houdini.handlers.play.player import handle_set_player_frame, handle_send_emote
from datetime import datetime, timedelta

from dataclasses import dataclass
# CONSTANTS

COOKIE_HANDLER_ID = "20141101"

START_PARTY = datetime(2023, 5, 1, 11, 00, 0)#date[year month day hour minute sec] for start party
END_PARTY = datetime(2026, 7, 28, 23, 59, 59)#date[year month day hour minute sec] for end party

COOKIE_HANDLER_NAME = "pirate"
PARTY_CACHE_CURRENT = "pirate2014"


DEFAULT_PARTY_COOKIE = {
    'msgViewedArray': [0] * 8,
    'questTaskStatus': [0] * 12,
    'qcMsgViewedArray': [0] * 20,
    'points': 0
}
PARTY_COOKIE_COMMAND = "partycookie" # done
PARTY_SETTINGS_RESPONSE_NAME = "partyservice" # done
MESSAGE_VIEWED_COMMAND = "msgviewed" # done
QC_MESSAGE_VIEWED_COMMAND = "qcmsgviewed" # done 
COLLECT_SWORD_REWARD_COMMAND = "collectswordreward" # done
COLLECT_QUEST_ITEM_COMMAND = "collectquestitem" # done

FREE_ITEMS = [
    
5495, 5496, 5497, 5498, 5499,
24227, 1948, 5500, 5502, 5503, 6241, 5504, 24228, 1949, 6242, 5501,
24230, 1950
]

# END OF CONSTANTS

def total_day_party():#this is the number of days already passed in the party
    return (datetime.now() - START_PARTY).days

@handlers.handler(XTPacket(COOKIE_HANDLER_NAME, PARTY_COOKIE_COMMAND))
async def handle_party_cookie(p):
    await send_party_cookie(p)
    
@handlers.handler(XTPacket(COOKIE_HANDLER_NAME, COLLECT_SWORD_REWARD_COMMAND))
async def collect_coin_reward(p, id: int):
    id -= 1
    if id not in COINS_REWARDS or COINS_REWARDS[id]['points'] > p.cookie['points'] or p.cookie['questTaskStatus'][id+7]:
        return
    
    coins = COINS_REWARDS[id]['coins']
    p.cookie['questTaskStatus'][id+7] = 1
    await p.update(coins=p.coins + coins).apply()
    await p.send_xt(COLLECT_SWORD_REWARD_COMMAND, p.coins)
    await send_party_cookie(p)
    
    
@handlers.handler(XTPacket(COOKIE_HANDLER_NAME, MESSAGE_VIEWED_COMMAND))
async def handle_party_message_viewed(p, message_index: int):
    p.cookie['msgViewedArray'][message_index] = 1
    await send_party_cookie(p)

@handlers.handler(XTPacket(COOKIE_HANDLER_NAME, COLLECT_QUEST_ITEM_COMMAND))
async def handle_party_task_complete(p, task_index: int):
    p.cookie['questTaskStatus'][task_index] = 1
    await send_party_cookie(p)

@handlers.handler(XTPacket(COOKIE_HANDLER_NAME, QC_MESSAGE_VIEWED_COMMAND))
async def handle_view_notification(p, notification_index: int):
    if len(p.cookie['qcMsgViewedArray']) < len(DEFAULT_PARTY_COOKIE['qcMsgViewedArray']):
        while len(p.cookie['qcMsgViewedArray']) < len(DEFAULT_PARTY_COOKIE['qcMsgViewedArray']):
            p.cookie['qcMsgViewedArray'].append(0)
    p.cookie['qcMsgViewedArray'][notification_index] = 1
    await send_party_cookie(p)


async def send_party_cookie(p):
    await p.server.redis.hset(PARTY_CACHE_CURRENT, p.id, ujson.dumps(p.cookie))
    await p.send_xt('partycookie', ujson.dumps(p.cookie))
    


"""
    1v1 Battle
"""
@dataclass
class Dueler:
    penguin: Penguin
    option: int = 0


    
RuleSet = {0: 1, 1: 2, 2: 0}
class PirateDuels:


    def __init__(self, p, game_id):
        self.server = p.server
        
        self.ingame = False
        self.creator_id = p.id
        self.game_id = game_id
        self.participant_id = None
        self.room_id = p.room.id
        
        self.duellers = [Dueler(penguin=p)]
        
        
    async def init(self):
        await self.send_xt(SERVER_COMMAND_OPEN, self.creator_id)
        
    async def select(self, p, option):
        dueller = self.get_dueller(p)
        dueller.option = option
    
    def get_dueller(self, p):
        for score in self.duellers:
            if score.penguin == p:
                return score
    
    def get_opponent(self, d):
        for dueller in self.duellers:
            if d != dueller:
                return dueller
        
    async def join(self, p):
        if self.get_dueller(p) is not None or self.ingame:
            return
        
        self.duellers.append(Dueler(penguin=p))
        self.participant_id = p.id
        p.battle = self
        await self.start()
        
    async def start(self):
        self.ingame = True	
        await self.send_command(SERVER_COMMAND_JOIN, *self.to_list_string())
        
        loop = asyncio.get_event_loop()
        loop.call_later(8, lambda: asyncio.ensure_future(self.game_over()))
        
        
    async def leave(self, p):
        self.duellers.remove(self.get_dueller(p))
        p.battle = None
        if len(self.duellers) <= 1:
            await self.disband(True)
            
        
    async def game_over(self):
        creator = self.duellers[0]
        challenger = self.duellers[1]
        

        is_creator_winner = self.get_winner(creator, challenger)
        
        creator_points = 20 if is_creator_winner == 0 else 10
        challenger_points = 20 if is_creator_winner == 1 else 10
        
        await self.send_command(SERVER_COMMAND_RESULT, *self.to_string())

        challenger.penguin.cookie['points'] += challenger_points
        creator.penguin.cookie['points'] += creator_points

        await send_party_cookie(creator.penguin)
        await send_party_cookie(challenger.penguin)
        await self.disband()
    
    def get_winner(self, creator, challenger):
        if creator.option != challenger.option:
            """
                RuleSet[HI] == MID (true)
                RuleSet[MID] == LOW (true)
                RuleSet[LOW] == HI (true)
            """
            return 0 if RuleSet[creator.option] == challenger.option else 1
        else:
            return 2
        
    async def disband(self, cancelled=False):
        if len(self.duellers) == 1 and not self.ingame or cancelled: 
            await self.send_command(SERVER_COMMAND_CANCEL, self.creator_id)
            
        if len(self.duellers) != 1 and not self.ingame: 
            await self.send_command(SERVER_COMMAND_CLOSE, self.creator_id, self.participant_id)

        for dueller in self.duellers:
            dueller.penguin.battle = None

        self.duellers.clear()
        del self.server.battles_in_room[self.room_id][self.game_id]
        del self.server
        
    async def send_command(self, cmd, *args):
        await self.send_xt(cmd, *args)
    
    async def send_xt(self, *args):
        await self.server.rooms[self.room_id].send_xt(*args)
        
    async def send_players_xt(self, *args):
        for dueller in self.duellers:
            await dueller.penguin.send_xt(*args)
        
    def to_string(self):
        for d in self.duellers:
            winner = self.get_winner(d, self.get_opponent(d))
            points = 20 if winner == 0 else 10
            yield ','.join(map(str, [d.penguin.id,d.option,winner,points]))
    
    def to_list_string(self):
        return map(str, [self.creator_id, self.participant_id, 8000, self.game_id])

    
SERVER_COMMAND_LIST = "pirateopenlist"
SERVER_COMMAND_INGAME_LIST = "pirateongoingduels"
SERVER_COMMAND_JOIN = "piratejoin"
SERVER_COMMAND_OPEN = "pirateopen"
SERVER_COMMAND_START = "piratestart"
SERVER_COMMAND_SELECT = "pirateselect"
SERVER_COMMAND_RESULT = "pirateresult"
SERVER_COMMAND_CANCEL = "piratecancel"
SERVER_COMMAND_CLOSE = "pirateclose"

GAME_ID = 0


@handlers.handler(XTPacket('u', 'sf'))
async def close_matchmaking_update_frame(p):
    if p.battle and not is_sword_equipped(p):
        await p.battle.disband()


@handlers.handler(XTPacket('u', 'sp'))
async def close_battle_on_move(p):
    if p.battle:
        await p.battle.leave(p)

async def send_players_list(p):
    room = p.room.id
    games = p.server.battles_in_room.get(room)
    if games is None:
        games = p.server.battles_in_room[room] = {}
    
    invitation_games = []
    ingame_games = []
    
    for game_id, game in games.items():
        if not game.ingame:
            invitation_games.append(game.creator_id)
            continue
        ingame_games.append(','.join(game.to_list_string()))
    
    await p.send_xt(SERVER_COMMAND_LIST, '|'.join(map(str, invitation_games)))
    await p.send_xt(SERVER_COMMAND_INGAME_LIST, '|'.join(ingame_games))

    
@handlers.handler(XTPacket('j', 'crl'))
async def handle_client_room_loaded(p):
    if p.battle:
        await p.battle.leave(p)
    await send_players_list(p)
    

@handlers.handler(XTPacket(COOKIE_HANDLER_NAME, SERVER_COMMAND_OPEN))
async def handle_create_game_session(p):
    if p.battle is not None:
        return
    p.server.game_id  += 1
    p.battle = p.server.battles_in_room[p.room.id][p.server.game_id] = PirateDuels(p, p.server.game_id)
    await p.battle.init()
    
@handlers.handler(XTPacket(COOKIE_HANDLER_NAME, SERVER_COMMAND_CLOSE))
async def handle_close_matchmaking(p):
    if p.battle is None:
        return
    await p.battle.leave(p)
    
@handlers.handler(XTPacket(COOKIE_HANDLER_NAME, SERVER_COMMAND_CANCEL))
async def handle_cancel_matchmaking(p):
    if p.battle is None:
        return
    await p.battle.disband()
    
@handlers.handler(XTPacket(COOKIE_HANDLER_NAME, SERVER_COMMAND_SELECT))
async def handle_select_attack(p, option: int):
    if p.battle is None:
        return
    await p.battle.select(p, option)
    
@handlers.handler(XTPacket(COOKIE_HANDLER_NAME, SERVER_COMMAND_JOIN))
async def handle_join_matchmaking(p, host_id: int):
    if p.battle is not None:
        return
    penguin = p.server.penguins_by_id.get(host_id)
    
    if penguin is None or penguin.battle is None:
        return
    await penguin.battle.join(p)
        

@handlers.disconnected
@handlers.player_attribute(joined_world=True)
async def handle_user_disconnected(p):
    if p.battle is None:
        return
    await p.battle.leave(p)
        
@handlers.boot
async def on_server_boot(server):
    server.game_id = 0
    server.battles_in_room = {}
    for room in server.rooms:
        server.battles_in_room[room] = {}
    for item in FREE_ITEMS:
        server.items[item].cost = 0
        server.items[item].patched = False

def is_sword_equipped(p):
    hand = p.hand or 0
    for sword in PARTY_SETTINGS['swordsList']:
        if sword['swordId'] == hand:
            return True
    return False
        
COINS_REWARDS = {
    0: {
        "coins": 50,
        "points": 100
    },
    1: {
        "coins": 100,
        "points": 200
    },
    2:{
        "coins": 150,
        "points": 300
    },
    3:{
        "coins": 200,
        "points": 400
    }
}     
PARTY_SETTINGS = {
    "partySettings": {
        "partyIglooItems": [0],
        "unlockDayIndex": 0,
        "numOfDaysInParty": 14
    },
    "questSettingList": [{
            "roomId": 400,
            "questItemIndex": 0,
            "unlockDay": 0,
            "memberItemId": 24227,
            "nonmemberItemId": 1948
        }, {
            "roomId": 800,
            "questItemIndex": 1,
            "unlockDay": 1,
            "memberItemId": 5500,
            "nonmemberItemId": 5502
        }, {
            "roomId": 100,
            "questItemIndex": 2,
            "unlockDay": 2,
            "memberItemId": 159,
            "nonmemberItemId": 5503
        }, {
            "roomId": 801,
            "questItemIndex": 3,
            "unlockDay": 3,
            "memberItemId": 6241,
            "nonmemberItemId": 5504
        }, {
            "roomId": 300,
            "questItemIndex": 4,
            "unlockDay": 4,
            "memberItemId": 24228,
            "nonmemberItemId": 1949
        }, {
            "roomId": 809,
            "questItemIndex": 5,
            "unlockDay": 5,
            "memberItemId": 24229,
            "nonmemberItemId": 2315
        }, {
            "roomId": 810,
            "questItemIndex": 6,
            "unlockDay": 6,
            "memberItemId": 6242,
            "nonmemberItemId": 5501
        }
    ],
    "finalRewards": {
        "points": 500,
        "memberItemId": 24230,
        "nonMemberItemId": 1950
    },
    "swordsList": [{
            "swordId": 0,
            "points": 0,
            "itemId": 5495
        }, {
            "swordId": 1,
            "points": 100,
            "itemId": 5496
        }, {
            "swordId": 2,
            "points": 200,
            "itemId": 5497
        }, {
            "swordId": 3,
            "points": 300,
            "itemId": 5498
        }, {
            "swordId": 4,
            "points": 400,
            "itemId": 5499
        }
    ],
    "piratePuffleReward": 159,
    "pirateFurnitureReward": 2315
}

PARTY_SETTINGS["numofquest"] = len(PARTY_SETTINGS['questSettingList'])




@handlers.handler(XTPacket('j', 'js'), after= handle_join_server)
@handlers.allow_once
async def handle_get_partysettings(p):
    if (datetime.now() < END_PARTY):#check enabled party, if the current datatime has exceeded the end of the party, then do not start
        PARTY_SETTINGS['partySettings']['unlockDayIndex'] = total_day_party()
        await p.send_xt('partyservice', ujson.dumps(PARTY_SETTINGS))
        await send_party_cookie(p)
   

@handlers.handler(XTPacket('j', 'js'), before= handle_join_server, pre_login=True)
@handlers.allow_once
async def handle_load_party_cookie(p):
    if (datetime.now() < END_PARTY):#check enabled party, if the current datatime has exceeded the end of the party, then do not start
        cookie = await p.server.redis.hget(PARTY_CACHE_CURRENT, p.id)
        if cookie is None:
            p.cookie = DEFAULT_PARTY_COOKIE
            cookie = ujson.dumps(p.cookie)
            await p.server.redis.hset(PARTY_CACHE_CURRENT, p.id, cookie)

        p.cookie = ujson.loads(cookie)

        await p.send_xt('activefeatures', COOKIE_HANDLER_ID)

@handlers.handler(XTPacket('j', 'js'), after= handle_get_partysettings)
@handlers.allow_once
async def handle_set_party_variables(p):
    p.battle = None
    