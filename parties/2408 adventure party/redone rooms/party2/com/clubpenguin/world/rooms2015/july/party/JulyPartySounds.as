//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2015.july.party.JulyPartySounds
    {
        static var _shell, _interface, _engine, _sfxLayer_snowballs, _sfx_snowball_throw_bingbong, _sfx_wave_bingbong, _sfx_snowball_throw_unicorn_1, _sfx_snowball_throw_unicorn_2, _sfx_snowball_throw_unicorn_3, _sfx_wave_unicorn_1, _sfx_wave_unicorn_2, _sfx_wave_unicorn_3, _sfx_wave_unicorn_4, _sfx_dance_unicorn, _sfx_snowball_impact_1, _sfx_snowball_impact_2, _unicornDanceLoopId;
        function JulyPartySounds () {
        }
        static function init() {
            _shell = _global.getCurrentShell();
            _interface = _global.getCurrentInterface();
            _engine = _global.getCurrentEngine();
            _shell.addListener(_shell.ROOM_INITIATED, com.clubpenguin.util.Delegate.create(com.clubpenguin.world.rooms2015.july.party.JulyPartySounds, onRoomInitialized));
        }
        static function get soundManager() {
            return(com.clubpenguin.world.rooms.BaseRoom.current.soundManager);
        }
        static function onRoomInitialized() {
            com.clubpenguin.world.rooms.BaseRoom.current.soundManagerReady.addOnce(onSoundManagerReady, com.clubpenguin.world.rooms2015.july.party.JulyPartySounds);
        }
        static function onSoundManagerReady() {
            _sfxLayer_snowballs = soundManager.addLayer("snowballs", 4);
            var _local_1 = function (symbolName) {
                return(com.clubpenguin.world.rooms2015.july.party.JulyPartySounds.soundManager.registerSymbolName(symbolName));
            };
            _sfx_snowball_throw_bingbong = _local_1("sfx_snowball_throw_bingbong");
            _sfx_wave_bingbong = _local_1("sfx_wave_bingbong");
            _sfx_snowball_throw_unicorn_1 = _local_1("sfx_snowball_throw_unicorn_1");
            _sfx_snowball_throw_unicorn_2 = _local_1("sfx_snowball_throw_unicorn_2");
            _sfx_snowball_throw_unicorn_3 = _local_1("sfx_snowball_throw_unicorn_3");
            _sfx_wave_unicorn_1 = _local_1("sfx_wave_unicorn_1");
            _sfx_wave_unicorn_2 = _local_1("sfx_wave_unicorn_2");
            _sfx_wave_unicorn_3 = _local_1("sfx_wave_unicorn_3");
            _sfx_wave_unicorn_4 = _local_1("sfx_wave_unicorn_4");
            _sfx_dance_unicorn = _local_1("sfx_dance_unicorn");
            _sfx_snowball_impact_1 = _local_1("sfx_snowball_impact_1");
            _sfx_snowball_impact_2 = _local_1("sfx_snowball_impact_2");
        }
        static function playSnowballImpact() {
            var _local_1 = random(2) + 1;
            soundManager.playSound(com.clubpenguin.world.rooms2015.july.party.JulyPartySounds["_sfx_snowball_impact_" + _local_1], _sfxLayer_snowballs, LOCAL_PLAYER_SFX_VOLUME);
        }
        static function playBingBongSnowballThrow() {
            soundManager.playSoundAfterDelay(_sfx_snowball_throw_bingbong, _sfxLayer_snowballs, 20, LOCAL_PLAYER_SFX_VOLUME);
        }
        static function playBingBongWave() {
            soundManager.playSound(_sfx_wave_bingbong, _sfxLayer_snowballs, LOCAL_PLAYER_SFX_VOLUME);
        }
        static function playRainbowUnicornWave() {
            soundManager.playSound(com.clubpenguin.world.rooms2015.july.party.JulyPartySounds["_sfx_wave_unicorn_" + Number(random(4) + 1)], _sfxLayer_snowballs, LOCAL_PLAYER_SFX_VOLUME);
        }
        static function playRainbowUnicornSnowballThrow() {
            soundManager.playSound(com.clubpenguin.world.rooms2015.july.party.JulyPartySounds["_sfx_snowball_throw_unicorn_" + Number(random(3) + 1)], _sfxLayer_snowballs, LOCAL_PLAYER_SFX_VOLUME);
        }
        static function playUnicornDanceLoop() {
            _unicornDanceLoopId = soundManager.playSoundLoop([_sfx_dance_unicorn], _sfxLayer_snowballs, LOCAL_PLAYER_SFX_VOLUME);
        }
        static function stopUnicornDanceLoop() {
            soundManager.stopSoundLoop(_unicornDanceLoopId);
        }
        static var LOCAL_PLAYER_SFX_VOLUME = 100;
    }
