import ujson

from houdini import handlers
from houdini.handlers import XTPacket
from houdini.handlers.play.navigation import handle_join_player_room, handle_join_room, handle_join_server
import time
from datetime import datetime, timedelta

IsPartyEnabled = True

TotalPartyDays = 16
PartyDateNow = 20200612
CookieHandlerName = "party"
PartyCacheCurrent = "puffle2016"

DefaultPartyCookie = {
    'msgViewedArray': [1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
    'communicatorMsgArray': [0] * 5,
    'questTaskStatus': [0] * 16
}
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
    await p.send_packet('partycookie', cookie)


@handlers.handler(XTPacket(CookieHandlerName, 'msgviewed'))
@handlers.depends_on_packet(XTPacket(CookieHandlerName, 'partycookie'))
async def handle_party_message_viewed(p, message_index: int):
    cookie = await p.server.redis.hget(PartyCacheCurrent, p.id)
    cookie = ujson.loads(cookie)

    cookie['msgViewedArray'][message_index] = 1

    await p.server.redis.hset(PartyCacheCurrent, p.id, ujson.dumps(cookie))


@handlers.handler(XTPacket(CookieHandlerName, 'qcmsgviewed'))
@handlers.depends_on_packet(XTPacket(CookieHandlerName, 'partycookie'))
async def handle_party_communicator_message_viewed(p, message_index: int):
    cookie = await p.server.redis.hget(PartyCacheCurrent, p.id)
    cookie = ujson.loads(cookie)

    cookie['communicatorMsgArray'][message_index] = 1

    await p.server.redis.hset(PartyCacheCurrent, p.id, ujson.dumps(cookie))


@handlers.handler(XTPacket('party', 'qtaskcomplete'))
@handlers.depends_on_packet(XTPacket(CookieHandlerName, 'partycookie'))
async def handle_party_task_complete(p, task_index: int):
    cookie = await p.server.redis.hget(PartyCacheCurrent, p.id)
    cookie = ujson.loads(cookie)

    cookie['questTaskStatus'][task_index] = 1

    await p.server.redis.hset(PartyCacheCurrent, p.id, ujson.dumps(cookie))


@handlers.handler(XTPacket('j', 'js'), after= handle_join_server)
@handlers.allow_once
async def handle_get_partysettings(p):
    if (IsPartyEnabled !=False) :
        await p.send_xt('activefeatures', '20160301')
        await p.send_partypacket('partyservice', '{"partySettings":{"unlockDayIndex":16,"numOfDaysInParty":16},"partyStartDate":"2015-10-21 00:00:00","partyEndDate":"2015-11-05 00:00:00"}')
