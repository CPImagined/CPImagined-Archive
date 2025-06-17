//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2014.frozen.party.FrozenPartySounds
    {
        static var _this, _shell, _interface, _engine, _sfxLayer_snowballs, _sfxLayer_freezing, _sfxLayer_melting, _sfxLayer_snowflakeCollect, _sfx_impact_1, _sfx_impact_2, _sfx_throw_1, _sfx_throw_2, _sfx_melt_1, _sfx_melt_2, _sfx_freeze_1, _sfx_freeze_2, _sfx_freeze_3, _sfx_freeze_4, _sfx_collect_snowflake;
        function FrozenPartySounds () {
        }
        static function init() {
            _this = com.clubpenguin.world.rooms2014.frozen.party.FrozenPartySounds;
            _shell = _global.getCurrentShell();
            _interface = _global.getCurrentInterface();
            _engine = _global.getCurrentEngine();
            _shell.addListener(_shell.ROOM_INITIATED, com.clubpenguin.util.Delegate.create(com.clubpenguin.world.rooms2014.frozen.party.FrozenPartySounds, onRoomInitialized));
        }
        static function get soundManager() {
            return(com.clubpenguin.world.rooms.BaseRoom.current.soundManager);
        }
        static function onRoomInitialized() {
            com.clubpenguin.world.rooms.BaseRoom.current.soundManagerReady.addOnce(onSoundManagerReady, com.clubpenguin.world.rooms2014.frozen.party.FrozenPartySounds);
        }
        static function onSoundManagerReady() {
            _sfxLayer_snowballs = soundManager.addLayer("snowballs", 4);
            _sfxLayer_freezing = soundManager.addLayer("freezing", 4);
            _sfxLayer_melting = soundManager.addLayer("melting", 4);
            _sfxLayer_snowflakeCollect = soundManager.addLayer("snowflake", 3);
            var _local_1 = function (_arg_1) {
                return(com.clubpenguin.world.rooms2014.frozen.party.FrozenPartySounds.soundManager.registerSymbolName(_arg_1));
            };
            _sfx_impact_1 = _local_1("sfx_impact_1");
            _sfx_impact_2 = _local_1("sfx_impact_2");
            _sfx_throw_1 = _local_1("sfx_throw_1");
            _sfx_throw_2 = _local_1("sfx_throw_2");
            _sfx_melt_1 = _local_1("sfx_melt_1");
            _sfx_melt_2 = _local_1("sfx_melt_2");
            _sfx_freeze_1 = _local_1("sfx_freeze_1");
            _sfx_freeze_2 = _local_1("sfx_freeze_2");
            _sfx_freeze_3 = _local_1("sfx_freeze_3");
            _sfx_freeze_4 = _local_1("sfx_freeze_4");
            _sfx_collect_snowflake = _local_1("sfx_collect_snowflake");
        }
        static function playSnowballImpact() {
            com.clubpenguin.util.Log.debug("playSnowballImpact");
            soundManager.playSound(_this["_sfx_impact_" + Number(random(2) + 1)], _sfxLayer_snowballs, LOCAL_PLAYER_SFX_VOLUME);
        }
        static function playSnowballThrow() {
            com.clubpenguin.util.Log.debug("play snowball throw");
            var _local_1 = ((com.clubpenguin.world.rooms2014.frozen.party.FrozenParty.localPlayerAvatarID == com.clubpenguin.world.rooms2014.frozen.party.FrozenParty.CONSTANTS.MARSHMALLOW_TRANSFORMATION_ID) ? 70 : 40);
            soundManager.playSoundAfterDelay(_this["_sfx_throw_" + Number(random(2) + 1)], _local_1, _sfxLayer_snowballs, LOCAL_PLAYER_SFX_VOLUME);
        }
        static function playFreezeSFX() {
            com.clubpenguin.util.Log.debug("playFreezeSFX");
            soundManager.playSound(_this["_sfx_freeze_" + Number(random(4) + 1)], _sfxLayer_freezing, LOCAL_PLAYER_SFX_VOLUME);
        }
        static function playThawSFX() {
            com.clubpenguin.util.Log.debug("playThawSFX");
            soundManager.playSound(_this["_sfx_melt_" + Number(random(2) + 1)], _sfxLayer_melting, LOCAL_PLAYER_SFX_VOLUME);
        }
        static function playCollectSnowflakeSFX() {
            com.clubpenguin.util.Log.debug("playCollectSnowflakeSFX");
            soundManager.playSound(_sfx_collect_snowflake, _sfxLayer_snowflakeCollect, LOCAL_PLAYER_SFX_VOLUME);
        }
        static var REMOTE_PLAYER_SFX_VOLUME = 25;
        static var LOCAL_PLAYER_SFX_VOLUME = 100;
    }
