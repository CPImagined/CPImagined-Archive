//Created by Action Script Viewer - https://www.buraks.com/asv
    class as_files.Town extends as_files.ScavengerHuntRoom
    {
        var _stage, _SHELL, _destroyDelegate, localize, setupNavigationButtons;
        function Town (stageReference) {
            super(stageReference);
            _stage.start_x = 395;
            _stage.start_y = 365;
        }
        function coffeeRollOver() {
            _stage.doorCoffee_mc.gotoAndStop(2);
        }
        function coffeeRollOut() {
            _stage.doorCoffee_mc.gotoAndStop(1);
        }
        function danceRollOver() {
            _stage.doorDance_mc.gotoAndStop(2);
        }
        function danceRollOut() {
            _stage.doorDance_mc.gotoAndStop(1);
        }
        function clothesRollOver() {
            _stage.doorClothes_mc.gotoAndStop(2);
        }
        function clothesRollOut() {
            _stage.doorClothes_mc.gotoAndStop(1);
        }
        function exit(name, x, y) {
            _SHELL.sendJoinRoom(name, x, y);
        }
        function init() {
            _destroyDelegate = com.clubpenguin.util.Delegate.create(this, destroy);
            _SHELL.addListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            localize([_stage.signCoffee_mc, _stage.signDance_mc, _stage.signClothes_mc]);
            setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.dock_btn, 70, 325), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.coffee_btn, 190, 280), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.dance_btn, 405, 260), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.clothes_btn, 605, 295), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.forts_btn, 725, 340)]);
            _stage.dock_btn.useHandCursor = false;
            _stage.forts_btn.useHandCursor = false;
            _stage.triggers_mc.dock_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "dock", 590, 165);
            _stage.triggers_mc.coffee_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "coffee", 355, 200);
            _stage.triggers_mc.dance_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "dance", 125, 280);
            _stage.triggers_mc.shop_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "shop", 555, 210);
            _stage.triggers_mc.forts_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "forts", 150, 165);
            _stage.coffee_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, coffeeRollOver);
            _stage.coffee_btn.onRollOut = com.clubpenguin.util.Delegate.create(this, coffeeRollOut);
            _stage.coffee_btn.onReleaseOutside = com.clubpenguin.util.Delegate.create(this, coffeeRollOut);
            _stage.dance_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, danceRollOver);
            _stage.dance_btn.onRollOut = com.clubpenguin.util.Delegate.create(this, danceRollOut);
            _stage.dance_btn.onReleaseOutside = com.clubpenguin.util.Delegate.create(this, danceRollOut);
            _stage.clothes_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, clothesRollOver);
            _stage.clothes_btn.onRollOut = com.clubpenguin.util.Delegate.create(this, clothesRollOut);
            _stage.clothes_btn.onReleaseOutside = com.clubpenguin.util.Delegate.create(this, clothesRollOut);
        }
        function destroy() {
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
        }
        static var CLASS_NAME = "Town";
    }
