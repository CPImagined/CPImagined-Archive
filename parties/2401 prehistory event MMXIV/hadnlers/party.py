import ujson
import time
import random
import asyncio

from houdini import handlers
from houdini.constants import ClientType
from houdini.handlers import XTPacket

from houdini.handlers.play.navigation import handle_join_player_room, handle_join_room, handle_join_server
from houdini.handlers.play.avatar import handle_player_transformation
from houdini.handlers.play.setting import handle_send_update_player_hand

from houdini.handlers.games.table import handle_join_room_table
from houdini.handlers.games.dinodig import DinoDigLogic

from houdini.handlers.play.igloo import get_layout_like_count
from houdini.data.igloo import IglooLike, IglooFurniture
from houdini.data.item import Item
from datetime import datetime, timedelta

COOKIE_HANDLER_PARTY = 20140101

START_PARTY = datetime(2022, 1, 1, 23, 00, 0)
END_PARTY = datetime(2025, 2, 4, 23, 59, 59)

COOKIE_HANDLER_NAME = "prehistoric"
PARTY_CACHE_CURRENT = "prehistoric2024"

DEFAULT_PARTY_COOKIE = {
    'msg': [0] * 5,
    'quest': [0] * 5,
    'trans': [0] * 20,
    'puff': [{"id":0,"state":0},{"id":1,"state":0},{"id":2,"state":0},{"id":3,"state":0},{"id":4,"state":0},{"id":5,"state":0}]
}



"""
    PUFFLE EGG IDS: 
        5408 => blue
        5409 => black
        5410 => pink
        5411 => red
        5412 => purple
        5413 => yellow
"""

PUFFLE_EGG_IDS = [5408, 5409, 5410, 5411, 5412, 5413]

PARTY_SETTINGS = {
    "day": 14, 
    "trans":[5406, 1764, 5405, 1765, 5402], 
    "puff": [5404, 5401, 1765, 5407, 5403, 1767], 
    "quests": []
}


@handlers.handler(XTPacket(COOKIE_HANDLER_NAME, 'prehistoricc'))
async def handle_party_cookie(p):
    await send_party_cookie(p)

@handlers.handler(XTPacket('s', 'upa'), overrides=[handle_send_update_player_hand])
@handlers.cooldown(1)
async def handle_send_update_player_hand_override(p, item_id: int):
    if item_id in PUFFLE_EGG_IDS:
        temp_item = Item(id=item_id, type=6, name="Egg")
        await p.set_hand(temp_item)
        return 
    
    item = p.server.items.get(item_id, None)
    
    if item is None or (item.id in p.inventory and item.is_hand()):
        await p.set_hand(item)
        
@handlers.handler(XTPacket(COOKIE_HANDLER_NAME, 'prehistorict'))
@handlers.cooldown(1)
async def handle_prehistoric_transform(p, transform_id: int):
    p.avatar = transform_id
    await p.room.send_xt('spts', p.id, transform_id)


@handlers.handler(XTPacket(COOKIE_HANDLER_NAME, 'prehistoricmsgviewed'))
async def handle_party_message_viewed(p, message_index: int):
    p.cookie['msg'][message_index] = 1
    await send_party_cookie(p)
    
@handlers.handler(XTPacket(COOKIE_HANDLER_NAME, 'prehistorictask'))
async def handle_task_finished(p, message_index: int):
    p.cookie['quest'][message_index] = 1
    await send_party_cookie(p)
    
@handlers.handler(XTPacket(COOKIE_HANDLER_NAME, 'prehistoricdinopuffleeggheated'))
async def handle_cook_puffle(p, message_index: int):
    try:
        p.cookie['puff'][PUFFLE_EGG_IDS.index(p.hand)]['state'] += 1
        await p.room.send_xt('prehistoricdinopuffleeggheated', p.id, p.cookie['puff'][PUFFLE_EGG_IDS.index(p.hand)]['state'] - 1)
        await send_party_cookie(p)
        
    except:
        pass


