//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2014.future.FuturePartySounds
    {
        static var _this, _shell, _interface, _engine, _sfxLayer_mech_movement, _sfxLayer_mech_snowballs, _sfxLayer_mech_blastoff, _sfxLayer_spacebattle, _sfx_jetpack_blastup, _sfx_jetpack_blastdown, _sfx_bigRed_start, _sfx_fishSticks_start, _sfx_oBlaster_start, _sfx_bigRed_blastup, _sfx_fishSticks_blastup, _sfx_oBlaster_blastup, _sfx_bigRed_blastdown, _sfx_fishSticks_blastdown, _sfx_oBlaster_blastdown, _sfx_bigRed_move, _sfx_fishSticks_move, _sfx_oBlaster_move_start, _sfx_oBlaster_move_loop, _sfx_oBlaster_move_end, _sfx_bigRed_snowball_1, _sfx_bigRed_snowball_2, _sfx_fishSticks_snowball_1, _sfx_fishSticks_snowball_2, _sfx_oBlaster_snowball_1, _sfx_oBlaster_snowball_2, _sfx_penguin_snowball_1, _sfx_penguin_snowball_2, _sfx_proto_music, _sfx_proto_portal, _sfx_robo_buzz, _sfx_meteor, _sfx_fire, _sfxLayer_jetpacks, _sfx_proto_music_id, _sfx_proto_portal_id, _sfx_robo_buzz_id, _sfx_meteor_id;
        function FuturePartySounds () {
        }
        static function init() {
            _this = com.clubpenguin.world.rooms2014.future.FuturePartySounds;
            _shell = _global.getCurrentShell();
            _interface = _global.getCurrentInterface();
            _engine = _global.getCurrentEngine();
            _shell.addListener(_shell.ROOM_INITIATED, com.clubpenguin.util.Delegate.create(com.clubpenguin.world.rooms2014.future.FuturePartySounds, onRoomInitialized));
            _shell.addListener(_shell.PLAYER_MOVE_START, onPlayerMoveStart, com.clubpenguin.world.rooms2014.future.FuturePartySounds);
            _shell.addListener(_shell.PLAYER_MOVE_DONE, onPlayerMoveEnd, com.clubpenguin.world.rooms2014.future.FuturePartySounds);
        }
        static function get soundManager() {
            return(com.clubpenguin.world.rooms.BaseRoom.current.soundManager);
        }
        static function onRoomInitialized() {
            com.clubpenguin.world.rooms.BaseRoom.current.soundManagerReady.addOnce(onSoundManagerReady, com.clubpenguin.world.rooms2014.future.FuturePartySounds);
        }
        static function onSoundManagerReady() {
            _sfxLayer_mech_movement = soundManager.addLayer("mech_movement", 2);
            _sfxLayer_mech_snowballs = soundManager.addLayer("mech_snowballs", 4);
            _sfxLayer_mech_blastoff = soundManager.addLayer("mech_blastoff", 4);
            _sfxLayer_spacebattle = soundManager.addLayer("space_battle", 8);
            var _local_1 = function (symbolName) {
                return(com.clubpenguin.world.rooms2014.future.FuturePartySounds.soundManager.registerSymbolName(symbolName));
            };
            _sfx_jetpack_blastup = _local_1("sfx_jetpack_blastup");
            _sfx_jetpack_blastdown = _local_1("sfx_jetpack_blastdown");
            _sfx_bigRed_start = _local_1("sfx_bigRed_start");
            _sfx_fishSticks_start = _local_1("sfx_fishSticks_start");
            _sfx_oBlaster_start = _local_1("sfx_oBlaster_start");
            _sfx_bigRed_blastup = _local_1("sfx_bigRed_blastup");
            _sfx_fishSticks_blastup = _local_1("sfx_fishSticks_blastup");
            _sfx_oBlaster_blastup = _local_1("sfx_oBlaster_blastup");
            _sfx_bigRed_blastdown = _local_1("sfx_bigRed_blastdown");
            _sfx_fishSticks_blastdown = _local_1("sfx_fishSticks_blastdown");
            _sfx_oBlaster_blastdown = _local_1("sfx_oBlaster_blastdown");
            _sfx_bigRed_move = [_local_1("sfx_bigRed_move_1"), _local_1("sfx_bigRed_move_2"), _local_1("sfx_bigRed_move_3")];
            _sfx_fishSticks_move = [_local_1("sfx_fishSticks_move_1"), _local_1("sfx_fishSticks_move_2"), _local_1("sfx_fishSticks_move_3")];
            _sfx_oBlaster_move_start = _local_1("sfx_oBlaster_move_start");
            _sfx_oBlaster_move_loop = _local_1("sfx_oBlaster_move_loop");
            _sfx_oBlaster_move_end = _local_1("sfx_oBlaster_move_end");
            _sfx_bigRed_snowball_1 = _local_1("sfx_bigRed_snowball_1");
            _sfx_bigRed_snowball_2 = _local_1("sfx_bigRed_snowball_2");
            _sfx_fishSticks_snowball_1 = _local_1("sfx_fishSticks_snowball_1");
            _sfx_fishSticks_snowball_2 = _local_1("sfx_fishSticks_snowball_2");
            _sfx_oBlaster_snowball_1 = _local_1("sfx_oBlaster_snowball_1");
            _sfx_oBlaster_snowball_2 = _local_1("sfx_oBlaster_snowball_2");
            _sfx_penguin_snowball_1 = _local_1("sfx_penguin_snowball_1");
            _sfx_penguin_snowball_2 = _local_1("sfx_penguin_snowball_2");
            _sfx_proto_music = _local_1("proto_music");
            _sfx_proto_portal = _local_1("portal_loop");
            _sfx_robo_buzz = _local_1("robot_buzz_loop");
            _sfx_meteor = _local_1("meteor_titan_loop");
            _sfx_fire = _local_1("proto_fire");
        }
        static function onPlayerMoveStart(player) {
            if (_shell.isMyPlayer(player.player_id)) {
                startSFXMechMovement(player.player_id);
            }
        }
        static function onPlayerMoveEnd(player) {
            if (_shell.isMyPlayer(player.player_id)) {
                stopSFXMechMovement(player.player_id);
            }
        }
        static function playJetpackBlastoff(player_id) {
            soundManager.playSound(((!com.clubpenguin.world.rooms2014.future.FutureParty.inSpaceRoom) ? (_sfx_jetpack_blastup) : (_sfx_jetpack_blastdown)), _sfxLayer_jetpacks, ((player_id == _shell.getMyPlayerId()) ? (LOCAL_PLAYER_SFX_VOLUME) : (REMOTE_PLAYER_SFX_VOLUME)));
        }
        static function playMechBlastoffStart(player_id) {
            var _local_1 = com.clubpenguin.world.rooms2014.future.mech.MechController.getRobotType(player_id);
            if (_local_1 == undefined) {
                return(undefined);
            }
            soundManager.playSound(_this[("_sfx_" + com.clubpenguin.world.rooms2014.future.FutureParty.CONSTANTS.ROBO_NAMES[_local_1]) + "_start"], _sfxLayer_mech_blastoff, ((player_id == _shell.getMyPlayerId()) ? (LOCAL_PLAYER_SFX_VOLUME) : (REMOTE_PLAYER_SFX_VOLUME)));
        }
        static function playMechBlastOff(player_id) {
            var _local_1 = com.clubpenguin.world.rooms2014.future.mech.MechController.getRobotType(player_id);
            if (_local_1 == undefined) {
                return(undefined);
            }
            var _local_2 = String((("_sfx_" + com.clubpenguin.world.rooms2014.future.FutureParty.CONSTANTS.ROBO_NAMES[_local_1]) + "_") + String((com.clubpenguin.world.rooms2014.future.FutureParty.inSpaceRoom ? "blastdown" : "blastup")));
            soundManager.playSound(_this[_local_2], _sfxLayer_mech_blastoff, ((player_id == _shell.getMyPlayerId()) ? (LOCAL_PLAYER_SFX_VOLUME) : (REMOTE_PLAYER_SFX_VOLUME)));
        }
        static function startSFXMechMovement(player_id) {
            stopSFXMechMovement(player_id);
            var _local_1 = com.clubpenguin.world.rooms2014.future.mech.MechController.getRobotType(player_id);
            if (((_local_1 == undefined) || (_local_1 == -1)) || (com.clubpenguin.world.rooms2014.future.FutureParty.inSpaceRoom)) {
                return(undefined);
            }
            if (_local_1 == com.clubpenguin.world.rooms2014.future.FutureParty.CONSTANTS.ROBO_TYPE_B) {
                soundManager.playSound(_sfx_oBlaster_move_start, _sfxLayer_mech_movement, LOCAL_PLAYER_SFX_VOLUME, undefined, com.clubpenguin.util.Delegate.create(_this, playOBlasterMoveLoop));
                return(undefined);
            } else {
                var _local_2 = null;
                if (_local_1 == com.clubpenguin.world.rooms2014.future.FutureParty.CONSTANTS.ROBO_TYPE_A) {
                    _local_2 = _sfx_bigRed_move;
                }
                if (_local_1 == com.clubpenguin.world.rooms2014.future.FutureParty.CONSTANTS.ROBO_TYPE_C) {
                    _local_2 = _sfx_fishSticks_move;
                }
                if (_local_2 != null) {
                    _sfx_walkingLoopId = soundManager.playSoundLoop(_local_2, _sfxLayer_mech_movement, LOCAL_PLAYER_SFX_VOLUME);
                }
            }
        }
        static function playOBlasterMoveLoop() {
            _sfx_walkingLoopId = soundManager.playSoundLoop([_sfx_oBlaster_move_loop], _sfxLayer_mech_movement, LOCAL_PLAYER_SFX_VOLUME);
        }
        static function stopSFXMechMovement(player_id) {
            if (_sfx_walkingLoopId != -1) {
                soundManager.stopSoundLoop(_sfx_walkingLoopId);
                _sfx_walkingLoopId = -1;
                if (com.clubpenguin.world.rooms2014.future.mech.MechController.getRobotType(player_id) == com.clubpenguin.world.rooms2014.future.FutureParty.CONSTANTS.ROBO_TYPE_B) {
                    soundManager.playSound(_sfx_oBlaster_move_end, _sfxLayer_mech_movement, LOCAL_PLAYER_SFX_VOLUME);
                }
            }
        }
        static function playSnowballSFX(player_id) {
            var _local_1 = com.clubpenguin.world.rooms2014.future.mech.MechController.getRobotType(player_id);
            if (_local_1 == undefined) {
                return(undefined);
            }
            var _local_2;
            if (_local_1 == -1) {
                soundManager.playSoundAfterDelay(_this["_sfx_penguin_snowball_" + Number(random(2) + 1)], _sfxLayer_mech_snowballs, 20, LOCAL_PLAYER_SFX_VOLUME);
            } else if (_local_1 >= 0) {
                _local_2 = com.clubpenguin.world.rooms2014.future.FutureParty.CONSTANTS.ROBO_NAMES[_local_1];
                soundManager.playSound(_this[(("_sfx_" + _local_2) + "_snowball_") + Number(random(2) + 1)], _sfxLayer_mech_snowballs, LOCAL_PLAYER_SFX_VOLUME);
            }
        }
        static function startProtoMusic() {
            trace("FuturePartySounds.startProtoMusic");
            _sfx_proto_music_id = soundManager.playSoundLoop([_sfx_proto_music], _sfxLayer_spacebattle, LOCAL_PLAYER_SFX_VOLUME);
        }
        static function stopProtoMusic() {
            trace("FuturePartySounds.stopProtoMusic");
            soundManager.stopSoundLoop(_sfx_proto_music_id);
        }
        static function startProtoPortal() {
            trace("FuturePartySounds.startProtoPortal");
            _sfx_proto_portal_id = soundManager.playSoundLoop([_sfx_proto_portal], _sfxLayer_spacebattle, LOCAL_PLAYER_SFX_VOLUME);
        }
        static function stopProtoPortal() {
            trace("FuturePartySounds.stopProtoPortal");
            soundManager.stopSoundLoop(_sfx_proto_portal_id);
        }
        static function startRoboBuzz() {
            trace("FuturePartySounds.startRoboBuzz");
            _sfx_robo_buzz_id = soundManager.playSoundLoop([_sfx_robo_buzz], _sfxLayer_spacebattle, LOCAL_PLAYER_SFX_VOLUME);
        }
        static function stopRoboBuzz() {
            trace("FuturePartySounds.stopRoboBuzz");
            soundManager.stopSoundLoop(_sfx_robo_buzz_id);
        }
        static function startMeteor() {
            trace("FuturePartySounds.startMeteor");
            _sfx_meteor_id = soundManager.playSoundLoop([_sfx_meteor], _sfxLayer_spacebattle, LOCAL_PLAYER_SFX_VOLUME);
        }
        static function stopMeteor() {
            trace("FuturePartySounds.stopMeteor");
            soundManager.stopSoundLoop(_sfx_meteor_id);
        }
        static function startFire() {
            trace("FuturePartySounds.startFire");
            soundManager.playSound(_sfx_fire, _sfxLayer_spacebattle, LOCAL_PLAYER_SFX_VOLUME);
        }
        static var REMOTE_PLAYER_SFX_VOLUME = 25;
        static var LOCAL_PLAYER_SFX_VOLUME = 100;
        static var _sfx_walkingLoopId = -1;
    }
