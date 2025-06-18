from houdini import handlers
from houdini import commands, permissions
from houdini.handlers import XTPacket
from houdini.handlers.play.navigation import handle_join_room, handle_join_server

import ujson

import logging
import random
import asyncio
import time

COOKIE_HANDLER_ID = 20130424
COOKIE_HANDLER_NAME = 'shp'
COOKIE_NAME = 'shp2013'
# Replace this permission name w/ whatever.
CMD_PERMISSION_NAME = 'shp_commands'

# Robot globals - these are above the default party cookie cuz it uses the max power value.
ROBOT_DAMAGE = 5
ROBOT_MAX_POWER = 40

DEFAULT_PARTY_COOKIE = {
    'glovePower': 1,
    'gloveTotal': 0,
    'robotPower': ROBOT_MAX_POWER,
    'snowballPower': 0,
    'built': [0] * 8,
    'inventory': [0] * 32
}
# 'snowballPower' seems to exist due to an oversight, so we can just ignore it and pretend it's not there.
# It's only used to compare against the max 'robotPower' on the client side, but with our current setup, it will never
# exceed the max power defined here.

# Glove globals
GLOVE_POWER_CONSUMPTION = 1

# Boss globals
WANT_BOSS = True

BOSS_ROOM = 851

ONE_MINUTE = 60

# An entire cycle is made up of both the attack phase and the cooldown phase.
BOSS_CYCLE_ATTACK_LENGTH = ONE_MINUTE * 2
BOSS_CYCLE_COOLDOWN_LENGTH = ONE_MINUTE * 18
BOSS_CYCLE_TOTAL_LENGTH = BOSS_CYCLE_COOLDOWN_LENGTH + BOSS_CYCLE_ATTACK_LENGTH

BOSS_APPEAR_TIME = BOSS_CYCLE_TOTAL_LENGTH - BOSS_CYCLE_ATTACK_LENGTH  # Boss appears at the start of the attack phase.

# At this time, the boss will start cycling the targets.
BOSS_START_TARGET_OFFSET = 20
BOSS_START_TARGET_TIME = BOSS_APPEAR_TIME + BOSS_START_TARGET_OFFSET

BOSS_NUM_SHOW_TARGETS = 3
BOSS_MAX_TARGETS = 6
BOSS_TARGET_CHOOSE_TIME = 5  # At multiples of this value, new targets will be shuffled in.

BOSS_MAX_HEALTH = 100
BOSS_DAMAGE = 5  # Damage dealt (or healed if "damaged" by villains).

# Team globals
WANT_WARNINGS = False

# Amount of players that must be in the room before sending the warning.
TEAM_WARNING_THRESHOLD = 4

# Room ID: (Prerequisite team ID, warning msg ID)
TEAM_ROOMS = {
    330: [(2, 0)],  # Bank
    853: [(2, 1)],  # Hero Lair
    852: [(1, 2)],  # Villain Lair
    805: [(2, 3)],  # Berg
    1208: [(0, 4), (2, 4)],  # Stage / Police Dept.
    100: [(2, 5)],  # Town
    110: [(1, 6), (2, 6)],  # Coffee
    111: [(2, 7)]  # Book
}


def format_time(val):
    # Format like a time on a digital clock by prepending a 0 if less than 10.
    # Used by the debug print in the boss main loop to show the cycle time left.
    return f'{"0" if val < 10 else ""}{val}'


