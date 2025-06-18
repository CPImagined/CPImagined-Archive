from houdini import handlers
from houdini.data import db
from houdini.handlers import XTPacket
from houdini.data.guides import PuffleGuide, PenguinPuffleGuide
from datetime import datetime, timedelta
from random import choice
from time import sleep

## NOTE: this code probably sucks this is my first time working
## with the database directly please be nice ;(

# define valid ids
rooms = [750, 751, 752]
puffles = [0, 1, 2, 3, 4]

# static ids
PUFFLEWILD_ID = 436
LODGE_ID = 220

# return random room
async def get_room():
    return choice(rooms)

# return random puffle
async def get_puffle():
    return choice(puffles)

# return data
async def request_data(p):
    # check for if this penguin already exists
    dataExists = await PenguinPuffleGuide.query.where((PenguinPuffleGuide.penguin_id == p.id)).gino.scalar()

    # if not, create it
    if dataExists is None:
        randRoom = await get_room()
        randPuff = await get_puffle()
        await PenguinPuffleGuide.create(penguin_id=p.id, room_id=randRoom, puffle_id=randPuff)
    
    # get the data
    currentId = await PenguinPuffleGuide.select('guide_id').where(PenguinPuffleGuide.penguin_id == p.id).gino.scalar()
    currentType = await PuffleGuide.select('type').where(PuffleGuide.id == currentId).gino.scalar()
    currentItem = await PuffleGuide.select('item_id').where(PuffleGuide.id == currentId).gino.scalar()

    currentDate = 1638073500
    currentRoom = await PenguinPuffleGuide.select('room_id').where(PenguinPuffleGuide.penguin_id == p.id).gino.scalar()
    currentPuffle = await PenguinPuffleGuide.select('puffle_id').where(PenguinPuffleGuide.penguin_id == p.id).gino.scalar()
    inProgress = await PenguinPuffleGuide.select('in_progress').where(PenguinPuffleGuide.penguin_id == p.id).gino.scalar()
    complete = await PenguinPuffleGuide.select('complete').where(PenguinPuffleGuide.penguin_id == p.id).gino.scalar()

    await p.send_xt('pgrd', currentType, currentItem, currentDate, currentRoom, currentPuffle, inProgress, complete, True)

# update task with new values + date
async def update_task(p):
    # get the data
    randRoom = await get_room()
    randPuff = await get_puffle()
    currentId = await PenguinPuffleGuide.select('guide_id').where(PenguinPuffleGuide.penguin_id == p.id).gino.scalar()

    highest = await db.select([db.func.max(PuffleGuide.id)]).gino.scalar()

    # make sure we dont go over the limit
    if currentId >= highest:
        currentId = highest
    else:
        currentId += 1

    # update all the things
    await PenguinPuffleGuide.update.values(guide_id=currentId).where(PenguinPuffleGuide.penguin_id == p.id).gino.status()
    await PenguinPuffleGuide.update.values(unlock_date=datetime.now() + timedelta(days=1)).where(PenguinPuffleGuide.penguin_id == p.id).gino.status()
    await PenguinPuffleGuide.update.values(room_id=randRoom).where(PenguinPuffleGuide.penguin_id == p.id).gino.status()
    await PenguinPuffleGuide.update.values(puffle_id=randPuff).where(PenguinPuffleGuide.penguin_id == p.id).gino.status()
    await PenguinPuffleGuide.update.values(in_progress=False).where(PenguinPuffleGuide.penguin_id == p.id).gino.status()
    await PenguinPuffleGuide.update.values(complete=False).where(PenguinPuffleGuide.penguin_id == p.id).gino.status()

    # resend data to the client
    await request_data(p)

# puffle guides request data
@handlers.handler(XTPacket('pg', 'pgrd'))
async def handle_puffle_guides_request_data(p):
    await request_data(p)

