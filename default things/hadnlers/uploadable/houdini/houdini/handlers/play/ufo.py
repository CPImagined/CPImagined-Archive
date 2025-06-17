import random
from datetime import datetime

from houdini import handlers

import asyncio

UFO_TIMES = {
    4: 801,
    9: 300,
    14: 809,
    19: 807,
    24: 435,
    29: 810,
    39: 230,
    44: 200,
    49: 400,
    54: 800,
    59: 100,
}

async def abduct_random_penguin(server, room):
    if len(room.penguins_by_id) <= 0:
        return
        
    penguin = random.choice(list(room.penguins_by_id.copy().values()))
    
    await penguin.add_inventory(server.items[21052])
    await room.send_xt('beamup', penguin.id)

async def wait_for_next_abduction(server):
    server.logger.info('wait for the next 00 seconds')
    await asyncio.sleep(60 - datetime.now().second)
    while True:
        current_time = datetime.now()
        minute = current_time.minute
        if minute in UFO_TIMES:
            
            abduct_room = server.rooms[UFO_TIMES[minute]]
            server.logger.info(f'Currently going to abduct random penguins in {abduct_room.name}')
            await abduct_random_penguin(server, abduct_room)
        
        await asyncio.sleep(60)

@handlers.boot
async def server_boot(server):
    server.abduction_loop = asyncio.create_task(wait_for_next_abduction(server))
