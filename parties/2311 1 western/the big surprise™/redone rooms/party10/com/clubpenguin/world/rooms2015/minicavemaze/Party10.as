//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2015.minicavemaze.Party10 extends com.clubpenguin.world.rooms.BaseRoom
    {
        var _stage, _SHELL, localize, setupNavigationButtons, _INTERFACE, _destroyDelegate;
        function Party10 (stageReference) {
            super(stageReference);
            trace(CLASS_NAME + "()");
            _stage.start_x = 380;
            _stage.start_y = 230;
            if (!_SHELL) {
                init();
            }
            localize([_stage.signWearHat_mc, _stage.signStart_mc, _stage.signPrize_mc, _stage.mazeMap_mc.signMazeMap_mc]);
            setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.navDock_btn, 110, 225), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.navMaze_btn, 375, 135)]);
            _stage.navDock_btn.useHandCursor = false;
            _stage.navMaze_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, mazeRollOver);
            _stage.navMaze_btn.onRollOut = com.clubpenguin.util.Delegate.create(this, mazeRollOut);
            _stage.navMaze_btn.onReleaseOutside = com.clubpenguin.util.Delegate.create(this, mazeRollOut);
            _stage.navMap_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, mapRollOver);
            _stage.navMap_btn.onRollOut = com.clubpenguin.util.Delegate.create(this, mapRollOut);
            _stage.navMap_btn.onReleaseOutside = com.clubpenguin.util.Delegate.create(this, mapRollOut);
            _stage.navMap_btn.onRelease = com.clubpenguin.util.Delegate.create(this, mazeMap);
            _stage.triggers_mc.dock_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "forts", 345, 367);
            _stage.triggers_mc.maze_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "party8", 380, 330);
        }
        function mazeRollOver() {
            _stage.mazeEntrance_mc.gotoAndStop(2);
        }
        function mazeRollOut() {
            _stage.mazeEntrance_mc.gotoAndStop(1);
        }
        function mapRollOver() {
            _stage.mazeMap_mc.gotoAndPlay("rollOver");
        }
        function mapRollOut() {
            _stage.mazeMap_mc.gotoAndPlay("rollOut");
        }
        function mazeMap() {
            _INTERFACE.showContent("maze_map");
            com.clubpenguin.util.TrackerAS2.getInstance().trackGameAction("maze_event", "open_see_hint_warning");
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
        static var CLASS_NAME = "Party10";
    }
