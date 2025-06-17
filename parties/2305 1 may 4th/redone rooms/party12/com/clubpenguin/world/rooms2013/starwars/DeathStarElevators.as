//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2013.starwars.DeathStarElevators extends com.clubpenguin.world.rooms.BaseRoom
    {
        var _stage, _SHELL, _destroyDelegate, setupNavigationButtons, _ENGINE, _INTERFACE;
        function DeathStarElevators (stageReference) {
            super(stageReference);
            _stage.start_x = 340;
            _stage.start_y = 290;
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
            checkRoomState();
        }
        function checkRoomState() {
            var _local_2 = "active";
            _stage.background_mc.elevatorDoor1_mc.gotoAndStop(_local_2);
            _stage.background_mc.elevatorDoor2_mc.gotoAndStop(_local_2);
            _stage.background_mc.elevatorEntrance1_mc.gotoAndStop(_local_2);
            _stage.background_mc.elevatorEntrance2_mc.gotoAndStop(_local_2);
            if ("active" == _local_2) {
                _stage.triggers_mc.party13A_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "party13", 260, 130);
                _stage.triggers_mc.party13B_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "party13", 480, 130);
                _stage.block_mc.gotoAndStop(2);
            }
        }
        function configureTriggers() {
            _stage.triggers_mc.party11_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "party11", 130, 340);
            _stage.triggers_mc.game_mc.triggerFunction = com.clubpenguin.util.Delegate.create(com.clubpenguin.world.rooms2013.starwars.StarWarsParty, com.clubpenguin.world.rooms2013.starwars.StarWarsParty.instance.launchIcejamGame, 2);
        }
        function configureNavigation() {
            setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.console_mc.console_btn, 242, 258)]);
        }
        function configureRoomElements() {
            _stage.block_mc._visible = false;
            _stage.triggers_mc._visible = false;
            _stage.testOn_btn.onRelease = com.clubpenguin.util.Delegate.create(this, elevatorsUnlocked);
            _stage.testOff_btn.onRelease = com.clubpenguin.util.Delegate.create(this, elevatorsLocked);
            _stage.background_mc.elevatorDoor1_mc.elevator_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, elevator1RollOver);
            _stage.background_mc.elevatorDoor1_mc.elevator_btn.onRollOut = com.clubpenguin.util.Delegate.create(this, elevator1RollOut);
            _stage.background_mc.elevatorDoor1_mc.elevator_btn.onReleaseOutside = com.clubpenguin.util.Delegate.create(this, elevator1RollOut);
            _stage.background_mc.elevatorDoor1_mc.elevator_btn.onRelease = com.clubpenguin.util.Delegate.create(this, elevator1Release);
            _stage.background_mc.elevatorDoor2_mc.elevator_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, elevator2RollOver);
            _stage.background_mc.elevatorDoor2_mc.elevator_btn.onRollOut = com.clubpenguin.util.Delegate.create(this, elevator2RollOut);
            _stage.background_mc.elevatorDoor2_mc.elevator_btn.onReleaseOutside = com.clubpenguin.util.Delegate.create(this, elevator2RollOut);
            _stage.background_mc.elevatorDoor2_mc.elevator_btn.onRelease = com.clubpenguin.util.Delegate.create(this, elevator2Release);
            _stage.background_mc.door_mc.door_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, doorRollOver);
            _stage.background_mc.door_mc.door_btn.onRollOut = com.clubpenguin.util.Delegate.create(this, doorRollOut);
            _stage.background_mc.door_mc.door_btn.onReleaseOutside = com.clubpenguin.util.Delegate.create(this, doorRollOut);
            _stage.background_mc.door_mc.door_btn.onRelease = com.clubpenguin.util.Delegate.create(this, doorRelease);
            _stage.console_mc.console_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, consoleRollOver);
            _stage.console_mc.console_btn.onRollOut = com.clubpenguin.util.Delegate.create(this, consoleRollOut);
            _stage.console_mc.console_btn.onReleaseOutside = com.clubpenguin.util.Delegate.create(this, consoleRollOut);
        }
        function elevatorsUnlocked() {
            _stage.background_mc.elevatorEntrance1_mc.gotoAndStop(2);
            _stage.background_mc.elevatorEntrance2_mc.gotoAndStop(2);
            _stage.background_mc.elevatorDoor1_mc.gotoAndStop(2);
            _stage.background_mc.elevatorDoor2_mc.gotoAndStop(2);
        }
        function elevatorsLocked() {
            _stage.background_mc.elevatorEntrance1_mc.gotoAndStop(1);
            _stage.background_mc.elevatorEntrance2_mc.gotoAndStop(1);
            _stage.background_mc.elevatorDoor1_mc.gotoAndStop(1);
            _stage.background_mc.elevatorDoor2_mc.gotoAndStop(1);
        }
        function elevator1RollOver() {
            if ((_stage.background_mc.elevatorDoor1_mc.elevator._currentframe == 1) || (_stage.background_mc.elevatorDoor1_mc.elevator._currentframe >= 50)) {
                _stage.background_mc.elevatorDoor1_mc.elevator.gotoAndPlay(10);
            }
            _stage.background_mc.elevatorDoor1_mc.elevator.doorTimer.gotoAndStop(1);
        }
        function elevator1RollOut() {
            if ((_stage.background_mc.elevatorDoor1_mc.elevator.doorTimer._currentframe == 1) && (_stage.background_mc.elevatorDoor1_mc.elevator._currentframe < 50)) {
                _stage.background_mc.elevatorDoor1_mc.elevator.gotoAndPlay(50);
            }
        }
        function elevator1Release() {
            _stage.background_mc.elevatorDoor1_mc.elevator.doorTimer.gotoAndPlay(2);
            _ENGINE.sendPlayerMove(80, 260);
        }
        function elevator2RollOver() {
            if ((_stage.background_mc.elevatorDoor2_mc.elevator._currentframe == 1) || (_stage.background_mc.elevatorDoor2_mc.elevator._currentframe >= 50)) {
                _stage.background_mc.elevatorDoor2_mc.elevator.gotoAndPlay(10);
            }
            _stage.background_mc.elevatorDoor2_mc.elevator.doorTimer.gotoAndStop(1);
        }
        function elevator2RollOut() {
            if ((_stage.background_mc.elevatorDoor2_mc.elevator.doorTimer._currentframe == 1) && (_stage.background_mc.elevatorDoor2_mc.elevator._currentframe < 50)) {
                _stage.background_mc.elevatorDoor2_mc.elevator.gotoAndPlay(50);
            }
        }
        function elevator2Release() {
            _stage.background_mc.elevatorDoor2_mc.elevator.doorTimer.gotoAndPlay(2);
            _ENGINE.sendPlayerMove(325, 202);
        }
        function doorRollOver() {
            if ((_stage.background_mc.door_mc._currentframe == 1) || (_stage.background_mc.door_mc._currentframe >= 50)) {
                _stage.background_mc.door_mc.gotoAndPlay(10);
            }
            _stage.background_mc.door_mc.doorTimer.gotoAndStop(1);
        }
        function doorRollOut() {
            if (_stage.background_mc.door_mc.doorTimer._currentframe == 1) {
                if ((_stage.background_mc.door_mc._currentframe < 50) && (_stage.background_mc.door_mc._currentframe != 1)) {
                    _stage.background_mc.door_mc.gotoAndPlay(50);
                }
            }
        }
        function doorRelease() {
            _stage.background_mc.door_mc.doorTimer.gotoAndPlay(2);
            _ENGINE.sendPlayerMove(598, 180);
        }
        function consoleRollOver() {
            _stage.console_mc.gotoAndStop(2);
            _INTERFACE.showHint(_stage.console_mc.hintAnchor_mc, "icejam_hint");
        }
        function consoleRollOut() {
            _stage.console_mc.gotoAndStop(1);
            _INTERFACE.closeHint();
        }
        function exit(roomName, x, y) {
            _SHELL.sendJoinRoom(roomName, x, y);
        }
        function destroy() {
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
        }
        static var CLASS_NAME = "DeathStarElevators";
    }