# puffle guides collect reward
@handlers.handler(XTPacket('pg', 'pgcr'))
async def handle_puffle_guides_collect_reward(p):
    # get the data
    currentId = await PenguinPuffleGuide.select('guide_id').where(PenguinPuffleGuide.penguin_id == p.id).gino.scalar()
    #currentDate = await PenguinPuffleGuide.select('unlock_date').where(PenguinPuffleGuide.penguin_id == p.id).gino.scalar()
    inProgress = await PenguinPuffleGuide.select('in_progress').where(PenguinPuffleGuide.penguin_id == p.id).gino.scalar()
    complete = await PenguinPuffleGuide.select('complete').where(PenguinPuffleGuide.penguin_id == p.id).gino.scalar()
    
    currentType = await PuffleGuide.select('type').where(PuffleGuide.id == currentId).gino.scalar()
    currentItem = await PuffleGuide.select('item_id').where(PuffleGuide.id == currentId).gino.scalar()

    # make sure the date is actually valid
    #if not currentDate < datetime.now():
        #p.logger.warn("CHEATER! pg#pgcr sent before task available! I want this guy killed. Clean shot.")
        #return

    # ensure the task is complete
    if not complete or not inProgress:
        p.logger.warn("CHEATER! pg#pgcr sent without completion! I want this guy killed. Clean shot.")
        return

    # check for coins
    if currentType == "coins":
        await p.update(coins=p.coins + currentItem).apply()
        await p.send_xt('pgcc', currentItem, p.coins)
        await update_task(p)
        return

    await p.add_inventory(p.server.items[currentItem], cost=0)

    await update_task(p)

# puffle guides start task
@handlers.handler(XTPacket('pg', 'pgst'))
async def handle_puffle_guides_start_task(p):
    # get the data
    #currentDate = await PenguinPuffleGuide.select('unlock_date').where(PenguinPuffleGuide.penguin_id == p.id).gino.scalar()
    inProgress = await PenguinPuffleGuide.select('in_progress').where(PenguinPuffleGuide.penguin_id == p.id).gino.scalar()
    complete = await PenguinPuffleGuide.select('complete').where(PenguinPuffleGuide.penguin_id == p.id).gino.scalar()

    # make sure the date is actually valid
    #if not currentDate < datetime.now():
        #p.logger.warn("CHEATER! pg#pgst sent before task available! I want this guy killed. Clean shot.")
        #return

    # set in progress
    await PenguinPuffleGuide.update.values(in_progress=True).where(PenguinPuffleGuide.penguin_id == p.id).gino.status()

    # go to pufflewild
    sleep(1)
    await p.join_room(p.server.rooms[PUFFLEWILD_ID])

# puffle guides find puffle
@handlers.handler(XTPacket('pg', 'pgfp'))
async def handle_puffle_guides_find_puffle(p, puffleId: int):
    # get the data
    #currentDate = await PenguinPuffleGuide.select('unlock_date').where(PenguinPuffleGuide.penguin_id == p.id).gino.scalar()
    inProgress = await PenguinPuffleGuide.select('in_progress').where(PenguinPuffleGuide.penguin_id == p.id).gino.scalar()
    complete = await PenguinPuffleGuide.select('complete').where(PenguinPuffleGuide.penguin_id == p.id).gino.scalar()
    currentPuffle = await PenguinPuffleGuide.select('puffle_id').where(PenguinPuffleGuide.penguin_id == p.id).gino.scalar()

    # make sure the date is actually valid
    #if not currentDate < datetime.now():
        #p.logger.warn("CHEATER! pg#pgst sent before task available! I want this guy killed. Clean shot.")
        #return

    # ensure the task is complete
    if not inProgress:
        p.logger.warn("CHEATER! pg#pgfp sent without starting! I want this guy killed. Clean shot.")
        return

    # make sure the correct puffle is returned
    if puffleId != currentPuffle:
        p.logger.warn("CHEATER! pg#pgfp sent with incorrect puffle id! I want this guy killed. Clean shot.")
        return

    # set completion
    await PenguinPuffleGuide.update.values(complete=True).where(PenguinPuffleGuide.penguin_id == p.id).gino.status()

    # go to lodge
    sleep(3)
    await p.join_room(p.server.rooms[LODGE_ID])