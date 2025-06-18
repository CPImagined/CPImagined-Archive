from discord_webhook import DiscordWebhook, DiscordEmbed
from houdini import handlers
from houdini.handlers import Priority, XMLPacket, XTPacket

connectionlogwebhook = 'https://discord.com/api/webhooks/1183971169511166022/FXn4nigINKLLMitUbszEl0i-zZ0JGFYfS4Co0BoZ1k1s8HuBtoZnpbPM2GgozmPNxl7Z'

clothing = [14444, 11314, 14445, 471, 9124]
furniture = [260, 2270, 2271, 2272]
puffle = [50]
igloo = [76]
location = [3]


def cheater():
    webhook = DiscordWebhook(url=connectionlogwebhook, content=f'**{p.username}** attempted to cheat ID **{item}** (Not in defined list)')
    response = webhook.execute()

@handlers.handler(XTPacket('i', 'calendaritem'))
async def handle_calendar_inventory(p, item: int):
    if item in clothing:
        await p.add_inventory(p.server.items[item], cost=0)
    else:
        cheater()

@handlers.handler(XTPacket('i', 'calendarfurn'))
async def handle_calendar_furniture(p, item: int):
    if item in furniture:
        await p.add_furniture(p.server.furniture[item], cost=0)
    else:
        cheater()

@handlers.handler(XTPacket('i', 'calendarpuff'))
async def handle_calendar_puffle_item(p, item: int):
    if item in puffle:
        await p.add_puffle_item(p.server.puffle_items[item], cost=0)
    else:
        cheater()

@handlers.handler(XTPacket('i', 'calendariggy'))
async def handle_calendar_igloo(p, item: int):
    if item in igloo:
        await p.add_igloo(p.server.igloos[item], cost=0)
    else:
        cheater()

@handlers.handler(XTPacket('i', 'calendarloco'))
async def handle_calendar_location(p, item: int):
    if item in location:
        await p.add_location(p.server.locations[item], cost=0)
    else:
        cheater()