import ujson

from houdini import handlers
from houdini.handlers import XTPacket
from houdini.handlers import Priority, XMLPacket
from houdini.data.room import Room
from houdini.handlers.play.navigation import handle_join_player_room, handle_join_room, handle_join_server
from os import path
from datetime import datetime, timedelta
import re

IsPartyEnabled = True

CookieHandlerId = 20160201

StartParty = datetime(2020, 9, 23, 00, 0, 0)#date[year month day hour minute sec] for start party
EndParty = datetime(2020, 10, 15, 00, 0, 0)#date[year month day hour minute sec] for end party

CookieHandlerName = "party"
PartyCacheCurrent = "operationtriumph"

DefaultPartyCookie = {
    'msgViewedArray': [0] * 10,
    'communicatorMsgArray': [0] * 10,
    'questTaskStatus': [0] * 10
}

def TotalDayParty():#this is the number of days already passed in the party
    return (datetime.now() - StartParty).days
    
def ClearCache():#clear cache
    f = open('/wand/vanilla-media/play/index.html', 'r+', encoding="utf8")
    data = f.read()
    token = re.findall(r'"cacheVersion": "(.*?)"', data, re.DOTALL)[0]
    data = data.replace('"' + token + '"', '"' + str(int(token)+1) + '"')
    data = data.replace('?clientVersion=' + token + '"', '?clientVersion=' + str(int(token)+1) + '"')
    f.seek(0)
    f.truncate(0)
    f.seek(0)
    f.write(data)
    f.close()

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
    if (datetime.now() < EndParty):#check enabled party, if the current datatime has exceeded the end of the party, then do not start' + str(TotalDayParty()+1) + '
        await p.send_xt('activefeatures', CookieHandlerId)
        cookie = await p.server.redis.hget(PartyCacheCurrent, p.id)
        if cookie is None:
            cookie = ujson.dumps(DefaultPartyCookie)
            await p.server.redis.hset(PartyCacheCurrent, p.id, cookie)
        else:
            cookie = cookie.decode('utf-8')
        if(TotalDayParty() >= 14):
            if path.exists("/wand/vanilla-media/media/play/en/web_service/game_configs3.bin"):
                os.rename('/wand/vanilla-media/media/play/en/web_service/game_configs.bin','/wand/vanilla-media/media/play/en/web_service/game_configs2.bin')
                os.rename('/wand/vanilla-media/media/play/en/web_service/game_configs3.bin','/wand/vanilla-media/media/play/web_service/game_configs.bin')
                ClearCache()
        elif(TotalDayParty() >= 7):
            if path.exists("/wand/vanilla-media/media/play/en/web_service/game_configs2.bin"):
                os.rename('/wand/vanilla-media/media/play/en/web_service/game_configs.bin','/wand/vanilla-media/media/play/en/web_service/game_configs1.bin')
                os.rename('/wand/vanilla-media/media/play/en/web_service/game_configs2.bin','/wand/vanilla-media/media/play/en/web_service/game_configs.bin')
                ClearCache()
        await p.send_packet('partycookie', cookie)
        await p.send_partypacket('partyservice', '{"partySettings":{"partyIglooItems":[0],"unlockDayIndex":' + str(TotalDayParty()) + ',"numOfDaysInParty":15},"partyStartDate":"2015-10-21 00:00:00","partyEndDate":"2020-11-05 00:00:00"}')
        