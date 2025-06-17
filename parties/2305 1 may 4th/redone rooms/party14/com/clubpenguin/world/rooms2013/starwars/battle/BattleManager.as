//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2013.starwars.battle.BattleManager
    {
        var _room, _engine, _shell, _service, _controllersMap, _sfxAmbient;
        function BattleManager (room) {
            _room = room;
            _engine = _global.getCurrentEngine();
            _shell = _global.getCurrentShell();
            _service = new com.clubpenguin.world.rooms2013.starwars.battle.RoomBattlesService();
            _service.battleOpened.add(onBattleOpened, this);
            _service.battleStarted.add(onBattleStarted, this);
            _service.battleEnded.add(onBattleEnded, this);
            _service.battleAborted.add(onBattleAborted, this);
            _controllersMap = new Object();
            _sfxAmbient = new Sound(room.partySoundsClip.createEmptyMovieClip("sfx_sw_battle_amb", room.partySoundsClip.getNextHighestDepth()));
            _sfxAmbient.attachSound("sfx_sw_battle_amb");
        }
        function destroy() {
            _service.destroy();
            for (var _local_2 in _controllersMap) {
                _controllersMap[_local_2].destroy();
            }
            _room.partySoundsClip.sfx_sw_battle_amb.removeMovieClip();
            delete _sfxAmbient;
        }
        function get service() {
            return(_service);
        }
        function isPlayerInActiveBattle(playerId) {
            return(_service.isPlayerInBattle(playerId));
        }
        function isPlayerInOpenBattle(playerId) {
            return(_service.isPlayerInOpenBattle(playerId));
        }
        function getNearestJoinableBattle(playerId) {
            var _local_4 = _service.getOpenBattles();
            var _local_2 = 0;
            while (_local_2 < _local_4.length) {
                var _local_3 = _local_4[_local_2];
                if (canJoinBattle(_local_3, playerId)) {
                    return(_local_3);
                }
                _local_2++;
            }
        }
        function canJoinBattle(battle, playerId) {
            if (((((battle.creatorId == null) || (battle.creatorId == playerId)) || (battle.state != com.clubpenguin.world.rooms2013.starwars.battle.BattleVO.STATE_OPENED)) || (battle.challengerId != null)) || (isPlayerInActiveBattle(playerId))) {
                return(false);
            }
            var _local_2 = _engine.getPlayerMovieClip(battle.creatorId);
            var _local_3 = _engine.getPlayerMovieClip(playerId);
            if (((_local_3._x == (_local_2._x + com.clubpenguin.world.rooms2013.starwars.battle.BattleController.CHALLENGER_X_OFFSET)) || (_local_3._x == (_local_2._x - com.clubpenguin.world.rooms2013.starwars.battle.BattleController.CHALLENGER_X_OFFSET))) && (_local_3._y == _local_2._y)) {
                return(true);
            } else {
                return(false);
            }
        }
        function onBattleOpened(battle) {
            if (_controllersMap[battle.id] != null) {
                return(undefined);
            }
            var _local_3 = com.clubpenguin.world.rooms2013.starwars.battle.BattleController.createOpened(_room, _service, battle);
            _controllersMap[battle.id] = _local_3;
            _local_3.battleCompleted.addOnce(onBattleCompleted, this);
            checkStartAmbientLoop(battle);
        }
        function onBattleStarted(battle, timeoutSeconds) {
            var _local_2 = _controllersMap[battle.id];
            if (_local_2 == null) {
                _local_2 = com.clubpenguin.world.rooms2013.starwars.battle.BattleController.createStarted(_room, _service, battle, timeoutSeconds);
                _controllersMap[battle.id] = _local_2;
                _local_2.battleCompleted.addOnce(onBattleCompleted, this);
                checkStartAmbientLoop(battle);
            } else {
                _local_2.changeToStartedState(timeoutSeconds);
            }
        }
        function onBattleEnded(battle, result) {
            var _local_2 = _controllersMap[battle.id];
            if (_local_2 == null) {
                return(undefined);
            }
            _local_2.changeToEndingState(result);
        }
        function onBattleAborted(battle) {
            var _local_3 = _controllersMap[battle.id];
            if (_local_3 == null) {
                return(undefined);
            }
            checkStopAmbientLoop(battle);
            _controllersMap[battle.id].completeBattle();
            _controllersMap[battle.id] = null;
            delete _controllersMap[battle.id];
        }
        function onBattleCompleted(controller, battle) {
            checkStopAmbientLoop(battle);
            _controllersMap[battle.id] = null;
            delete _controllersMap[battle.id];
            _service.removeBattle(battle);
        }
        function checkStartAmbientLoop(battle) {
            if (_shell.isMyPlayer(battle.creatorId) || (_shell.isMyPlayer(battle.challengerId))) {
                _sfxAmbient.start(0, 999);
            }
        }
        function checkStopAmbientLoop(battle) {
            if (_shell.isMyPlayer(battle.creatorId) || (_shell.isMyPlayer(battle.challengerId))) {
                _sfxAmbient.stop();
            }
        }
        function traceControllers() {
            for (var _local_2 in _controllersMap) {
            }
        }
    }
