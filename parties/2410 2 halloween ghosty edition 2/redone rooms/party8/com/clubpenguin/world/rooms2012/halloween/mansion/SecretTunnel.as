//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2012.halloween.mansion.SecretTunnel extends com.clubpenguin.world.rooms.BaseRoom
    {
        var _stage, _destroyDelegate, _SHELL, _playerUpdateDelegate, _triggerWatcher, setupNavigationButtons, _ghostList, _ghostCheckDelegate, _triggerWatcherInterval, _ghostAnimator, _ENGINE;
        function SecretTunnel (stageReference) {
            super(stageReference);
            _stage.start_x = 380;
            _stage.start_y = 330;
            _stage.customPenguinSize = 130;
        }
        function init() {
            _destroyDelegate = com.clubpenguin.util.Delegate.create(this, destroy);
            _SHELL.addListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            _playerUpdateDelegate = com.clubpenguin.util.Delegate.create(this, checkIfPlayerCanSeeGhosts);
            _SHELL.addListener(_SHELL.UPDATE_PLAYER, _playerUpdateDelegate);
            _SHELL.addListener(_SHELL.PLAYER_AVATAR_TRANSFORMED, _playerUpdateDelegate);
            _triggerWatcher = new com.clubpenguin.world.rooms2012.common.triggers.TriggerWatcher(_stage, _SHELL);
            _stage.triggers_mc.libraryTop_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "party2", 632, 151);
            _stage.triggers_mc.libraryBottom_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "party2", 185, 246);
            _stage.triggers_mc.cellar_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "party6", 123, 157);
            _stage.triggers_mc.attic_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "party5", 586, 230);
            setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.doorAttic_mc.attic_btn, 100, 165), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.doorlibrary_mc.library_btn, 670, 170), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.graveCave1_mc.graveCave_btn, 75, 340), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.libraryCave1_mc.libraryCave_btn, 670, 340)]);
            _ghostList = [_stage.foreground_mc.ghostGogglesView.gogglesView_mc.ghost1, _stage.foreground_mc.ghostGogglesView.gogglesView_mc.ghost2, _stage.foreground_mc.ghostGogglesView.gogglesView_mc.ghost3, _stage.foreground_mc.ghostGogglesView.gogglesView_mc.ghost4];
            _ghostCheckDelegate = com.clubpenguin.util.Delegate.create(this, checkDestructableIsHit);
            _SHELL.addListener(_SHELL.BALL_LAND, _ghostCheckDelegate);
            clearInterval(_triggerWatcherInterval);
            _triggerWatcherInterval = setInterval(_triggerWatcher, "checkAllPlayers", 40);
            var _local_2 = _SHELL.getPlayerObjectById(_SHELL.getMyPlayerId());
            checkIfPlayerCanSeeGhosts(_local_2);
            _ghostAnimator = new com.clubpenguin.world.rooms2012.halloween.HauntedGhostAnimator([_stage.ghost0, _stage.ghost1], com.clubpenguin.world.rooms2012.halloween.HauntedGhostAnimator.MODE_PLAY_ONE_DELAYED);
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
            _SHELL.removeListener(_SHELL.UPDATE_PLAYER, _playerUpdateDelegate);
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            _SHELL.removeListener(_SHELL.PLAYER_AVATAR_TRANSFORMED, _playerUpdateDelegate);
            _SHELL.removeListener(_SHELL.BALL_LAND, _ghostCheckDelegate);
            _ghostAnimator.destroy();
        }
        static var CLASS_NAME = "SecretTunnel";
    }
