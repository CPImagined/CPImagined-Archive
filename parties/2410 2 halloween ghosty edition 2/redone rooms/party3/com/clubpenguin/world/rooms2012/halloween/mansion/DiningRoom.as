//Created by Action Script Viewer - https://www.buraks.com/asv
import flash.external.*;
    class com.clubpenguin.world.rooms2012.halloween.mansion.DiningRoom extends com.clubpenguin.world.rooms.BaseRoom
    {
        var _stage, _destroyDelegate, returnFromGhost, _playerUpdateDelegate, _PARTY, _SHELL, _triggerWatcher, _ghostBandTrigger, setupNavigationButtons, _ghostList, _ghostCheckDelegate, _triggerWatcherInterval, _ghostAnimator, _ENGINE, _INTERFACE;
        function DiningRoom (stageReference) {
            super(stageReference);
            _stage.start_x = 483;
            _stage.start_y = 280;
            _stage.customPenguinSize = 90;
			if (!_SHELL) {
				init();
			};
        }
        function init() {
			returnFromGhost = false;
			_PARTY = _global.getCurrentParty().BaseParty.CURRENT_PARTY;
            _destroyDelegate = com.clubpenguin.util.Delegate.create(this, destroy);
            _playerUpdateDelegate = com.clubpenguin.util.Delegate.create(this, checkIfPlayerCanSeeGhosts);
            _SHELL.addListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            _SHELL.addListener(_SHELL.UPDATE_PLAYER, _playerUpdateDelegate);
            _SHELL.addListener(_SHELL.PLAYER_AVATAR_TRANSFORMED, _playerUpdateDelegate);
			if (!_PARTY.getTaskComplete(12)) {
                var gameParams = _ENGINE.getGameCompletedParams();
                if (gameParams.key12Found) {
					_PARTY.setTaskComplete(12);
                    var pickUpSound = new Sound(_stage);
					pickUpSound.attachSound("sfx_key_pick_up");
					pickUpSound.start();
					_INTERFACE.showContent("w.p2024.halloween.keys.found");
                } else if (gameParams.key12NotFound) {
					returnFromGhost = true;
					_INTERFACE.showContent("w.p2024.halloween.keys.dining.notfound");
                };
            };
            checkIfKeyFound();
            var _local_2 = _SHELL.getPlayerObjectById(_SHELL.getMyPlayerId());
            checkIfPlayerCanSeeGhosts(_local_2);
            _triggerWatcher = new com.clubpenguin.world.rooms2012.common.triggers.TriggerWatcher(_stage, _SHELL);
            _ghostBandTrigger = new com.clubpenguin.world.rooms2012.common.triggers.PlayerTrigger(_stage.triggers_mc.ghost_band_mc);
            _ghostBandTrigger.playersAdded.add(com.clubpenguin.util.Delegate.create(this, playHauntedInstruments));
            _triggerWatcher.addTrigger(_ghostBandTrigger);
            _stage.triggers_mc.hall_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "party4", 588, 341);
            _stage.triggers_mc.library_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "party2", 593, 135);
            _stage.triggers_mc.library2_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "party2", 430, 199);
            _stage.triggers_mc.attic_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "party5", 650, 366);
            setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.kitchenbackwall_mc.libraryDown_btn, 134, 429), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.ballroomBackwall_mc.libraryUpper_btn, 658, 377), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.attic_btn, 606, 132), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.halldoor_btn, 117, 262)]);
            //_stage.table_mc.lid_mc.ghost_mc.ghost_btn.onRelease = com.clubpenguin.util.Delegate.create(this, talkToGhost); literally why wont this work
            _ghostList = [_stage.foreground_mc.ghostGogglesView.gogglesView_mc.ghost1, _stage.foreground_mc.ghostGogglesView.gogglesView_mc.ghost2, _stage.foreground_mc.ghostGogglesView.gogglesView_mc.ghost3];
            _ghostCheckDelegate = com.clubpenguin.util.Delegate.create(this, checkDestructableIsHit);
            _SHELL.addListener(_SHELL.BALL_LAND, _ghostCheckDelegate);
            clearInterval(_triggerWatcherInterval);
            _triggerWatcherInterval = setInterval(_triggerWatcher, "checkAllPlayers", 40);
            _ghostAnimator = new com.clubpenguin.world.rooms2012.halloween.HauntedGhostAnimator([_stage.ghost0, _stage.foreground_mc.foregroundObjects_mc.ghost1], com.clubpenguin.world.rooms2012.halloween.HauntedGhostAnimator.MODE_PLAY_ONE_DELAYED);
        }
		function talkToGhost() {
			if (!_PARTY.getTaskComplete(12)) {
				if (returnFromGhost) {
					_INTERFACE.showContent("w.p2024.halloween.keys.dining.notfound");
				} else {
					_INTERFACE.showContent("w.p2024.halloween.keys.dining.start");
				};
			};
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
        function playHauntedInstruments() {
            if (_stage.recordPlayer.instruments_mc._currentframe == 1) {
                _stage.recordPlayer.instruments_mc.gotoAndPlay(2);
            }
        }
        function checkIfKeyFound() {
			if (returnFromGhost) {
				_stage.table_mc.lid_mc.gotoAndStop(21);
			}
            if (_PARTY.getTaskComplete(12)) {
                _stage.table_mc.lid_mc.ghost_mc._visible = false;
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
        static var CLASS_NAME = "DiningRoom";
    }
