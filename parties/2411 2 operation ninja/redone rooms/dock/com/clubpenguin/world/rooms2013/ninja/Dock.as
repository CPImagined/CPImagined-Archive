//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2013.ninja.Dock extends com.clubpenguin.world.rooms.BaseRoom
    {
        var _stage, _SHELL, setupNavigationButtons, setupHint, _destroyDelegate, wem, _INTERFACE, _ENGINE;
        function Dock (stageReference) {
            super(stageReference);
            _stage.start_x = 470;
            _stage.start_y = 240;
            if (!_SHELL) {
                init();
            }
            setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.boat_mc.boat_btn, 118, 324), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.exit_btn, 435, 135)]);
            setupHint([new com.clubpenguin.world.rooms.common.HintVO(_stage.boat_mc.boat_btn, _stage.boat_mc.boat_btn, "hydro_hint")]);
        }
        function init() {
            _destroyDelegate = com.clubpenguin.util.Delegate.create(this, destroy);
            _SHELL.addListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            wem = new com.clubpenguin.world.rooms.weathereffects.WeatherEffectsManager(_SHELL, _stage.background_mc);
            wem.setupFireAnimationHeight(40);
            wem.setupRainAnimationHeight(65);
            wem.setupSnowAnimationHeight(65);
            wem.setupRainAnimationSpeed(0.4);
            wem.setupSnowAnimationSpeed(0.8);
            wem.setupRainDelayTime(2);
            wem.setupSnowDelayTime(2);
            wem.startWeatherEffectCheck();
            _stage.interface_mc.party_cat_btn.onRelease = com.clubpenguin.util.Delegate.create(_INTERFACE, _INTERFACE.showContent, "party_catalogue");
            _stage.interface_mc.dock_cat_btn.onRelease = com.clubpenguin.util.Delegate.create(this, showContent, "dock_catalogue");
            _stage.dock_cat_obj_mc.dock_cat_obj_btn.onRelease = com.clubpenguin.util.Delegate.create(this, showContent, "dock_catalogue");
            _stage.boat_mc.boat_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, showHydroHint);
            _stage.boat_mc.boat_btn.onRollOut = com.clubpenguin.util.Delegate.create(this, hideHydroHint);
            setupTriggers();
        }
        function setupTriggers() {
            _stage.triggers_mc.beach_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "beach", 560, 250);
            _stage.triggers_mc.village_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "village", 650, 380);
            _stage.triggers_mc.town_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "town", 130, 320);
            _stage.triggers_mc.party1_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "party1", 104, 357);
            _stage.triggers_mc.boat_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, launchHydroGame);
        }
        function showHydroHint() {
            _INTERFACE.showHint(_stage.boat_mc.boat_btn, "hydro_hint");
        }
        function hideHydroHint() {
            _INTERFACE.closeHint();
        }
        function launchHydroGame(gameNumber) {
            _ENGINE.sendJoinGame("hydro", true);
        }
        function showContent(contentID) {
            _INTERFACE.showContent(contentID);
        }
        function exit(name, x, y) {
            _SHELL.sendJoinRoom(name, x, y);
        }
        function destroy() {
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            wem.destroy();
        }
        static var CLASS_NAME = "Dock";
    }
