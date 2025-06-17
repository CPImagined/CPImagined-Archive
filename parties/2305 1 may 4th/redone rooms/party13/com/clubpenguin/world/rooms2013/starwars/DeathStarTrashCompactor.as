//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2013.starwars.DeathStarTrashCompactor extends com.clubpenguin.world.rooms.BaseRoom
    {
        var _stage, _SHELL, _destroyDelegate, _crushInterval, _steveInterval, setupNavigationButtons, _ENGINE, _INTERFACE;
        function DeathStarTrashCompactor (stageReference) {
            super(stageReference);
            _stage.start_x = 370;
            _stage.start_y = 110;
            if (!_SHELL) {
                init();
            }
            com.clubpenguin.world.rooms2013.starwars.StarWarsParty.instance.waitForPlayerLoadComplete("DeathStar");
        }
        function init() {
            _destroyDelegate = com.clubpenguin.util.Delegate.create(this, destroy);
            _SHELL.addListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            configureNavigation();
            configureTriggers();
            configureRoomElements();
            _stage.interface_mc.catalogue_btn.onRelease = com.clubpenguin.util.Delegate.create(com.clubpenguin.world.rooms2013.starwars.StarWarsParty, com.clubpenguin.world.rooms2013.starwars.StarWarsParty.launchCatalogue);
            _stage.elevatorA.lights.gotoAndPlay(3);
            _crushInterval = new com.clubpenguin.world.rooms.common.SyncedInterval(2, 0);
            _crushInterval.signal.add(playCrush, this);
            _steveInterval = new com.clubpenguin.world.rooms.common.SyncedInterval(6, 1);
            _steveInterval.signal.add(playSteve, this);
            checkRoomState();
        }
        function checkRoomState() {
            var _local_2 = "active";
            _stage.background_mc.door.gotoAndStop(_local_2);
            _stage.background_mc.bgBitmap.gotoAndStop(_local_2);
            if ("active" == _local_2) {
                _stage.triggers_mc.party14_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "party14", 166, 138);
            }
        }
        function configureTriggers() {
            _stage.triggers_mc.party12a_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "party12", 111, 307);
            _stage.triggers_mc.party12b_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "party12", 357, 240);
            _stage.triggers_mc.game_mc.triggerFunction = com.clubpenguin.util.Delegate.create(com.clubpenguin.world.rooms2013.starwars.StarWarsParty, com.clubpenguin.world.rooms2013.starwars.StarWarsParty.instance.launchIcejamGame, 3);
        }
        function configureNavigation() {
            setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.console_mc.console_btn, 165, 133)]);
        }
        function configureRoomElements() {
            _stage.block_mc._visible = false;
            _stage.triggers_mc._visible = false;
            _stage.testOn_btn.onRelease = com.clubpenguin.util.Delegate.create(this, doorUnlocked);
            _stage.testOff_btn.onRelease = com.clubpenguin.util.Delegate.create(this, doorLocked);
            _stage.playCrush_btn.onRelease = com.clubpenguin.util.Delegate.create(this, playCrush);
            _stage.playSteve_btn.onRelease = com.clubpenguin.util.Delegate.create(this, playSteve);
            _stage.background_mc.door.doorGreen.door_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, party14DoorRollOver);
            _stage.background_mc.door.doorGreen.door_btn.onRollOut = com.clubpenguin.util.Delegate.create(this, party14DoorRollOut);
            _stage.background_mc.door.doorGreen.door_btn.onReleaseOutside = com.clubpenguin.util.Delegate.create(this, party14DoorRollOut);
            _stage.background_mc.door.doorGreen.door_btn.onRelease = com.clubpenguin.util.Delegate.create(this, party14DoorRelease);
            _stage.elevator1.elevator_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, elevator1RollOver);
            _stage.elevator1.elevator_btn.onRollOut = com.clubpenguin.util.Delegate.create(this, elevator1RollOut);
            _stage.elevator1.elevator_btn.onReleaseOutside = com.clubpenguin.util.Delegate.create(this, elevator1RollOut);
            _stage.elevator1.elevator_btn.onRelease = com.clubpenguin.util.Delegate.create(this, elevator1Release);
            _stage.elevator2.elevator_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, elevator2RollOver);
            _stage.elevator2.elevator_btn.onRollOut = com.clubpenguin.util.Delegate.create(this, elevator2RollOut);
            _stage.elevator2.elevator_btn.onReleaseOutside = com.clubpenguin.util.Delegate.create(this, elevator2RollOut);
            _stage.elevator2.elevator_btn.onRelease = com.clubpenguin.util.Delegate.create(this, elevator2Release);
            _stage.console_mc.console_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, consoleRollOver);
            _stage.console_mc.console_btn.onRollOut = com.clubpenguin.util.Delegate.create(this, consoleRollOut);
            _stage.console_mc.console_btn.onReleaseOutside = com.clubpenguin.util.Delegate.create(this, consoleRollOut);
        }
        function doorUnlocked() {
            _stage.background_mc.bgBitmap.gotoAndStop(2);
            _stage.background_mc.door.gotoAndStop(2);
        }
        function doorLocked() {
            _stage.background_mc.bgBitmap.gotoAndStop(1);
            _stage.background_mc.door.gotoAndStop(1);
        }
        function party14DoorRollOver() {
            if ((_stage.background_mc.door.doorGreen._currentframe == 1) || (_stage.background_mc.door.doorGreen._currentframe >= 50)) {
                _stage.background_mc.door.doorGreen.gotoAndPlay(10);
            }
            _stage.background_mc.door.doorGreen.doorTimer.gotoAndStop(1);
        }
        function party14DoorRollOut() {
            if ((_stage.background_mc.door.doorGreen.doorTimer._currentframe == 1) && (_stage.background_mc.door.doorGreen._currentframe < 50)) {
                _stage.background_mc.door.doorGreen.gotoAndPlay(50);
            }
        }
        function party14DoorRelease() {
            _stage.background_mc.door.doorGreen.doorTimer.gotoAndPlay(2);
            _ENGINE.sendPlayerMove(646, 111);
        }
        function elevator1RollOver() {
            if ((_stage.elevator1.door._currentframe == 1) || (_stage.elevator1.door._currentframe >= 50)) {
                _stage.elevator1.door.gotoAndPlay(10);
            }
            _stage.elevator1.door.doorTimer.gotoAndStop(1);
        }
        function elevator1RollOut() {
            if ((_stage.elevator1.door.doorTimer._currentframe == 1) && (_stage.elevator1.door._currentframe < 50)) {
                _stage.elevator1.door.gotoAndPlay(50);
            }
        }
        function elevator1Release() {
            _stage.elevator1.door.doorTimer.gotoAndPlay(2);
            _ENGINE.sendPlayerMove(263, 80);
        }
        function elevator2RollOver() {
            if ((_stage.elevator2.door._currentframe == 1) || (_stage.elevator2.door._currentframe >= 50)) {
                _stage.elevator2.door.gotoAndPlay(10);
            }
            _stage.elevator2.door.doorTimer.gotoAndStop(1);
        }
        function elevator2RollOut() {
            if ((_stage.elevator2.door.doorTimer._currentframe == 1) && (_stage.elevator2.door._currentframe < 50)) {
                _stage.elevator2.door.gotoAndPlay(50);
            }
        }
        function elevator2Release() {
            _stage.elevator2.door.doorTimer.gotoAndPlay(2);
            _ENGINE.sendPlayerMove(482, 80);
        }
        function consoleRollOver() {
            _stage.console_mc.gotoAndStop(2);
            _INTERFACE.showHint(_stage.console_mc.hintAnchor_mc, "icejam_hint");
        }
        function consoleRollOut() {
            _stage.console_mc.gotoAndStop(1);
            _INTERFACE.closeHint();
        }
        function playCrush() {
            _stage.directorCrusher.gotoAndPlay("startCrushing");
        }
        function playSteve() {
            _stage.directorSteve.gotoAndPlay("steveArrives");
        }
        function exit(roomName, x, y) {
            _SHELL.sendJoinRoom(roomName, x, y);
        }
        function destroy() {
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
        }
        static var CLASS_NAME = "DeathStarTrashCompactor";
    }
