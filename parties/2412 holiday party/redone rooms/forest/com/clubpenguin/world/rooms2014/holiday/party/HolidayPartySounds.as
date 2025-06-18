//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2014.holiday.party.HolidayPartySounds
    {
        static var _shell, _interface, _engine, _sfxLayer_snowballs, _sfxLayer_quest, _sfx_collect_crystal, _sfx_tree_1, _sfx_tree_2, _sfx_tree_3, _sfx_pizza_1, _sfx_pizza_2, _sfx_pizza_3, _sfx_fish_1, _sfx_fish_2, _sfx_fish_3, _sfx_candy_cane_1, _sfx_candy_cane_2, _sfx_candy_cane_3, _sfx_snowball_throw_1, _sfx_snowball_throw_2, _sfx_snowball_throw_3;
        function HolidayPartySounds () {
        }
        static function init() {
            _shell = _global.getCurrentShell();
            _interface = _global.getCurrentInterface();
            _engine = _global.getCurrentEngine();
            _shell.addListener(_shell.ROOM_INITIATED, com.clubpenguin.util.Delegate.create(com.clubpenguin.world.rooms2014.holiday.party.HolidayPartySounds, onRoomInitialized));
        }
        static function get soundManager() {
            return(com.clubpenguin.world.rooms.BaseRoom.current.soundManager);
        }
        static function onRoomInitialized() {
            com.clubpenguin.world.rooms.BaseRoom.current.soundManagerReady.addOnce(onSoundManagerReady, com.clubpenguin.world.rooms2014.holiday.party.HolidayPartySounds);
        }
        static function onSoundManagerReady() {
            _sfxLayer_snowballs = soundManager.addLayer("snowballs", 4);
            _sfxLayer_quest = soundManager.addLayer("quest", 2);
            var r = function (symbolName) {
                return(com.clubpenguin.world.rooms2014.holiday.party.HolidayPartySounds.soundManager.registerSymbolName(symbolName));
            };
            _sfx_collect_crystal = r("sfx_collect_crystal");
            _sfx_tree_1 = r("sfx_tree_1");
            _sfx_tree_2 = r("sfx_tree_2");
            _sfx_tree_3 = r("sfx_tree_3");
            _sfx_pizza_1 = r("sfx_pizza_1");
            _sfx_pizza_2 = r("sfx_pizza_2");
            _sfx_pizza_3 = r("sfx_pizza_3");
            _sfx_fish_1 = r("sfx_fish_1");
            _sfx_fish_2 = r("sfx_fish_2");
            _sfx_fish_3 = r("sfx_fish_3");
            _sfx_candy_cane_1 = r("sfx_candy_cane_1");
            _sfx_candy_cane_2 = r("sfx_candy_cane_2");
            _sfx_candy_cane_3 = r("sfx_candy_cane_3");
            _sfx_snowball_throw_1 = r("sfx_snowball_throw_1");
            _sfx_snowball_throw_2 = r("sfx_snowball_throw_2");
            _sfx_snowball_throw_3 = r("sfx_snowball_throw_3");
        }
        static function playCollectCrystal() {
            soundManager.playSound(_sfx_collect_crystal, _sfxLayer_quest, LOCAL_PLAYER_SFX_VOLUME);
        }
        static function playTreeImpact() {
            var random = (random(3) + 1);
            soundManager.playSound(com.clubpenguin.world.rooms2014.holiday.party.HolidayPartySounds["_sfx_tree_" + random], _sfxLayer_snowballs, LOCAL_PLAYER_SFX_VOLUME);
        }
        static function playCandyCaneImpact() {
            var random = (random(3) + 1);
            soundManager.playSound(com.clubpenguin.world.rooms2014.holiday.party.HolidayPartySounds["_sfx_candy_cane_" + random], _sfxLayer_snowballs, LOCAL_PLAYER_SFX_VOLUME);
        }
        static function playPizzaImpact() {
            var random = (random(3) + 1);
            soundManager.playSound(com.clubpenguin.world.rooms2014.holiday.party.HolidayPartySounds["_sfx_pizza_" + random], _sfxLayer_snowballs, LOCAL_PLAYER_SFX_VOLUME);
        }
        static function playFishImpact() {
            var random = (random(3) + 1);
            soundManager.playSound(com.clubpenguin.world.rooms2014.holiday.party.HolidayPartySounds["_sfx_fish_" + random], _sfxLayer_snowballs, LOCAL_PLAYER_SFX_VOLUME);
        }
        static function playSnowballThrow() {
            soundManager.playSoundAfterDelay(com.clubpenguin.world.rooms2014.holiday.party.HolidayPartySounds["_sfx_snowball_throw_" + Number(random(2) + 1)], _sfxLayer_snowballs, 10, LOCAL_PLAYER_SFX_VOLUME);
        }
        static var REMOTE_PLAYER_SFX_VOLUME = 25;
        static var LOCAL_PLAYER_SFX_VOLUME = 100;
    }
