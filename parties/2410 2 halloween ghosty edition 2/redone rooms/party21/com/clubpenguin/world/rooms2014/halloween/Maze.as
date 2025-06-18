//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2014.halloween.Maze extends com.clubpenguin.world.rooms.BaseRoom
    {
        var _stage, _SHELL, localize, _destroyDelegate,setupNavigationButtons, _INTERFACE;
        function Maze (stageReference) {
            super(stageReference);
            _stage.start_x = 100;
            _stage.start_y = 250;
            if (!_SHELL) {
                init();
            }
            localize([]);
        }
        function init() {
            _destroyDelegate = com.clubpenguin.util.Delegate.create(this, destroy);
            _SHELL.addListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            _stage.customPenguinSize = 85;
            configureNavigation();
            configureTriggers();
            configureRoomElements();
        }
        function configureNavigation() {
            setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.navElevator_btn, 60, 240), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.navChair01_btn, 141, 105), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.navChair02_btn, 50, 289), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.navChair03_btn, 39, 340)]);
            _stage.navChair01_btn.useHandCursor = false;
            _stage.navChair02_btn.useHandCursor = false;
            _stage.navChair03_btn.useHandCursor = false;
        }
        function configureTriggers() {
            _stage.triggers_mc.elevator_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, elevatorUI);
        }
        function configureRoomElements() {
            _stage.navElevator_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, elevatorRollOver);
            _stage.navElevator_btn.onRollOut = com.clubpenguin.util.Delegate.create(this, elevatorRollOut);
            _stage.navElevator_btn.onReleaseOutside = com.clubpenguin.util.Delegate.create(this, elevatorRollOut);
        }
        function elevatorRollOver() {
            if (_stage.elevator._currentFrame == 1) {
                _stage.elevator.gotoAndPlay("open");
            } else if (_stage.elevator._currentFrame == 16) {
            } else {
                _stage.elevator.gotoAndPlay(30 - (_stage.elevator._currentFrame - 2));
            }
        }
        function elevatorRollOut() {
            if (_stage.elevator._currentFrame > 13) {
                _stage.elevator.gotoAndPlay("close");
            } else {
                _stage.elevator.gotoAndPlay(2 + (30 - _stage.elevator._currentFrame));
            }
        }
        function elevatorUI() {
            _INTERFACE.showContent(com.clubpenguin.world.rooms2014.halloween.party.HalloweenParty.CONSTANTS.ELEVATOR_UI_PATH);
        }
        function exit(roomName, x, y) {
            _SHELL.sendJoinRoom(roomName, x, y);
        }
        function destroy() {
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
        }
        static var CLASS_NAME = "Maze";
    }
