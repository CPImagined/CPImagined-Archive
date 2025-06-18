import ujson
import asyncio

from houdini import handlers
from houdini.handlers.play.navigation import handle_join_player_room, handle_join_room, handle_join_server
from houdini.handlers import XTPacket

COOKIE_HANDLER_PARTY = 20240101

COOKIE_HANDLER_NAME = "template"
PARTY_CACHE_CURRENT = "halloween2024pre"

DEFAULT_PARTY_COOKIE = {
    'msg': [0] * 20,
    'qcmsg': [0] * 20,
    'trans': [0] * 20,
    'task': [0] * 20
}

PARTY_SETTINGS = {
    "day": 14
}


@handlers.handler(XTPacket(COOKIE_HANDLER_NAME, 'templatec'))
async def handle_party_cookie(p):
    await send_party_cookie(p)


@handlers.handler(XTPacket(COOKIE_HANDLER_NAME, 'templatemsgviewed'))
async def handle_party_message_viewed(p, message_index: int):
    p.cookie['msg'][message_index] = 1
    await send_party_cookie(p)


@handlers.handler(XTPacket(COOKIE_HANDLER_NAME, 'templateqcmsgviewed'))
async def handle_party_qc_message_viewed(p, message_index: int):
    p.cookie['qcmsg'][message_index] = 1
    await send_party_cookie(p)


@handlers.handler(XTPacket(COOKIE_HANDLER_NAME, 'templatetaskcomplete'))
async def handle_party_task_complete(p, task_index: int):
    p.cookie['task'][task_index] = 1
    await send_party_cookie(p)
    

async def send_party_cookie(p):
    cookie = ujson.dumps(p.cookie)
    await p.server.redis.hset(PARTY_CACHE_CURRENT, p.id, cookie)
    await p.send_xt('templatec', cookie)


@handlers.handler(XTPacket('j', 'js'), after=handle_join_server)
@handlers.allow_once
async def handle_get_partysettings(p, *args, **kwargs):
    cookie = await p.server.redis.hget(PARTY_CACHE_CURRENT, p.id)
    if cookie is None:
        p.cookie = DEFAULT_PARTY_COOKIE
        cookie = ujson.dumps(p.cookie)
        
        await p.server.redis.hset(PARTY_CACHE_CURRENT, p.id, cookie)

    p.cookie = ujson.loads(cookie)
    await p.send_xt('activefeatures', COOKIE_HANDLER_PARTY)
    await p.send_xt('templates', ujson.dumps(PARTY_SETTINGS))
    await send_party_cookie(p)