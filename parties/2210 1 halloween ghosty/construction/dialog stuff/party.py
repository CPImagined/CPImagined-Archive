import ujson
import asyncio

from houdini import handlers
from houdini.data import db
from houdini.handlers import XTPacket
from houdini.data.penguin import PartyQuest, PartyQuestCollection, FairTickets, FairTicketsCollection, LastSpin, LastSpinCollection

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


@handlers.handler(XTPacket('party', 'ticketcount'))
async def handle_get_tickets(p, penguin_id: int):
    playerTickets = await FairTickets.query.where(FairTickets.penguin_id == penguin_id).gino.all()

    if len(playerTickets) >= 1:
       await p.send_xt('ticketcount', playerTickets.tickets)


@handlers.handler(XTPacket('party', 'changeticketcount'))
async def handle_update_tickets(p, penguin_id: int, tickets: int):
    hasTicketEntry = await FairTickets.query.where(FairTickets.penguin_id == penguin_id).gino.all()

    if len(hasTicketEntry) < 1:
        await FairTickets.create(penguin_id=penguin_id)

        await FairTickets.update.values(tickets = tickets).where(
                FairTickets.penguin_id == penguin_id).gino.status()

    if len(hasTicketEntry) >= 1:
        await FairTickets.update.values(tickets = FairTickets.tickets + tickets).where(
                FairTickets.penguin_id == penguin_id).gino.status()

@handlers.handler(XTPacket('party', 'getlastspintime'))
async def handle_get_last_spin_time(p, penguin_id: int):
    playerLastSpinTime = LastSpin.query.where(LastSpin.penguin_id == penguin_id)
    async with db.transaction():
        async for penguinLastSpinTime in playerLastSpinTime.gino.iterate():
            if penguinLastSpinTime.last_spin >= 1:
                await p.send_xt('lastspintime', penguinLastSpinTime.last_spin)


@handlers.handler(XTPacket('party', 'setlastspintime'))
async def handle_set_last_spin_time(p, penguin_id: int, last_spin: int):
    hasSpinned = await LastSpin.query.where(LastSpin.penguin_id == penguin_id).gino.all()

    if len(hasSpinned) < 1:
        await LastSpin.create(penguin_id=penguin_id)

        await LastSpin.update.values(last_spin = last_spin).where(
                LastSpin.penguin_id == penguin_id).gino.status()

    if len(hasSpinned) >= 1:
        await LastSpin.update.values(last_spin = last_spin).where(
                LastSpin.penguin_id == penguin_id).gino.status()

