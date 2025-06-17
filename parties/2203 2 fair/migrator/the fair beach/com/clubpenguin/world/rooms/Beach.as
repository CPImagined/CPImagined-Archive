//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms.Beach extends com.clubpenguin.world.rooms.BaseRoom
    {
        var _stage, localize, setupNavigationButtons, _ENGINE, _SHELL, _destroyDelegate, wem;
        function Beach (stageReference) {
            super(stageReference);
            _stage.start_x = 300;
            _stage.start_y = 290;
            localize([_stage.background_mc.ship_mc.migratortext_mc]);
            setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.light_btn, 220, 200)]);
            _stage.bucket_mc.bucket_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, bucketAnimate);
            _stage.bucket_mc.bucket_btn.onRelease = com.clubpenguin.util.Delegate.create(this, moveToMouse);
            _stage.bucket_mc.bucket_btn.useHandCursor = false;
            _stage.triggers_mc.light_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "light", 300, 275);
            _stage.triggers_mc.village_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "village", 160, 395);
            _stage.triggers_mc.dock_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "dock", 230, 180);
        }
        function bucketAnimate() {
            _stage.bucket_mc.play();
        }
        function moveToMouse() {
            _ENGINE.sendPlayerMove(_xmouse, _ymouse);
        }
        function exit(name, x, y) {
            _SHELL.sendJoinRoom(name, x, y);
        }
        function init() {
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
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            wem.destroy();
        }
        static var CLASS_NAME = "Beach";
    }
