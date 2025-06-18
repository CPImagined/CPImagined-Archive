//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2013.prehistoric.snowball.DinoHitCheck
    {
        var _opcodeJournal, _SHELL, _ENGINE, _responseDelegate;
        function DinoHitCheck (opcodeJournal) {
            _opcodeJournal = opcodeJournal;
            _SHELL = _global.getCurrentShell();
            _ENGINE = _global.getCurrentEngine();
            _responseDelegate = com.clubpenguin.util.Delegate.create(this, onServerResponse);
            _SHELL.AIRTOWER.addListener(_SHELL.AIRTOWER.COINS_AWARDED, onServerResponse, this);
        }
        function hitCheck(snowballEvent) {
            var _local_4 = _SHELL.getPlayerObjectById(snowballEvent.player_id);
            var _local_3 = _SHELL.getPlayerObjectById(snowballEvent.hit_player_id);
            if (com.clubpenguin.world.rooms2013.prehistoric.Prehistoric.isPlayerDinosaur(_local_3.avatar_id) && (com.clubpenguin.world.rooms2013.prehistoric.Prehistoric.isPlayerCaveman(_local_4.avatar_id))) {
                if (_SHELL.isMyPlayer(_local_4.player_id)) {
                    _SHELL.AIRTOWER.send(_SHELL.AIRTOWER.PLAY_EXT, (_SHELL.AIRTOWER.PLAYER_HANDLER + "#") + _SHELL.AIRTOWER.SNOWBALL_HIT, [snowballEvent.x, snowballEvent.y, _local_3.player_id], "str", _SHELL.getRoomObject().room_id);
                }
                _ENGINE.updatePlayerFrame(_local_3.player_id, com.clubpenguin.world.rooms2013.prehistoric.Prehistoric.EAT_FRAME);
                snowballEvent.snowballMC._visible = false;
                _opcodeJournal.sendOpcode(com.clubpenguin.world.rooms2013.prehistoric.OpcodeJournal.PLAYER_FEEDS_DINOSAUR_WITH_SNOWBALL);
            }
        }
        function onServerResponse(response) {
            var _local_2 = _SHELL.getPlayerObjectById(response[1]);
            _ENGINE.avatarManager.effectManager.playEffectForPlayer(com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.COIN_TWIRL, _local_2);
            if (_SHELL.isMyPlayer(_local_2.player_id)) {
                _SHELL.setMyPlayerTotalCoins(response[3]);
            }
        }
    }