class SuperheroPartyBoss:
    def __init__(self, server):
        self.server = server

        self.boss_cycle_start = 0
        self.boss_cycle_time_remaining = 0

        self.boss_health = BOSS_MAX_HEALTH

        self.boss_initial_targets_set = False
        self.boss_open_targets = []

        self.boss_cycle_countdown = None

    async def toggle_boss(self, flag=None):
        if flag is not None:
            self.server.shp_want_boss = flag

        if self.server.shp_want_boss and not self.boss_cycle_countdown:
            self.boss_cycle_start = time.time()
            self.boss_cycle_countdown = asyncio.create_task(self.handle_countdown())
        elif self.boss_cycle_countdown:
            self.boss_cycle_countdown.cancel()
            self.boss_cycle_countdown = None

            self.boss_cycle_time_remaining = 0
            self.boss_health = BOSS_MAX_HEALTH
            self.boss_initial_targets_set = False

    async def handle_countdown(self):
        while True:
            curr_time = time.time()
            elapsed = curr_time - self.boss_cycle_start

            # Remaining cycle time is saved for clients who happen to enter during the attack phase.
            self.boss_cycle_time_remaining = int(max(0.0, BOSS_CYCLE_TOTAL_LENGTH - elapsed))

            if self.server.logger.isEnabledFor(logging.DEBUG):
                # This is only used for debug output, so we can skip it if we're not outputting debug info.
                minutes = self.boss_cycle_time_remaining // 60
                seconds = self.boss_cycle_time_remaining % 60

                self.server.logger.debug(f'{format_time(minutes)}:{format_time(seconds)} left in the current cycle.')

            if elapsed >= BOSS_CYCLE_TOTAL_LENGTH or (not self.is_boss_alive() and elapsed >= BOSS_APPEAR_TIME):
                # Boss cycle over. Start a new one.
                self.boss_cycle_start = time.time()
                self.server.logger.debug(f'Boss cycle over. Next cycle started at {self.boss_cycle_start}.')
            elif elapsed < BOSS_START_TARGET_TIME:
                # We're outside the attack phase.

                # Keep boss health maxed out.
                self.server.logger.debug('In cooldown phase.')

                self.boss_health = BOSS_MAX_HEALTH

                # Also, indicate that the targets aren't setup yet for the next attack phase.
                self.boss_initial_targets_set = False
            elif elapsed >= BOSS_START_TARGET_TIME:
                # Time to choose new targets.
                self.server.logger.debug('In attack phase.')

                # Choose new targets on either multiples of BOSS_TARGET_CHOOSE_TIME seconds
                # (this seems close enough to the actual target cycling interval from the original game)
                # or immediately if the initial batch hasn't been set up yet.
                if not self.boss_initial_targets_set or (int(elapsed) % BOSS_TARGET_CHOOSE_TIME == 0):
                    self.choose_new_targets()

                    if not self.boss_initial_targets_set:
                        # Initial targets have been set up.
                        self.boss_initial_targets_set = True

                        self.server.logger.debug('Initial targets setup.')
                        
                    # Update targets on clients.
                    await self.server.rooms[BOSS_ROOM].send_xt('REVEAL', self.boss_open_targets)

                self.server.logger.debug(f'Boss targets are: {self.boss_open_targets}.')

            await asyncio.sleep(1)

    def choose_new_targets(self):
        # We will always only try to show the specified number of targets.
        self.server.logger.debug('Choosing new targets.')

        self.boss_open_targets.clear()

        for _ in range(BOSS_NUM_SHOW_TARGETS):
            new_targets = random.choice([t for t in range(BOSS_MAX_TARGETS + 1) if t not in self.boss_open_targets])
            self.boss_open_targets.append(new_targets)

    def is_boss_alive(self):
        return self.boss_health > 0


@handlers.boot
async def shp_load(server):
    server.shp_want_boss = WANT_BOSS
    server.shp_want_warnings = WANT_WARNINGS

    server.logger.info('Marvel Superhero Takeover booted up!')

    server.shp_boss = SuperheroPartyBoss(server)

    await server.shp_boss.toggle_boss()

async def get_party_cookie(p):
    if hasattr(p, 'cookie'):
        # Return a cached cookie.
        return p.cookie

    cookie = await p.server.redis.hget(COOKIE_NAME, p.id)
    if cookie is None:
        # No cookie for this player - make new one.
        cookie = ujson.dumps(DEFAULT_PARTY_COOKIE)
        await p.server.redis.hset(COOKIE_NAME, p.id, cookie)
    else:
        cookie = ujson.loads(cookie)

    # Cache the cookie.
    p.cookie = cookie

    return cookie

async def send_party_cookie(p, update=False):
    if update:
        await p.server.redis.hset(COOKIE_NAME, p.id, await get_party_cookie(p))
    await p.send_xt('shppc', await ujson.loads(p.cookie))

@handlers.handler(XTPacket('j', 'js'), after=handle_join_server)
@handlers.allow_once
async def handle_get_party_settings(p):
    # Cache their team.
    p.team = 0  # Start with neutral.

    # Create a new cookie or load existing.
    await get_party_cookie(p)

    # Tell this player the party's going on.
    await p.send_xt('activefeatures', COOKIE_HANDLER_ID)

    # Now tell them their cookie.
    await send_party_cookie(p)

@handlers.handler(XTPacket(COOKIE_HANDLER_NAME, 'shppc'))
async def handle_party_cookie(p, cookie: str):
    if cookie:
        # Convert the cookie string to a dictionary.
        new_cookie_data = ujson.loads(cookie)

        # Update the existing with values from the received cookie.
        for key in list(new_cookie_data.keys()):
            p.cookie[key] = new_cookie_data[key]

        # Convert the updated party cookie to JSON.
        updated_cookie = ujson.dumps(p.cookie)

        # Store the updated JSON data in the Redis server cache.
        await p.server.redis.hset(COOKIE_NAME, p.id, updated_cookie)

    # If the player didn't send up cookie data, they simply requested their current cookie.

    await send_party_cookie(p)

