//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2013.teenbeach.Cove extends com.clubpenguin.world.rooms.BaseRoom
    {
        var _stage, _SHELL, _destroyDelegate, setupNavigationButtons, localize, _ENGINE, _INTERFACE;
        function Cove (stageReference) {
            super(stageReference);
            trace(CLASS_NAME + "()");
            _stage.start_x = 300;
            _stage.start_y = 250;
            if (!_SHELL) {
                init();
            }
        }
        function init() {
            trace(CLASS_NAME + ": init()");
            _destroyDelegate = com.clubpenguin.util.Delegate.create(this, destroy);
            _SHELL.addListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            com.clubpenguin.world.rooms2013.teenbeach.TeenBeachParty.instance.configureItemHut(CLASS_NAME.toLowerCase(), _stage.itemHut_mc);
            configureNavigation();
            configureTriggers();
            configureRoomElements();
            var _local_2 = new com.clubpenguin.world.rooms.weathereffects.WeatherEffectsManager(_SHELL, _stage.background_mc);
            _local_2.setupFireAnimationHeight(30);
            _local_2.setupRainAnimationHeight(40);
            _local_2.setupSnowAnimationHeight(40);
            _local_2.setupRainAnimationSpeed(0.35);
            _local_2.setupSnowAnimationSpeed(0.7);
            _local_2.setupRainDelayTime(1.5);
            _local_2.setupSainDelayTime(1.5);
            _local_2.startWeatherEffectCheck();
        }
        function configureTriggers() {
            _stage.triggers_mc.highway_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "party4", 500, 135);
            _stage.triggers_mc.party3_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "party3", 110, 260);
            _stage.triggers_mc.forest_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "forest", 595, 375);
            _stage.triggers_mc.waves_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, sendJoinWaveGame);
			_stage.triggers_mc.item_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, pickupItem);
            _stage.triggers_mc.itemHutTrigger_mc.triggerFunction = com.clubpenguin.util.Delegate.create(com.clubpenguin.world.rooms2013.teenbeach.TeenBeachParty, com.clubpenguin.world.rooms2013.teenbeach.TeenBeachParty.instance.collectPartyItem, CLASS_NAME.toLowerCase());
        }
		function pickupItem() {
			if(!_SHELL.isItemInMyInventory(292)) {
				_INTERFACE.buyInventory(292);
			};
		}
        function configureNavigation() {
            setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.itemHut_mc.itemHut_btn, 80, 185), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.waves_mc.waves_btn, 590, 330), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.buoy_mc.buoy_btn, 380, 450), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.highway_btn, 505, 145)]);
        }
        function configureRoomElements() {
            localize([_stage.SurfShack_mc.SurfShackRoof_mc.SurfShackSign_mc]);
            _stage.background_mc.chair_mc.useHandCursor = false;
            _stage.background_mc.chair_mc.onRelease = function () {
                _global.getCurrentEngine().sendPlayerMove(337, 141);
            };
            _stage.chair_front_mc.binoculars_btn.onRelease = com.clubpenguin.util.Delegate.create(this, showBinoculars);
            _stage.waves_mc.waves_btn.onRelease = function () {
                _global.getCurrentEngine().sendPlayerMove(615, 350);
            };
            _stage.waves_mc.waves_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, showWaveHint);
            _stage.waves_mc.waves_btn.onRollOut = com.clubpenguin.util.Delegate.create(this, hideWaveHint);
            _stage.interface_mc.cove_cat_btn.onRelease = com.clubpenguin.util.Delegate.create(this, showCoveCatalogue);
            _stage.foreground_mc.cove_cat_obj_mc.cove_cat_obj_btn.onRelease = com.clubpenguin.util.Delegate.create(this, showCoveCatalogue);
            _stage.interface_mc.catalogue_btn.onRelease = com.clubpenguin.util.Delegate.create(com.clubpenguin.world.rooms2013.teenbeach.TeenBeachParty, com.clubpenguin.world.rooms2013.teenbeach.TeenBeachParty.instance.showCatalogue);
        }
        function sendJoinWaveGame() {
            _ENGINE.sendJoinGame("waves", true);
        }
        function showCoveCatalogue() {
            _INTERFACE.showContent("cove_catalogue");
        }
        function showBinoculars() {
            _INTERFACE.showContent("binoculars");
        }
        function showWaveHint() {
            _INTERFACE.showHint(_stage.hintwave_mc, "waves_hint");
        }
        function hideWaveHint() {
            _INTERFACE.closeHint();
        }
        function exit(roomName, x, y) {
            trace(CLASS_NAME + ": exit()");
            _SHELL.sendJoinRoom(roomName, x, y);
        }
        function destroy() {
            trace(CLASS_NAME + ": destroy()");
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
        }
        static var CLASS_NAME = "Cove";
    }
