from houdini import handlers
from houdini.handlers import XTPacket
from houdini.handlers.play.igloo import get_layout_like_count
from houdini.data.item import Item
from houdini.penguin import Penguin


@handlers.handler(XTPacket('g', 'gri'))
async def get_open_igloos(p, igloo_id: int):
    async def get_igloo_string(igloo):
        owner_name = p.server.penguins_by_id[igloo.penguin_id].safe_name
        like_count = p.server.cache.get(f'layout_like_count.{igloo.id}')
        like_count = await get_layout_like_count(igloo.id) if like_count is None else like_count
        p.server.cache.set(f'layout_like_count.{igloo.id}', like_count)
        igloo_population = len(igloo.penguins_by_id)
        return f'{igloo.penguin_id}|{owner_name}|{like_count}|{igloo_population}|{int(igloo.locked)}'


    open_igloos = [await get_igloo_string(igloo) for penguin_id, igloo in p.server.open_igloos_by_penguin_id.items() if penguin_id != p.id and igloo.type == igloo_id]
    local_room_population = 0
    
    own_layout_like_count = 0 if p.igloo is None else await get_layout_like_count(p.igloo)
    await p.send_xt('gri', own_layout_like_count, local_room_population, *open_igloos)