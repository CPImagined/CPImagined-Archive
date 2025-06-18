//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2014.halloween.Floor12multi extends com.clubpenguin.world.rooms.BaseRoom
    {
        var _stage, _SHELL, localize, _destroyDelegate, setupNavigationButtons, _ENGINE, _INTERFACE;
        function Floor12multi (stageReference) {
            super(stageReference);
            trace(CLASS_NAME + "()");
            _stage.start_x = 130;
            _stage.start_y = 230;
            if (!_SHELL) {
                init();
            }
            localize([]);
			_stage.foreground_mc.ghostsA_mc.ghost01_mc.gotoAndStop("gone");
			_stage.foreground_mc.ghostsA_mc.ghost03_mc.gotoAndStop("gone");
			_stage.foreground_mc.ghostsA_mc.ghost05_mc.gotoAndStop("gone");
            _stage.foreground_mc.ghostsA_mc.ghost01_mc.hover_mc.gotoAndPlay(15);
            _stage.foreground_mc.ghostsA_mc.ghost02_mc.hover_mc.gotoAndPlay(32);
            _stage.foreground_mc.ghostsA_mc.ghost03_mc.hover_mc.gotoAndPlay(45);
            _stage.foreground_mc.ghostsA_mc.ghost04_mc.hover_mc.gotoAndPlay(24);
            _stage.foreground_mc.ghostsA_mc.ghost05_mc.hover_mc.gotoAndPlay(42);
            _stage.foreground_mc.ghostsA_mc.ghost06_mc.hover_mc.gotoAndPlay(1);
        }
        function init() {
            trace(CLASS_NAME + ": init()");
            _destroyDelegate = com.clubpenguin.util.Delegate.create(this, destroy);
            _SHELL.addListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            configureTriggers();
            configureRoomElements();
        }
        function configureTriggers() {
            _stage.triggers_mc.elevator_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, elevatorUI);
        }
		function configureNavigation() {
			setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(this._stage.navElevator_btn,68,250)]);
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
        function moveToMouse() {
            _ENGINE.sendPlayerMove(_xmouse, _ymouse);
        }
        function elevatorUI() {
            _INTERFACE.showContent(com.clubpenguin.quests.rainbowpuffle.RainbowPuffleQuest.HOTEL_ELEVATOR_UI);
        }
        function exit(roomName, x, y) {
            trace(CLASS_NAME + ": exit()");
            _SHELL.sendJoinRoom(roomName, x, y);
        }
        function destroy() {
            trace(CLASS_NAME + ": destroy()");
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
        }
        static var CLASS_NAME = "Floor12multi";
    }
