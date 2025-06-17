import ujson
import asyncio

from houdini import handlers
from houdini.data import db
from houdini.handlers import XTPacket
from houdini.data.penguin import PartyQuest, PartyQuestCollection

@handlers.handler(XTPacket('party', 'isquestcomplete'))
async def handle_quest_packet(p, penguin_id: int, quest_id: int):
    quest_completion = await PartyQuest.query.where((PartyQuest.penguin_id == penguin_id)
                                                    & (PartyQuest.quest_id == quest_id)).gino.all()
    if len(quest_completion) >= 1:
        await p.send_xt('igloobashquest', quest_id)

    if len(quest_completion) < 1:
        await p.send_xt('igloobashquestincomplete', quest_id)


@handlers.handler(XTPacket('party', 'questcompletion'))
async def handle_quest_completion(p, penguin_id: int, quest_id: int):
    p.quest = await PartyQuestCollection.get_collection(p.id)
    await p.quest.insert(penguin_id=penguin_id, quest_id=quest_id)
    await p.send_xt('igloobashquestcomplete', quest_id)
