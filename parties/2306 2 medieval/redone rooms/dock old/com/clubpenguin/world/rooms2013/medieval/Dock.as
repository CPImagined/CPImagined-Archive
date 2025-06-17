//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2013.medieval.Dock extends com.clubpenguin.world.rooms.BaseRoom
    {
        var _stage, localize, setupNavigationButtons, _INTERFACE, _ENGINE, _SHELL, _destroyDelegate, wem;
        function Dock (stageReference) {
            super(stageReference);
            trace(CLASS_NAME + "()");
            configureBerries();
            _stage.start_x = 360;
            _stage.start_y = 315;
            localize([]);
            setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.beach_btn, 25, 320), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.village_btn, 565, 155), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.town_btn, 740, 250), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.dock_mc.boat_btn, 140, 395)]);
            _stage.background_mc.beach_btn.useHandCursor = false;
            _stage.background_mc.village_btn.useHandCursor = false;
            _stage.background_mc.town_btn.useHandCursor = false;
            _stage.tubes_mc.tubes_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, tubesAnimate);
            _stage.tubes_mc.tubes_btn.useHandCursor = false;
            _stage.interface_mc.dock_cat_btn.onRelease = com.clubpenguin.util.Delegate.create(this, showContent, "dock_catalogue");
            _stage.hydrocatalog_mc.hydrocatalog_btn.onRelease = com.clubpenguin.util.Delegate.create(this, showContent, "dock_catalogue");
            _stage.dock_mc.boat_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, showHydroHintRollOver);
            _stage.dock_mc.boat_btn.onRollOut = com.clubpenguin.util.Delegate.create(this, hideHydroHintRollOut);
            _stage.triggers_mc.beach_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "beach", 565, 205);
            _stage.triggers_mc.village_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "village", 665, 350);
            _stage.triggers_mc.town_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "town", 95, 320);
            _stage.triggers_mc.hydro_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, launchHydroGame);
            _stage.interface_mc.catalogue_Btn.onRelease = com.clubpenguin.util.Delegate.create(this, showCatalogue);
        }
		function showCatalogue() {
			_INTERFACE.showContent("party_catalogue");
		}
        function tubesAnimate() {
            _stage.tubes_mc.gotoAndPlay(2);
        }
        function showContent(contentID) {
            trace("show contnet");
            _INTERFACE.showContent(contentID);
        }
        function showHydroHintRollOver() {
            trace("show hint");
            _INTERFACE.showHint(_stage.hinthydro_mc, "hydro_hint");
            _stage.dock_mc.boat_mc.boathover_mc.gotoAndStop(2);
        }
        function hideHydroHintRollOut() {
            trace("hide hint");
            _INTERFACE.closeHint();
            _stage.dock_mc.boat_mc.boathover_mc.gotoAndStop(1);
        }
        function launchHydroGame() {
            _ENGINE.sendJoinGame("hydro", true);
        }
        function exit(name, x, y) {
            trace(CLASS_NAME + ": exit()");
            _SHELL.sendJoinRoom(name, x, y);
        }
        function init() {
            trace(CLASS_NAME + ": init()");
            _destroyDelegate = com.clubpenguin.util.Delegate.create(this, destroy);
            _SHELL.addListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
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
        function configureBerries() {
            if (com.clubpenguin.world.rooms2013.medieval.MedievalParty.instance.hasPlayerCollectedIngredient(com.clubpenguin.world.rooms2013.medieval.MedievalParty.MAGIC_BERRY_ITEM_ID)) {
                deactivateIngredient();
                return(undefined);
            }
            trace("user does not have berries");
            var _local_2 = com.clubpenguin.util.Delegate.create(this, deactivateIngredient);
            trace("add callback function " + _local_2);
            _stage.berry_mc.berry_btn.onRelease = com.clubpenguin.util.Delegate.create(com.clubpenguin.world.rooms2013.medieval.MedievalParty.instance, com.clubpenguin.world.rooms2013.medieval.MedievalParty.instance.sendCollectIngredient, com.clubpenguin.world.rooms2013.medieval.MedievalParty.MAGIC_BERRY_ITEM_ID, _local_2);
        }
        function deactivateIngredient() {
            _stage.berry_mc.shiny_MC._visible = false;
            _stage.berry_mc.berry_btn.enabled = false;
        }
        function destroy() {
            trace(CLASS_NAME + ": destroy()");
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            wem.destroy();
        }
        static var CLASS_NAME = "Dock";
    }