async def send_party_cookie(p):
    cookie = ujson.dumps(p.cookie)
    await p.server.redis.hset(PARTY_CACHE_CURRENT, p.id, cookie)
    await p.send_xt('prehistoricc', cookie)

@handlers.handler(XTPacket('j', 'js'), after= handle_join_server)
@handlers.allow_once
async def handle_get_partysettings(p, *args, **kwargs):
    cookie = await p.server.redis.hget(PARTY_CACHE_CURRENT, p.id)
    if cookie is None:
        p.cookie = DEFAULT_PARTY_COOKIE
        cookie = ujson.dumps(p.cookie)
        
        await p.server.redis.hset(PARTY_CACHE_CURRENT, p.id, cookie)

    p.cookie = ujson.loads(cookie)
    if (datetime.now() < END_PARTY):
        await p.send_xt('activefeatures', COOKIE_HANDLER_PARTY)
        await p.send_xt('prehistorics', ujson.dumps(PARTY_SETTINGS))
        await send_party_cookie(p)
        
import gc
        
class CustomRoomTable:

    def __init__(self):
        self.penguins = []
        self.room = None
        self.logic = None

    async def add_penguin(self, p):
        self.penguins.append(p)
        seat_id = len(self.penguins) - 1
        p.table = self

        return seat_id

    async def remove_penguin(self, p):
        seat_id = self.get_seat_id(p)
        is_player = seat_id < 2
        game_ready = len(self.penguins) > 1
        if is_player and game_ready:
            await self.reset()
        else:
            self.penguins.remove(p)
            p.table = None

    async def reset(self):
        for penguin in self.penguins:
            penguin.table = None
        self.logic = type(self.logic)()
        self.penguins = []

    def get_seat_id(self, p):
        return self.penguins.index(p)

    def get_string(self):
    
        player_one, = self.penguins
        return '%'.join([player_one.safe_name, player_one.safe_name, self.logic.get_string(), '1'])

    async def send_xt(self, *data):
        for penguin in self.penguins:
            await penguin.send_xt(*data)

   
# static var PARTY_SETTINGS_RESPONSE_NAME = "prehistorics"; - done



# static var MESSAGE_VIEWED_COMMAND = "prehistoricmsgviewed"; - done
# static var DINO_PUFFLE_EGG_HEATED = "prehistoricdinopuffleeggheated"; - done
# static var DINO_TRANSFORMATION_COMMAND = "prehistorict"; - done
# static var VOLCANO_STATUS_COMMAND = "volcanostatus"; - Done
# static var PREHISTORIC_SPAWN_COMMAND_NAME = "prehistoricjoin"; - done
# static var CP_SPAWN_COMMAND_NAME = "exitparty"; - done


@handlers.handler(XTPacket('j', 'jr'), before= handle_join_room_table)
async def handle_join_game(p, room_id: int): 
    if room_id == 961:
        table = CustomRoomTable()
        p.joined_dino = True
        table.room = p.server.rooms[961]
        table.logic = DinoDigLogic()
        await table.add_penguin(p)
    
    elif room_id == 865 or room_id == 866 or room_id == 867:
        await p.send_xt('volcanostatus', p.server.volcano_state)

@handlers.handler(XTPacket('j', 'exitparty'), before= handle_join_room_table)
async def handle_exit_party(p, room_id: int): 
    await p.join_room(p.server.rooms[801])


@handlers.handler(XTPacket(COOKIE_HANDLER_NAME, 'prehistoricjoin'))
async def handle_join_party(p, room_id: int): 
    await p.join_room(p.server.rooms[852])
    
    
@handlers.boot
async def server_boot(server):
    server.volcano_state = random.randrange(1, 5)
    server.lava_loop = asyncio.create_task(start_loop(server))


async def start_loop(server):
    while True:
        await server.rooms[865].send_xt('volcanostatus', server.volcano_state)
        await server.rooms[866].send_xt('volcanostatus', server.volcano_state)
        await server.rooms[867].send_xt('volcanostatus', server.volcano_state)
        server.volcano_state = random.randrange(1, 5)
        await asyncio.sleep(14)
