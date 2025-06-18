//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms.Mine extends com.clubpenguin.world.rooms.BaseRoom
    {
        var _stage, localize, setupNavigationButtons, _INTERFACE, _ENGINE, _SHELL, _destroyDelegate;
        function Mine (stageReference) {
            super(stageReference);
            _stage.start_x = 410;
            _stage.start_y = 300;
            localize([_stage.background_mc.puffleRescueWall_mc.rescueSign_mc.rescueSignLang_mc, _stage.cartSurferFront_mc.cartSign_mc.cartSignLang_mc]);
            setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.cart_btn, 586, 197), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.cave_btn, 95, 255), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.shack_btn, 395, 160), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.exitCaveMine_mc.caveMine_btn, 645, 371), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.puffleRescue_mc.rescueTable_mc.puffleRescue_btn, 270, 200), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.cartSurfer_btn, 630, 230)]);
            _stage.cart_btn.useHandCursor = false;
            _stage.puffleRescue_mc.rescueTable_mc.puffleRescue_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, rescueRollOver);
            _stage.puffleRescue_mc.rescueTable_mc.puffleRescue_btn.onRollOut = com.clubpenguin.util.Delegate.create(this, rescueRollOut);
            _stage.puffleRescue_mc.rescueTable_mc.puffleRescue_btn.onReleaseOutside = com.clubpenguin.util.Delegate.create(this, rescueRollOut);
            _stage.background_mc.cartSurfer_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, cartRollOver);
            _stage.background_mc.cartSurfer_btn.onRollOut = com.clubpenguin.util.Delegate.create(this, cartRollOut);
            _stage.background_mc.cartSurfer_btn.onReleaseOutside = com.clubpenguin.util.Delegate.create(this, cartRollOut);
            _stage.triggers_mc.puffleRescue_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, launchRescueGame);
            _stage.triggers_mc.cartSurfer_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, launchCartGame);
            _stage.triggers_mc.cave_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "cave", 645, 340);
            _stage.triggers_mc.shack_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "shack", 455, 235);
            _stage.triggers_mc.caveMine_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "cavemine", 110, 330);
        }
        function rescueRollOver() {
            _INTERFACE.showHint(_stage.hintPuffleRescue_mc, "rescue_hint");
            _stage.background_mc.puffleRescueWall_mc.gotoAndStop("rollOver");
        }
        function rescueRollOut() {
            _INTERFACE.closeHint();
            _stage.background_mc.puffleRescueWall_mc.gotoAndStop("rollOut");
        }
        function cartRollOver() {
            _INTERFACE.showHint(_stage.hintCartSurfer_mc, "cart_hint");
        }
        function cartRollOut() {
            _INTERFACE.closeHint();
        }
        function launchRescueGame() {
            _ENGINE.sendJoinGame("rescue", true);
        }
        function launchCartGame() {
            _ENGINE.sendJoinGame("cart", true);
        }
        function exit(name, x, y) {
            _SHELL.sendJoinRoom(name, x, y);
        }
        function init() {
            _destroyDelegate = com.clubpenguin.util.Delegate.create(this, destroy);
            _SHELL.addListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
        }
        function destroy() {
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
        }
        static var CLASS_NAME = "Mine";
    }
