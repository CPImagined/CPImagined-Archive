//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2012.halloween.mansion.Greenhouse extends com.clubpenguin.world.rooms.BaseRoom
    {
        var _stage, _destroyDelegate, returnFromGhost, _playerUpdateDelegate, _PARTY, _SHELL, _triggerWatcher, setupNavigationButtons, _ghostList, _ghostCheckDelegate, _triggerWatcherInterval, _ghostAnimator, _ENGINE, _INTERFACE;
        function Greenhouse (stageReference) {
            super(stageReference);
            _stage.start_x = 450;
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
			if (!_PARTY.getTaskComplete(11)) {
				var gameParams = _ENGINE.getGameCompletedParams();
				if (gameParams.key11Found) {
					_PARTY.setTaskComplete(11);
					var pickUpSound = new Sound(_stage);
					pickUpSound.attachSound("sfx_key_pick_up");
					pickUpSound.start();
					_INTERFACE.showContent("w.p2024.halloween.keys.found");
				} else if (gameParams.key11NotFound && !_PARTY.getTaskComplete(11)) {
					returnFromGhost = true;
					_INTERFACE.showContent("w.p2024.halloween.keys.greenhouse.notfound");
				};
			};
            _triggerWatcher = new com.clubpenguin.world.rooms2012.common.triggers.TriggerWatcher(_stage, _SHELL);
            _stage.triggers_mc.hall_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "party4", 180, 340);
            _stage.triggers_mc.cellar_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "party6", 570, 150);
            _stage.triggers_mc.graveyard_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "party6", 280, 150);
			_stage.greenhouse_key_mc.cryptClosed.onRelease = com.clubpenguin.util.Delegate.create(this, openGrave);
			_stage.greenhouse_key_mc.ghost_btn.onRelease = com.clubpenguin.util.Delegate.create(this, talkToGhost);
            setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.hall_btn, 650, 205), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.foreground_mc.cellar_btn, 717, 435), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.graveyard_btn, 90, 430)]);
            _ghostList = [_stage.foreground_mc.ghostGogglesView.gogglesView_mc.ghost1, _stage.foreground_mc.ghostGogglesView.gogglesView_mc.ghost2, _stage.foreground_mc.ghostGogglesView.gogglesView_mc.ghost3];
            _ghostCheckDelegate = com.clubpenguin.util.Delegate.create(this, checkDestructableIsHit);
            _SHELL.addListener(_SHELL.BALL_LAND, _ghostCheckDelegate);
            checkIfKeyFound();
            var _local_2 = _SHELL.getPlayerObjectById(_SHELL.getMyPlayerId());
            checkIfPlayerCanSeeGhosts(_local_2);
            clearInterval(_triggerWatcherInterval);
            _triggerWatcherInterval = setInterval(_triggerWatcher, "checkAllPlayers", 40);
            _ghostAnimator = new com.clubpenguin.world.rooms2012.halloween.HauntedGhostAnimator([_stage.ghost0, _stage.ghost1], com.clubpenguin.world.rooms2012.halloween.HauntedGhostAnimator.MODE_PLAY_ONE_DELAYED);
        }
		function talkToGhost() {
			if (!_PARTY.getTaskComplete(11)) {
				if (returnFromGhost) {
					_INTERFACE.showContent("w.p2024.halloween.keys.greenhouse.notfound");
				} else {
					_INTERFACE.showContent("w.p2024.halloween.keys.greenhouse.start");
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
        function checkIfKeyFound() {
			if (returnFromGhost) {
				openGrave();
			}
            if (_PARTY.getTaskComplete(11)) {
                _stage.greenhouse_key_mc.gotoAndStop(3);
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
        function openGrave() {
            _stage.greenhouse_key_mc.gotoAndStop(2);
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
        static var CLASS_NAME = "Greenhouse";
    }
