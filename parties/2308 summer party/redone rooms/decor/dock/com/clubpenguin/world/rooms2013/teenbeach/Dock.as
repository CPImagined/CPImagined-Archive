//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2013.teenbeach.Dock extends com.clubpenguin.world.rooms.BaseRoom
    {
        var _stage, _SHELL, _destroyDelegate, setupNavigationButtons, _INTERFACE, _ENGINE;
        function Dock (stageReference) {
            super(stageReference);
            trace(CLASS_NAME + "()");
            _stage.start_x = 340;
            _stage.start_y = 240;
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
        }
        function configureNavigation() {
            setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.beach_btn, 15, 200), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.village_btn, 230, 107), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.town_btn, 730, 100), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.dock_mc.boat_btn, 140, 320), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.itemHut_mc.itemHut_btn, 700, 250), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.dock_mc.boat_btn, 105, 330), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.buoy_mc.buoy_btn, 700, 430)]);
            _stage.beach_btn.useHandCursor = false;
            _stage.village_btn.useHandCursor = false;
            _stage.town_btn.useHandCursor = false;
            _stage.buoy_mc.buoy_btn.useHandCursor = false;
        }
        function configureTriggers() {
            _stage.triggers_mc.beach_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "beach", 680, 230);
            _stage.triggers_mc.village_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "village", 600, 380);
            _stage.triggers_mc.surf_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "party3", 120, 250);
            _stage.triggers_mc.town_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "town", 22, 232);
            _stage.triggers_mc.itemHutTrigger_mc.triggerFunction = com.clubpenguin.util.Delegate.create(com.clubpenguin.world.rooms2013.teenbeach.TeenBeachParty, com.clubpenguin.world.rooms2013.teenbeach.TeenBeachParty.instance.collectPartyItem, CLASS_NAME.toLowerCase());
            _stage.triggers_mc.hydro_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, launchHydroGame);
			_stage.triggers_mc.item_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, pickupItem);
        }
		function pickupItem() {
			if(!_SHELL.isItemInMyInventory(14570)) {
				_INTERFACE.buyInventory(14570);
			};
		}
        function configureRoomElements() {
            _stage.interface_mc.dock_cat_btn.onRelease = com.clubpenguin.util.Delegate.create(this, showContent, "dock_catalogue");
            _stage.hydrocatalog_mc.hydrocatalog_btn.onRelease = com.clubpenguin.util.Delegate.create(this, showContent, "dock_catalogue");
            _stage.dock_mc.boat_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, showHydroHintRollOver);
            _stage.dock_mc.boat_btn.onRollOut = com.clubpenguin.util.Delegate.create(this, hideHydroHintRollOut);
            _stage.block_mc._visible = false;
            _stage.triggers_mc._visible = false;
            _stage.interface_mc.catalogue_btn.onRelease = com.clubpenguin.util.Delegate.create(this, showContent, "party_catalogue");
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
        function destroy() {
            trace(CLASS_NAME + ": destroy()");
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
        }
        static var CLASS_NAME = "Dock";
    }
