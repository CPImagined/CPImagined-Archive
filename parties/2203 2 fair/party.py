import ujson
import random

from houdini import handlers
from houdini.data.penguin import Penguin
from houdini.handlers import XTPacket
from houdini.handlers.play.navigation import handle_join_player_room, handle_join_room, handle_join_server
from datetime import datetime, timedelta

CookieHandlerId = 20150501

StartParty = datetime(2022, 3, 7, 00, 00, 0)#date[year month day hour minute sec] for start party
EndParty = datetime(2022, 3, 23, 00, 00, 0)#date[year month day hour minute sec] for end party

CookieHandlerName = "fair"
PartyCacheCurrent = "fair202008" #if you have a repeated party, it is advisable to make a different name every time

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

#item reward
ItemCost = {
   24295: 300,
   5525: 150,
   24297: 300,
   24298: 350,
   59: 400,
   21014: 200,
   21013: 200,
   5523: 75,
   5522: 75,
   1196: 75,
   3133: 200,
   148: 400,
   5524: 150,
   24296: 350,
   91: 400,
   21011: 100,
   2168: 100,
   5079: 50,
   328: 50,
   21012: 100
}


def TotalDayParty():#this is the number of days already passed in the party
    return (datetime.now() - StartParty).days

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
    if cookie['spinDayIndex'] > TotalDayParty(): return False
    rPrize_type = random.choice(Type_prize)
    rTicket = random.choice(Ticket)
    rCoin = random.choice(Coin)

    if rPrize_type == 'TICKET':
        await p.send_xt('fdailyspin', 'TICKET', rTicket, rTicket)
        cookie['tickets'][0] += rTicket
        cookie['spinDayIndex'] += 1
    elif rPrize_type == 'COIN':
        await p.send_xt('fdailyspin', 'COIN', rCoin, rCoin)
        await p.update(coins=p.coins + rCoin).apply()
        await p.send_xt('cdu', p.coins + rCoin, p.coins + rCoin)
        cookie['spinDayIndex'] += 1
    elif rPrize_type == 'SPIN':
        await p.send_xt('fdailyspin', 'SPIN', 1, 1)
        cookie['tickets'][0] += 5
    elif rPrize_type == 'SILVER':
        await p.send_xt('fdailyspin', 'SILVER', 1, 1)
        await p.update(coins=p.coins + 1000).apply()
        await p.send_xt('cdu', p.coins + 1000, p.coins + 1000)
        cookie['silverTicket'][0] += 1
        cookie['spinDayIndex'] += 1
    
    await p.server.redis.hset(PartyCacheCurrent, p.id, ujson.dumps(cookie))
    
    newPartyCookie = await p.server.redis.hget(PartyCacheCurrent, p.id)
    newPartyCookie = newPartyCookie.decode('utf-8')
    
    await p.send_xt('partycookie', newPartyCookie)


@handlers.handler(XTPacket(CookieHandlerName, 'fusetickets'))
async def handle_party_useticket(p, item_id: int):
    cookie = await p.server.redis.hget(PartyCacheCurrent, p.id)
    cookie = ujson.loads(cookie) 
    if int(cookie['tickets'][0]) <= 0 or int(cookie['tickets'][0]) < ItemCost[item_id]: return False
    
    p.logger.info(f'award item {item_id} cost= \'{ItemCost[item_id]}\'')
    if(item_id == 59 or item_id == 148 or item_id == 91):
     await p.add_puffle_item(p.server.puffle_items[item_id])
    else:
     await p.add_inventory(p.server.items[item_id], cost=0)
    cookie['tickets'][0] -= ItemCost[item_id]
    await p.server.redis.hset(PartyCacheCurrent, p.id, ujson.dumps(cookie))
    
    newPartyCookie = await p.server.redis.hget(PartyCacheCurrent, p.id)
    newPartyCookie = newPartyCookie.decode('utf-8')
    
    await p.send_xt('partycookie', newPartyCookie)


@handlers.handler(XTPacket('j', 'js'), after= handle_join_server)
@handlers.allow_once
async def handle_get_partysettings(p):
    if (datetime.now() < EndParty):#check enabled party, if the current datatime has exceeded the end of the party, then do not start
        await p.send_xt('activefeatures', 20150501)
        cookie = await p.server.redis.hget(PartyCacheCurrent, p.id)
        if cookie is None:
            cookie = ujson.dumps(DefaultPartyCookie)
            await p.server.redis.hset(PartyCacheCurrent, p.id, cookie)
        else:
            cookie = cookie.decode('utf-8')
        await p.send_xt('partycookie', cookie)
        await p.send_xt('partyservice', '{"partySettings":{"unlockDayIndex":16,"numOfDaysInParty":16},"partyStartDate":"' + str(StartParty) + '","partyEndDate":"' + str(EndParty) + '"}')
