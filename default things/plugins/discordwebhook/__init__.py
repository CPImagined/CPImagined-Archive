from houdini.plugins import IPlugin
from houdini import handlers
from discord_webhook import DiscordWebhook, DiscordEmbed
from houdini.handlers import XTPacket
from houdini.handlers.games import determine_coins_earned, game_over_cooling
import difflib
import time

chatlogwebhook = 'https://discord.com/api/webhooks/1009550237293101116/DNYvY8byUM9fDH7SV1vY8ZxwkeE-rdqHeEyXBqbn4miR3OJIe6-blPHfUhHGbG2q4mEX'
coinslogwebhook = 'https://discord.com/api/webhooks/1183971169511166022/FXn4nigINKLLMitUbszEl0i-zZ0JGFYfS4Co0BoZ1k1s8HuBtoZnpbPM2GgozmPNxl7Z'
connectionlogwebhook = 'https://discord.com/api/webhooks/1183971169511166022/FXn4nigINKLLMitUbszEl0i-zZ0JGFYfS4Co0BoZ1k1s8HuBtoZnpbPM2GgozmPNxl7Z'
newswebhook = 'https://discord.com/api/webhooks/1133882122604658790/AR8Bxziz6NufyhxJ4xOSugFF-Pa7RjIP5oX1vwwpWO2VP4aOZuwJcdwkCVK8indPRain'


class DiscordWebhookLogger(IPlugin):
    author = "Allinol"
    description = "Discord Webhook plugin"
    version = "1.0.0"

    def __init__(self, server):
        super().__init__(server)

        self.items_by_name = None

    async def ready(self):
        self.server.logger.info("Discord webhook logger ready!")
        
        
    @handlers.handler(XTPacket('j', 'js'), pre_login=True)   
    async def connected_logger(self, p):
        webhook = DiscordWebhook(url=connectionlogwebhook, content=f'**{p.username}** connected to **{p.server.config.name}**')
        response = webhook.execute()
    
    @handlers.disconnected
    @handlers.player_attribute(joined_world=True)
    async def disconnected(self, p):
        webhook = DiscordWebhook(url=connectionlogwebhook, content=f'**{p.username}** disconnected')
        response = webhook.execute()
    
    @handlers.handler(XTPacket('zo', ext='z'))
    @handlers.cooldown(10, callback=game_over_cooling)
    async def coins_logger(self, p, score: int):
        coins_earned = determine_coins_earned(p, score)
        webhook = DiscordWebhook(url=coinslogwebhook, content=f'**{p.username}** earned **{coins_earned}**')
        response = webhook.execute()
        
    @handlers.handler(XTPacket('m', 'sm'))   
    async def chat_logger(self, p, penguin_id: int, message: str):
        if message:
            webhook = DiscordWebhook(url=chatlogwebhook, content=f'**{p.username}** said `{message}` in **{p.room.name}** while connected to **{self.server.config.name}**')
            response = webhook.execute()

    @handlers.handler(XTPacket('u', 'submission'))   
    async def news_submissions(self, p, category: str, content: str):
        webhook = DiscordWebhook(url=newswebhook, content=f'**{p.username}** sent in category `{category}`:\n```{content}```')
        response = webhook.execute()