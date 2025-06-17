//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2013.starwars.battle.states.BattleOpenState extends com.clubpenguin.world.rooms2013.starwars.battle.states.BaseBattleState
    {
        var _active, _onPlayerFrameUpdateDelegate, _onUpdatePlayerDelegate, _battle, _controller, _shell, _engine, _leftBattleButton, _rightBattleButton, _leftStartTrigger, _rightStartTrigger;
        function BattleOpenState (manager, controller, battle) {
            super("BattleOpenState", manager, controller, battle);
            _active = false;
            _onPlayerFrameUpdateDelegate = com.clubpenguin.util.Delegate.create(this, onPlayerFrameUpdate);
            _onUpdatePlayerDelegate = com.clubpenguin.util.Delegate.create(this, onUpdatePlayer);
        }
        function onEnterState() {
            _active = true;
            if (!com.clubpenguin.world.rooms2013.starwars.StarWarsParty.isPlayerABattleAvatar(_battle.creatorId)) {
                _controller.loadCreatorAvatar().addOnce(onAvatarLoaded, this);
            }
            addShellListeners();
        }
        function onExitState() {
            removeShellListeners();
            removeJoinBattleButtons();
            removeStartBattleTrigger();
            _active = false;
        }
        function addShellListeners() {
            _shell.addListener(_shell.PLAYER_FRAME, _onPlayerFrameUpdateDelegate, this);
            _shell.addListener(_shell.PLAYER_ACTION, _onPlayerFrameUpdateDelegate, this);
            _shell.addListener(_shell.PLAYER_MOVE, _onPlayerFrameUpdateDelegate, this);
            _shell.addListener(_shell.UPDATE_PLAYER, _onUpdatePlayerDelegate);
        }
        function removeShellListeners() {
            _shell.removeListener(_shell.PLAYER_FRAME, _onPlayerFrameUpdateDelegate);
            _shell.removeListener(_shell.PLAYER_ACTION, _onPlayerFrameUpdateDelegate);
            _shell.removeListener(_shell.PLAYER_MOVE, _onPlayerFrameUpdateDelegate);
            _shell.removeListener(_shell.UPDATE_PLAYER, _onUpdatePlayerDelegate);
        }
        function onAvatarLoaded(player, newAvatar) {
            if (!_active) {
                return(undefined);
            }
            var _local_2 = _engine.getPlayerMovieClip(_battle.creatorId);
            _local_2.art_mc.gotoAndStop("pose");
            checkCreateJoinBattleButtons();
            _controller.tintAvatar(_battle.creatorId);
        }
        function checkCreateJoinBattleButtons() {
            if ((_leftBattleButton == null) && (com.clubpenguin.world.rooms2013.starwars.StarWarsParty.isLightSaberEquipped(_shell.getMyPlayerId()))) {
                createJoinBattleButtons();
                createStartBattleTrigger();
            }
        }
        function checkRemoveJoinBattleButtons() {
            if ((_leftBattleButton != null) && (!com.clubpenguin.world.rooms2013.starwars.StarWarsParty.isLightSaberEquipped(_shell.getMyPlayerId()))) {
                removeJoinBattleButtons();
                removeStartBattleTrigger();
            }
        }
        function createJoinBattleButtons() {
            var _local_2 = _engine.getPlayerMovieClip(_battle.creatorId);
            if (_leftBattleButton == null) {
                _leftBattleButton = _engine.avatarManager.effectManager.playEffectAtLocation(com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.STAR_WARS_BATTLE_ICON, _local_2._x - com.clubpenguin.world.rooms2013.starwars.battle.BattleController.CHALLENGER_X_OFFSET, _local_2._y);
            }
            if (_rightBattleButton == null) {
                _rightBattleButton = _engine.avatarManager.effectManager.playEffectAtLocation(com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.STAR_WARS_BATTLE_ICON, _local_2._x + com.clubpenguin.world.rooms2013.starwars.battle.BattleController.CHALLENGER_X_OFFSET, _local_2._y);
            }
            if (_battle.creatorId != _shell.getMyPlayerId()) {
                _leftBattleButton.onRelease = com.clubpenguin.util.Delegate.create(this, onLeftBattleButtonClicked);
                _rightBattleButton.onRelease = com.clubpenguin.util.Delegate.create(this, onRightBattleButtonClicked);
            }
        }
        function removeJoinBattleButtons() {
            if (_leftBattleButton != null) {
                _leftBattleButton.removeMovieClip();
                _leftBattleButton = null;
            }
            if (_rightBattleButton != null) {
                _rightBattleButton.removeMovieClip();
                _rightBattleButton = null;
            }
        }
        function createStartBattleTrigger() {
            var _local_4 = _engine.getPlayerMovieClip(_battle.creatorId);
            var _local_3 = _engine.getRoomMovieClip();
            var _local_2 = _local_3.triggers_mc;
            _leftStartTrigger = _local_2.createEmptyMovieClip("_leftStartTrigger", _local_2.getNextHighestDepth());
            _rightStartTrigger = _local_2.createEmptyMovieClip("_rightStartTrigger", _local_2.getNextHighestDepth());
            drawTrigger(_leftStartTrigger, _leftBattleButton._x, _leftBattleButton._y);
            drawTrigger(_rightStartTrigger, _rightBattleButton._x, _rightBattleButton._y);
            _leftStartTrigger.triggerFunction = com.clubpenguin.util.Delegate.create(this, onStartTriggered);
            _rightStartTrigger.triggerFunction = com.clubpenguin.util.Delegate.create(this, onStartTriggered);
        }
        function drawTrigger(trigger, x, y) {
            var _local_3 = new flash.geom.Point(x, y);
            trigger._parent.globalToLocal(_local_3);
            x = _local_3.x;
            y = _local_3.y;
            var _local_2 = 10;
            trigger.beginFill(25631, 50);
            trigger.moveTo(0, 0);
            trigger.lineTo(_local_2, 0);
            trigger.lineTo(_local_2, _local_2);
            trigger.lineTo(0, _local_2);
            trigger.lineTo(0, 0);
            trigger.endFill();
            trigger._x = x - (_local_2 / 2);
            trigger._y = y - (_local_2 / 2);
        }
        function removeStartBattleTrigger() {
            if (_leftStartTrigger != null) {
                _leftStartTrigger.removeMovieClip();
                _leftStartTrigger = null;
            }
            if (_rightStartTrigger != null) {
                _rightStartTrigger.removeMovieClip();
                _rightStartTrigger = null;
            }
        }
        function onLeftBattleButtonClicked() {
            var _local_2 = _engine.getPlayerMovieClip(_shell.getMyPlayerId());
            if ((_local_2._x == _leftBattleButton._x) && (_local_2._y == _leftBattleButton._y)) {
                onStartTriggered();
            } else {
                _engine.sendPlayerMove(_leftBattleButton._x, _leftBattleButton._y);
            }
        }
        function onRightBattleButtonClicked() {
            var _local_2 = _engine.getPlayerMovieClip(_shell.getMyPlayerId());
            if ((_local_2._x == _rightBattleButton._x) && (_local_2._y == _rightBattleButton._y)) {
                onStartTriggered();
            } else {
                _engine.sendPlayerMove(_rightBattleButton._x, _rightBattleButton._y);
            }
        }
        function onStartTriggered() {
            _controller.moveChallengerToCreator(_shell.getMyPlayerId());
            _controller.service.sendJoinBattle(_battle.creatorId);
        }
        function onPlayerFrameUpdate(event) {
            var _local_2 = event.player_id;
            if ((_local_2 == _battle.creatorId) || (_local_2 == _battle.challengerId)) {
                _controller.completeBattle();
            }
        }
        function onUpdatePlayer(player_ob) {
            if (_shell.isMyPlayer(player_ob.player_id)) {
                checkCreateJoinBattleButtons();
                checkRemoveJoinBattleButtons();
            }
        }
    }
