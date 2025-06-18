//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2015.automated.party.DecemberSounds
    {
        static var _shell, _interface, _engine, _sfxLayer_snowballs, _sfxLayer_transform, _sfx_snowball_impact_1, _sfx_snowball_impact_2, _sfx_snowball_impact_normal_1, _sfx_snowball_impact_normal_2, _sfx_transform_frostbite, _sfx_throw_1;
        function DecemberSounds () {
        }
        static function init() {
            _shell = _global.getCurrentShell();
            _interface = _global.getCurrentInterface();
            _engine = _global.getCurrentEngine();
            _shell.addListener(_shell.ROOM_INITIATED, com.clubpenguin.util.Delegate.create(com.clubpenguin.world.rooms2015.automated.party.DecemberSounds, onRoomInitialized));
        }
        static function get soundManager() {
            return(com.clubpenguin.world.rooms.BaseRoom.current.soundManager);
        }
        static function onRoomInitialized() {
            com.clubpenguin.world.rooms.BaseRoom.current.soundManagerReady.addOnce(onSoundManagerReady, com.clubpenguin.world.rooms2015.automated.party.DecemberSounds);
        }
        static function onSoundManagerReady() {
            _sfxLayer_snowballs = soundManager.addLayer("snowballs", 4);
            _sfxLayer_transform = soundManager.addLayer("tansform", 3);
            var _local_1 = function (symbolName) {
                return(com.clubpenguin.world.rooms2015.automated.party.DecemberSounds.soundManager.registerSymbolName(symbolName));
            };
            _sfx_snowball_impact_1 = _local_1("sfx_snowball_impact_1");
            _sfx_snowball_impact_2 = _local_1("sfx_snowball_impact_2");
            _sfx_snowball_impact_normal_1 = _local_1("sfx_snowball_normal_1");
            _sfx_snowball_impact_normal_2 = _local_1("sfx_snowball_normal_2");
            _sfx_transform_frostbite = _local_1("sfx_transform");
            _sfx_throw_1 = _local_1("sfx_throw_1");
        }
        static function playFrostbiteSnowballThrow() {
            com.clubpenguin.util.Log.debug("playFrostbiteSnowballThrow()");
            soundManager.playSound(_sfx_throw_1, _sfxLayer_snowballs, LOCAL_PLAYER_SFX_VOLUME);
        }
        static function playFrostbiteTransform() {
            var _local_1 = random(2) + 1;
            soundManager.playSound(com.clubpenguin.world.rooms2015.automated.party.DecemberSounds["_sfx_transform_frostbite" + _local_1], _sfxLayer_transform, LOCAL_PLAYER_SFX_VOLUME);
        }
        static function playFrostbiteSnowballImpact() {
            var _local_1 = random(2) + 1;
            soundManager.playSound(com.clubpenguin.world.rooms2015.automated.party.DecemberSounds["_sfx_snowball_impact_" + _local_1], _sfxLayer_snowballs, LOCAL_PLAYER_SFX_VOLUME);
        }
        static function playNormalSnowballImpact() {
            var _local_1 = random(2) + 1;
            soundManager.playSound(com.clubpenguin.world.rooms2015.automated.party.DecemberSounds["_sfx_snowball_impact_normal_" + _local_1], _sfxLayer_snowballs, LOCAL_PLAYER_SFX_VOLUME);
        }
        static var LOCAL_PLAYER_SFX_VOLUME = 100;
    }
