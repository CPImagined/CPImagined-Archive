from houdini.plugins import IPlugin
from houdini import commands
from houdini.data.penguin import Penguin
from houdini import permissions
from houdini.data.room import Room
from houdini.handlers.play.moderation import moderator_ban,moderator_kick
from houdini.data import db
from houdini.data.mail import PenguinPostcard
from houdini.data.buddy import IgnoreList
import difflib
import time
from houdini.data.moderator import Ban


class WaddleOn(IPlugin):
    author = "Allinol"
    description = "WaddleOn Moderator Commands"
    version = "1.0.0"

    def __init__(self, server):
        super().__init__(server)

        self.items_by_name = None

    async def ready(self):
        await self.server.permissions.register('waddleon.jr')
        await self.server.permissions.register('waddleon.ai')
        await self.server.permissions.register('waddleon.ac')
        await self.server.permissions.register('waddleon.pay')
        await self.server.permissions.register('waddleon.ban')  
        await self.server.permissions.register('waddleon.kick')
        await self.server.permissions.register('waddleon.tp')
        await self.server.permissions.register('waddleon.summon')
        await self.server.permissions.register('waddleon.addall')
        await self.server.permissions.register('waddleon.tf')
        await self.server.permissions.register('waddleon.global')
        await self.server.permissions.register('waddleon.ufo')
        await self.server.permissions.register('waddleon.cards')
        self.items_by_name = {item.name: item for item in self.server.items.values()}

    @commands.command('addall')
    @permissions.has_or_moderator('waddleon.addall')
    async def add_all(self, p):
        for a in self.server.items.values():
            await p.add_inventory(a, cost=0)
        for b in self.server.stamps.values():
            await p.add_stamp(b)
        for c in self.server.igloos.values():
            await p.add_igloo(c, cost=0)
        for d in self.server.furniture.values():
            await p.add_furniture(d, cost=0)
        for e in self.server.locations.values():
            await p.add_location(e, cost=0)
        for f in self.server.flooring.values():
            await p.add_flooring(f, cost=0)
        for g in self.server.cards.values():
            await p.add_card(g)

    @commands.command('puffle')
    @permissions.has_or_moderator('waddleon.addall')
    async def add_all(self, p):
        for a in self.server.puffle_items.values():
            await p.add_puffle_item(a, cost=0)

    @commands.command('af')
    @permissions.has_or_moderator('waddleon.addall')
    async def af(self, p):
        for a in self.server.igloos.values():
            await p.add_igloo(a, cost=0)
        for b in self.server.furniture.values():
            await p.add_furniture(b, cost=0)
        for c in self.server.locations.values():
            await p.add_location(c, cost=0)
        for d in self.server.flooring.values():
            await p.add_flooring(d, cost=0)

    @commands.command('room', alias=['jr'])
    @permissions.has_or_moderator('waddleon.jr')
    async def join_room(self, p, room: Room):
        if room is not None:
            await p.join_room(room)
        else:
            await p.send_xt('mm', 'Room does not exist!', p.id)

    @commands.command('ban')
    @permissions.has_or_moderator('waddleon.ban') #Example !BAN NotCool 24 Allinol Sucks
    async def ban_penguin(self, p, message:str, duration: int = 24, *player: str):
      player = ' '.join(player)

      try:
        player = player.lower()
        penguin_id = await Penguin.select('id').where(Penguin.username == player).gino.first()
        if penguin_id == None:
            await p.send_xt('mm', 'Player is invalid!', p.id)
            return
        else:
            penguin_id = int(penguin_id[0])
        banned = p.server.penguins_by_id[penguin_id]
        if duration == 0:
            await Penguin.update.values(permaban=True).where(Penguin.username == player).gino.status()
            await banned.close()
            return
        else:
            await moderator_ban(p, penguin_id, hours=duration, comment=message)   
            await banned.close()
            return
      except AttributeError:
        await p.send_xt('mm', 'Player is invalid!', p.id)

    @commands.command('unban')
    @permissions.has_or_moderator('waddleon.ban')
    async def unban_penguin(self, p, *player: str):
        player = ' '.join(player)

        player = player.lower() 
        penguin_id = await Penguin.select('id').where(Penguin.username == player).gino.first()
        if penguin_id == None:
            await p.send_xt('mm', 'Player is invalid!', p.id)
            return
        else:
            penguin_id = int(penguin_id[0])       
        if duration == 0:
            await Penguin.update.values(permaban=False).where(Penguin.username == player).gino.status()
        else:
            await Ban.delete.where(Ban.penguin_id == penguin_id).gino.status()


    @commands.command('kick')
    @permissions.has_or_moderator('waddleon.kick')
    async def kick_penguin(self, p, *player: str):
        player = ' '.join(player)

        try:
            player = player.lower()
            penguin_id = await Penguin.select('id').where(Penguin.username == player).gino.first()
            if penguin_id == None:
                await p.send_xt('mm', 'Player is invalid!', p.id)
                return
            else:
                penguin_id = int(penguin_id[0])
            await moderator_kick(p, penguin_id)
        except AttributeError:
            await p.send_xt('mm', 'Player is invalid!', p.id)


    @commands.command('ai')
    @permissions.has_or_moderator('waddleon.ai')
    async def add_item(self, p, *item_query: str):
        item_query = ' '.join(item_query)

        try:
            if item_query.isdigit():
                item = self.server.items[int(item_query)]
            else:
                item_name = difflib.get_close_matches(item_query, self.items_by_name.keys(), n=1)
                item = self.items_by_name[item_name[0]]

            await p.add_inventory(item, cost=0)
        except (IndexError, KeyError):
            await p.send_xt('mm', 'Item does not exist!', p.id)

    @commands.command('ac')
    @permissions.has_or_moderator('waddleon.ac')
    async def add_coins(self, p, amount: int = 100):
            await p.add_coins(amount, stay=True)  

    @commands.command('tf')
    @permissions.has_or_moderator('waddleon.tf')
    async def change_avatar(self, p, avatar_id: int):
            p.avatar = avatar_id
            await p.room.send_xt('spts', p.id, avatar_id)
            
    @commands.command('pay')
    @permissions.has_or_moderator('waddleon.pay')
    async def pay_coins(self, p, amount: int, *receiver):
        receiver = ' '.join(receiver)
        
        receiver = receiver.lower()
        count = await Penguin.select('coins').where(Penguin.id == p.id).gino.first()
        count = int(count[0])
        receivercount = await Penguin.select('coins').where(Penguin.username == receiver).gino.first()
        receivercount = int(receivercount[0])
        prid = await Penguin.select('id').where(Penguin.username == receiver).gino.first()
        prid = int(prid[0])
        try:
            t = p.server.penguins_by_id[prid]
            if p.username == receiver:
                await p.send_xt('mm', "You can't transfer to yourself!", p.id)
                return
            else:
                if count < amount:
                    await p.send_xt('mm', 'You don\'t have enough coins to transfer!', p.id)
                else:
                    updatedamount = count - amount
                    sentamount = receivercount + amount
                    await p.update(coins=count - amount).apply()
                    await t.update(coins=receivercount + amount).apply()
                    await p.send_xt('cdu', updatedamount, updatedamount)
                    await t.send_xt('cdu', sentamount, sentamount)
                    if amount > 0:
                        await p.send_xt('mm', f'Successfully transfered {amount} coins to {receiver}.', p.id)
                        await t.send_xt('mm', f"You've received {amount} coins from {p.nickname}!", prid)
                    else:
                        await p.send_xt('mm', f'Successfully took {amount} coins from {receiver}.', p.id)
                        await t.send_xt('mm', f"{p.nickname} stole {amount} coins from you!", prid)
        except KeyError:
            await p.send_xt('mm', 'Player is not online', p.id)
            
    @commands.command('tp')
    @permissions.has_or_moderator('waddleon.tp')
    async def tp(self, p, *player):
        player = ' '.join(player)
        player = player.lower()
        prid = await Penguin.select('id').where(Penguin.username == player).gino.first()
        prid = int(prid[0])
        try:
            t = p.server.penguins_by_id[prid]
            await p.join_room(t.room)
        except KeyError:
            await p.send_xt('mm', 'Player is not online!', p.id)

    @commands.command('summon')
    @permissions.has_or_moderator('waddleon.summon')
    async def summon(self, p, *player):
        player = ' '.join(player)
        player = player.lower()
        trid = await Penguin.select('id').where(Penguin.username == player).gino.first()
        trid = int(trid[0])
        try:
            y = p.server.penguins_by_id[trid]
            await y.join_room(p.room)
        except KeyError:
            await p.send_xt('mm', 'Player is not online!', p.id)

    @commands.command('summonall')
    @permissions.has_or_moderator('waddleon.summon')
    async def summonall(self, p):
        try:
            for y in p.server.penguins_by_id.values():
                await y.join_room(p.room)
        except KeyError:
            await p.send_xt('mm', 'something has gone catastrophically wrong', p.id)

    @commands.command('n')
    @permissions.has_or_moderator('waddleon.global')
    async def msgannounce(self, p, *msg: str):
        msg = ' '.join(msg)
        for i in p.server.penguins_by_id.values():
            await i.send_xt('gannounce', f'{msg}', p.id)

    @commands.command('g')
    @permissions.has_or_moderator('waddleon.global')
    async def msgglobal(self, p, *msg: str):
        msg = ' '.join(msg)
        for i in p.server.penguins_by_id.values():
            await i.send_xt('cprompt', f'{msg}', 'CPImagined')

    @commands.command('e')
    @permissions.has_or_moderator('waddleon.global')
    async def msgerrorglobal(self, p, *msg: str):
        msg = ' '.join(msg)
        for i in p.server.penguins_by_id.values():
            await i.send_xt('cerror', f'{msg}', 'CPImagined')

    @commands.command('mm')
    @permissions.has_or_moderator('waddleon.global')
    async def moderatormessages(self, p, type, *player):
        warning_type = 0
        if type == "igloo":
            warning_type = 1
        elif type == "wordw":
            warning_type = 2
        elif type == "kick":
            warning_type = 3
        elif type == "wordb":
            warning_type = 610
        elif type == "cheat":
            warning_type = 611
        elif type == "disres":
            warning_type = 612
        player = ' '.join(player)
        player = player.lower()
        trid = await Penguin.select('id').where(Penguin.username == player).gino.first()
        trid = int(trid[0])
        if warning_type != 0:
            try:
                y = p.server.penguins_by_id[trid]
                await y.send_xt('moderatormessage', warning_type)
            except KeyError:
                await p.send_xt('mm', 'Player is not online!', p.id)
        else:
            await p.send_xt('mm', 'Incorrect message key.', p.id)

    @commands.command('ufo')
    @permissions.has_or_moderator('waddleon.ufo')
    async def ufo(self, p, *player):
        player = ' '.join(player)
        player = player.lower()
        abid = await Penguin.select('id').where(Penguin.username == player).gino.first()
        abid = int(abid[0])
        try:
            h = p.server.penguins_by_id[abid]
            await h.room.send_xt('beamup', h.id)
        except KeyError:
            await p.send_xt('mm', 'Player is not online!', p.id)

    @commands.command('event')
    @permissions.has_or_moderator('waddleon.global')
    async def event(self, p):
        try:
            await p.room.send_xt('liveevent', p.id)
        except KeyError:
            await p.send_xt('mm', 'something has gone catastrophically wrong', p.id)

    @commands.command('event2')
    @permissions.has_or_moderator('waddleon.global')
    async def event2(self, p):
        try:
            await p.room.send_xt('liveevent2', p.id)
        except KeyError:
            await p.send_xt('mm', 'something has gone catastrophically wrong', p.id)

    @commands.command('users')
    @permissions.has_or_moderator('waddleon.tp')
    async def users(self, p):
        await p.send_xt('cprompt', f"There are {len(p.server.penguins_by_id)} users online.")

    @commands.command('weather')
    @permissions.has_or_moderator('waddleon.global')
    async def setweather(self, p, type, num, shadowNum):
        await p.room.send_xt('mweather', type, num, shadowNum)

    @commands.command('cards')
    @permissions.has_or_moderator('waddleon.cards')
    async def addallcards(self, p):
        for a in self.server.cards.values():
            await p.add_card(a)

    @commands.command('names')
    @permissions.has_or_moderator('waddleon.tp')
    async def names(self, p):
        usernames = ""
        for user in p.server.penguins_by_id.items():
            usernames += user[1].username + " (" + str(user[1].id) + ") " "| "
        usernames = usernames[:-3]
        await p.send_xt('cprompt', f"{usernames}")
    
    async def send_mail(self, p, recipient_id: int, postcard_id: int):
        mail_count = await db.select([db.func.count(PenguinPostcard.id)]).where(
            PenguinPostcard.penguin_id == recipient_id).gino.scalar()
        if recipient_id in p.server.penguins_by_id:
            recipient = p.server.penguins_by_id[recipient_id]
            if p.id in recipient.ignore:
                return await p.send_xt('ms', p.coins, 1)
            if mail_count >= 100:
                return await p.send_xt('ms', p.coins, 0)
            postcard = await PenguinPostcard.create(penguin_id=recipient_id, sender_id=p.id,
                                                    postcard_id=postcard_id)
            sent_timestamp = int(time.mktime(postcard.send_date.timetuple()))
            await recipient.send_xt('mr', p.safe_name, p.id, postcard_id, '', sent_timestamp, postcard.id)
        else:
            ignored = await IgnoreList.query.where((IgnoreList.penguin_id == recipient_id)
                                                & (IgnoreList.ignore_id == p.id)).gino.scalar()
            if ignored is not None:
                return await p.send_xt('ms', p.coins, 1)
            if mail_count >= 100:
                return await p.send_xt('ms', p.coins, 0)
            await PenguinPostcard.create(penguin_id=recipient_id, sender_id=p.id, postcard_id=postcard_id)
        return await p.send_xt('ms', p.coins, 1)

    @commands.command('postcard')
    @permissions.has_or_moderator('waddleon.global')
    async def postcardroom(self, p, postcard: int, *player: str):
        if player:
            try:
                player = ' '.join(player)
                player = player.lower()
                pcid = await Penguin.select('id').where(Penguin.username == player).gino.first()
                pcid = int(pcid[0])
                await self.send_mail(p, pcid, postcard)
            except KeyError:
                await p.send_xt('mm', 'Player is not online!', p.id)
        else:
            for j in p.room.penguins_by_id.values():
                await self.send_mail(p, j.id, postcard)

    @commands.command('concert')
    @permissions.has_or_moderator('waddleon.global')
    async def concert(self, p, concert):
        try:
            await p.room.send_xt('jamconcert', concert)
        except KeyError:
            await p.send_xt('mm', 'something has gone catastrophically wrong', p.id)