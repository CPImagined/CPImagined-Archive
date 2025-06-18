import random

from houdini import ITable, handlers
from houdini.handlers import XTPacket


class DinoDigLogic(ITable):

    def __init__(self):
        self.map_width = 10
        self.map_height = 10
        self.coins_hidden = 0
        self.gems_hidden = 0
        self.turns = 12
        self.emerald_value = 100
        self.gem_value = 25
        self.coin_value = 1
        self.gem_locations = []
        self.treasure_map = []
        self.coins_found = 0
        self.gems_found = 0
        self.emerald_found = 0
        self.dig_record_names = []
        self.dig_record_directions = []
        self.dig_record_numbers = []
        self.emerald = 0
        self.current_egg = self.get_puffle_egg()
        self.generate_map()

    def get_puffle_egg(self):
        """
            PUFFLE EGG IDS: 
                202 => blue
                106 => black
                304 => pink
                104 => red
                204 => purple
                302 => yellow
        """
        return random.choices([202, 104, 302, 304, 204, 106], weights=[80, 60, 40, 30, 20, 15])[0]

    def make_move(self, movie, direction, spade):
        if direction == 'right':
            row = self.treasure_map[spade]
            for column, tiles in enumerate(row):
                self.dig(spade, column)
        elif direction == 'down':
            for row, columns in enumerate(self.treasure_map):
                self.dig(row, spade)
        self.turns -= 1
        self.dig_record_names.append(movie)
        self.dig_record_directions.append(direction)
        self.dig_record_numbers.append(spade)

    def is_valid_move(self, movie, direction, spade):
        test_movie = direction + 'button' + str(spade) + '_mc'
        if test_movie == movie and direction in ['down', 'right'] and 0 <= spade <= 9:
            if direction == 'right':
                row = self.treasure_map[spade]
                for column, tiles in enumerate(row):
                    treasure, digs = self.treasure_map[spade][column]
                    if digs == 2:
                        return False
            elif direction == 'down':
                for row, columns in enumerate(self.treasure_map):
                    treasure, digs = self.treasure_map[row][spade]
                    if digs == 2:
                        return False
            return True
        return False

    def get_string(self):
        treasure_map = ','.join(str(item) for row in self.treasure_map for item, digs in row)
        gem_locations = ','.join(self.gem_locations)
        game_array = [self.map_width, self.map_height, self.coins_hidden, self.gems_hidden, self.turns,
                      self.gem_value, self.coin_value, gem_locations, treasure_map]
        if self.dig_record_numbers:
            game_array += [self.coins_found, self.gems_found, self.emerald_found]
            game_array += [','.join(self.dig_record_names), ','.join(self.dig_record_directions),
                           ','.join(map(str, self.dig_record_numbers))]
        return '%'.join(map(str, game_array))

    def generate_map(self):
        for row in range(self.map_height):
            self.treasure_map.append([])
            for column in range(self.map_width):
                self.treasure_map[row].append([self.generate_treasure(row, column), 0])

    def generate_treasure(self, row, column):
        treasure_type = [('None', 0), ('Coin', 1), ('Gem', self.current_egg)]
        if self.get_gem_by_piece(row, column):
            return 3
        if row + 1 == self.map_height or column + 1 == self.map_width:
            treasure_type = treasure_type[:2]
        name, value = random.choices(treasure_type, weights=[60, 20, 20, 5][:len(treasure_type)])[0]
        if value == 1:
            self.coins_hidden += 1
        if value > 1:
            if self.gems_hidden > 0:
                return 0
            self.gems_hidden += 1
            self.gem_locations.append(f'{row},{column}')
        return value

    def get_gem_by_piece(self, row, column):
        if row > 0:
            treasure, digs = self.treasure_map[row - 1][column]
            if treasure == self.current_egg:
                return row - 1, column
        if column > 0:
            treasure, digs = self.treasure_map[row][column - 1]
            if treasure == self.current_egg:
                return row, column - 1
        if row > 0 and column > 0:
            treasure, digs = self.treasure_map[row - 1][column - 1]
            if treasure == self.current_egg:
                return row - 1, column - 1
        return None

    def is_gem_uncovered(self, row, column):
        if row == self.map_width - 1 or column == self.map_height - 1:
            return False
        for delta_row, delta_col in [(0, 1), (1, 1), (1, 0)]:
            treasure, digs = self.treasure_map[row + delta_row][column + delta_col]
            if digs != 2:
                return False
        return True

    def dig(self, row, column):
        self.treasure_map[row][column][1] += 1
        treasure, digs = self.treasure_map[row][column]
        
        if digs == 2:
            print(treasure)
            if treasure == 1:
                self.coins_found += 1
            elif treasure == self.current_egg:
                if self.is_gem_uncovered(row, column):
                    self.gems_found += 1
            elif treasure == 3:
                treasure_row, treasure_col = self.get_gem_by_piece(row, column)
                treasure, digs = self.treasure_map[treasure_row][treasure_col]
                if self.is_gem_uncovered(treasure_row, treasure_col):
                    if treasure == self.current_egg:
                        self.gems_found += 1

    def determine_winnings(self):
        total = self.coins_found * self.coin_value
        total += self.gems_found * self.gem_value
        total += self.emerald_found * self.emerald_value
        return total

