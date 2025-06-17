from houdini.plugins import IPlugin
from houdini import handlers
from houdini.handlers import XTPacket, Priority, XMLPacket
from houdini.data.outfit import Outfit

import ujson

class outfitSaver(IPlugin):
    author = "Reed"
    description = "Outfit Saver"
    version = "1.0.0"

    def __init__(self, server):
        super().__init__(server)

    async def ready(self):
        self.outfits = {}

   #Code is ass but oh well
    @handlers.handler(XMLPacket('login'), priority=Priority.Low) 
    @handlers.allow_once
    async def handle_load_outfits(self, p):
        
        insertOutfitDataExists = await Outfit.query.where((Outfit.player_id == p.id)).gino.scalar()
        if insertOutfitDataExists is None:
            await Outfit.create(player_id=p.id)

        self.outfits = await Outfit.select('outfit_data').where(Outfit.player_id == p.id).gino.scalar()
        await p.send_xt('loadcurroutfit', self.outfits)


    @handlers.handler(XTPacket('outfit', 'save'))
    @handlers.cooldown(1)
    async def handle_outfit_save(self, p, outfitName: str, slot_id: str, colour_id: int, head: int, face: int, neck: int, body: int, hand: int, feet: int):
        try:
           self.outfits = await Outfit.select('outfit_data').where(Outfit.player_id == p.id).gino.scalar()
           outfitData = ujson.loads(self.outfits)
           outfitData['slot'+ slot_id]['name'] = outfitName
           outfitData['slot'+ slot_id]['head'] = head
           outfitData['slot'+ slot_id]['face'] = face
           outfitData['slot'+ slot_id]['body'] = body
           outfitData['slot'+ slot_id]['neck'] = neck
           outfitData['slot'+ slot_id]['hand'] = hand
           outfitData['slot'+ slot_id]['feet'] = feet
           outfitData['slot'+ slot_id]['color'] = colour_id
           self.outfits = ujson.dumps(outfitData)

           await Outfit.update.values(outfit_data=self.outfits).where(Outfit.player_id == p.id).gino.status()
           await p.send_xt('saveoutfit', self.outfits)  

        except Exception as e:
            print(f"Error(s): {e}")
    

    @handlers.handler(XTPacket('outfit', 'delete'))
    @handlers.cooldown(1)
    async def handle_outfit_delete(self, p, slot_id: str):
        try:
           self.outfits = await Outfit.select('outfit_data').where(Outfit.player_id == p.id).gino.scalar()
           outfitData = ujson.loads(self.outfits)
           outfitData['slot'+ slot_id]['name'] = ""
           outfitData['slot'+ slot_id]['head'] = 0
           outfitData['slot'+ slot_id]['face'] = 0
           outfitData['slot'+ slot_id]['body'] = 0
           outfitData['slot'+ slot_id]['neck'] = 0
           outfitData['slot'+ slot_id]['hand'] = 0
           outfitData['slot'+ slot_id]['feet'] = 0
           outfitData['slot'+ slot_id]['color'] = 0
           self.outfits = ujson.dumps(outfitData)

           await Outfit.update.values(outfit_data=self.outfits).where(Outfit.player_id == p.id).gino.status()
           await p.send_xt('delcurrfit', self.outfits)  

        except Exception as e:
            print(f"Error(s): {e}")
    

