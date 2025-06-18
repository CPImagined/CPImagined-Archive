//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2014.pirate.swordfight.BattleManager
    {
        var _engine, _shell, _service, _controllersMap, _sfxAmbient;
        function BattleManager () {
            com.clubpenguin.util.Log.debug("BattleManager init");
            _engine = _global.getCurrentEngine();
            _shell = _global.getCurrentShell();
            _service = new com.clubpenguin.world.rooms2014.pirate.swordfight.RoomBattlesService();
            _service.battleOpened.add(onBattleOpened, this);
            _service.battleStarted.add(onBattleStarted, this);
            _service.battleEnded.add(onBattleEnded, this);
            _service.battleAborted.add(onBattleAborted, this);
            _controllersMap = new Object();
        }
        function destroy() {
            _service.destroy();
            for (var _local_2 in _controllersMap) {
                _controllersMap[_local_2].destroy();
            }
            delete _sfxAmbient;
        }
        function get service() {
            return(_service);
        }
        function isPlayerAHost(playerId) {
            return(isPlayerInActiveBattle(playerId) || ((isPlayerInOpenBattle(playerId) == null) && (com.clubpenguin.world.rooms2014.pirate.party.PirateParty.isSwordEquipped(playerId))));
        }
        function isPlayerInActiveBattle(playerId) {
            return(_service.isPlayerInBattle(playerId));
        }
        function isPlayerInOpenBattle(playerId) {
            return(_service.isPlayerInOpenBattle(playerId));
        }
        function isPlayerBattling(playerId) {
            if (_service.isPlayerInBattle(playerId) && (!_service.isPlayerInOpenBattle(playerId))) {
                return(true);
            }
            return(false);
        }
        function requestBattleOpen() {
            service.sendOpenBattle();
        }
        function requestBattleCancel() {
            service.abortMyBattle();
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
            if (((((battle.creatorId == null) || (battle.creatorId == playerId)) || (battle.state != com.clubpenguin.world.rooms2014.pirate.swordfight.states.BattleStateEnum.OPEN)) || (battle.challengerId != null)) || (isPlayerInActiveBattle(playerId))) {
                return(false);
            }
            var _local_2 = _engine.getPlayerMovieClip(battle.creatorId);
            var _local_3 = _engine.getPlayerMovieClip(playerId);
            if (((_local_3._x == (_local_2._x + com.clubpenguin.world.rooms2014.pirate.swordfight.BattleController.CHALLENGER_X_OFFSET)) || (_local_3._x == (_local_2._x - com.clubpenguin.world.rooms2014.pirate.swordfight.BattleController.CHALLENGER_X_OFFSET))) && (_local_3._y == _local_2._y)) {
                return(true);
            } else {
                return(false);
            }
        }
        function onBattleOpened(battle) {
            com.clubpenguin.util.Log.debug("BattleManager.onBattleOpened " + battle);
            if (_controllersMap[battle.id] != null) {
                com.clubpenguin.util.Log.debug("BattleManager.onBattleOpened WARNING: cannot add newly opened battle because a controller already exists.");
                return(undefined);
            }
            var _local_3 = com.clubpenguin.world.rooms2014.pirate.swordfight.BattleController.createOpened(_service, battle);
            _controllersMap[battle.id] = _local_3;
            _local_3.battleCompleted.addOnce(onBattleCompleted, this);
        }
        function onBattleStarted(battle, timeoutSeconds) {
            com.clubpenguin.util.Log.debug("BattleManager.onBattleStarted " + battle);
            var _local_2 = _controllersMap[battle.id];
            if (_local_2 == null) {
                _local_2 = com.clubpenguin.world.rooms2014.pirate.swordfight.BattleController.createStarted(_service, battle, timeoutSeconds);
                _controllersMap[battle.id] = _local_2;
                _local_2.battleCompleted.addOnce(onBattleCompleted, this);
                checkStartAmbientLoop(battle);
            } else {
                _local_2.changeToStartedState(timeoutSeconds);
            }
        }
        function onBattleEnded(battle, result) {
            com.clubpenguin.util.Log.debug((("BattleManager.onBattleEnded " + battle) + "  ") + result);
            var _local_2 = _controllersMap[battle.id];
            if (_local_2 == null) {
                com.clubpenguin.util.Log.debug("BattleManager.onBattleEnded WARNING: no controller exists for the battle that just ended.");
                return(undefined);
            }
            _local_2.changeToEndingState(result);
        }
        function onBattleAborted(battle) {
            com.clubpenguin.util.Log.debug("BattleManager.onBattleAborted " + battle);
            var _local_3 = _controllersMap[battle.id];
            if (_local_3 == null) {
                com.clubpenguin.util.Log.debug("BattleManager.onBattleAborted WARNING: no controller exists for the battle that just aborted.");
                return(undefined);
            }
            checkStopAmbientLoop(battle);
            _controllersMap[battle.id].completeBattle();
            _controllersMap[battle.id] = null;
            delete _controllersMap[battle.id];
        }
        function onBattleCompleted(controller, battle) {
            com.clubpenguin.util.Log.debug((("BattleManager.onBattleComplete " + controller) + "   ") + battle);
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
                com.clubpenguin.util.Log.debug("BattleManager > _controllersMap[k] = " + _controllersMap[_local_2]);
            }
        }
    }
