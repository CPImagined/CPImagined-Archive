//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2014.prehistoric.DinoSounds
    {
        static var _shell, _interface, _engine, _sfxLayer_dinoWalk, _sfxLayer_dinoAction, _sfxLayer_dinoSnowball, _sfx_pteranodonDance, _sfx_pteranodonEat, _sfx_pteranodonSnowball, _sfx_pteranodonWalk, _sfx_pteranodonWave, _sfx_raptorDance, _sfx_raptorEat, _sfx_raptorSnowball, _sfx_raptorWalk, _sfx_raptorWave, _sfx_stegosaurusDance, _sfx_stegosaurusEat, _sfx_stegosaurusSnowball, _sfx_stegosaurusWalk, _sfx_stegosaurusWave, _sfx_trexDance, _sfx_trexEat, _sfx_trexSnowball, _sfx_trexWalk, _sfx_trexWave, _sfx_triceratopsDance, _sfx_triceratopsEat, _sfx_triceratopsSnowball, _sfx_triceratopsWalk, _sfx_triceratopsWave;
        function DinoSounds () {
        }
        static function init() {
            _shell = _global.getCurrentShell();
            _interface = _global.getCurrentInterface();
            _engine = _global.getCurrentEngine();
            _shell.addListener(_shell.ROOM_INITIATED, com.clubpenguin.util.Delegate.create(com.clubpenguin.world.rooms2014.prehistoric.DinoSounds, onRoomInitialized));
            _shell.addListener(_shell.PLAYER_MOVE_START, onPlayerMoveStart, com.clubpenguin.world.rooms2014.prehistoric.DinoSounds);
            _shell.addListener(_shell.PLAYER_MOVE_DONE, onPlayerMoveEnd, com.clubpenguin.world.rooms2014.prehistoric.DinoSounds);
            _shell.addListener(_shell.PLAYER_DANCE_START, onPlayerDanceStart, com.clubpenguin.world.rooms2014.prehistoric.DinoSounds);
            _shell.addListener(_shell.PLAYER_WAVE_START, onPlayerWaveStart, com.clubpenguin.world.rooms2014.prehistoric.DinoSounds);
        }
        static function get soundManager() {
            return(com.clubpenguin.world.rooms.BaseRoom.current.soundManager);
        }
        static function onRoomInitialized() {
            com.clubpenguin.world.rooms.BaseRoom.current.soundManagerReady.addOnce(onSoundManagerReady, com.clubpenguin.world.rooms2014.prehistoric.DinoSounds);
        }
        static function onSoundManagerReady() {
            _sfxLayer_dinoWalk = soundManager.addLayer("dinoWalk", 2);
            _sfxLayer_dinoAction = soundManager.addLayer("dinoAction", 4);
            _sfxLayer_dinoSnowball = soundManager.addLayer("dinoSnowball", 4);
            var _local_1 = function (symbolName) {
                return(com.clubpenguin.world.rooms2014.prehistoric.DinoSounds.soundManager.registerSymbolName(symbolName));
            };
            _sfx_pteranodonDance = [_local_1("sfx_pteranodon_dance")];
            _sfx_pteranodonEat = [_local_1("sfx_pteranodon_eat_1"), _local_1("sfx_pteranodon_eat_2")];
            _sfx_pteranodonSnowball = [_local_1("sfx_pteranodon_snowball")];
            _sfx_pteranodonWalk = [_local_1("sfx_pteranodon_walk_1"), _local_1("sfx_pteranodon_walk_2")];
            _sfx_pteranodonWave = [_local_1("sfx_pteranodon_wave")];
            _sfx_raptorDance = [_local_1("sfx_raptor_dance_1"), _local_1("sfx_raptor_dance_2"), _local_1("sfx_raptor_dance_3")];
            _sfx_raptorEat = [_local_1("sfx_raptor_eat_1"), _local_1("sfx_raptor_eat_2")];
            _sfx_raptorSnowball = [_local_1("sfx_raptor_snowball_1"), _local_1("sfx_raptor_snowball_2")];
            _sfx_raptorWalk = [_local_1("sfx_raptor_walk_1"), _local_1("sfx_raptor_walk_2")];
            _sfx_raptorWave = [_local_1("sfx_raptor_wave_1"), _local_1("sfx_raptor_wave_2")];
            _sfx_stegosaurusDance = [_local_1("sfx_stegosaurus_dance_1"), _local_1("sfx_stegosaurus_dance_2"), _local_1("sfx_stegosaurus_dance_3")];
            _sfx_stegosaurusEat = [_local_1("sfx_stegosaurus_eat_1"), _local_1("sfx_stegosaurus_eat_2")];
            _sfx_stegosaurusSnowball = [_local_1("sfx_stegosaurus_snowball_1"), _local_1("sfx_stegosaurus_snowball_2")];
            _sfx_stegosaurusWalk = [_local_1("sfx_stegosaurus_walk_1"), _local_1("sfx_stegosaurus_walk_2")];
            _sfx_stegosaurusWave = [_local_1("sfx_stegosaurus_wave_1"), _local_1("sfx_stegosaurus_wave_2"), _local_1("sfx_stegosaurus_wave_3")];
            _sfx_trexDance = [_local_1("sfx_trex_dance")];
            _sfx_trexEat = [_local_1("sfx_trex_eat_1"), _local_1("sfx_trex_eat_2")];
            _sfx_trexSnowball = [_local_1("sfx_trex_snowball_1"), _local_1("sfx_trex_snowball_2"), _local_1("sfx_trex_snowball_3"), _local_1("sfx_trex_snowball_4"), _local_1("sfx_trex_snowball_5"), _local_1("sfx_trex_snowball_6")];
            _sfx_trexWalk = [_local_1("sfx_trex_walk_1"), _local_1("sfx_trex_walk_2")];
            _sfx_trexWave = [_local_1("sfx_trex_wave")];
            _sfx_triceratopsDance = [_local_1("sfx_triceratops_dance")];
            _sfx_triceratopsEat = [_local_1("sfx_triceratops_eat")];
            _sfx_triceratopsSnowball = [_local_1("sfx_triceratops_snowball")];
            _sfx_triceratopsWalk = [_local_1("sfx_triceratops_walk_1"), _local_1("sfx_triceratops_walk_2")];
            _sfx_triceratopsWave = [_local_1("sfx_triceratops_wave")];
        }
        static function onPlayerMoveStart(player) {
            if (_shell.isMyPlayer(player)) {
                startSfxDinoWalk(player.avatarVO.avatar_id);
            }
        }
        static function onPlayerMoveEnd(player) {
            if (_shell.isMyPlayer(player)) {
                stopSfxDinoWalk();
            }
        }
        static function startSfxDinoWalk(avatarId) {
            stopSfxDinoWalk();
            var _local_1 = null;
            if (com.clubpenguin.world.rooms2014.prehistoric.PrehistoricParty.isTrex(avatarId)) {
                _local_1 = _sfx_trexWalk;
            } else if (com.clubpenguin.world.rooms2014.prehistoric.PrehistoricParty.isTriceratops(avatarId)) {
                _local_1 = _sfx_triceratopsWalk;
            } else if (com.clubpenguin.world.rooms2014.prehistoric.PrehistoricParty.isPteranodon(avatarId)) {
                _local_1 = _sfx_pteranodonWalk;
            } else if (com.clubpenguin.world.rooms2014.prehistoric.PrehistoricParty.isStegosuarus(avatarId)) {
                _local_1 = _sfx_stegosaurusWalk;
            } else if (com.clubpenguin.world.rooms2014.prehistoric.PrehistoricParty.isRaptor(avatarId)) {
                _local_1 = _sfx_raptorWalk;
            }
            if (_local_1 != null) {
                _sfx_walkingLoopId = soundManager.playSoundLoop(_local_1, _sfxLayer_dinoWalk, LOCAL_PLAYER_SFX_VOLUME);
            }
        }
        static function stopSfxDinoWalk() {
            if (_sfx_walkingLoopId != -1) {
                soundManager.stopSoundLoop(_sfx_walkingLoopId);
                _sfx_walkingLoopId = -1;
            }
        }
        static function onPlayerDanceStart(player) {
            var _local_2 = REMOTE_PLAYER_SFX_VOLUME;
            if (_shell.isMyPlayer(player)) {
                _local_2 = LOCAL_PLAYER_SFX_VOLUME;
            }
            stopAllSoundsForPlayer(player.player_id);
            playSfxDinoRoar(player.avatarVO.avatar_id, _local_2, player.player_id);
        }
        static function playSfxDinoRoar(avatarId, volume, tag) {
            var _local_1 = null;
            if (com.clubpenguin.world.rooms2014.prehistoric.PrehistoricParty.isTrex(avatarId)) {
                _local_1 = _sfx_trexDance;
                soundManager.playSoundAfterDelay(_local_1[0], _sfxLayer_dinoAction, 18, volume, tag);
            } else if (com.clubpenguin.world.rooms2014.prehistoric.PrehistoricParty.isTriceratops(avatarId)) {
                _local_1 = _sfx_triceratopsDance;
                soundManager.playSoundAfterDelay(_local_1[0], _sfxLayer_dinoAction, 2, volume, tag);
            } else if (com.clubpenguin.world.rooms2014.prehistoric.PrehistoricParty.isPteranodon(avatarId)) {
                _local_1 = _sfx_pteranodonDance;
                soundManager.playSoundAfterDelay(_local_1[0], _sfxLayer_dinoAction, 22, volume, tag);
            } else if (com.clubpenguin.world.rooms2014.prehistoric.PrehistoricParty.isStegosuarus(avatarId)) {
                _local_1 = _sfx_stegosaurusDance;
                soundManager.playSoundAfterDelay(_local_1[0], _sfxLayer_dinoAction, 8, volume, tag);
                soundManager.playSoundAfterDelay(_local_1[1], _sfxLayer_dinoAction, 40, volume, tag);
                soundManager.playSoundAfterDelay(_local_1[2], _sfxLayer_dinoAction, 68, volume, tag);
            } else if (com.clubpenguin.world.rooms2014.prehistoric.PrehistoricParty.isRaptor(avatarId)) {
                _local_1 = _sfx_raptorDance;
                soundManager.playSoundAfterDelay(_local_1[0], _sfxLayer_dinoAction, 14, volume, tag);
                soundManager.playSoundAfterDelay(_local_1[1], _sfxLayer_dinoAction, 40, volume, tag);
                soundManager.playSoundAfterDelay(_local_1[2], _sfxLayer_dinoAction, 68, volume, tag);
            }
        }
        static function onPlayerWaveStart(player) {
            var _local_2 = REMOTE_PLAYER_SFX_VOLUME;
            if (_shell.isMyPlayer(player)) {
                _local_2 = LOCAL_PLAYER_SFX_VOLUME;
            }
            stopAllSoundsForPlayer(player.player_id);
            playSfxDinoWave(player.avatarVO.avatar_id, _local_2, player.player_id);
        }
        static function playSfxDinoWave(avatarId, volume, tag) {
            var _local_1 = null;
            if (com.clubpenguin.world.rooms2014.prehistoric.PrehistoricParty.isTrex(avatarId)) {
                _local_1 = _sfx_trexWave;
                soundManager.playSoundAfterDelay(_local_1[0], _sfxLayer_dinoAction, 2, volume, tag);
            } else if (com.clubpenguin.world.rooms2014.prehistoric.PrehistoricParty.isTriceratops(avatarId)) {
                _local_1 = _sfx_triceratopsWave;
                soundManager.playSoundAfterDelay(_local_1[0], _sfxLayer_dinoAction, 2, volume, tag);
            } else if (com.clubpenguin.world.rooms2014.prehistoric.PrehistoricParty.isPteranodon(avatarId)) {
                _local_1 = _sfx_pteranodonWave;
                soundManager.playSoundAfterDelay(_local_1[0], _sfxLayer_dinoAction, 2, volume, tag);
            } else if (com.clubpenguin.world.rooms2014.prehistoric.PrehistoricParty.isStegosuarus(avatarId)) {
                _local_1 = _sfx_stegosaurusWave;
                soundManager.playSoundAfterDelay(_local_1[0], _sfxLayer_dinoAction, 2, volume, tag);
                soundManager.playSoundAfterDelay(_local_1[1], _sfxLayer_dinoAction, 10, volume, tag);
                soundManager.playSoundAfterDelay(_local_1[2], _sfxLayer_dinoAction, 35, volume, tag);
            } else if (com.clubpenguin.world.rooms2014.prehistoric.PrehistoricParty.isRaptor(avatarId)) {
                _local_1 = _sfx_raptorWave;
                soundManager.playSoundAfterDelay(_local_1[0], _sfxLayer_dinoAction, 5, volume, tag);
                soundManager.playSoundAfterDelay(_local_1[1], _sfxLayer_dinoAction, 55, volume, tag);
            }
        }
        static function onDinoEatStart(player) {
            var _local_2 = REMOTE_PLAYER_SFX_VOLUME;
            if (_shell.isMyPlayer(player)) {
                _local_2 = LOCAL_PLAYER_SFX_VOLUME;
            }
            stopAllSoundsForPlayer(player.player_id);
            playSfxDinoEat(player.avatarVO.avatar_id, _local_2, player.player_id);
        }
        static function playSfxDinoEat(avatarId, volume, tag) {
            var _local_1 = null;
            if (com.clubpenguin.world.rooms2014.prehistoric.PrehistoricParty.isTrex(avatarId)) {
                _local_1 = _sfx_trexEat;
            } else if (com.clubpenguin.world.rooms2014.prehistoric.PrehistoricParty.isTriceratops(avatarId)) {
                _local_1 = _sfx_triceratopsEat;
                soundManager.playSoundAfterDelay(_local_1[0], _sfxLayer_dinoAction, 2, volume, tag);
            } else if (com.clubpenguin.world.rooms2014.prehistoric.PrehistoricParty.isPteranodon(avatarId)) {
                _local_1 = _sfx_pteranodonEat;
                soundManager.playSoundAfterDelay(_local_1[0], _sfxLayer_dinoAction, 8, volume, tag);
                soundManager.playSoundAfterDelay(_local_1[1], _sfxLayer_dinoAction, 15, volume, tag);
            } else if (com.clubpenguin.world.rooms2014.prehistoric.PrehistoricParty.isStegosuarus(avatarId)) {
                _local_1 = _sfx_stegosaurusEat;
                soundManager.playSoundAfterDelay(_local_1[0], _sfxLayer_dinoAction, 10, volume, tag);
                soundManager.playSoundAfterDelay(_local_1[1], _sfxLayer_dinoAction, 73, volume, tag);
            } else if (com.clubpenguin.world.rooms2014.prehistoric.PrehistoricParty.isRaptor(avatarId)) {
                _local_1 = _sfx_raptorEat;
                soundManager.playSoundAfterDelay(_local_1[0], _sfxLayer_dinoAction, 2, volume, tag);
                soundManager.playSoundAfterDelay(_local_1[1], _sfxLayer_dinoAction, 55, volume, tag);
            }
        }
        static function onDinoThrowStart(player) {
            var _local_2 = REMOTE_PLAYER_SFX_VOLUME;
            if (_shell.isMyPlayer(player)) {
                _local_2 = LOCAL_PLAYER_SFX_VOLUME;
            }
            stopAllSoundsForPlayer(player.player_id);
            playSfxDinoThrow(player.avatarVO.avatar_id, _local_2, player.player_id);
        }
        static function playSfxDinoThrow(avatarId, volume, tag) {
            var _local_1 = null;
            if (com.clubpenguin.world.rooms2014.prehistoric.PrehistoricParty.isTrex(avatarId)) {
                _local_1 = _sfx_trexSnowball;
                soundManager.playSoundAfterDelay(_local_1[0], _sfxLayer_dinoAction, 5, volume, tag);
                soundManager.playSoundAfterDelay(_local_1[1], _sfxLayer_dinoAction, 32, volume, tag);
                soundManager.playSoundAfterDelay(_local_1[2], _sfxLayer_dinoAction, 51, volume, tag);
                soundManager.playSoundAfterDelay(_local_1[3], _sfxLayer_dinoAction, 84, volume, tag);
                soundManager.playSoundAfterDelay(_local_1[4], _sfxLayer_dinoAction, 95, volume, tag);
                soundManager.playSoundAfterDelay(_local_1[5], _sfxLayer_dinoAction, 115, volume, tag);
            } else if (com.clubpenguin.world.rooms2014.prehistoric.PrehistoricParty.isTriceratops(avatarId)) {
                _local_1 = _sfx_triceratopsSnowball;
                soundManager.playSoundAfterDelay(_local_1[0], _sfxLayer_dinoAction, 2, volume, tag);
            } else if (com.clubpenguin.world.rooms2014.prehistoric.PrehistoricParty.isPteranodon(avatarId)) {
                _local_1 = _sfx_pteranodonSnowball;
                soundManager.playSoundAfterDelay(_local_1[0], _sfxLayer_dinoAction, 2, volume, tag);
            } else if (com.clubpenguin.world.rooms2014.prehistoric.PrehistoricParty.isStegosuarus(avatarId)) {
                _local_1 = _sfx_stegosaurusSnowball;
                soundManager.playSoundAfterDelay(_local_1[0], _sfxLayer_dinoAction, 5, volume, tag);
                soundManager.playSoundAfterDelay(_local_1[1], _sfxLayer_dinoAction, 22, volume, tag);
            } else if (com.clubpenguin.world.rooms2014.prehistoric.PrehistoricParty.isRaptor(avatarId)) {
                _local_1 = _sfx_raptorSnowball;
                soundManager.playSoundAfterDelay(_local_1[0], _sfxLayer_dinoAction, 5, volume, tag);
                soundManager.playSoundAfterDelay(_local_1[1], _sfxLayer_dinoAction, 35, volume, tag);
            }
        }
        static function stopAllSoundsForPlayer(playerId) {
            soundManager.stopSoundsForTag(playerId);
        }
        static var REMOTE_PLAYER_SFX_VOLUME = 25;
        static var LOCAL_PLAYER_SFX_VOLUME = 100;
        static var _sfx_walkingLoopId = -1;
    }