@handlers.handler(XTPacket('jz',  ext='z'))
@handlers.table(DinoDigLogic)
async def handle_join_game(p):
    seat_id = p.table.get_seat_id(p)
    await p.send_xt('jz', seat_id)
    await p.table.send_xt('uz', seat_id, p.safe_name)
    await p.table.send_xt('sz', p.table.get_string())

@handlers.handler(XTPacket('zm', ext='z'))
@handlers.table(DinoDigLogic)
async def handle_send_move(p, movie: str, direction: str, spade: int):
    try:
        seat_id = p.table.get_seat_id(p)
        is_player = seat_id < 2
        if is_player:
            current_player = p.table.penguins[0]
            if not p.table.logic.is_valid_move(movie, direction, spade):
                return
            p.table.logic.make_move(movie, direction, spade)
            await p.table.send_xt('zm', movie, direction, spade)
            
            if p.table.logic.turns == 0:
                winnings = p.table.logic.determine_winnings()
                print('GEMS FOUND:', p.table.logic.gems_found)
                if p.table.logic.gems_found > 0:
                    # blue
                    if p.table.logic.current_egg == 202:
                        if p.cookie['puff'][0]['state'] == 0 or p.cookie['puff'][0]['state'] == 4:
                            p.cookie['puff'][0]['state'] = 1
                            await send_party_cookie(p)
                    # black
                    elif p.table.logic.current_egg == 106:
                        if p.cookie['puff'][1]['state'] == 0 or p.cookie['puff'][1]['state'] == 4:
                            p.cookie['puff'][1]['state'] = 1
                            await send_party_cookie(p)
                    # pink
                    elif p.table.logic.current_egg == 304:
                        if p.cookie['puff'][2]['state'] == 0 or p.cookie['puff'][2]['state'] == 4:
                            p.cookie['puff'][2]['state'] = 1
                            await send_party_cookie(p)
                    # red
                    elif p.table.logic.current_egg == 104:
                        if p.cookie['puff'][3]['state'] == 0 or p.cookie['puff'][3]['state'] == 4:
                            p.cookie['puff'][3]['state'] = 1
                            await send_party_cookie(p)
                    # purple
                    elif p.table.logic.current_egg == 204:
                        if p.cookie['puff'][4]['state'] == 0 or p.cookie['puff'][4]['state'] == 4:
                            p.cookie['puff'][4]['state'] = 1
                            await send_party_cookie(p)
                    # yellow
                    elif p.table.logic.current_egg == 302:
                        if p.cookie['puff'][5]['state'] == 0 or p.cookie['puff'][5]['state'] == 4:
                            p.cookie['puff'][5]['state'] = 1
                            await send_party_cookie(p)
                    # i hate python
                await p.update(coins= p.coins + winnings).apply()
                await p.table.send_xt('cz')
                await p.table.reset()
                return
    except (KeyError, ValueError):
        p.logger.warn(f'Invalid treasure hunt move made by {p}')
        
import ujson
PARTY_CACHE_CURRENT = "prehistoric2022"
async def send_party_cookie(p):
    cookie = ujson.dumps(p.cookie)
    await p.server.redis.hset(PARTY_CACHE_CURRENT, p.id, cookie)
    await p.send_xt('prehistoricc', cookie)