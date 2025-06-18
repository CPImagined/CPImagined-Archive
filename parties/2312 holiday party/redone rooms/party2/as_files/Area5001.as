//Created by Action Script Viewer - https://www.buraks.com/asv
    class as_files.Area5001 extends com.clubpenguin.world.rooms.BaseRoom
    {
        var _stage, _SHELL, _currentParty, _destroyDelegate, localize, setupNavigationButtons, _dialog1FinishedDelegate, _INTERFACE;
        function Area5001 (stageReference) {
            super(stageReference);
            trace(CLASS_NAME + "()");
            _stage.start_x = 530;
            _stage.start_y = 345;
            if (!_SHELL) {
                init();
            }
        }
        function init() {
            trace(CLASS_NAME + ": init()");
            _destroyDelegate = com.clubpenguin.util.Delegate.create(this, destroy);
            _SHELL.addListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            localize([_stage.background_mc.area5001art, _stage.eliteGear, _stage.area5001Sign, _stage.puffleComputer, _stage.foreground_mc.authorizedSign, _stage.foreground_mc.restrictedAreaSign]);
            setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.navUfo, 128, 212), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.navDock, 672, 228), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.navSeat1, 315, 300), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.navSeat2, 436, 300), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.navSeat3, 551, 370), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.navSeat4, 643, 337)]);
            _stage.navSeat1.useHandCursor = false;
            _stage.navSeat2.useHandCursor = false;
            _stage.navSeat3.useHandCursor = false;
            _stage.navSeat4.useHandCursor = false;
            _stage.navDock.onRollOver = com.clubpenguin.util.Delegate.create(this, dockDoorRollOver);
            _stage.navDock.onRollOut = com.clubpenguin.util.Delegate.create(this, dockDoorRollOut);
            _stage.navDock.onReleaseOutside = com.clubpenguin.util.Delegate.create(this, dockDoorRollOut);
            _stage.triggers_mc.dock_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "dock", 478, 220);
            _stage.triggers_mc.ufo_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "party3", 219, 142);
        }
		function dockDoorRollOver() {
			_stage.dockDoor.gotoAndPlay("open");
		}
		function dockDoorRollOut() {
			_stage.dockDoor.gotoAndPlay("close");
		}
        function showContent(contentID) {
            trace("show contnet");
            _INTERFACE.showContent(contentID);
        }
        function exit(name, x, y) {
            trace(CLASS_NAME + ": exit()");
            _SHELL.sendJoinRoom(name, x, y);
        }
        function destroy() {
            trace(CLASS_NAME + ": destroy()");
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
        }
        static var CLASS_NAME = "Area5001";
    }
