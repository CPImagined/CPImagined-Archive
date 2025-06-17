import ujson

from houdini import handlers
from houdini.handlers import XTPacket
from houdini.handlers import Priority, XMLPacket
from houdini.data.room import Room
from houdini.handlers.play.navigation import handle_join_player_room, handle_join_room, handle_join_server
from datetime import datetime, timedelta

IsPartyEnabled = True

CookieHandlerId = 20160701

StartParty = datetime(2020, 9, 14, 00, 0, 0)#date[year month day hour minute sec] for start party
EndParty = datetime(2020, 10, 10, 00, 0, 0)#date[year month day hour minute sec] for end party

CookieHandlerName = "party"
PartyCacheCurrent = "findingdory"

DefaultPartyCookie = {
    'msgViewedArray': [0] * 27,
    'communicatorMsgArray': [0] * 27,
    'questTaskStatus': [0] * 27
}

def TotalDayParty():#this is the number of days already passed in the party
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
        await p.send_partypacket('partyservice', '{"partySettings":{"partyIglooItems":[0],"unlockDayIndex":' + str(TotalDayParty()) + ',"numOfDaysInParty":10},"questSettingList":[{"questTaskIndex":0,"memberItemIds":24393,"unlockDay":0},{"questTaskIndex":1,"memberItemIds":24394,"unlockDay":1},{"questTaskIndex":2,"memberItemIds":24395,"unlockDay":2},{"questTaskIndex":3,"memberItemIds":24396,"unlockDay":3},{"questTaskIndex":4,"nonMemberItemIds":9310,"unlockDay":4},{"questTaskIndex":5,"memberItemIds":24397,"unlockDay":5},{"questTaskIndex":6,"nonMemberItemIds":7280,"unlockDay":6},{"questTaskIndex":7,"memberItemIds":24398,"unlockDay":7},{"questTaskIndex":8,"nonMemberItemIds":9311,"unlockDay":8}]}')
        