import ujson
import random

from houdini import handlers
from houdini.data.penguin import Penguin
from houdini.handlers import XTPacket
from houdini.handlers.play.navigation import handle_join_player_room, handle_join_room, handle_join_server
from datetime import datetime, timedelta

CookieHandlerId = 20141002

StartParty = datetime(2020, 9, 15, 00, 00, 0)#date[year month day hour minute sec] for start party
EndParty = datetime(2020, 9, 30, 00, 00, 0)#date[year month day hour minute sec] for end party

CookieHandlerName = "halloween"
PartyCacheCurrent = "halloween20" #if you have a repeated party, it is advisable to make a different name every time

DefaultPartyCookie = {
    'msgViewedArray': [0] * 10,
    'questTaskStatus': [0] * 8,
    'communicatorMsgArray': [0] * 7,
    'visitedFloor12': [0] * 1
}


def TotalDayParty():#this is the number of days already passed in the party
    return (datetime.now() - StartParty).days

@handlers.handler(XTPacket(CookieHandlerName, 'visitedfloor12'))
@handlers.depends_on_packet(XTPacket(CookieHandlerName, 'partycookie'))
async def handle_party_visit_floor_12(p, message_index: int):
    cookie = await p.server.redis.hget(PartyCacheCurrent, p.id)
    cookie = ujson.loads(cookie)
    
    cookie['msgViewedArray'][message_index] = 1
    
    await p.server.redis.hset(PartyCacheCurrent, p.id, ujson.dumps(cookie))
    
    newPartyCookie = await p.server.redis.hget(PartyCacheCurrent, p.id)
    newPartyCookie = newPartyCookie.decode('utf-8')
    
    await p.send_packet('visitedfloor12', newPartyCookie)
    

@handlers.handler(XTPacket(CookieHandlerName, 'partycookie'))
async def handle_party_cookie(p):
    cookie = await p.server.redis.hget(PartyCacheCurrent, p.id)
    if cookie is None:
        cookie = ujson.dumps(DefaultPartyCookie)
        await p.server.redis.hset(PartyCacheCurrent, p.id, cookie)
    else:
        cookie = cookie.decode('utf-8')
    await p.send_packet('partycookie', cookie)

@handlers.handler(XTPacket(CookieHandlerName, 'msgviewed'))
@handlers.depends_on_packet(XTPacket(CookieHandlerName, 'partycookie'))
async def handle_party_message_viewed(p, message_index: int):
    cookie = await p.server.redis.hget(PartyCacheCurrent, p.id)
    cookie = ujson.loads(cookie)
    
    cookie['msgViewedArray'][message_index] = 1
    
    await p.server.redis.hset(PartyCacheCurrent, p.id, ujson.dumps(cookie))
    
    newPartyCookie = await p.server.redis.hget(PartyCacheCurrent, p.id)
    newPartyCookie = newPartyCookie.decode('utf-8')
    
    await p.send_packet('partycookie', newPartyCookie)

@handlers.handler(XTPacket(CookieHandlerName, 'collectquestitem'))
@handlers.depends_on_packet(XTPacket(CookieHandlerName, 'partycookie'))
async def handle_party_task_complete(p, task_index: int):
    cookie = await p.server.redis.hget(PartyCacheCurrent, p.id)
    cookie = ujson.loads(cookie)
    print("Task Completed: ", task_index)
    cookie['questTaskStatus'][task_index] = 1

    await p.server.redis.hset(PartyCacheCurrent, p.id, ujson.dumps(cookie))
    newPartyCookie = await p.server.redis.hget(PartyCacheCurrent, p.id)
    newPartyCookie = newPartyCookie.decode('utf-8')
    
    await p.send_packet('partycookie', newPartyCookie)
    
@handlers.handler(XTPacket(CookieHandlerName, 'qcmsgviewed'))
@handlers.depends_on_packet(XTPacket(CookieHandlerName, 'partycookie'))
async def handle_party_communicator_message_viewed(p, message_index: int):
    cookie = await p.server.redis.hget(PartyCacheCurrent, p.id)
    cookie = ujson.loads(cookie)
    
    cookie['communicatorMsgArray'][message_index] = 1
    
    await p.server.redis.hset(PartyCacheCurrent, p.id, ujson.dumps(cookie))
    
    newPartyCookie = await p.server.redis.hget(PartyCacheCurrent, p.id)
    newPartyCookie = newPartyCookie.decode('utf-8')
    
    await p.send_packet('partycookie', newPartyCookie)



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
        await p.send_partypacket('partyservice','{"partySettings":{"partyIglooItems":[0],"unlockDayIndex":'+ str(TotalDayParty()) +',"numOfDaysInParty":14},"questSettingList":[{"roomId":851,"questItemIndex":0,"unlockDay":0},{"roomId":852,"questItemIndex":1,"unlockDay":0},{"roomId":853,"questItemIndex":2,"unlockDay":1},{"roomId":854,"questItemIndex":3,"unlockDay":1},{"roomId":855,"questItemIndex":-1,"unlockDay":0},{"roomId":856,"questItemIndex":4,"unlockDay":2},{"roomId":857,"questItemIndex":5,"unlockDay":2},{"roomId":858,"questItemIndex":-1,"unlockDay":3},{"roomId":859,"questItemIndex":6,"unlockDay":3},{"roomId":891,"questItemIndex":-1,"unlockDay":0},{"roomId":892,"questItemIndex":7,"unlockDay":3},{"roomId":430,"questItemIndex":-1,"unlockDay":0},{"roomId":431,"questItemIndex":-1,"unlockDay":0},{"roomId":432,"questItemIndex":-1,"unlockDay":0}],"rewardList":[{"roomId":855,"rewardId":1,"unlockDay":0,"memberItemId":3219,"nonmemberItemId":5485},{"roomId":855,"rewardId":2,"unlockDay":2,"memberItemId":24212,"nonmemberItemId":1932},{"roomId":855,"rewardId":3,"unlockDay":4,"memberItemId":2163,"nonmemberItemId":5483},{"roomId":858,"rewardId":4,"unlockDay":6,"memberItemId":24213,"nonmemberItemId":5481},{"roomId":858,"rewardId":5,"unlockDay":8,"memberItemId":5480,"nonmemberItemId":5484},{"roomId":858,"rewardId":6,"unlockDay":10,"memberItemId":24214,"nonmemberItemId":5482},{"roomId":892,"rewardId":7,"unlockDay":-1,"memberItemId":0,"nonmemberItemId":1931}],"ghostCatchRoom":860,"finaleRoom":861}')