import ujson

from houdini import handlers
from houdini.data import db
from houdini.data.penguin import CfcDonation
from houdini.data.item import Item
from houdini.data.igloo import Flooring, Location, Igloo, Furniture
from houdini.handlers import XTPacket
from houdini.handlers.play.navigation import handle_join_player_room, handle_join_room, handle_join_server
from datetime import datetime, timedelta

IsPartyEnabled = True

CookieHandlerId = 20161102

StartParty = datetime(2022, 12, 1, 00, 0, 0)#date[year month day hour minute sec] for start party
EndParty = datetime(2025, 1, 6, 00, 0, 0)#date[year month day hour minute sec] for end party

CookieHandlerName = "party"
PartyCacheCurrent = "holiday23"

DefaultPartyCookie = {
    'msgViewedArray': [0] * 10,
    'communicatorMsgArray': [0] * 10,
    'questTaskStatus': [0] * 10
}

def TotalDayParty():#this is the number of days already passed in the party
    if(CookieHandlerId == 20161101):
        if((datetime.now() - StartParty).days == 1):
            return 3
        elif((datetime.now() - StartParty).days == 2):
            return 6
        elif((datetime.now() - StartParty).days == 3):
            return 9
        elif((datetime.now() - StartParty).days == 4):
            return 11
        elif((datetime.now() - StartParty).days == 5):
            return 14
        elif((datetime.now() - StartParty).days == 6):
            return 17
        elif((datetime.now() - StartParty).days == 7):
            return 20
        elif((datetime.now() - StartParty).days == 8):
            return 20
        elif((datetime.now() - StartParty).days == 9):
            return 21
        elif((datetime.now() - StartParty).days == 10):
            return 22
        elif((datetime.now() - StartParty).days == 11):
            return 24
        elif((datetime.now() - StartParty).days == 12):
            return 27
        elif((datetime.now() - StartParty).days == 13):
            return 29
        elif((datetime.now() - StartParty).days >= 14):
            return 31
    return (datetime.now() - StartParty).days

@handlers.handler(XTPacket(CookieHandlerName, 'transform'))
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


@handlers.handler(XTPacket(CookieHandlerName, 'msgviewed'))
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
    
    
@handlers.handler(XTPacket(CookieHandlerName, 'cfcglobaltotal'))
async def handle_party_cfc_total(p, index: int):
    donate_total = await db.select([db.func.sum(CfcDonation.coins)]).gino.scalar()
    if(donate_total == None):
        donate_total = 0
    await p.send_xt('cfcglobaltotal', donate_total)
    
    
@handlers.handler(XTPacket(CookieHandlerName, 'cfcstationdonate'))
async def handle_party_cfc_donate(p, coins: int):
    if p.coins >= coins and 100 <= coins <= 10000:
        await p.update(coins=p.coins-coins).apply()
        await CfcDonation.create(penguin_id=p.id, coins=coins, charity=1)
        await p.send_xt('dc', p.coins)
        donate_player = await db.select([db.func.sum(CfcDonation.coins)]).where((CfcDonation.penguin_id == p.id)).gino.scalar()
        if(donate_player >= 10000):
            await p.add_stamp(p.server.stamps[296])
        if(donate_player >= 5000):
            await p.add_stamp(p.server.stamps[294])
        if(donate_player > 0):
            await p.add_inventory(p.server.items[90906], cost=0)
            await p.add_stamp(p.server.stamps[191])
        
@handlers.handler(XTPacket(CookieHandlerName, 'qtupdate'))
async def handle_party_coins_award(p, coins: int):
    await p.update(coins=p.coins+15).apply()
    await p.send_xt('dc', p.coins)
    

@handlers.handler(XTPacket('i', 'ai'))
async def handle_cfc_catalog(p, item: Item):
    if p.coins >= item.cost and item.cost > 0:
        await CfcDonation.create(penguin_id=p.id, coins=item.cost, charity=1)
        
        
@handlers.handler(XTPacket('g', 'ag'))
async def handle_cfc_flooring_catalog(p, flooring: Flooring):
    if p.coins >= flooring.cost and flooring.cost > 0:
        await CfcDonation.create(penguin_id=p.id, coins=flooring.cost, charity=1)
        
@handlers.handler(XTPacket('g', 'aloc'))
async def handle_cfc_location_igloo(p, location: Location):
    if p.coins >= location.cost and location.cost > 0:
        await CfcDonation.create(penguin_id=p.id, coins=location.cost, charity=1)
        
@handlers.handler(XTPacket('g', 'au'))
async def handle_cfc_type_igloo(p, igloo: Igloo):
    if p.coins >= igloo.cost and igloo.cost > 0:
        await CfcDonation.create(penguin_id=p.id, coins=igloo.cost, charity=1)
        
@handlers.handler(XTPacket('g', 'af'))
async def handle_cfc_furniture_catalog(p, furniture: Furniture):
    if p.coins >= furniture.cost and furniture.cost > 0:
        await CfcDonation.create(penguin_id=p.id, coins=furniture.cost, charity=1)
        

@handlers.handler(XTPacket(CookieHandlerName, 'qtaskcomplete'))
async def handle_party_task_complete(p, task_index: int):
    cookie = await p.server.redis.hget(PartyCacheCurrent, p.id)
    cookie = ujson.loads(cookie)
    
    cookie['questTaskStatus'][task_index] = 1
    
    await p.server.redis.hset(PartyCacheCurrent, p.id, ujson.dumps(cookie))
    
    newPartyCookie = await p.server.redis.hget(PartyCacheCurrent, p.id)
    newPartyCookie = newPartyCookie.decode('utf-8')
    
    await p.send_xt('partycookie', newPartyCookie)

@handlers.handler(XTPacket('j', 'js'), after= handle_join_server)
@handlers.allow_once
async def handle_get_partysettings(p):
    if (datetime.now() < EndParty):#check enabled party, if the current datatime has exceeded the end of the party, then do not start
        await p.send_xt('activefeatures', CookieHandlerId)
        cookie = await p.server.redis.hget(PartyCacheCurrent, p.id)
        if cookie is None:
            cookie = ujson.dumps(DefaultPartyCookie)
            await p.server.redis.hset(PartyCacheCurrent, p.id, cookie)
        else:
            cookie = cookie.decode('utf-8')
        await p.send_packet('partycookie', cookie)
        await p.send_partypacket('partyservice', '{"partySettings":{"unlockDayIndex":30,"numOfDaysInParty":30},"partyStartDate":"2015-10-21 00:00:00","partyEndDate":"2015-11-05 00:00:00"}')
        