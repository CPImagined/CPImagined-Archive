//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2015.minicavemaze.Party11 extends com.clubpenguin.world.rooms.BaseRoom
    {
        var _stage, _SHELL, localize, setupNavigationButtons, _INTERFACE, _destroyDelegate;
        function Party11 (stageReference) {
            super(stageReference);
            trace(CLASS_NAME + "()");
            _stage.start_x = 380;
            _stage.start_y = 230;
            if (!_SHELL) {
                init();
            }
            localize([_stage.signExit_mc, _stage.signPick_mc, _stage.signPrize_mc, _stage.signCoffee_mc, _stage.signPizza_mc, _stage.signFree_mc]);
            setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.navDock_btn, 95, 180), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.navFreeItem_btn, 415, 180), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.navMaze_btn, 380, 420), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.seat01_btn, 221, 178), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.seat02_btn, 316, 208), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.seat03_btn, 228, 316), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.seat04_btn, 118, 360), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.seat05_btn, 232, 363), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.seat06_btn, 521, 309), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.seat07_btn, 599, 355)]);
            _stage.navMaze_btn.useHandCursor = false;
            _stage.seat01_btn.useHandCursor = false;
            _stage.seat02_btn.useHandCursor = false;
            _stage.seat03_btn.useHandCursor = false;
            _stage.seat04_btn.useHandCursor = false;
            _stage.seat05_btn.useHandCursor = false;
            _stage.seat06_btn.useHandCursor = false;
            _stage.seat07_btn.useHandCursor = false;
            _stage.navDock_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, dockRollOver);
            _stage.navDock_btn.onRollOut = com.clubpenguin.util.Delegate.create(this, dockRollOut);
            _stage.navDock_btn.onReleaseOutside = com.clubpenguin.util.Delegate.create(this, dockRollOut);
            _stage.navFreeItem_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, freeItemRollOver);
            _stage.navFreeItem_btn.onRollOut = com.clubpenguin.util.Delegate.create(this, freeItemRollOut);
            _stage.navFreeItem_btn.onReleaseOutside = com.clubpenguin.util.Delegate.create(this, freeItemRollOut);
            _stage.triggers_mc.dock_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "forts", 345, 367);
            _stage.triggers_mc.freeItem_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, pickUpPickaxe);
            _stage.triggers_mc.maze_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "party5", 380, 230);
        }
        function dockRollOver() {
            _stage.dockExit_mc.gotoAndStop(2);
        }
        function dockRollOut() {
            _stage.dockExit_mc.gotoAndStop(1);
        }
        function freeItemRollOver() {
            _stage.freeItemBox_mc.gotoAndStop(2);
            _stage.drill_mc.picks_mc.gotoAndStop(2);
        }
        function freeItemRollOut() {
            _stage.freeItemBox_mc.gotoAndStop(1);
            _stage.drill_mc.picks_mc.gotoAndStop(1);
        }
        function pickUpPickaxe() {
            _INTERFACE.buyInventory(93111);
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
        static var CLASS_NAME = "Party11";
    }
