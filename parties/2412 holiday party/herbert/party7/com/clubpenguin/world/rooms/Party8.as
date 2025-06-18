//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms.Party8 extends com.clubpenguin.world.rooms.BaseRoom
    {
        var _stage, localize, setupNavigationButtons, _ENGINE, _INTERFACE, _SHELL, _destroyDelegate;
        function Party8 (stageReference) {
            super(stageReference);
            _stage.start_x = 375;
            _stage.start_y = 320;
            localize([]);
            setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.foreground_mc.exit_btn, 375, 395), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.foreground_mc.entrance_btn, 375, 80)]);
            _stage.foreground_mc.exit_btn.useHandCursor = false;
            _stage.foreground_mc.entrance_btn.useHandCursor = false;
            if (mazeReset == false) {
                _stage.foreground_mc.darkness_mc.gotoAndStop("light");
            }
            if (mazeReset == true) {
                _stage.foreground_mc.darkness_mc.gotoAndStop("dark");
            }
            _stage.foreground_mc.move_btn.onRelease = com.clubpenguin.util.Delegate.create(this, moveToMouse);
            _stage.foreground_mc.move_btn.useHandCursor = false;
            _stage.triggers_mc.entranceTrigger_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "party8", 375, 320);
            _stage.onEnterFrame = com.clubpenguin.util.Delegate.create(this, updateDarkness);
        }
        function updateDarkness(event) {
            _stage.foreground_mc.darkness_mc._x = _ENGINE.player_x;
            _stage.foreground_mc.darkness_mc._y = _ENGINE.player_y;
        }
        function moveToMouse() {
            _ENGINE.sendPlayerMove(_xmouse, _ymouse);
        }
        function showContent(contentID) {
            _INTERFACE.showContent(contentID);
        }
        function exit(name, x, y) {
            _SHELL.sendJoinRoom(name, x, y);
        }
        function init() {
            _destroyDelegate = com.clubpenguin.util.Delegate.create(this, destroy);
            _SHELL.addListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            _stage.customPenguinSize = 80;
        }
        function destroy() {
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
        }
        static var CLASS_NAME = "Party8";
        var mazeReset = true;
    }
