import ujson
import random
import asyncio

from houdini import handlers
from houdini.handlers import Priority, XTPacket
from houdini.handlers.play.navigation import handle_join_player_room, handle_join_room, handle_join_server
from datetime import datetime, timedelta
from houdini.data.penguin import Penguin

CookieHandlerId = 20150101

StartParty = datetime(2021, 10, 14, 00, 00, 0)#date[year month day hour minute sec] for start party
EndParty = datetime(2021, 10, 31, 00, 00, 0)#date[year month day hour minute sec] for end party

CookieHandlerName = "sw2015"
PartyCacheCurrent = "starwarsparty"

DefaultPartyCookie = {
    'msgViewedArray': [0] * 20,
    'qcMessageArray': [0] * 20,
    'questTaskStatus': [0] * 6,
    'points': 0
}

def TotalDayParty():#this is the number of days already passed in the party
    return (datetime.now() - StartParty).days

@handlers.handler(XTPacket(CookieHandlerName, 'transform'))
async def handle_party_transformation(p, transform_id: int):
    p.avatar = transform_id
    await p.room.send_xt('spts', p.id, transform_id)

@handlers.handler(XTPacket(CookieHandlerName, 'swopen'))
async def handle_party_swopen(p, pid: int):
    if(p.swopen == 0):
        p.swopen = 1
        await p.room.send_xt('swopen', p.id)
    
@handlers.handler(XTPacket(CookieHandlerName, 'swclose'))#i dont know why swclose now working. i use u#sf
async def handle_party_swclose(p, pid: int):
    p.swopen = 0
    await p.room.send_xt('swclose', p.id,p.id)
    
@handlers.handler(XTPacket('u', 'sf'))
async def handle_party_sfclose(p, anim: int):
    if(p.swopen == 1):
        p.swopen = 0
        await p.room.send_xt('swcancel', p.id,p.id)

@handlers.handler(XTPacket(CookieHandlerName, 'swselect'))#игрок делает ход
async def handle_party_swselect(p, select: int, battleId: int):
    p.battleattack = select
    
@handlers.handler(XTPacket(CookieHandlerName, 'swjoin'))
async def handle_party_swjoin(p, creatorId: int):
    creatorPeng = p.server.penguins_by_id[creatorId]
    if creatorPeng.battleId is None and p.battleId is None and creatorPeng.swopen == 1:
        creatorPeng.battleId = random.randint(1000, 99999)
        p.battleId = creatorPeng.battleId
        await p.room.send_xt('swcancel', p.id,p.id)
        await p.room.send_xt('swjoin',creatorId,p.id,5000,creatorPeng.battleId)
        #await creatorPeng.room.send_xt('swcancel', creatorPeng.id,creatorPeng.id)
        p.swopen = 0
        creatorPeng.swopen = 0
        asyncio.create_task(battle(creatorPeng,p,creatorPeng.battleId))

async def battle_result(creator, challenger, resultForCreator, resultForChallenger, creatorPoints, challengerPoints):
    result = {'won':0,'lost':1,'tie':2}
    resultForCreator = result[resultForCreator]
    resultForChallenger = result[resultForChallenger]
    await add_point(creator, creatorPoints)
    await add_point(challenger, challengerPoints)
    await creator.room.send_xt('swresult', f'{creator.id},{creator.battleattack},{resultForCreator},{creatorPoints}',f'{challenger.id},{challenger.battleattack},{resultForChallenger},{challengerPoints}')#отправляет результат битвы
    creator.battleId = None
    challenger.battleId = None


async def battle(creator, challenger, battleId):
    await asyncio.sleep(9)#Ждём 9 секунд до результата
    if(creator.battleattack == 0 and challenger.battleattack == 2):
        return await battle_result(creator, challenger, 'won', 'lost', 5, 2)
    elif(creator.battleattack == 0 and challenger.battleattack == 1):
        return await battle_result(creator, challenger, 'lost', 'won', 2, 5)
    elif(creator.battleattack == 0 and challenger.battleattack == 0):
        return await battle_result(creator, challenger, 'tie', 'tie', 2, 2)
        
    elif(creator.battleattack == 1 and challenger.battleattack == 0):
        return await battle_result(creator, challenger, 'won', 'lost', 5, 2)
    elif(creator.battleattack == 1 and challenger.battleattack == 2):
        return await battle_result(creator, challenger, 'lost', 'won', 2, 5)
    elif(creator.battleattack == 1 and challenger.battleattack == 1):
        return await battle_result(creator, challenger, 'tie', 'tie', 2, 2)
        
    elif(creator.battleattack == 2 and challenger.battleattack == 1):
        return await battle_result(creator, challenger, 'won', 'lost', 5, 2)
    elif(creator.battleattack == 2 and challenger.battleattack == 0):
        return await battle_result(creator, challenger, 'lost', 'won', 2, 5)
    elif(creator.battleattack == 2 and challenger.battleattack == 2):
        return await battle_result(creator, challenger, 'tie', 'tie', 2, 2)

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
async def handle_party_qcmsgviewed(p, message_index: int):
    cookie = await p.server.redis.hget(PartyCacheCurrent, p.id)
    cookie = ujson.loads(cookie)
    
    cookie['qcMessageArray'][message_index] = 1
    
    await p.server.redis.hset(PartyCacheCurrent, p.id, ujson.dumps(cookie))
    
    newPartyCookie = await p.server.redis.hget(PartyCacheCurrent, p.id)
    newPartyCookie = newPartyCookie.decode('utf-8')
    
    await p.send_packet('partycookie', newPartyCookie)

