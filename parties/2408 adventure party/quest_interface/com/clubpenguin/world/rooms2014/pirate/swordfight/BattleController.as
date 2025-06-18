//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2014.pirate.swordfight.BattleController
    {
        var _battle, _stateManager, _service, _shell, _engine, battleCompleted, _navigationBlocker, _isLocalPlayerBattle;
        function BattleController (service, battle) {
            _battle = battle;
            _stateManager = new com.clubpenguin.util.state.StateManager();
            _service = service;
            _shell = _global.getCurrentShell();
            _engine = _global.getCurrentEngine();
            battleCompleted = new org.osflash.signals.Signal(com.clubpenguin.world.rooms2014.pirate.swordfight.BattleController, com.clubpenguin.world.rooms2014.pirate.swordfight.vo.BattleVO);
        }
        static function createOpened(service, battle) {
            var _local_1 = new com.clubpenguin.world.rooms2014.pirate.swordfight.BattleController(service, battle);
            _local_1.changeToOpenedState();
            return(_local_1);
        }
        static function createStarted(service, battle, timeoutSeconds) {
            var _local_1 = new com.clubpenguin.world.rooms2014.pirate.swordfight.BattleController(service, battle);
            _local_1.changeToStartedState(timeoutSeconds);
            return(_local_1);
        }
        function destroy() {
            battleCompleted.removeAll();
            _stateManager.changeState(null);
        }
        function get service() {
            return(_service);
        }
        function changeToOpenedState() {
            debugTrace("changeToOpenState " + _battle);
            setIsLocalPlayerBattle();
            _stateManager.changeState(new com.clubpenguin.world.rooms2014.pirate.swordfight.states.BattleOpenState(_stateManager, this, _battle));
        }
        function changeToStartedState(timeoutSeconds) {
            debugTrace("changeToStartedState " + _battle);
            setIsLocalPlayerBattle();
            _stateManager.changeState(new com.clubpenguin.world.rooms2014.pirate.swordfight.states.BattleStartedState(_stateManager, this, _battle, timeoutSeconds));
        }
        function changeToEndingState(result) {
            debugTrace("changeToEndingState " + _battle);
            _stateManager.changeState(new com.clubpenguin.world.rooms2014.pirate.swordfight.states.BattleEndingState(_stateManager, this, _battle, result));
        }
        function completeBattle() {
            debugTrace("completeBattle " + _battle);
            _stateManager.changeState(null);
            revertCreatorAvatar();
            if (_shell.isMyPlayer(_battle.creatorId) || (_shell.isMyPlayer(_battle.challengerId))) {
                removeNavigationBlocker();
                _engine.enableMouseMovement();
            }
            if (_battle.challengerId != null) {
                revertChallengerAvatar();
            }
            battleCompleted.dispatch(this, _battle);
            battleCompleted.removeAll();
            _battle = null;
        }
        function loadCreatorAvatar() {
            return(loadBattleAvatar(_battle.creatorId));
        }
        function loadChallengerAvatar() {
            return(loadBattleAvatar(_battle.challengerId));
        }
        function loadBattleAvatar(playerId) {
            if (_shell.getMyPlayerId() == playerId) {
            }
            _engine.updatePlayerFrame(playerId, 1);
            var _local_2 = _shell.getPlayerObjectById(playerId);
            var _local_4 = com.clubpenguin.world.rooms2014.pirate.party.PirateParty.getBattleAvatarIdForPlayer(_local_2);
            com.clubpenguin.util.Log.debug("Load Battle Avatar - getBattleAvatarIdForPlayer(player) " + _local_4);
            com.clubpenguin.util.Log.debug("Load Battle Avatar - player.avatarVO.avatar_id " + _local_2.avatarVO.avatar_id);
            _local_2.avatarVO = _engine.avatarManager.model.createAvatarFromTemplate(_local_4);
            com.clubpenguin.world.rooms2014.pirate.party.PiratePartySounds.playTransformSound(playerId);
            return(_engine.avatarManager.transformationManager.transformPlayer(_local_2, com.clubpenguin.engine.avatar.transformation.AvatarTypeEnum.DEFAULT_ID));
        }
        function revertCreatorAvatar() {
            return(revertBattleAvatar(_battle.creatorId));
        }
        function revertChallengerAvatar() {
            return(revertBattleAvatar(_battle.challengerId));
        }
        function revertBattleAvatar(playerId) {
            com.clubpenguin.util.Log.debug("Revert battle avatar");
            if (_shell.getMyPlayerId() == playerId) {
            }
            var _local_2 = _shell.getPlayerObjectById(playerId);
            _local_2.avatarVO = _engine.avatarManager.model.createAvatarFromTemplate(com.clubpenguin.engine.avatar.transformation.AvatarTypeEnum.DEFAULT_ID);
            var _local_4 = com.clubpenguin.world.rooms2014.pirate.party.PirateParty.getBattleAvatarIdForPlayer(_local_2);
            com.clubpenguin.world.rooms2014.pirate.party.PiratePartySounds.playTransformSound(playerId);
            return(_engine.avatarManager.transformationManager.transformPlayer(_local_2, _local_4));
        }
        function tintAvatar(playerId) {
            var _local_2 = _engine.getPlayerMovieClip(playerId).art_mc;
            var _local_3 = _shell.getPlayerObjectById(playerId);
            var _local_4 = new Color(_local_2.body);
            _local_4.setRGB(_shell.getPlayerHexFromId(_local_3.colour_id));
        }
        function createNavigationBlocker() {
            var _local_2 = _engine.getPlayerMovieClip(_battle.creatorId);
            var _local_6 = _engine.getPlayerMovieClip(_battle.challengerId);
            var _local_5 = _engine.getRoomMovieClip();
            var _local_3 = _local_5.block_mc;
            _navigationBlocker = _local_3.createEmptyMovieClip("_navigationBlocker", _local_3.getNextHighestDepth());
            var _local_4 = _local_2._x + ((_local_6._x - _local_2._x) / 2);
            drawNavigationBlocker(_navigationBlocker, _local_4, _local_2._y);
            moveStuckObservers();
        }
        function removeNavigationBlocker() {
            _navigationBlocker.removeMovieClip();
        }
        function drawNavigationBlocker(blocker, x, y) {
            var _local_10 = 50;
            var _local_11 = 15;
            var _local_8 = 16;
            blocker.beginFill(0, 50);
            blocker.moveTo(_local_10, 0);
            var _local_1 = 0;
            while (_local_1 <= _local_8) {
                var _local_7 = _local_1 / _local_8;
                var _local_2 = (_local_7 * 2) * Math.PI;
                var _local_5 = Math.cos(_local_2);
                var _local_3 = Math.sin(_local_2);
                var _local_6 = _local_5 * _local_10;
                var _local_4 = _local_3 * _local_11;
                blocker.lineTo(_local_6, _local_4);
                _local_1++;
            }
            blocker.endFill();
            blocker._x = x;
            blocker._y = y + 10;
        }
        function moveStuckObservers() {
            var _local_6 = _engine.getRoomMovieClip();
            var _local_4 = _shell.getPlayerList();
            var _local_3;
            var _local_5;
            var _local_2 = 0;
            while (_local_2 < _local_4.length) {
                _local_3 = _local_4[_local_2].player_id;
                _local_5 = _engine.getPlayerMovieClip(_local_3);
                if (((_local_3 != _battle.creatorId) && (_local_3 != _battle.challengerId)) && (_navigationBlocker.hitTest(_local_5._x, _local_5._y, true))) {
                    _engine.movePlayerToSpawnLocation(_local_4[_local_2], true);
                }
                _local_2++;
            }
        }
        function get isLocalPlayerBattle() {
            return(_isLocalPlayerBattle);
        }
        function setIsLocalPlayerBattle() {
            _isLocalPlayerBattle = _battle.containsPlayer(_shell.getMyPlayerId());
        }
        function moveChallengerToCreator(challengerId) {
            var _local_3 = _engine.getPlayerMovieClip(challengerId);
            var _local_2 = _engine.getPlayerMovieClip(_battle.creatorId);
            var _local_6 = _shell.getPlayerObjectById(challengerId);
            if (_shell.getMyPlayerId() == challengerId) {
                _local_6 = _shell.getMyPlayerObject();
            }
            _local_3.is_moving = false;
            var _local_4;
            var _local_7;
            if (_local_3._x < _local_2._x) {
                _local_4 = _local_2._x - CHALLENGER_X_OFFSET;
            } else {
                _local_4 = _local_2._x + CHALLENGER_X_OFFSET;
            }
            _local_7 = _local_2._y;
            _engine.sendPlayerMove(_local_4, _local_7);
        }
        function toString() {
            return(("BattleController{" + _battle) + "}");
        }
        function debugTrace(msg) {
            if (debug) {
                com.clubpenguin.util.Log.debug("BattleController > " + msg);
            }
        }
        static var CHALLENGER_X_OFFSET = 70;
        var debug = true;
    }
