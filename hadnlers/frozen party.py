import ujson

from houdini import handlers
from houdini.data.penguin import Penguin
from houdini.handlers import XTPacket
from houdini.handlers.play.navigation import handle_join_player_room, handle_join_room, handle_join_server
from datetime import datetime, timedelta

CookieHandlerId = 20140801

StartParty = datetime(2022, 11, 21, 00, 00, 0)#date[year month day hour minute sec] for start party
EndParty = datetime(2022, 12, 4, 18, 22, 0)#date[year month day hour minute sec] for end party

CookieHandlerName = "frozen"
PartyCacheCurrent = "frozen2014" #if you have a repeated party, it is advisable to make a different name every time

DefaultPartyCookie = {
    'msgViewedArray': [0] * 2,
    'snowflakes': [0] * 21,
    'freezingPowers': 0
}

RoomStates = {
    100: [0] * 5, # TOWN
    300: [0] * 6, # PLAZA
    400: [0] * 5, # BEACH
    800: [0] * 6, # DOCK
    801: [0] * 5, # SNOW FORTS
    809: [0] * 5, # FOREST
    810: [0] * 6  # COVE
}

def TotalDayParty():#this is the number of days already passed in the party
    return (datetime.now() - StartParty).days


@handlers.handler(XTPacket(CookieHandlerName, 'fptransform'))
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


@handlers.handler(XTPacket(CookieHandlerName, 'fpmsgviewed'))
async def handle_party_message_viewed(p, msg_index: int):
    cookie = await p.server.redis.hget(PartyCacheCurrent, p.id)
    cookie = ujson.loads(cookie)
    
    cookie['msgViewedArray'][msg_index] = 1
    
    await p.server.redis.hset(PartyCacheCurrent, p.id, ujson.dumps(cookie))
    
    newPartyCookie = await p.server.redis.hget(PartyCacheCurrent, p.id)
    newPartyCookie = newPartyCookie.decode('utf-8')
    
    await p.send_xt('partycookie', newPartyCookie)


@handlers.handler(XTPacket(CookieHandlerName, 'fpfindsnowflake'))
async def handle_party_startgame(p, snowflake_index: int):
    cookie = await p.server.redis.hget(PartyCacheCurrent, p.id)
    cookie = ujson.loads(cookie)
    
    cookie['snowflakes'][snowflake_index] = 1
    
    await p.server.redis.hset(PartyCacheCurrent, p.id, ujson.dumps(cookie))
    
    newPartyCookie = await p.server.redis.hget(PartyCacheCurrent, p.id)
    newPartyCookie = newPartyCookie.decode('utf-8')
    
    await p.send_xt('partycookie', newPartyCookie)


@handlers.handler(XTPacket(CookieHandlerName, 'fpactivatefreezingpower'))
async def handle_party_freezing(p):
    cookie = await p.server.redis.hget(PartyCacheCurrent, p.id)
    cookie = ujson.loads(cookie)
    
    cookie['freezingPowers'] = 1
    
    await p.server.redis.hset(PartyCacheCurrent, p.id, ujson.dumps(cookie))
    
    newPartyCookie = await p.server.redis.hget(PartyCacheCurrent, p.id)
    newPartyCookie = newPartyCookie.decode('utf-8')
    
    await p.send_xt('partycookie', newPartyCookie)


@handlers.handler(XTPacket(CookieHandlerName, 'fpcountdown'))
async def handle_party_countdown(p):
    await p.send_xt('fpcountdown', 300000) # 5 MINUTES IN MILLISECONDS. HERE I WOULD HAVE MADE A TIMER, SO THAT ALL PLAYERS HAVE THE SERVER COUNTDOWN SYNCHRONIZED, BUT I DON'T KNOW HOW TO DO IT TO BE HONEST.


@handlers.handler(XTPacket(CookieHandlerName, 'fpfurniturepack'))
async def handle_party_furniturepack(p):
    for _ in range(5):
        await p.add_furniture(p.server.furniture[2270], cost=0)
    for _ in range(3):
        await p.add_furniture(p.server.furniture[2271], cost=0)
    for _ in range(10):
        await p.add_furniture(p.server.furniture[2272], cost=0)
    await p.send_xt('fpfurniturepack', 0)


@handlers.handler(XTPacket(CookieHandlerName, 'fpupdateroomstate'))
async def handle_party_update_room_state(p, room_section: int, state: int, x: int, y:int):
    if state == 1:
        RoomStates[p.room.id][room_section - 1] = 1
    else:
        RoomStates[p.room.id][room_section - 1] = 0
    await p.room.send_xt('fpupdateroomstate', p.id, room_section, state, x, y)


@handlers.handler(XTPacket('j', 'crl'), after=handle_join_room)
async def handle_party_get_room_state(p):
    if p.room.id in (100,300,400,800,801,809,810):
        roomState = ','.join(str(state) for state in RoomStates[p.room.id])
        await p.send_xt('fproomstate', roomState)


@handlers.handler(XTPacket('j', 'js'), after=handle_join_server)
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
        await p.send_partypacket('partyservice','{"partySettings":{"unlockDayIndex":'+ str(TotalDayParty()) +',"numOfDaysInParty":14},"questSettingList":[{"roomId":400,"snowflakeIds":[0,1,2],"memberItemId":24189,"nonmemberItemId":5466},{"roomId":800,"snowflakeIds":[3,4,5],"memberItemId":24184,"nonmemberItemId":1904},{"roomId":100,"snowflakeIds":[6,7,8],"memberItemId":24185,"nonmemberItemId":5468},{"roomId":801,"snowflakeIds":[9,10,11],"memberItemId":24186,"nonmemberItemId":5469},{"roomId":300,"snowflakeIds":[12,13,14],"memberItemId":24188,"nonmemberItemId":1903},{"roomId":809,"snowflakeIds":[15,16,17],"memberItemId":24187,"nonmemberItemId":5467},{"roomId":810,"snowflakeIds":[18,19,20],"memberItemId":24190,"nonmemberItemId":5465}],"icePalaceUnlockDay":7}')