@handlers.handler(XTPacket('j', 'crl'), after=handle_join_room)#show all active battle
async def handle_join_crlj(p):
    for i in p.server.penguins_by_username.values():
        if(i.swopen == 1 and i.room.id == p.room.id):
            await p.send_xt('swopen', i.id)
            
@handlers.handler(XTPacket('j', 'jr'), priority=Priority.High)#if change location > close swopen
async def handle_join_roomjr(p):
    if(p.swopen == 1):
        p.swopen = 0
        await p.room.send_xt('swcancel', p.id,p.id)
            
@handlers.handler(XTPacket('u', 'sp'))#if move penguin > close swopen
async def handle_join_usp(p,x,y):
    if(p.swopen == 1):
        p.swopen = 0
        await p.room.send_xt('swcancel', p.id,p.id)

@handlers.handler(XTPacket(CookieHandlerName, 'qtaskcomplete'))
async def handle_party_task_complete(p, task_index: int):
    cookie = await p.server.redis.hget(PartyCacheCurrent, p.id)
    cookie = ujson.loads(cookie)
    
    cookie['questTaskStatus'][task_index] = 1
    
    await p.server.redis.hset(PartyCacheCurrent, p.id, ujson.dumps(cookie))
    
    newPartyCookie = await p.server.redis.hget(PartyCacheCurrent, p.id)
    newPartyCookie = newPartyCookie.decode('utf-8')
    
    await p.send_xt('partycookie', newPartyCookie)
    
async def add_point(p, value: int):
    cookie = await p.server.redis.hget(PartyCacheCurrent, p.id)
    cookie = ujson.loads(cookie)
    
    cookie['points'] += value
    
    await p.server.redis.hset(PartyCacheCurrent, p.id, ujson.dumps(cookie))
    
    newPartyCookie = await p.server.redis.hget(PartyCacheCurrent, p.id)
    newPartyCookie = newPartyCookie.decode('utf-8')
    
    await p.send_xt('partycookie', newPartyCookie)

@handlers.handler(XTPacket('j', 'js'), after= handle_join_server)
@handlers.allow_once
async def handle_get_partysettings(p):
    if (datetime.now() < EndParty):#check enabled party, if the current datatime has exceeded the end of the party, then do not start
        Penguin.battleattack = 0
        Penguin.swopen = 0
        Penguin.battleId = None
        await p.send_xt('activefeatures', CookieHandlerId)
        cookie = await p.server.redis.hget(PartyCacheCurrent, p.id)
        if cookie is None:
            cookie = ujson.dumps(DefaultPartyCookie)
            await p.server.redis.hset(PartyCacheCurrent, p.id, cookie)
        else:
            cookie = cookie.decode('utf-8')
        await p.send_packet('partycookie', cookie)
        await p.send_partypacket('partyservice', '{"partySettings":{"partyIglooItems":[0],"numOfDaysInParty":14,"unlockDayIndex":' + str(TotalDayParty()) + '},"questSettingList":[{"roomIds":[800,809,300,100],"questItemIndex":0,"unlockDay":0,"memberItemIds":[1967,24245],"nonmemberItemId":5509},{"roomIds":[800,809,300,801,100],"questItemIndex":1,"unlockDay":0,"memberItemIds":[1965,24243],"nonmemberItemId":5508},{"roomIds":[800,809,801],"questItemIndex":2,"unlockDay":1,"memberItemIds":[1968,24246],"nonmemberItemId":5510},{"roomIds":[800,801,300],"questItemIndex":3,"unlockDay":1,"memberItemIds":[1969,24247],"nonmemberItemId":5516},{"roomIds":[891],"questItemIndex":4,"unlockDay":2,"memberItemIds":[1966,24244],"nonmemberItemId":9291}],"swordsList":[{"rewardId":0,"points":20,"itemId":2327,"type":"FURNITURE"},{"rewardId":1,"points":50,"itemId":5512,"type":"PAPER_ITEM"},{"rewardId":2,"points":100,"itemId":5515,"type":"PAPER_ITEM"},{"rewardId":3,"points":200,"itemId":5513,"type":"PAPER_ITEM"},{"rewardId":4,"points":350,"itemId":83,"type":"IGLOO"},{"rewardId":5,"points":600,"itemId":0,"type":"PAPER_ITEM"}],"kananLightsaber":{"unlockDay":2,"itemId":5511},"inquisitorPrizeItems":{"memberItemId":[24248,5514],"nonmemberItemId":1970}}')