//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2012.halloween.mansion.Library extends com.clubpenguin.world.rooms.BaseRoom
    {
        var _stage, _destroyDelegate, returnFromGhost, _playerUpdateDelegate, _PARTY, _SHELL, _triggerWatcher, setupNavigationButtons, _ghostList, _ghostCheckDelegate, _triggerWatcherInterval, _ghostAnimator, _ENGINE, _INTERFACE;
        function Library (stageReference) {
            super(stageReference);
            _stage.start_x = 380;
            _stage.start_y = 330;
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
			if (!_PARTY.getTaskComplete(13)) {
                var gameParams = _ENGINE.getGameCompletedParams();
                if (gameParams.key13Found) {
					_PARTY.setTaskComplete(13);
                    var pickUpSound = new Sound(_stage);
					pickUpSound.attachSound("sfx_key_pick_up");
					pickUpSound.start();
					_INTERFACE.showContent("w.p2024.halloween.keys.found");
                } else if (gameParams.key13NotFound) {
					returnFromGhost = true;
					_INTERFACE.showContent("w.p2024.halloween.keys.library.notfound");
                };
            };
            _triggerWatcher = new com.clubpenguin.world.rooms2012.common.triggers.TriggerWatcher(_stage, _SHELL);
            _stage.triggers_mc.foyer_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "party1", 574, 357);
            _stage.triggers_mc.ballDown_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "party3", 180, 368);
            _stage.triggers_mc.ballUpper_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "party3", 660, 317);
            _stage.triggers_mc.tunnelUpper_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "party8", 576, 182);
            _stage.triggers_mc.tunnelDown_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "party8", 558, 382);
            checkIfKeyFound();
            var _local_2 = _SHELL.getPlayerObjectById(_SHELL.getMyPlayerId());
            checkIfPlayerCanSeeGhosts(_local_2);
            setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.bookGoto_btn, 190, 350), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.foyer_btn, 115, 264), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.ballUpper_btn, 578, 97), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.ballDown_btn, 428, 177)]);
            _stage.bookGoto_btn.useHandCursor = false;
			_ghostList = [_stage.foreground_mc.ghostGogglesView.gogglesView_mc.ghost1, _stage.foreground_mc.ghostGogglesView.gogglesView_mc.ghost2, _stage.foreground_mc.ghostGogglesView.gogglesView_mc.ghost3, _stage.foreground_mc.ghostGogglesView.gogglesView_mc.ghost4];
            _ghostCheckDelegate = com.clubpenguin.util.Delegate.create(this, checkDestructableIsHit);
            _SHELL.addListener(_SHELL.BALL_LAND, _ghostCheckDelegate);
            clearInterval(_triggerWatcherInterval);
            _triggerWatcherInterval = setInterval(_triggerWatcher, "checkAllPlayers", 40);
            _stage.bust_mc.bust_btn.onRelease = com.clubpenguin.util.Delegate.create(this, openBust);
            _stage.background_mc.shelving_mc.switch_mc.switch_btn.onRelease = com.clubpenguin.util.Delegate.create(this, openBookcase);
            _ghostAnimator = new com.clubpenguin.world.rooms2012.halloween.HauntedGhostAnimator([_stage.ghost0, _stage.foreground_mc.ghost1, _stage.ghost2, _stage.ghost3], com.clubpenguin.world.rooms2012.halloween.HauntedGhostAnimator.MODE_PLAY_ONE_DELAYED);
        }
		function talkToGhost() {
			if (!_PARTY.getTaskComplete(13)) {
				if (returnFromGhost) {
					_INTERFACE.showContent("w.p2024.halloween.keys.library.notfound");
				} else {
					_INTERFACE.showContent("w.p2024.halloween.keys.library.start");
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
        function openBust() {
            _stage.bust_mc.gotoAndStop(2);
            _stage.bust_mc.bust_btn.onRelease = com.clubpenguin.util.Delegate.create(this, openPortrait);
        }
        function openPortrait() {
            _stage.background_mc.painting_mc.gotoAndStop(2);
			_stage.bust_mc.gotoAndStop(3);
            _stage.block_mc.gotoAndStop(2);
        }
        function openBookcase() {
			_stage.background_mc.shelving_mc.switch_mc.switch_btn.enabled = false;
            _stage.background_mc.shelving_mc.bookcase_mc.gotoAndPlay(2);
            _stage.block_mc.gotoAndStop(2);
            _stage.background_mc.shelving_mc.switch_mc.switch_btn.onRelease = null;
        }
        function checkIfKeyFound() {
			if (returnFromGhost) {
				openBook();
			}
            if (_PARTY.getTaskComplete(13)) {
                _stage.background_mc.shelving_mc.book_mc.gotoAndStop(2);
				_stage.background_mc.shelving_mc.window_mc.gotoAndStop(2);
            } else {
                _stage.background_mc.shelving_mc.book_mc.book_btn.onRelease = com.clubpenguin.util.Delegate.create(this, openBook);
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
        function openBook() {
            _stage.background_mc.shelving_mc.book_mc.gotoAndStop(2);
			_stage.background_mc.shelving_mc.window_mc.gotoAndStop(2);
			_stage.background_mc.shelving_mc.ghost_mc.gotoAndStop(2);
            _stage.background_mc.shelving_mc.ghost_mc.ghost_btn.onRelease = com.clubpenguin.util.Delegate.create(this, talkToGhost);
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
        static var CLASS_NAME = "Library";
    }
