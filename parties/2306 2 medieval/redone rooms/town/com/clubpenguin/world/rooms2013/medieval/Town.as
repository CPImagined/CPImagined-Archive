//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2013.medieval.Town extends com.clubpenguin.world.rooms.BaseRoom
    {
        var _stage, localize, setupNavigationButtons, _SHELL, _INTERFACE, _destroyDelegate, wem;
        function Town (stageReference) {
            super(stageReference);
            _stage.start_x = 400;
            _stage.start_y = 350;
            setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.dock_btn, 65, 290), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.coffeedoor_mc.coffeedoor_btn, 230, 240), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.clubdoor_mc.clubdoor_btn, 400, 245), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.shop_btn, 545, 230), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.forts_btn, 700, 295), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.market_btn, 535, 240), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.seat02_btn, 347, 232)]);
            _stage.background_mc.dock_btn.useHandCursor = false;
            _stage.background_mc.forts_btn.useHandCursor = false;
            _stage.background_mc.seat01_btn.useHandCursor = false;
            _stage.background_mc.seat02_btn.useHandCursor = false;
            _stage.background_mc.dance_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, danceRollOver);
            _stage.background_mc.dance_btn.onRollOut = com.clubpenguin.util.Delegate.create(this, danceRollOut);
            _stage.triggers_mc.dock_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "dock", 720, 245);
            _stage.triggers_mc.coffee_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "coffee", 355, 200);
            _stage.triggers_mc.dance_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "dance", 170, 270);
            _stage.triggers_mc.shop_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "shop", 555, 210);
            _stage.triggers_mc.forts_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "forts", 110, 260);
            _stage.interface_mc.catalogue_Btn.onRelease = com.clubpenguin.util.Delegate.create(this, showCatalogue);
        }
		function showCatalogue() {
			_INTERFACE.showContent("party_catalogue");
		}
        function danceRollOver() {
            _stage.danceawning_mc.gotoAndStop(2);
            _stage.background_mc.dancedoor_mc.gotoAndPlay(2);
        }
        function danceRollOut() {
            _stage.danceawning_mc.gotoAndStop(1);
            _stage.background_mc.dancedoor_mc.gotoAndPlay(8);
        }
        function exit(name, x, y) {
            _SHELL.sendJoinRoom(name, x, y);
        }
        function init() {
            _destroyDelegate = com.clubpenguin.util.Delegate.create(this, destroy);
            _SHELL.addListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            wem = new com.clubpenguin.world.rooms.weathereffects.WeatherEffectsManager(_SHELL, _stage.background_mc);
            wem.setupFireAnimationHeight(50);
            wem.setupRainAnimationHeight(75);
            wem.setupSnowAnimationHeight(75);
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
        static var CLASS_NAME = "Town";
    }