@handlers.handler(XTPacket(COOKIE_HANDLER_NAME, 'shprh'))
async def handle_attack_robots(p, victim_id: int):
    # Find our target. They should be in the same room.
    victim = p.room.penguins_by_id.get(victim_id)
    if victim:
        # Found em!

        # Give em some damage.
        victim.cookie['robotPower'] -= ROBOT_DAMAGE
        power_level = victim.cookie['robotPower']

        await p.room.send_xt('shprh', int(power_level), victim.id)

        # They were defeated. Restore power level.
        if power_level <= 0:
            victim.cookie['robotPower'] = ROBOT_MAX_POWER

        await send_party_cookie(victim, True)

@handlers.handler(XTPacket(COOKIE_HANDLER_NAME, 'shpgp'))
async def handle_power_snowball(p):
    # Player threw a power snowball. Subtract glove power.
    if p.cookie['glovePower'] - GLOVE_POWER_CONSUMPTION > 0:
        p.cookie['glovePower'] -= GLOVE_POWER_CONSUMPTION

        await p.send_xt('shpgp', int(p.cookie['glovePower']))

        await send_party_cookie(p, True)

# BOSS CONFIGURATION STUFF BEGINS BELOW
@handlers.handler(XTPacket('j', 'crl'), after=handle_join_room)
async def send_boss_status(p):
    if p.room.id == BOSS_ROOM:
        # Someone just joined the room. Update them on the boss status. Note that we don't need to keep doing
        # this as long as they're in the room cuz the client will remember the times and reset the clock
        # and local boss state accordingly.
        await p.send_xt('Boss_Status', 'INIT', p.server.shp_boss.boss_cycle_time_remaining,
                        int(not p.server.shp_boss.is_boss_alive()), p.server.shp_boss.boss_health,
                        int(BOSS_APPEAR_TIME), BOSS_CYCLE_TOTAL_LENGTH)

        await asyncio.sleep(1)

        # Update targets too. Copy the list in case it changes during this operation.
        await p.send_xt('REVEAL', ', '.join(str(t) for t in list(p.server.shp_boss.boss_open_targets)))

@handlers.handler(XTPacket('bhs', 'brts'))
async def battle_targets(p, target_id: int):
    if target_id >= 0:
        p.server.shp_boss.boss_health -= BOSS_DAMAGE

        dmgStr = 'lost'
    else:
        # Villain target ID is -1. This target is also a special one cuz it never hides.
        p.server.shp_boss.boss_health += BOSS_DAMAGE

        dmgStr = 'recovered'

    self.server.logger.debug(f'Boss {dmgStr} {BOSS_DAMAGE} health.')

    # Update health on client.
    if p.server.shp_boss.is_boss_alive():
        await p.room.send_xt('Boss_Status', 'HIT', p.server.shp_boss.boss_health)

# TEAM CONFIGURATION STUFF BEGINS BELOW
async def update_ring(p):
    # Tell everyone else in the room about this player's team ring.
    await p.room.send_xt('TeamRing', p.id, p.team)

@handlers.handler(XTPacket('TeamRing'))
async def change_team(p, team: int):
    # Update their cached team.
    p.team = team

    await update_ring(p)

@handlers.handler(XTPacket('j', 'crl'), after=handle_join_room)
async def update_team(p):
    # Tell this player about everyone else's team rings...
    for i in list(p.room.penguins_by_id.values()):
        await p.send_xt('TeamRing', i.id, i.team)

    # ...and tell everyone else about theirs.
    await update_ring(p)

    if p.server.shp_want_warnings:
        num_teammates = 0

        # Check if player is in a team room.
        if p.room.id in TEAM_ROOMS:
            prerequisites = TEAM_ROOMS[p.room.id]
            for prerequisite_team_id, warning_id in prerequisites:
                if p.team == prerequisite_team_id:
                    # This player is on the right team.
                    # Check if there's enough players of the same team in the room.
                    for i in list(p.room.penguins_by_id.values()):
                        if i.team == p.team:
                            num_teammates += 1

                        if num_teammates >= TEAM_WARNING_THRESHOLD:
                            # We found enough teammates.
                            await p.room.send_xt('Warning', warning_id, p.team)
                            break

@handlers.handler(XTPacket('ReTP'))  # Reposition player (used in the boss room).
async def reposition(p, x, y):
    p.x, p.y = x, y
    await p.room.send_xt('ReTP', p.id, x, y)

# COMMANDS BEGIN BELOW.
@commands.command('shp_toggleboss')
@permissions.has_or_moderator(CMD_PERMISSION_NAME)
async def toggle_boss_cmd(p):
    p.server.shp_boss.toggle_boss(not p.server.shp_want_boss)

    await p.room.send_xt('mm', 'Toggled boss.', p.id)

@commands.command('shp_togglewarnings')
@permissions.has_or_moderator(CMD_PERMISSION_NAME)
async def toggle_warnings(p):
    p.server.shp_want_warnings = not p.server.shp_want_warnings

    await p.room.send_xt('mm', 'Toggled team warnings.', p.id)
