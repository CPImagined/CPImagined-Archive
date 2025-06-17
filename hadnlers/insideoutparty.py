import ujson

from houdini import handlers
from houdini.handlers import XTPacket
from houdini.handlers.play.navigation import handle_join_player_room, handle_join_room, handle_join_server
from houdini.data.penguin import Penguin

IsPartyEnabled = True

CookieHandlerId = 20150702

CookieHandlerName = "insideout"
PartyCacheCurrent = "partycp"

DefaultPartyCookie = {
    'msgViewedArray': [0] * 5,
    'questTaskStatus': [0] * 8,
    'communicatorMsgArray': [0] * 5
    
}
@handlers.handler(XTPacket(CookieHandlerName, 'itransform'))
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
    await p.send_packet('partycookie', cookie)


@handlers.handler(XTPacket(CookieHandlerName, 'msgviewed'))
async def handle_party_message_viewed(p, message_index: int):
    cookie = await p.server.redis.hget(PartyCacheCurrent, p.id)
    cookie = ujson.loads(cookie)
    
    cookie['msgViewedArray'][message_index] = 1
    
    await p.server.redis.hset(PartyCacheCurrent, p.id, ujson.dumps(cookie))
    
    newPartyCookie = await p.server.redis.hget(PartyCacheCurrent, p.id)
    newPartyCookie = newPartyCookie.decode('utf-8')
    
    await p.send_packet('partycookie', newPartyCookie)


@handlers.handler(XTPacket(CookieHandlerName, 'qcmsgviewed'))
async def handle_party_communicator_message_viewed(p, message_index: int):
    cookie = await p.server.redis.hget(PartyCacheCurrent, p.id)
    cookie = ujson.loads(cookie)
    
    cookie['communicatorMsgArray'][message_index] = 1
    
    await p.server.redis.hset(PartyCacheCurrent, p.id, ujson.dumps(cookie))
    
    newPartyCookie = await p.server.redis.hget(PartyCacheCurrent, p.id)
    newPartyCookie = newPartyCookie.decode('utf-8')
    
    await p.send_packet('partycookie', newPartyCookie)


@handlers.handler(XTPacket(CookieHandlerName, 'qtaskcomplete'))
async def handle_party_task_complete(p, task_index: int):
    cookie = await p.server.redis.hget(PartyCacheCurrent, p.id)
    cookie = ujson.loads(cookie)
    
    
    if (task_index == 4):
        #Fear emotion is done, task index 4 is true
        cookie['questTaskStatus'][4] = 1
        #every task is done, task index 5 is true
        cookie['questTaskStatus'][5] = 1
    #if penguin is not member, receive 500 coins after complete inside out party taks
    elif(task_index == 6):
        cookie['questTaskStatus'][6] = 1
        await p.update(coins=p.coins + 500).apply()
        await p.send_xt('cdu', p.coins + 500, p.coins + 500)
    #if penguin is member, receive 1000 coins after complete inside out party taks
    elif(task_index == 7):
        cookie['questTaskStatus'][7] = 1
        await p.update(coins=p.coins + 1000).apply()
        await p.send_xt('cdu', p.coins + 1000, p.coins + 1000)
        await p.server.redis.hset(PartyCacheCurrent, p.id, ujson.dumps(cookie))
    else:
        cookie['questTaskStatus'][task_index] = 1
    
    #new party cookie packet is sent at the end
    await p.server.redis.hset(PartyCacheCurrent, p.id, ujson.dumps(cookie))
    
    newPartyCookie = await p.server.redis.hget(PartyCacheCurrent, p.id)
    newPartyCookie = newPartyCookie.decode('utf-8')
    
    await p.send_packet('partycookie', newPartyCookie)

@handlers.handler(XTPacket('j', 'js'), after= handle_join_server)
@handlers.allow_once
async def handle_get_partysettings(p):
    if (IsPartyEnabled !=False) :
        await p.send_xt('activefeatures', CookieHandlerId)
        cookie = await p.server.redis.hget(PartyCacheCurrent, p.id)
        if cookie is None:
            cookie = ujson.dumps(DefaultPartyCookie)
            await p.server.redis.hset(PartyCacheCurrent, p.id, cookie)
        else:
            cookie = cookie.decode('utf-8')
        await p.send_packet('partycookie', cookie)
        await p.send_partypacket('partyservice', '{"partySettings":{"partyIglooItems":[0],"unlockDayIndex":16,"numOfDaysInParty":16},"questSettingList":[{"questTaskIndex":0,"emotion":"Joy","nonMemberItem":5530,"memberItems":[21022,24307]},{"questTaskIndex":1,"emotion":"Sadness","nonMemberItem":5529,"memberItems":[21023,24308,6265]},{"questTaskIndex":2,"emotion":"Anger","nonMemberItem":5531,"memberItems":[21021,24306,10358]},{"questTaskIndex":3,"emotion":"Disgust","nonMemberItem":21027,"memberItems":[21025,3234,24310,6264]},{"questTaskIndex":4,"emotion":"Fear","nonMemberItem":21026,"memberItems":[21024,24309,6263]},{"questTaskIndex":5,"emotion":"CompletedAll","nonMemberItem":9302,"memberItems":[1951,1277,4226,5496,5500]}],"numOfQuests":8}')
