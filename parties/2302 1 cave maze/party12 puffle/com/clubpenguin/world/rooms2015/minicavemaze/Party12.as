//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2015.minicavemaze.Party12 extends com.clubpenguin.world.rooms.BaseRoom
    {
        var _stage, _SHELL, localize, setupNavigationButtons, _destroyDelegate;
        function Party12 (stageReference) {
            super(stageReference);
            trace(CLASS_NAME + "()");
            _stage.start_x = 380;
            _stage.start_y = 230;
            if (!_SHELL) {
                init();
            }
            localize([_stage.signDance, _stage.signSecretRoom, _stage.signRockOn]);
            setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.navMaze_btn, 380, 420)]);
            _stage.navMaze_btn.useHandCursor = false;
            _stage.triggers_mc.maze_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "party1", 130, 260);
        }
        function exit(name, x, y) {
            trace(CLASS_NAME + ": exit()");
            _SHELL.sendJoinRoom(name, x, y);
        }
        function init() {
            trace(CLASS_NAME + ": init()");
            _destroyDelegate = com.clubpenguin.util.Delegate.create(this, destroy);
            _SHELL.addListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
        }
        function destroy() {
            trace(CLASS_NAME + ": destroy()");
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
        }
        static var CLASS_NAME = "Party12";
    }
