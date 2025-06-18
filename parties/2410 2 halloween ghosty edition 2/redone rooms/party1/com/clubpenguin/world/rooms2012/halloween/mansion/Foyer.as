//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2012.halloween.mansion.Foyer extends com.clubpenguin.world.rooms.BaseRoom
    {
        var _stage, _destroyDelegate, _playerUpdateDelegate, _PARTY, _SHELL, _triggerWatcher, _ghostList, _ghostCheckDelegate, _triggerWatcherInterval, _ghostAnimator, _ENGINE, setupNavigationButtons, _INTERFACE;
        function Foyer (stageReference) {
            super(stageReference);
            _stage.start_x = 380;
            _stage.start_y = 330;
            _stage.customPenguinSize = 90;
			if (!_SHELL) {
				init();
			};
        }
        function init() {
			_PARTY = _global.getCurrentParty().BaseParty.CURRENT_PARTY;
            _destroyDelegate = com.clubpenguin.util.Delegate.create(this, destroy);
            _playerUpdateDelegate = com.clubpenguin.util.Delegate.create(this, checkIfPlayerCanSeeGhosts);
            _SHELL.addListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            _SHELL.addListener(_SHELL.UPDATE_PLAYER, _playerUpdateDelegate);
            _SHELL.addListener(_SHELL.PLAYER_AVATAR_TRANSFORMED, _playerUpdateDelegate);
            _triggerWatcher = new com.clubpenguin.world.rooms2012.common.triggers.TriggerWatcher(_stage, _SHELL);
            var _local_3 = _SHELL.getPlayerObjectById(_SHELL.getMyPlayerId());
            checkIfPlayerCanSeeGhosts(_local_3);
            checkIfUserHasFinishedScavengerHunt();
            checkIfKeyFound();
            _stage.triggers_mc.forest_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "party10", 340, 280);
            _stage.triggers_mc.cellar_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "party6", 580, 330);
            _stage.triggers_mc.library_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "party2", 185, 277);
            _stage.triggers_mc.hallLeft_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "party4", 195, 400);
            _stage.triggers_mc.hallRight_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "party4", 565, 400);
            reSetupNavigationButtons();
            _ghostList = [_stage.foreground_mc.ghostGogglesView.gogglesView_mc.ghost1, _stage.foreground_mc.ghostGogglesView.gogglesView_mc.ghost2, _stage.foreground_mc.ghostGogglesView.gogglesView_mc.ghost3];
            _ghostCheckDelegate = com.clubpenguin.util.Delegate.create(this, checkDestructableIsHit);
            _SHELL.addListener(_SHELL.BALL_LAND, _ghostCheckDelegate);
            _stage.banister_mc.scavengerHuntKey_mc.key_btn.onRelease = com.clubpenguin.util.Delegate.create(this, collectScavengerKey);
            _stage.trunk_mc.trunk_btn.onRelease = com.clubpenguin.util.Delegate.create(this, onTrunkClicked);
            clearInterval(_triggerWatcherInterval);
            _triggerWatcherInterval = setInterval(_triggerWatcher, "checkAllPlayers", 40);
            _ghostAnimator = new com.clubpenguin.world.rooms2012.halloween.HauntedGhostAnimator([_stage.foreground_mc.ghost0, _stage.ghost1], com.clubpenguin.world.rooms2012.halloween.HauntedGhostAnimator.MODE_PLAY_ONE_DELAYED);
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
		function checkIfKeyFound() {
            if (_PARTY.getTaskComplete(10)) {
                _stage.banister_mc.scavengerHuntKey_mc.gotoAndStop(2);
				_stage.banister_mc.wall_mc.gotoAndStop(2);
            }
        }
        function reSetupNavigationButtons() {
            setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.left_mc.door_btn, 90, 380), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.left_mc.doorBack_btn, 205, 130), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.right_mc.door_btn, 670, 380), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.right_mc.doorBack_btn, 555, 130), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.trunk_mc.trunkOpen_btn, 380, 190)]);
        }
        function openTrunk() {
            _stage.trunk_mc.gotoAndStop(2);
            _stage.triggers_mc.gotoAndStop(2);
            reSetupNavigationButtons();
			_stage.triggers_mc.trunk_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, collectGhostGoggles);
        }
        function checkIfUserHasFinishedScavengerHunt() {
            if (_SHELL.isItemInMyInventory(93043)) {
                openTrunk();
            }
        }
        function onTrunkClicked() {
            if (_PARTY.getTaskComplete(10) && _PARTY.getTaskComplete(11) && _PARTY.getTaskComplete(12) && _PARTY.getTaskComplete(13) && _PARTY.getTaskComplete(14)) {
                openTrunk();
			} else if (!_SHELL.isItemInMyInventory(93043)) {
                showScavengerHunt();
            }
        }
        function showScavengerHunt() {
            _INTERFACE.showContent("w.p2024.halloween.keys");
        }
        function collectGhostGoggles() {
            _INTERFACE.showContent("w.p2024.halloween.keys.goggles");
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
		function collectScavengerKey() {
            if (!_PARTY.getTaskComplete(10)) {
                _PARTY.setTaskComplete(10);
            };
            _stage.banister_mc.scavengerHuntKey_mc.gotoAndStop(2);
			_stage.banister_mc.wall_mc.gotoAndStop(2);
            _INTERFACE.showContent("w.p2024.halloween.keys");
            var _local_3 = new Sound(_stage);
            _local_3.attachSound("sfx_key_pick_up");
            _local_3.start();
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
        static var CLASS_NAME = "Foyer";
    }
