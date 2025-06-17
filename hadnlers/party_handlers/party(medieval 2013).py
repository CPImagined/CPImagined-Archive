import ujson
import random

from houdini import handlers
from houdini.data.penguin import Penguin
from houdini.handlers import XTPacket
from houdini.handlers.play.navigation import handle_join_player_room, handle_join_room, handle_join_server
from datetime import datetime, timedelta

CookieHandlerId = 20130901

StartParty = datetime(2021, 4, 9, 00, 00, 0)#date[year month day hour minute sec] for start party
EndParty = datetime(2021, 6, 1, 00, 00, 0)#date[year month day hour minute sec] for end party

CookieHandlerName = "mdvl"
PartyCacheCurrent = "mdvl_party" #if you have a repeated party, it is advisable to make a different name every time

DefaultPartyCookie = {
    'msgIndex': 0,
    'ingredients': [0] * 5,
    'potionsMade': [0] * 10,
    'inventory': [0] * 10,
    'golden': 0
}

#2 - scale

Tranform = {
   0: 0,
   1: 31,
   2: 38,
   3: 32,
   4: 39,
   5: 33,
   6: 34,
   7: 35,
   8: 40,
   9: 41,
   10: 36,
   11: 37
}


def TotalDayParty():#this is the number of days already passed in the party
    return (datetime.now() - StartParty).days
    
@handlers.handler(XTPacket(CookieHandlerName, 'transform'))
async def handle_party_transformation(p, transform_id: int):
    p.avatar = transform_id
    await p.room.send_xt('spts', p.id, transform_id)


@handlers.handler(XTPacket(CookieHandlerName, 'mdvlp'))
async def handle_party_cookie(p):
    cookie = await p.server.redis.hget(PartyCacheCurrent, p.id)
    if cookie is None:
        cookie = ujson.dumps(DefaultPartyCookie)
        await p.server.redis.hset(PartyCacheCurrent, p.id, cookie)
    else:
        cookie = cookie.decode('utf-8')
    await p.send_xt('mdvlp', cookie)


@handlers.handler(XTPacket(CookieHandlerName, 'mdvlv'))
async def handle_party_message_viewed(p, message_index: int):
    cookie = await p.server.redis.hget(PartyCacheCurrent, p.id)
    cookie = ujson.loads(cookie)
    
    if message_index == 11:
        cookie['golden'] = 1

    cookie['msgIndex'] = message_index
    
    await p.server.redis.hset(PartyCacheCurrent, p.id, ujson.dumps(cookie))
    
    newPartyCookie = await p.server.redis.hget(PartyCacheCurrent, p.id)
    newPartyCookie = newPartyCookie.decode('utf-8')
    
    await p.send_xt('mdvlp', newPartyCookie)
    
@handlers.handler(XTPacket(CookieHandlerName, 'mdvli'))
async def handle_party_find_ingredient(p, ingredient_index: int):
    cookie = await p.server.redis.hget(PartyCacheCurrent, p.id)
    cookie = ujson.loads(cookie)

    cookie['ingredients'][ingredient_index] = 1
    await p.send_xt('mdvli', ingredient_index)
    
    await p.server.redis.hset(PartyCacheCurrent, p.id, ujson.dumps(cookie))
    
    newPartyCookie = await p.server.redis.hget(PartyCacheCurrent, p.id)
    newPartyCookie = newPartyCookie.decode('utf-8')
    
    await p.send_xt('mdvlp', newPartyCookie)
    
@handlers.handler(XTPacket(CookieHandlerName, 'mdvlm'))#success
async def handle_party_potion_made(p, potion_index: int):
    cookie = await p.server.redis.hget(PartyCacheCurrent, p.id)
    cookie = ujson.loads(cookie)
    potion_index -= 1

    cookie['potionsMade'][potion_index] = 1
    cookie['inventory'][potion_index] += 5
    
    await p.server.redis.hset(PartyCacheCurrent, p.id, ujson.dumps(cookie))
    
    newPartyCookie = await p.server.redis.hget(PartyCacheCurrent, p.id)
    newPartyCookie = newPartyCookie.decode('utf-8')
    
    await p.send_xt('mdvlp', newPartyCookie)
    
@handlers.handler(XTPacket(CookieHandlerName, 'mdvlc'))#chicken - fail
async def handle_party_transform(p, transform_id: int):
    cookie = await p.server.redis.hget(PartyCacheCurrent, p.id)
    cookie = ujson.loads(cookie)

    if(transform_id != 11):
        cookie['inventory'][transform_id-1] -= 1
    if transform_id in Tranform:
        p.avatar = Tranform[transform_id]
        await p.room.send_xt('spts', p.id, Tranform[transform_id])
    
    await p.server.redis.hset(PartyCacheCurrent, p.id, ujson.dumps(cookie))
    
    newPartyCookie = await p.server.redis.hget(PartyCacheCurrent, p.id)
    newPartyCookie = newPartyCookie.decode('utf-8')
    
    await p.send_xt('mdvlp', newPartyCookie)

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
        await p.send_packet('mdvlp', cookie)
        await p.send_partypacket('mdvls', '{"unlockDayIndex":' + str(TotalDayParty()) + ',"potionsPerGame":5,"coinsPerGame":50,"maxPotions":99,"maxSpeed":200,"recipes":[{"ingredientIds":[0, 3, 4, 1, 2, 0, 3, 4]},{"ingredientIds":[2, 1, 4, 1, 0, 2, 1, 4]},{"ingredientIds":[0, 0, 3, 3, 4, 4, 1, 1]},{"ingredientIds":[2, 2, 1, 1, 4, 4, 1, 1]},{"ingredientIds":[2, 0, 1, 0, 4, 0, 3, 0]},{"ingredientIds":[0, 3, 4, 1, 1, 4, 3, 0]},{"ingredientIds":[1, 2, 1, 2, 4, 3, 4, 3]},{"ingredientIds":[0, 3, 3, 4, 4, 4, 1, 2]},{"ingredientIds":[4, 0, 2, 3, 3, 2, 0, 4]},{"ingredientIds":[1, 5, 4, 5, 3, 5, 0, 5]}]}')