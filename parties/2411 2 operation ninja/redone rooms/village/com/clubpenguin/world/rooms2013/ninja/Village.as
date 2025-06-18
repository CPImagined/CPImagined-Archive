    class com.clubpenguin.world.rooms2013.ninja.Village extends com.clubpenguin.world.rooms.BaseRoom
    {
        var _stage, localize, setupNavigationButtons, _INTERFACE, _SHELL, _destroyDelegate, wem;
        function Village (stageReference) {
            super(stageReference);
            _stage.start_x = 380;
            _stage.start_y = 340;
            localize([_stage.tour_mc, _stage.background_mc.epfsign_mc]);
            setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.lodge_btn, 480, 220), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.epf_mc.epf1_btn, 700, 280)]);
            _stage.tour2_mc.tour_mc.tour_btn.onRelease = com.clubpenguin.util.Delegate.create(this, onTourButtonClicked);
            _stage.triggers_mc.beach_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "beach", 445, 175);
            _stage.triggers_mc.mtn_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "mtn", 500, 275);
            _stage.triggers_mc.lodge_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "lodge", 380, 400);
            _stage.triggers_mc.epf_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "agentlobbymulti", 135, 300);
            _stage.triggers_mc.dock_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "dock", 345, 180);
        }
        function showContent(contentID) {
            _INTERFACE.showContent(contentID);
        }
        function onTourButtonClicked() {
            if (_INTERFACE.isTourGuide()) {
                _INTERFACE.showContent("give_tour");
            } else {
                _INTERFACE.showContent("take_tour");
            }
        }
        function exit(name, x, y) {
            _SHELL.sendJoinRoom(name, x, y);
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
        }
        function destroy() {
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            wem.destroy();
        }
        static var CLASS_NAME = "Village";
    }
