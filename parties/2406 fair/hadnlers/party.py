import ujson
import random

from houdini import handlers
from houdini.data.penguin import Penguin
from houdini.handlers import XTPacket
from houdini.handlers.play.navigation import handle_join_player_room, handle_join_room, handle_join_server
from datetime import datetime, timedelta

CookieHandlerId = 20150501

CookieHandlerName = "fair"
PartyCacheCurrent = "fair2024" #if you have a repeated party, it is advisable to make a different name every time


StartParty = datetime(2023, 3, 7, 00, 00, 0)#date[year month day hour minute sec] for start party
EndParty = datetime(2026, 3, 23, 00, 00, 0)#date[year month day hour minute sec] for end party

DefaultPartyCookie = {
    'msgViewedArray': [0] * 2,
    'tickets': [0] * 1,
    'silverTicket': [0] * 1,
    'spinDayIndex': 0,
    'resetSpin': 0
}

#wheel prize
Type_prize = list( { 'TICKET', 'COIN', 'SPIN', 'SILVER' } )
Ticket = list( { 75, 100, 150, 750 } )
Coin = list( { 250, 500 } )


# item reward
ItemCost = {
    1481: 1500,
    1177: 1500,
    5417: 1500,
    970: 500,

    1302: 1000,
    350: 1500,
    7032: 500,
    486: 3000,
    5416: 3000,

    3087: 3000,
    5415: 3000,
    14437: 5000,
    2002: 1500,

    5006: 1000,
    5414: 1000,
    2168: 1000,
    9108: 500,

    4421: 5000,
    5077: 1000,
    3178: 5000,
    5367: 5000,

    3149: 10000,
    591: 500,
    1996: 10000
}
PuffleItemCost = {
    148: 2000,
    147: 2000,
    82: 2000,
    159: 2000,
    93: 2000
}
IglooItemCost = {
    29: 7500
}
LocationItemCost = {
    12: 7500
}

@handlers.handler(XTPacket(CookieHandlerName, 'ftransform'))
async def handle_party_transformation(p, transform_id: int):
    p.avatar = transform_id
    await p.room.send_xt('spts', p.id, transform_id)


@handlers.handler(XTPacket(CookieHandlerName, 'partycookie'))
async def handle_party_cookie(p):
    cookie = await p.server.redis.hget(PartyCacheCurrent, p.id)
    if cookie is None:
        cookie = ujson.dumps(DefaultPartyCookie)
        await p.server.redis.hset(PartyCacheCurrent, p.id, cookie)
    else:
        cookie = cookie.decode('utf-8')
    await p.send_xt('partycookie', cookie)


@handlers.handler(XTPacket(CookieHandlerName, 'fmsgviewed'))
async def handle_party_message_viewed(p, message_index: int):
    cookie = await p.server.redis.hget(PartyCacheCurrent, p.id)
    cookie = ujson.loads(cookie)
    
    cookie['msgViewedArray'][message_index] = 1
    
    await p.server.redis.hset(PartyCacheCurrent, p.id, ujson.dumps(cookie))
    
    newPartyCookie = await p.server.redis.hget(PartyCacheCurrent, p.id)
    newPartyCookie = newPartyCookie.decode('utf-8')
    
    await p.send_xt('partycookie', newPartyCookie)


@handlers.handler(XTPacket(CookieHandlerName, 'qcmsgviewed'))
async def handle_party_communicator_message_viewed(p, message_index: int):
    cookie = await p.server.redis.hget(PartyCacheCurrent, p.id)
    cookie = ujson.loads(cookie)
    
    cookie['communicatorMsgArray'][message_index] = 1
    
    await p.server.redis.hset(PartyCacheCurrent, p.id, ujson.dumps(cookie))
    
    newPartyCookie = await p.server.redis.hget(PartyCacheCurrent, p.id)
    newPartyCookie = newPartyCookie.decode('utf-8')
    
    await p.send_xt('partycookie', newPartyCookie)


@handlers.handler(XTPacket(CookieHandlerName, 'qtaskcomplete'))
async def handle_party_task_complete(p, task_index: int):
    cookie = await p.server.redis.hget(PartyCacheCurrent, p.id)
    cookie = ujson.loads(cookie)
    
    cookie['questTaskStatus'][task_index] = 1
    
    await p.server.redis.hset(PartyCacheCurrent, p.id, ujson.dumps(cookie))
    
    newPartyCookie = await p.server.redis.hget(PartyCacheCurrent, p.id)
    newPartyCookie = newPartyCookie.decode('utf-8')
    
    await p.send_xt('partycookie', newPartyCookie)
    

@handlers.handler(XTPacket(CookieHandlerName, 'fendgame'))
async def handle_party_endgame(p, tickets: int):
    cookie = await p.server.redis.hget(PartyCacheCurrent, p.id)
    cookie = ujson.loads(cookie)
    
    cookie['tickets'][0] += tickets
    
    await p.server.redis.hset(PartyCacheCurrent, p.id, ujson.dumps(cookie))
    
    newPartyCookie = await p.server.redis.hget(PartyCacheCurrent, p.id)
    newPartyCookie = newPartyCookie.decode('utf-8')
    
    await p.send_xt('partycookie', newPartyCookie)


@handlers.handler(XTPacket(CookieHandlerName, 'fstartgame'))
async def handle_party_startgame(p, game_id: int):
    cookie = await p.server.redis.hget(PartyCacheCurrent, p.id)
    cookie = ujson.loads(cookie)
    
    #if cookie['resetSpin'] == 0:
        #cookie['spinDayIndex'] = 0
        #cookie['resetSpin'] = 1

    cookie['spinDayIndex'] = 0
    await p.server.redis.hset(PartyCacheCurrent, p.id, ujson.dumps(cookie))
    
    newPartyCookie = await p.server.redis.hget(PartyCacheCurrent, p.id)
    newPartyCookie = newPartyCookie.decode('utf-8')
    
    await p.send_xt('partycookie', newPartyCookie)

