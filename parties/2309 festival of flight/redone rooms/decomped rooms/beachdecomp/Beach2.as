//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2015.september1.Beach extends com.clubpenguin.world.rooms.BaseRoom
    {
        var _stage, localize, setupNavigationButtons, _ENGINE, _INTERFACE, _SHELL, _destroyDelegate, wem;
        function Beach (stageReference) {
            super(stageReference);
            trace(CLASS_NAME + "()");
            _stage.start_x = 300;
            _stage.start_y = 290;
            localize([_stage.background_mc.ship_mc.migratortext_mc, _stage.freeItem_mc.languague, _stage.tlapdBanner]);
            setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.light_btn, 220, 200), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.freeItem_btn, 444, 397)]);
            _stage.bucket_mc.bucket_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, bucketAnimate);
            _stage.bucket_mc.bucket_btn.onRelease = com.clubpenguin.util.Delegate.create(this, moveToMouse);
            _stage.bucket_mc.bucket_btn.useHandCursor = false;
            _stage.freeItem_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, freeItemRollOver);
            _stage.freeItem_btn.onRollOut = com.clubpenguin.util.Delegate.create(this, freeItemRollOut);
            _stage.freeItem_btn.onReleaseOutside = com.clubpenguin.util.Delegate.create(this, freeItemRollOut);
            _stage.triggers_mc.light_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "light", 300, 275);
            _stage.triggers_mc.village_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "village", 160, 395);
            _stage.triggers_mc.dock_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "dock", 230, 180);
            _stage.triggers_mc.freeItem_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, pickUpFreeItem);
        }
        function bucketAnimate() {
            _stage.bucket_mc.play();
        }
        function moveToMouse() {
            _ENGINE.sendPlayerMove(_xmouse, _ymouse);
        }
        function freeItemRollOver() {
            _stage.freeItem_mc.gotoAndStop(2);
        }
        function freeItemRollOut() {
            _stage.freeItem_mc.gotoAndStop(1);
        }
        function pickUpFreeItem() {
            _INTERFACE.buyInventory(490);
        }
        function exit(name, x, y) {
            trace(CLASS_NAME + ": exit()");
            _SHELL.sendJoinRoom(name, x, y);
        }
        function init() {
            trace(CLASS_NAME + ": init()");
            _destroyDelegate = com.clubpenguin.util.Delegate.create(this, destroy);
            _SHELL.addListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            var _local_2 = _SHELL.getMascotOptions();
            if (_local_2.migrator_active) {
                _stage.background_mc.ship_mc._visible = true;
                _stage.triggers_mc.ship_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "ship", 440, 300);
            } else {
                _stage.background_mc.ship_mc._visible = false;
            }
            wem = new com.clubpenguin.world.rooms.weathereffects.WeatherEffectsManager(_SHELL, _stage.background_mc);
            wem.setupFireAnimationHeight(45);
            wem.setupRainAnimationHeight(70);
            wem.setupSnowAnimationHeight(70);
            wem.setupRainAnimationSpeed(0.4);
            wem.setupSnowAnimationSpeed(0.8);
            wem.setupRainDelayTime(2);
            wem.setupSnowDelayTime(2);
            wem.startWeatherEffectCheck();
        }
        function destroy() {
            trace(CLASS_NAME + ": destroy()");
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            wem.destroy();
        }
        static var CLASS_NAME = "Beach";
    }
