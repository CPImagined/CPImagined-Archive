//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2012.halloween.mansion.Hall extends com.clubpenguin.world.rooms.BaseRoom
    {
        var _stage, _destroyDelegate, _playerUpdateDelegate, _SHELL, _triggerWatcher, setupNavigationButtons, _ghostList, _ghostCheckDelegate, _triggerWatcherInterval, _ghostAnimator, _ENGINE;
        function Hall (stageReference) {
            super(stageReference);
            _stage.start_x = 380;
            _stage.start_y = 330;
            _stage.customPenguinSize = 90;
        }
        function init() {
            _destroyDelegate = com.clubpenguin.util.Delegate.create(this, destroy);
            _playerUpdateDelegate = com.clubpenguin.util.Delegate.create(this, checkIfPlayerCanSeeGhosts);
            _SHELL.addListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            _SHELL.addListener(_SHELL.UPDATE_PLAYER, _playerUpdateDelegate);
            _SHELL.addListener(_SHELL.PLAYER_AVATAR_TRANSFORMED, _playerUpdateDelegate);
            _triggerWatcher = new com.clubpenguin.world.rooms2012.common.triggers.TriggerWatcher(_stage, _SHELL);
            _stage.triggers_mc.foyer1_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "party1", 235, 150);
            _stage.triggers_mc.foyer2_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "party1", 522, 150);
            _stage.triggers_mc.ghostLab_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exitToGhostLab);
            _stage.triggers_mc.greenhouse_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "party7", 673, 265);
            _stage.triggers_mc.kitchen_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "party3", 103, 325);
            _stage.triggers_mc.attic_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "party5", 215, 415);
            if (_SHELL.isPlayerMascotById(_SHELL.getMyPlayerId())) {
                _stage.triggers_mc.mascotTrig_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "party9", 713, 322);
            }
            var _local_2 = new com.clubpenguin.world.rooms2012.common.triggers.PlayerWalkTrigger(_stage.triggers_mc.axe_mc);
            _local_2.isLocalPlayerOnly();
            _local_2.playersAdded.addOnce(com.clubpenguin.util.Delegate.create(this, dropAxe));
            _triggerWatcher.addTrigger(_local_2);
            setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.kitchenDoor_btn, 645, 335), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.greenhouseDoor_btn, 108, 335), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.ghost_door.ghostDoor_btn, 380, 126), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.bgPiece_mc.foyerRollover1_btn, 195, 430), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.bgPiece_mc.foyerRollover2_btn, 560, 430), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.bgPiece_mc.bgPiece2_mc.bgPiece3_mc.atticRollover_btn, 472, 141), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.ghost_door.ghostDoor_btn, 380, 128)]);
            _ghostList = [_stage.foreground_mc.ghostGogglesView.gogglesView_mc.ghost1, _stage.foreground_mc.ghostGogglesView.gogglesView_mc.ghost2, _stage.foreground_mc.ghostGogglesView.gogglesView_mc.ghost3];
            _ghostCheckDelegate = com.clubpenguin.util.Delegate.create(this, checkDestructableIsHit);
            _SHELL.addListener(_SHELL.BALL_LAND, _ghostCheckDelegate);
            clearInterval(_triggerWatcherInterval);
            _triggerWatcherInterval = setInterval(_triggerWatcher, "checkAllPlayers", 40);
            var _local_3 = _SHELL.getPlayerObjectById(_SHELL.getMyPlayerId());
            checkIfPlayerCanSeeGhosts(_local_3);
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
                    _local_4.ghost._visible = false;
                    snowballInfo.snowballMC._visible = false;
                    _local_4.effect.gotoAndStop(2);
                    return(undefined);
                }
                snowballInfo.snowballMC._visible = false;
                _local_4.effect.gotoAndStop(3);
            }
        }
        function exitToGhostLab() {
			var _local_2 = _global.getCurrentShell();
            var _local_3 = _local_2.getPlayerObjectById(_local_2.getMyPlayerId());
            if ((_local_3.face == 93043) || (_local_3.avatar_id == 1917)) {
				if (_global.getCurrentParty().BaseParty.CURRENT_PARTY.getTaskComplete(15)) {
                	exit("party9", 402, 380);
				} else {
					exit("partysolo1", 402, 380);
				};
            };
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
            _stage.background_mc.ghost_door.gotoAndStop(1);
            _stage.foreground_mc.ghostGogglesView.gotoAndStop(1);
        }
        function switchRoomToGhostGoggleMode() {
            _stage.background_mc.ghost_door.gotoAndStop(2);
            _stage.foreground_mc.ghostGogglesView.gotoAndStop(2);
            _stage.foreground_mc.ghostGogglesView.gogglesView_mc.goggles_border._visible = true;
        }
        function switchRoomToGhostMode() {
            _stage.background_mc.ghost_door.gotoAndStop(2);
            _stage.foreground_mc.ghostGogglesView.gotoAndStop(2);
            _stage.foreground_mc.ghostGogglesView.gogglesView_mc.goggles_border._visible = false;
        }
        function exit(roomName, x, y) {
            _SHELL.sendJoinRoom(roomName, x, y);
        }
        function dropAxe() {
            _stage.statue_mc.axe_mc.gotoAndPlay(2);
        }
        function destroy() {
            clearInterval(_triggerWatcherInterval);
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            _SHELL.removeListener(_SHELL.UPDATE_PLAYER, _playerUpdateDelegate);
            _SHELL.removeListener(_SHELL.PLAYER_AVATAR_TRANSFORMED, _playerUpdateDelegate);
            _SHELL.removeListener(_SHELL.BALL_LAND, _ghostCheckDelegate);
            _ghostAnimator.destroy();
        }
        static var CLASS_NAME = "Hall";
    }