@handlers.handler(XTPacket('zo', ext='z'))
@handlers.player_in_room(961)
async def handle_bounce_end_game(p, tickets: int):
    cookie = await p.server.redis.hget(PartyCacheCurrent, p.id)
    cookie = ujson.loads(cookie)
    
    cookie['tickets'][0] += tickets
    p.logger.info(f"added {tickets} tickets from bounce")
    
    await p.server.redis.hset(PartyCacheCurrent, p.id, ujson.dumps(cookie))
    
    newPartyCookie = await p.server.redis.hget(PartyCacheCurrent, p.id)
    newPartyCookie = newPartyCookie.decode('utf-8')
    
    await p.send_xt('partycookie', newPartyCookie)


@handlers.handler(XTPacket(CookieHandlerName, 'fawardtickets'))
async def handle_party_award_ticket(p, tickets: int):
    cookie = await p.server.redis.hget(PartyCacheCurrent, p.id)
    cookie = ujson.loads(cookie)
    
    cookie['tickets'][0] += 1
    
    await p.server.redis.hset(PartyCacheCurrent, p.id, ujson.dumps(cookie))
    
    newPartyCookie = await p.server.redis.hget(PartyCacheCurrent, p.id)
    newPartyCookie = newPartyCookie.decode('utf-8')
    
    await p.send_xt('partycookie', newPartyCookie)


@handlers.handler(XTPacket(CookieHandlerName, 'fdailyspin'))
async def handle_party_daily_spin(p, tickets: int):
    cookie = await p.server.redis.hget(PartyCacheCurrent, p.id)
    cookie = ujson.loads(cookie)
    rPrize_type = random.choice(Type_prize)
    rTicket = random.choice(Ticket)
    rCoin = random.choice(Coin)

    if rPrize_type == 'TICKET':
        await p.send_xt('fdailyspin', 'TICKET', rTicket, rTicket)
        cookie['tickets'][0] += rTicket
    elif rPrize_type == 'COIN':
        await p.send_xt('fdailyspin', 'COIN', rCoin, rCoin)
        await p.update(coins=p.coins + rCoin).apply()
        await p.send_xt('cdu', p.coins + rCoin, p.coins + rCoin)
    elif rPrize_type == 'SPIN':
        await p.send_xt('fdailyspin', 'SPIN', 1, 1)
        cookie['tickets'][0] += 50
    elif rPrize_type == 'SILVER':
        await p.send_xt('fdailyspin', 'SILVER', 1, 1)
        await p.update(coins=p.coins + 1000).apply()
        await p.send_xt('cdu', p.coins + 1000, p.coins + 1000)
        cookie['silverTicket'][0] += 1
    
    await p.server.redis.hset(PartyCacheCurrent, p.id, ujson.dumps(cookie))
    
    newPartyCookie = await p.server.redis.hget(PartyCacheCurrent, p.id)
    newPartyCookie = newPartyCookie.decode('utf-8')
    
    await p.send_xt('partycookie', newPartyCookie)


@handlers.handler(XTPacket(CookieHandlerName, 'fusetickets'))
async def handle_party_useticket(p, item_id: int, type: str):
    cookie = await p.server.redis.hget(PartyCacheCurrent, p.id)
    cookie = ujson.loads(cookie)
    itemTypeCost = ItemCost
    if type == "puffle":
        itemTypeCost = PuffleItemCost
    elif type == "igloo":
        itemTypeCost = IglooItemCost
    elif type == "location":
        itemTypeCost = LocationItemCost

    if item_id not in itemTypeCost or int(cookie['tickets'][0]) <= 0 or int(cookie['tickets'][0]) < itemTypeCost[item_id]: return False
    
    p.logger.info(f'award item {item_id} ({type}) cost= \'{itemTypeCost[item_id]}\'')
    if type == "item" and item_id in itemTypeCost:
        await p.add_inventory(p.server.items[item_id], cost=0)
    elif type == "puffle" and item_id in itemTypeCost:
        await p.add_puffle_item(p.server.puffle_items[item_id], cost=0)
    elif type == "igloo" and item_id in itemTypeCost:
        await p.add_igloo(p.server.igloos[item_id], cost=0)
    elif type == "location" and item_id in itemTypeCost:
        await p.add_location(p.server.locations[item_id], cost=0)
    cookie['tickets'][0] -= itemTypeCost[item_id]
    await p.server.redis.hset(PartyCacheCurrent, p.id, ujson.dumps(cookie))
    
    newPartyCookie = await p.server.redis.hget(PartyCacheCurrent, p.id)
    newPartyCookie = newPartyCookie.decode('utf-8')
    
    await p.send_xt('partycookie', newPartyCookie)


@handlers.handler(XTPacket('j', 'js'), after= handle_join_server)
@handlers.allow_once
async def handle_get_partysettings(p):
    await p.send_xt('activefeatures', 20150501)
    cookie = await p.server.redis.hget(PartyCacheCurrent, p.id)
    if cookie is None:
        cookie = ujson.dumps(DefaultPartyCookie)
        await p.server.redis.hset(PartyCacheCurrent, p.id, cookie)
    else:
        cookie = cookie.decode('utf-8')
    await p.send_xt('partycookie', cookie)
    await p.send_xt('partyservice', '{"partySettings":{"unlockDayIndex":16,"numOfDaysInParty":16},"partyStartDate":"' + str(StartParty) + '","partyEndDate":"' + str(EndParty) + '"}')
