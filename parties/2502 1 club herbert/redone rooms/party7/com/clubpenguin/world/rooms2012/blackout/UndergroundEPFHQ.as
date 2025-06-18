//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2012.blackout.UndergroundEPFHQ extends com.clubpenguin.world.rooms.BaseRoom
    {
        var _stage, localize, _destroyDelegate, _SHELL, _snowballCheck, _triggerWatcher, setupNavigationButtons, _workoutTrigger, _locker1Trigger, _locker2Trigger, _locker3Trigger, _locker4Trigger, _roomUpdateInterval, _INTERFACE;
        function UndergroundEPFHQ (stageReference) {
            super(stageReference);
            _stage.start_x = 254;
            _stage.start_y = 254;
            _stage.customPenguinSize = 90;
            localize([_stage.statusBoard_mc.captured_mc]);
            _stage.warRoomPenguin01_mc.onPress = startMove;
            _stage.warRoomPenguin01_mc.onRelease = stopMove;
            _stage.warRoomPenguin01_mc.onReleaseOutside = stopMove;
            _stage.warRoomPenguin02_mc.onPress = startMove;
            _stage.warRoomPenguin02_mc.onRelease = stopMove;
            _stage.warRoomPenguin02_mc.onReleaseOutside = stopMove;
            _stage.warRoomPenguin03_mc.onPress = startMove;
            _stage.warRoomPenguin03_mc.onRelease = stopMove;
            _stage.warRoomPenguin03_mc.onReleaseOutside = stopMove;
            _stage.warRoomPenguin04_mc.onPress = startMove;
            _stage.warRoomPenguin04_mc.onRelease = stopMove;
            _stage.warRoomPenguin04_mc.onReleaseOutside = stopMove;
            _stage.warRoomHerbert_mc.onPress = startMove;
            _stage.warRoomHerbert_mc.onRelease = stopMove;
            _stage.warRoomHerbert_mc.onReleaseOutside = stopMove;
        }
        function init() {
            _destroyDelegate = com.clubpenguin.util.Delegate.create(this, destroy);
            _SHELL.addListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            _snowballCheck = com.clubpenguin.util.Delegate.create(this, ballLand);
            _SHELL.addListener(_SHELL.BALL_LAND, _snowballCheck);
            _triggerWatcher = new com.clubpenguin.world.rooms2012.common.triggers.TriggerWatcher(_stage, _SHELL);
            _stage.foreground_mc.partyCat_mc.partyCat_btn.onRelease = com.clubpenguin.util.Delegate.create(this, showCatalogue);
            setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.workoutBottom_mc.weightCenterButton_btn, 595, 422), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.tunnel_mc.tunnel_btn, 62, 280), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.lockerDoor01_mc.lockerDoor01_btn, 95, 163), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.lockerDoor02_mc.lockerDoor02_btn, 115, 147), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.lockerDoor03_mc.lockerDoor03_btn, 134, 133), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.lockerDoor04_mc.lockerDoor04_btn, 150, 119), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.beach_mc.beach_btn, 196, 72), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.village_mc.village_btn, 268, 72), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.dock_mc.dock_btn, 340, 72), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.town_mc.town_btn, 412, 72), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.plaza_mc.plaza_btn, 484, 72)]);
            _stage.triggers_mc.tunnel_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "party6", 520, 276);
			//_stage.triggers_mc.tunnel_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, showContent, "w.app.p2025.doom.tunnelnote");
            _stage.triggers_mc.beach_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "beach", 455, 370);
            _stage.triggers_mc.village_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "village", 410, 385);
            _stage.triggers_mc.dock_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "dock", 405, 270);
            _stage.triggers_mc.town_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "town", 250, 295);
            _stage.triggers_mc.plaza_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "plaza", 405, 365);
            _workoutTrigger = new com.clubpenguin.world.rooms2012.common.triggers.PlayerWalkTrigger(_stage.triggers_mc.workout_mc);
            _workoutTrigger.playersAdded.add(com.clubpenguin.util.Delegate.create(this, startWorkout));
            _workoutTrigger.playersRemoved.add(com.clubpenguin.util.Delegate.create(this, stopWorkout));
            _triggerWatcher.addTrigger(_workoutTrigger);
            _locker1Trigger = new com.clubpenguin.world.rooms2012.common.triggers.PlayerWalkTrigger(_stage.triggers_mc.locker1_mc);
            _locker1Trigger.playersAdded.add(com.clubpenguin.util.Delegate.create(this, openLocker, _stage.lockerDoor01_mc, _locker1Trigger));
            _locker1Trigger.playersRemoved.add(com.clubpenguin.util.Delegate.create(this, closeLocker, _stage.lockerDoor01_mc, _locker1Trigger));
            _triggerWatcher.addTrigger(_locker1Trigger);
            _locker2Trigger = new com.clubpenguin.world.rooms2012.common.triggers.PlayerWalkTrigger(_stage.triggers_mc.locker2_mc);
            _locker2Trigger.playersAdded.add(com.clubpenguin.util.Delegate.create(this, openLocker, _stage.lockerDoor02_mc, _locker2Trigger));
            _locker2Trigger.playersRemoved.add(com.clubpenguin.util.Delegate.create(this, closeLocker, _stage.lockerDoor02_mc, _locker2Trigger));
            _triggerWatcher.addTrigger(_locker2Trigger);
            _locker3Trigger = new com.clubpenguin.world.rooms2012.common.triggers.PlayerWalkTrigger(_stage.triggers_mc.locker3_mc);
            _locker3Trigger.playersAdded.add(com.clubpenguin.util.Delegate.create(this, openLocker, _stage.lockerDoor03_mc, _locker3Trigger));
            _locker3Trigger.playersRemoved.add(com.clubpenguin.util.Delegate.create(this, closeLocker, _stage.lockerDoor03_mc, _locker3Trigger));
            _triggerWatcher.addTrigger(_locker3Trigger);
            _locker4Trigger = new com.clubpenguin.world.rooms2012.common.triggers.PlayerWalkTrigger(_stage.triggers_mc.locker4_mc);
            _locker4Trigger.playersAdded.add(com.clubpenguin.util.Delegate.create(this, openLocker, _stage.lockerDoor04_mc, _locker4Trigger));
            _locker4Trigger.playersRemoved.add(com.clubpenguin.util.Delegate.create(this, closeLocker, _stage.lockerDoor04_mc, _locker4Trigger));
            _triggerWatcher.addTrigger(_locker4Trigger);
            clearInterval(_roomUpdateInterval);
            _roomUpdateInterval = setInterval(this, "update", 40);
            setCorkboardState();
        }
        function update() {
            _triggerWatcher.checkAllPlayers();
            checkForHerberts();
        }
        function showCatalogue() {
            _INTERFACE.showContent("party_catalogue");
        }
        function checkForHerberts() {
            var _local_4 = _SHELL.getPlayerList();
            var _local_5 = {};
            var _local_6 = false;
            var _local_3 = 0;
            while (_local_3 < _local_4.length) {
                if ((_local_4[_local_3].body == com.clubpenguin.world.rooms2012.blackout.Blackout.HERBERT_COSTUME_ID) || (_SHELL.getMascotIdByPlayerId(_local_4[_local_3].player_id) == com.clubpenguin.world.rooms2012.common.MascotEnum.HERBERT_MASCOT_ID)) {
                    _local_5[_local_4[_local_3].player_id] = _local_4[_local_3];
                    _local_6 = true;
                } else if (_local_5[_local_4[_local_3].player_id]) {
                    _local_5[_local_4[_local_3].player_id] = null;
                }
                _local_3++;
            }
            if (_local_6 && (_stage.herbertWarning_mc._currentframe == 1)) {
                _stage.herbertWarning_mc.gotoAndStop(2);
                _stage.herbertWarning_mc._visible = true;
                _stage.herbertWarning_mc.localAlarmScreen_mc[_global.getCurrentShell().getLanguageAbbreviation()].play();
                _stage.alarmLightsAnimation_mc.gotoAndPlay("on");
            } else if ((!_local_6) && (_stage.herbertWarning_mc._currentframe == 2)) {
                _stage.herbertWarning_mc.gotoAndStop(1);
                _stage.herbertWarning_mc._visible = false;
                _stage.herbertWarning_mc.localAlarmScreen_mc[_global.getCurrentShell().getLanguageAbbreviation()].gotoAndStop(1);
                _stage.alarmLightsAnimation_mc.gotoAndPlay("off");
            }
        }
        function openLocker(players, lockerMC, trigger) {
            if (lockerMC._currentframe != 1) {
                return(undefined);
            }
            lockerMC.gotoAndPlay("open");
        }
        function closeLocker(players, lockerMC, trigger) {
            if (trigger.getPlayerCount() > 0) {
                return(undefined);
            }
            lockerMC.gotoAndPlay("close");
        }
        function setRoomState(state) {
            _stage.statusBoard_mc.gotoAndStop(state);
        }
        function setCorkboardState() {
            if (com.clubpenguin.world.rooms2012.blackout.Blackout.playerHasCompletedChallege(com.clubpenguin.world.rooms2012.blackout.Blackout.CHALLENGE_6)) {
                _stage.statusBoard_mc.gotoAndStop(6);
            } else if (com.clubpenguin.world.rooms2012.blackout.Blackout.playerHasCompletedChallege(com.clubpenguin.world.rooms2012.blackout.Blackout.CHALLENGE_5)) {
                _stage.statusBoard_mc.gotoAndStop(5);
            } else if (com.clubpenguin.world.rooms2012.blackout.Blackout.isChallengeUnlocked(com.clubpenguin.world.rooms2012.blackout.Blackout.CHALLENGE_5)) {
                _stage.statusBoard_mc.gotoAndStop(4);
            } else if (com.clubpenguin.world.rooms2012.blackout.Blackout.isChallengeUnlocked(com.clubpenguin.world.rooms2012.blackout.Blackout.CHALLENGE_4)) {
                _stage.statusBoard_mc.gotoAndStop(3);
            } else if (com.clubpenguin.world.rooms2012.blackout.Blackout.isChallengeUnlocked(com.clubpenguin.world.rooms2012.blackout.Blackout.CHALLENGE_3)) {
                _stage.statusBoard_mc.gotoAndStop(2);
            }
        }
        function startMove() {
            MovieClip(this).startDrag(false, 209, 314, 304, 395);
        }
        function stopMove() {
            MovieClip(this).stopDrag();
        }
        function startWorkout() {
            if (_stage.workoutBottom_mc._currentframe == 1) {
                _stage.workoutBottom_mc.gotoAndPlay(2);
                _stage.workoutTop_mc.gotoAndPlay(2);
            }
        }
        function stopWorkout() {
            if (_workoutTrigger.getPlayerCount() > 0) {
                return(undefined);
            }
            _stage.workoutBottom_mc.gotoAndStop(1);
            _stage.workoutTop_mc.gotoAndStop(1);
        }
        function ballLand(snowballInfo) {
            if (_stage.triggers_mc.herbertTrigger01_mc.hitTest(snowballInfo.x, snowballInfo.y, true)) {
                if (_stage.herbertTarget01_mc._currentframe == 1) {
                    _stage.herbertTarget01_mc.gotoAndPlay(2);
                }
                snowballInfo.snowballMC._visible = false;
                return(undefined);
            } else if (_stage.triggers_mc.herbertTrigger02_mc.hitTest(snowballInfo.x, snowballInfo.y, true)) {
                if (_stage.herbertTarget02_mc._currentframe == 1) {
                    _stage.herbertTarget02_mc.gotoAndPlay(2);
                }
                snowballInfo.snowballMC._visible = false;
                return(undefined);
            } else if (_stage.triggers_mc.herbertTrigger03_mc.hitTest(snowballInfo.x, snowballInfo.y, true)) {
                if (_stage.herbertTarget03_mc._currentframe == 1) {
                    _stage.herbertTarget03_mc.gotoAndPlay(2);
                }
                snowballInfo.snowballMC._visible = false;
                return(undefined);
            }
        }
		function showContent(contentID) {
			_INTERFACE.showContent(contentID);
		}
        function exit(roomName, x, y) {
            _SHELL.sendJoinRoom(roomName, x, y);
        }
        function destroy() {
            clearInterval(_roomUpdateInterval);
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            _SHELL.removeListener(_SHELL.BALL_LAND, _snowballCheck);
        }
        static var CLASS_NAME = "UndergroundEPFHQ";
    }
