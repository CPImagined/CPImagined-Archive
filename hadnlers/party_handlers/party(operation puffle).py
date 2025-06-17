import ujson
import random

from houdini import handlers
from houdini.data.penguin import Penguin
from houdini.handlers import XTPacket
from houdini.handlers.play.navigation import handle_join_player_room, handle_join_room, handle_join_server
from datetime import datetime, timedelta

CookieHandlerId = 20131120

StartParty = datetime(2020, 7, 12, 00, 00, 0)#date[year month day hour minute sec] for start party
EndParty = datetime(2022, 8, 3, 00, 00, 0)#date[year month day hour minute sec] for end party

CookieHandlerName = "epfparty"
PartyCacheCurrent = "epf_party" #if you have a repeated party, it is advisable to make a different name every time

DefaultPartyCookie = {
    'garyMessageViewed': 0,
    'directorVideoViewed': 0,
    'score': [0] * 10,
    'goldenItemIdsUnlocked': 0,
    'goldenItemIds': [4981,3183,6207,5382,127],
    'endGameUnlocked': 0,
    'endGameWon': 0,
    'coinBonusCollected': 0
}


def TotalDayParty():#this is the number of days already passed in the party
    return (datetime.now() - StartParty).days

@handlers.handler(XTPacket(CookieHandlerName, 'epfpartycookie'))
async def handle_party_cookie(p):
    cookie = await p.server.redis.hget(PartyCacheCurrent, p.id)
    if cookie is None:
        cookie = ujson.dumps(DefaultPartyCookie)
        await p.server.redis.hset(PartyCacheCurrent, p.id, cookie)
    else:
        cookie = cookie.decode('utf-8')
    await p.send_xt('epfpartycookie', cookie)


@handlers.handler(XTPacket(CookieHandlerName, 'epfpartymessaged'))
async def handle_party_message_viewed(p, message_index: int):
    cookie = await p.server.redis.hget(PartyCacheCurrent, p.id)
    cookie = ujson.loads(cookie)
    
    if(message_index == 0):
        cookie['directorVideoViewed'] = 1
    if(message_index == 1):
        cookie['garyMessageViewed'] = 1
    
    await p.server.redis.hset(PartyCacheCurrent, p.id, ujson.dumps(cookie))
    
    newPartyCookie = await p.server.redis.hget(PartyCacheCurrent, p.id)
    newPartyCookie = newPartyCookie.decode('utf-8')
    
    await p.send_xt('epfpartycookie', newPartyCookie)
    
@handlers.handler(XTPacket(CookieHandlerName, 'epfpartyendgame'))
async def handle_party_end_game(p, message_index: int):
    cookie = await p.server.redis.hget(PartyCacheCurrent, p.id)
    cookie = ujson.loads(cookie)
    
    if(cookie['endGameWon'] == 0):
        await p.update(coins=p.coins+5000).apply()
        await p.send_xt('dc', p.coins)
        cookie['endGameWon'] = 1
        cookie['coinBonusCollected'] = 1
    
    await p.server.redis.hset(PartyCacheCurrent, p.id, ujson.dumps(cookie))
    
    newPartyCookie = await p.server.redis.hget(PartyCacheCurrent, p.id)
    newPartyCookie = newPartyCookie.decode('utf-8')
    
    await p.send_xt('epfpartycookie', newPartyCookie)

@handlers.handler(XTPacket(CookieHandlerName, 'epfpartyminigame'))
async def handle_party_end_minigame(p, chipId: int, gameCompleted: int, pufflesCollected: int, coinsEarned: int, itemId: str, coinBonus: int):
    cookie = await p.server.redis.hget(PartyCacheCurrent, p.id)
    cookie = ujson.loads(cookie)
    
    if(pufflesCollected > cookie['score'][chipId]):
        cookie['score'][chipId] = pufflesCollected
        
    cookie['goldenItemIdsUnlocked'] = pufflesCollected
    #cookie['coinBonusCollected'] += coinBonus
    
    await p.update(coins=p.coins+coinsEarned+coinBonus).apply()
    await p.send_xt('dc', p.coins)
    
    if(sum(cookie['score']) >= 50):
        cookie['endGameUnlocked'] = 1
    
    await p.server.redis.hset(PartyCacheCurrent, p.id, ujson.dumps(cookie))
    
    newPartyCookie = await p.server.redis.hget(PartyCacheCurrent, p.id)
    newPartyCookie = newPartyCookie.decode('utf-8')
    
    await p.send_line(f'%xt%epfpartyminigame%{chipId}%{coinsEarned}%{coinBonus}%{p.coins}%{newPartyCookie}%')
    await p.send_xt('epfpartycookie', newPartyCookie)

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
        await p.send_packet('epfpartycookie', cookie)
        await p.send_partypacket('epfpartysettings', TotalDayParty())#party day