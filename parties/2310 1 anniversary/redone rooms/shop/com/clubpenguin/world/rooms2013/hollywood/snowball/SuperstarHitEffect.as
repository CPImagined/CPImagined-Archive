//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2013.hollywood.snowball.SuperstarHitEffect
    {
        var _opcodeJournal, _SHELL, _ENGINE, _INTERFACE, _responseDelegate, _showContentTimeout;
        function SuperstarHitEffect (opcodeJournal) {
            _opcodeJournal = opcodeJournal;
            _SHELL = _global.getCurrentShell();
            _ENGINE = _global.getCurrentEngine();
            _INTERFACE = _global.getCurrentInterface();
            _responseDelegate = com.clubpenguin.util.Delegate.create(this, onServerResponse);
            _SHELL.AIRTOWER.addListener(_SHELL.AIRTOWER.PLAYER_DIRECTOR_POINTS, onServerResponse, this);
        }
        function applyHitEffect(snowballEvent) {
            var _local_3 = _SHELL.getPlayerObjectById(snowballEvent.player_id);
            var _local_2 = _SHELL.getPlayerObjectById(snowballEvent.hit_player_id);
            if (com.clubpenguin.world.rooms2013.hollywood.Hollywood.isPlayerDirector(_local_3.avatar_id)) {
                _ENGINE.avatarManager.effectManager.playEffectForPlayer(com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.CAMERA_FLASH_SIMPLE, _local_3);
                if (com.clubpenguin.world.rooms2013.hollywood.Hollywood.canPhotographPlayer(_local_2.player_id)) {
                    _ENGINE.avatarManager.effectManager.playEffectForPlayer(com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.CAMERA_FLASH_SPARKLE, _local_2);
                    if (_SHELL.isMyPlayer(_local_3.player_id)) {
                        _SHELL.AIRTOWER.send(_SHELL.AIRTOWER.PLAY_EXT, (_SHELL.AIRTOWER.PLAYER_HANDLER + "#") + _SHELL.AIRTOWER.SNOWBALL_HIT, [snowballEvent.x, snowballEvent.y, _local_2.player_id], "str", _SHELL.getRoomObject().room_id);
                    }
                    com.clubpenguin.world.rooms2013.hollywood.Hollywood.PLAYER_PHOTO_LIST.push(_local_2.player_id);
                }
            }
        }
        function applyMissEffect(snowballEvent) {
            var _local_2 = _SHELL.getPlayerObjectById(snowballEvent.player_id);
            if (com.clubpenguin.world.rooms2013.hollywood.Hollywood.isPlayerDirector(_local_2.avatar_id)) {
                _ENGINE.avatarManager.effectManager.playEffectForPlayer(com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.CAMERA_FLASH_SIMPLE, _local_2);
            }
        }
        function onServerResponse(response) {
            var _local_2 = _SHELL.getPlayerObjectById(response[1]);
            _ENGINE.avatarManager.effectManager.playEffectForPlayer(com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.DIRECTOR_POINTS, _local_2);
            if (_SHELL.isMyPlayer(_local_2.player_id)) {
                com.clubpenguin.world.rooms2013.hollywood.Hollywood.setDirectorPower(response[3]);
                if (com.clubpenguin.world.rooms2013.hollywood.Hollywood.getDirectorPower() == 100) {
                    _showContentTimeout = setTimeout(com.clubpenguin.util.Delegate.create(this, showContent), 1000);
                }
            }
        }
        function showContent() {
            clearTimeout(_showContentTimeout);
            _INTERFACE.showContent("w.party.announcement");
        }
    }
