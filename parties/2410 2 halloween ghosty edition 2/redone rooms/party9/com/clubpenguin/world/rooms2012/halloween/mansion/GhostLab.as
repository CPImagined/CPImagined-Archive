//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2012.halloween.mansion.GhostLab extends com.clubpenguin.world.rooms.BaseRoom
    {
        var _stage, doorOpen, doorTimerActive, cursorOverDoor, ghostMachineActivated, _destroyDelegate, _playerUpdateDelegate, _SHELL, _triggerWatcher, localize, setupNavigationButtons, _triggerWatcherInterval, _ghostAnimator, _ghostList, _ghostCheckDelegate, _ENGINE, _INTERFACE;
        function GhostLab (stageReference) {
            super(stageReference);
            _stage.start_x = 400;
            _stage.start_y = 370;
            _stage.customPenguinSize = 90;
            doorOpen = false;
            doorTimerActive = false;
            cursorOverDoor = false;
            ghostMachineActivated = false;
        }
        function init() {
            _destroyDelegate = com.clubpenguin.util.Delegate.create(this, destroy);
            _playerUpdateDelegate = com.clubpenguin.util.Delegate.create(this, checkIfPlayerCanSeeGhosts);
            _SHELL.addListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            _SHELL.addListener(_SHELL.UPDATE_PLAYER, _playerUpdateDelegate);
            _SHELL.addListener(_SHELL.PLAYER_AVATAR_TRANSFORMED, _playerUpdateDelegate);
            _triggerWatcher = new com.clubpenguin.world.rooms2012.common.triggers.TriggerWatcher(_stage, _SHELL);
            _stage.triggers_mc.leaveRoom_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "party4", 380, 145);
            _stage.triggers_mc.ghostMachine_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, turnPlayerIntoGhost);
            if (_SHELL.isPlayerMascotById(_SHELL.getMyPlayerId())) {
                _stage.triggers_mc.gExit_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "party4", 380, 145);
            };
            enableMachineDoor(!com.clubpenguin.world.rooms2012.halloween.Halloween.isMyPlayerGhost());
            _stage.machineDoorButton.onRelease = com.clubpenguin.util.Delegate.create(this, walkToGhostMachine);
            setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.foreground_mc.entranceButton, 406, 421)]);
            clearInterval(_triggerWatcherInterval);
            _triggerWatcherInterval = setInterval(_triggerWatcher, "checkAllPlayers", 40);
            var _local_2 = _SHELL.getPlayerObjectById(_SHELL.getMyPlayerId());
            checkIfPlayerCanSeeGhosts(_local_2);
            _ghostAnimator = new com.clubpenguin.world.rooms2012.halloween.HauntedGhostAnimator([_stage.ghost0, _stage.foreground_mc.ghost1], com.clubpenguin.world.rooms2012.halloween.HauntedGhostAnimator.MODE_PLAY_ONE_DELAYED);
            _ghostList = [_stage.foreground_mc.ghostGogglesView.gogglesView_mc.ghost1, _stage.foreground_mc.ghostGogglesView.gogglesView_mc.ghost2, _stage.foreground_mc.ghostGogglesView.gogglesView_mc.ghost3];
            _ghostCheckDelegate = com.clubpenguin.util.Delegate.create(this, checkDestructableIsHit);
            _SHELL.addListener(_SHELL.BALL_LAND, _ghostCheckDelegate);
            if (!_SHELL.isMyPlayerMember()) {
                _stage.block_mc.gotoAndStop(2);
            }
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
                    _local_4.ghost._visible = false;
                    snowballInfo.snowballMC._visible = false;
                    _local_4.effect.gotoAndStop(2);
                    return(undefined);
                }
                if (com.clubpenguin.world.rooms2012.halloween.Halloween.isMyPlayerGhost()) {
                    _local_4.ghost._visible = false;
                    snowballInfo.snowballMC._visible = false;
                    _local_4.effect.gotoAndStop(2);
                    return(undefined);
                }
                snowballInfo.snowballMC._visible = false;
                _local_4.effect.gotoAndStop(3);
            }
        }
        function enableMachineDoor(isEnabled) {
            if (isEnabled) {
                _stage.machineDoorButton.onRollOver = com.clubpenguin.util.Delegate.create(this, openGhostMachineDoor);
                _stage.machineDoorButton.onRollOut = com.clubpenguin.util.Delegate.create(this, closeGhostMachineDoor);
                _stage.machineDoorButton.onReleaseOutside = com.clubpenguin.util.Delegate.create(this, closeGhostMachineDoor);
            } else {
                _stage.machineDoorButton.onRollOver = null;
                _stage.machineDoorButton.onRollOut = null;
                _stage.machineDoorButton.onReleaseOutside = null;
            }
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
        function transformPlayerAvatar() {
            _ENGINE.avatarManager.transformationManager.sendTransformPlayer(1917);
			_ENGINE.sendPlayerTeleport(395, 217);
        }
        function turnPlayerIntoGhost() {
            if (com.clubpenguin.world.rooms2012.halloween.Halloween.isMyPlayerGhost()) {
                return(undefined);
            }
            _stage.ghostMachineDirector.gotoAndPlay("start");
            enableMachineDoor(false);
            doorTimerActive = false;
            closeGhostMachineDoor();
        }
        function show(contentKey) {
            _INTERFACE.showContent(contentKey);
        }
        function exit(roomName, x, y) {
            _SHELL.sendJoinRoom(roomName, x, y);
        }
        function openGhostMachineDoor() {
            if (doorOpen == false) {
                doorOpen = true;
                _stage.ghostMachine.door.gotoAndPlay("open");
            }
        }
        function closeGhostMachineDoor() {
            if ((doorOpen == true) && (doorTimerActive == false)) {
                doorOpen = false;
                _stage.ghostMachine.door.gotoAndPlay("close");
            }
        }
        function walkToGhostMachine() {
            if (ghostMachineActivated == false) {
                doorTimerActive = true;
                _ENGINE.sendPlayerMove(395, 217);
            }
        }
        function destroy() {
            clearInterval(_triggerWatcherInterval);
            _SHELL.removeListener(_SHELL.UPDATE_PLAYER, _playerUpdateDelegate);
            _SHELL.removeListener(_SHELL.PLAYER_AVATAR_TRANSFORMED, _playerUpdateDelegate);
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            _SHELL.removeListener(_SHELL.BALL_LAND, _ghostCheckDelegate);
            _ghostAnimator.destroy();
        }
        static var CLASS_NAME = "GhostLab";
    }
