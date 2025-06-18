//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2012.halloween.mansion.Cellar extends com.clubpenguin.world.rooms.BaseRoom
    {
        var _stage, _destroyDelegate, _playerUpdateDelegate, _SHELL, setupNavigationButtons, _ghostList, _triggerWatcher, _cageTrigger, _triggerWatcherInterval, _destructableCheckDelegate, _ghostAnimator, _ENGINE, _cageResetInterval;
        function Cellar (stageReference) {
            super(stageReference);
            _stage.start_x = 420;
            _stage.start_y = 290;
            _stage.customPenguinSize = 90;
			if (!_SHELL) {
				init();
			};
        }
        function init() {
            _destroyDelegate = com.clubpenguin.util.Delegate.create(this, destroy);
            _playerUpdateDelegate = com.clubpenguin.util.Delegate.create(this, checkIfPlayerCanSeeGhosts);
            _SHELL.addListener(_SHELL.UPDATE_PLAYER, _playerUpdateDelegate);
            _SHELL.addListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            _SHELL.addListener(_SHELL.PLAYER_AVATAR_TRANSFORMED, _playerUpdateDelegate);
            _stage.triggers_mc.foyer_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "party1", 135, 377);
            _stage.triggers_mc.greenhouse_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "party7", 702, 424);
            _stage.triggers_mc.graveyard_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "party7", 148, 348);
            _stage.triggers_mc.secrettunnel_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "party8", 148, 348);
            _stage.crypt_mc.cryptclosed.onRelease = com.clubpenguin.util.Delegate.create(this, openSecretTunnel);
            setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.rosegrave_mc.rosegrave_btn, 203, 360), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.emotegrave_mc.emotegrave_btn, 113, 321), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.anchorgrave_mc.anchorgrave_btn, 164, 230), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.graveyard_btn, 293, 129), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.foyer_btn, 668, 319), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.greenhouse_btn, 568, 133), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.crypt_mc.cryptopen_btn, 127, 145)]);
            _ghostList = [_stage.foreground_mc.ghostGogglesView.gogglesView_mc.ghost1, _stage.foreground_mc.ghostGogglesView.gogglesView_mc.ghost2, _stage.foreground_mc.ghostGogglesView.gogglesView_mc.ghost3];
            _triggerWatcher = new com.clubpenguin.world.rooms2012.common.triggers.TriggerWatcher(_stage, _SHELL);
            _cageTrigger = new com.clubpenguin.world.rooms2012.common.triggers.PlayerTrigger(_stage.triggers_mc.cage_mc);
            _cageTrigger.playersAdded.add(com.clubpenguin.util.Delegate.create(this, activateCage));
            _triggerWatcher.addTrigger(_cageTrigger);
            clearInterval(_triggerWatcherInterval);
            _triggerWatcherInterval = setInterval(_triggerWatcher, "checkAllPlayers", 40);
            _destructableCheckDelegate = com.clubpenguin.util.Delegate.create(this, checkDestructableIsHit);
            _SHELL.addListener(_SHELL.BALL_LAND, _destructableCheckDelegate);
            var _local_2 = _SHELL.getPlayerObjectById(_SHELL.getMyPlayerId());
            checkIfPlayerCanSeeGhosts(_local_2);
            _ghostAnimator = new com.clubpenguin.world.rooms2012.halloween.HauntedGhostAnimator([_stage.ghost0, _stage.foreground_mc.ghost1], com.clubpenguin.world.rooms2012.halloween.HauntedGhostAnimator.MODE_PLAY_ONE_DELAYED);
        }
        function openSecretTunnel() {
            _stage.crypt_mc.gotoAndStop(2);
            _stage.triggers_mc.gotoAndStop(2);
        }
        function checkDestructableIsHit(snowballInfo) {
            var _local_5 = _SHELL.getPlayerObjectById(snowballInfo.player_id);
            if (!com.clubpenguin.world.rooms2012.halloween.Halloween.isGhostHunter(_local_5)) {
                return(undefined);
            }
            var _local_4;
            var _local_2 = 0;
            while (_local_2 < _ghostList.length) {
                if (_ghostList[_local_2].ghost._visible && (_ghostList[_local_2].hitTest(snowballInfo.x, snowballInfo.y, true))) {
                    _local_4 = _ghostList[_local_2];
                    break;
                }
                _local_2++;
            }
            if (_local_4) {
                if (snowballInfo.player_id == _SHELL.getMyPlayerId()) {
                    snowballInfo.snowballMC._visible = false;
                    _local_4.effect.gotoAndStop(2);
                    _SHELL.sendGhostCapturedRequest();
                    return(undefined);
                }
                if (com.clubpenguin.world.rooms2012.halloween.Halloween.isMyPlayerGhost()) {
                    snowballInfo.snowballMC._visible = false;
                    _local_4.effect.gotoAndStop(2);
                    return(undefined);
                }
                snowballInfo.snowballMC._visible = false;
                _local_4.effect.gotoAndStop(3);
            }
        }
        function activateCage() {
            if (_stage.cagefront_mc._currentframe == 1) {
                _stage.block_mc.gotoAndStop(2);
                _stage.cagefront_mc.gotoAndStop(2);
                _stage.cageback_mc.gotoAndStop(2);
                _stage.button_mc.gotoAndPlay(2);
                clearInterval(_cageResetInterval);
                _cageResetInterval = setInterval(this, "resetCage", 3500);
            }
        }
        function resetCage() {
            _stage.block_mc.gotoAndStop(1);
            clearInterval(_cageResetInterval);
        }
        function checkIfPlayerCanSeeGhosts(playerObject) {
            if (playerObject.player_id != _SHELL.getMyPlayerId()) {
                return(undefined);
            }
            var _local_2 = _global.getCurrentShell();
            var _local_3 = _local_2.getPlayerObjectById(_local_2.getMyPlayerId());
            if ((_local_3.face == 93043) || (_local_3.avatar_id == 1917) || _SHELL.isPlayerMascotById(_SHELL.getMyPlayerId())) {
                if (_local_3.avatar_id == 1917) {
                    switchRoomToGhostMode();
                } else {
                    switchRoomToGhostGoggleMode();
                }
                //_stage.foreground_mc.ghostGogglesView.gogglesView_mc.arrows_mc._visible = !_SHELL.isItemInMyInventory(com.clubpenguin.world.rooms2012.halloween.Halloween.GARIWALD_BACKGROUND);
            } else {
                switchRoomToNormalMode();
            }
        }
        function switchRoomToNormalMode() {
            _stage.foreground_mc.ghostGogglesView.gotoAndStop(1);
        }
        function switchRoomToGhostGoggleMode() {
            _stage.foreground_mc.ghostGogglesView.gotoAndStop(2);
            _stage.foreground_mc.ghostGogglesView.gogglesView_mc.goggles_border._visible = true;
        }
        function switchRoomToGhostMode() {
            _stage.foreground_mc.ghostGogglesView.gotoAndStop(2);
            _stage.foreground_mc.ghostGogglesView.gogglesView_mc.goggles_border._visible = false;
        }
        function exit(roomName, x, y) {
            _SHELL.sendJoinRoom(roomName, x, y);
        }
        function destroy() {
            clearInterval(_triggerWatcherInterval);
            clearInterval(_cageResetInterval);
            _SHELL.removeListener(_SHELL.UPDATE_PLAYER, _playerUpdateDelegate);
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            _SHELL.removeListener(_SHELL.PLAYER_AVATAR_TRANSFORMED, _playerUpdateDelegate);
            _SHELL.removeListener(_SHELL.BALL_LAND, _destructableCheckDelegate);
            _ghostAnimator.destroy();
        }
        static var CLASS_NAME = "Cellar";
    }
