import ujson

from houdini import handlers
from houdini.handlers import XTPacket
from houdini.handlers.play.navigation import handle_join_player_room, handle_join_room, handle_join_server
from datetime import datetime, timedelta

IsPartyEnabled = True

CookieHandlerId = 20161101

StartParty = datetime(2020, 11, 15, 00, 0, 0)#date[year month day hour minute sec] for start party
EndParty = datetime(2020, 11, 1, 00, 0, 0)#date[year month day hour minute sec] for end party

CookieHandlerName = "party"
PartyCacheCurrent = "musicjam202"

DefaultPartyCookie = {
    'msgViewedArray': [0] * 44,
    'communicatorMsgArray': [0] * 38,
    'questTaskStatus': [0] * 44
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
        await p.send_partypacket('partyservice', '{"partySettings":{"unlockDayIndex":' + str(TotalDayParty()) + ',"numOfDaysInParty":20},"partyStartDate":"2015-10-21 00:00:00","partyEndDate":"2015-11-05 00:00:00"}')
        