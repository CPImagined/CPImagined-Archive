//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2012.halloween.mansion.Attic extends com.clubpenguin.world.rooms.BaseRoom
    {
        var _stage, _destroyDelegate, returnFromGhost, _playerUpdateDelegate, _PARTY, _SHELL, _triggerWatcher, setupNavigationButtons, _ghostList, _ghostCheckDelegate, _triggerWatcherInterval, _secondCheckIntervalID, _currentTime, _currentMinute, _ghostAnimator, _ENGINE, _currentSecond, _INTERFACE;
        function Attic (stageReference) {
            super(stageReference);
            _stage.start_x = 345;
            _stage.start_y = 230;
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
			if (!_PARTY.getTaskComplete(14)) {
                var gameParams = _ENGINE.getGameCompletedParams();
                if (gameParams.key14Found) {
					_PARTY.setTaskComplete(14);
                    var pickUpSound = new Sound(_stage);
					pickUpSound.attachSound("sfx_key_pick_up");
					pickUpSound.start();
					_INTERFACE.showContent("w.p2024.halloween.keys.found");
                } else if (gameParams.key14NotFound) {
					returnFromGhost = true;
					_INTERFACE.showContent("w.p2024.halloween.keys.attic.notfound");
                };
            };
            _triggerWatcher = new com.clubpenguin.world.rooms2012.common.triggers.TriggerWatcher(_stage, _SHELL);
            _stage.triggers_mc.hallway_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "party4", 437, 151);
            _stage.triggers_mc.ballroom_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "party3", 561, 136);
            _stage.triggers_mc.wardrobeTrigger_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "party8", 178, 179);
            _stage.triggers_mc.telescopeTrigger_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, showTelescope);
            checkIfKeyFound();
            var _local_2 = _SHELL.getPlayerObjectById(_SHELL.getMyPlayerId());
            checkIfPlayerCanSeeGhosts(_local_2);
            setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.table_mc.crystal_btn, 465, 347), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.cageFront_mc.cage_btn, 465, 116), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.hallway_mc.hallway_btn, 213, 340), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.ballroom_mc.ballroom_btn, 678, 400), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.wardrobe_mc.wardrobeOpen_btn, 600, 195)]);
            _stage.painting_mc.ghost_btn.onRelease = com.clubpenguin.util.Delegate.create(this, talkToGhost);
            _stage.telescope_mc.telescope_btn.onRelease = com.clubpenguin.util.Delegate.create(this, showTelescope);
            _stage.wardrobe_mc.wardrobeClosed_btn.onRelease = com.clubpenguin.util.Delegate.create(this, openWardrobe);
            _stage.painting_mc.paintingClosed_btn.onRelease = com.clubpenguin.util.Delegate.create(this, openPainting);
            _ghostList = [_stage.foreground_mc.ghostGogglesView.gogglesView_mc.ghost1, _stage.foreground_mc.ghostGogglesView.gogglesView_mc.ghost2, _stage.foreground_mc.ghostGogglesView.gogglesView_mc.ghost3];
            _ghostCheckDelegate = com.clubpenguin.util.Delegate.create(this, checkDestructableIsHit);
            _SHELL.addListener(_SHELL.BALL_LAND, _ghostCheckDelegate);
            clearInterval(_triggerWatcherInterval);
            _triggerWatcherInterval = setInterval(_triggerWatcher, "checkAllPlayers", 40);
            _secondCheckIntervalID = setInterval(com.clubpenguin.util.Delegate.create(this, updateTime), ONE_SECOND);
            _currentTime = fetchTime();
            _currentMinute = _currentTime.getMinutes();
            updateTime();
            _ghostAnimator = new com.clubpenguin.world.rooms2012.halloween.HauntedGhostAnimator([_stage.ghost0, _stage.ghost1, _stage.ghost2], com.clubpenguin.world.rooms2012.halloween.HauntedGhostAnimator.MODE_PLAY_ONE_DELAYED);
        }
		function talkToGhost() {
			if (!_PARTY.getTaskComplete(14)) {
				if (returnFromGhost) {
					_INTERFACE.showContent("w.p2024.halloween.keys.attic.notfound");
				} else {
					_INTERFACE.showContent("w.p2024.halloween.keys.attic.start");
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
        function fetchTime() {
            if (_SHELL == undefined) {
                return(new Date());
            } else {
                return(_SHELL.getPenguinStandardTime());
            }
        }
        function updateTime() {
            _currentTime.setTime(_currentTime.getTime() + ONE_SECOND);
            _currentSecond = _currentTime.getSeconds();
            if ((_currentSecond == 5) || (_currentSecond == 35)) {
                _stage.lightning.gotoAndPlay(2);
            }
            if (_currentMinute != _currentTime.getMinutes()) {
                _currentMinute = _currentTime.getMinutes();
                _currentTime = fetchTime();
            }
        }
        function checkIfKeyFound() {
			if (returnFromGhost) {
				openPainting();
			};
            if (_PARTY.getTaskComplete(14)) {
                _stage.painting_mc.ghost_btn._visible = false;
				_stage.painting_mc.paintingClosed_btn.enabled = false;
            }
        }
        function showTelescope() {
            _INTERFACE.showContent(com.clubpenguin.world.rooms2012.halloween.Halloween.CONTENT_TELESCOPE_CLOSE_UP);
        }
        function openWardrobe() {
            _stage.wardrobe_mc.gotoAndStop(2);
            _stage.triggers_mc.gotoAndStop(2);
        }
        function openPainting() {
            _stage.painting_mc.gotoAndStop(2);
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
        static var CLASS_NAME = "Attic";
        var ONE_SECOND = 1000;
    }
