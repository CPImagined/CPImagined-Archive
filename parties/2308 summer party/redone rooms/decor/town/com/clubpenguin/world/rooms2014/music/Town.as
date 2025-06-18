//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2014.music.Town extends com.clubpenguin.world.rooms.BaseRoom
    {
        var _stage, _SHELL, _INTERFACE, _destroyDelegate, setupNavigationButtons, localize;
        function Town (stageReference) {
            super(stageReference);
            _stage.start_x = 360;
            _stage.start_y = 330;
            if (!_SHELL) {
                init();
            }
        }
        function init() {
            _destroyDelegate = com.clubpenguin.util.Delegate.create(this, destroy);
            _SHELL.addListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            configureNavigation();
            configureTriggers();
            configureRoomElements();
        }
        function configureTriggers() {
            _stage.triggers_mc.dock_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "dock", 635, 195);
            _stage.triggers_mc.coffeeTrigger_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "coffee", 355, 200);
            _stage.triggers_mc.danceTrigger_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "dance", 170, 285);
            _stage.triggers_mc.clothesTrigger_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "shop", 555, 210);
            _stage.triggers_mc.fortsTrigger_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "forts", 110, 310);
			_stage.triggers_mc.party3_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "party3", 110, 260);
			_stage.interface_mc.catalogue_btn.onRelease = com.clubpenguin.util.Delegate.create(this, catalogOpen);
        }
		function catalogOpen() {
			_INTERFACE.showContent("party_catalogue");
		}
        function configureNavigation() {
            setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.motorcycle01_mc.nav_btn, 329, 304), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.motorcycle02_mc.nav_btn, 250, 261), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.itemHut_mc.itemHut_btn, 646, 331), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.shack_btn, 400, 215), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.clothes_btn, 600, 225), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.buoy_mc.buoy_btn, 630, 420), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.coffee_btn, 80, 190)]);
        }
        function configureRoomElements() {
            localize([_stage.background_mc.smoothies_mc, _stage.background_mc.shimmyShack_mc.text_mc, _stage.background_mc.clothesShop_mc]);
            _stage.block_mc._visible = false;
            _stage.triggers_mc._visible = false;
            _stage.chair01_mc.nav_btn.useHandCursor = false;
            _stage.chair02_mc.nav_btn.useHandCursor = false;
        }
        function exit(roomName, x, y) {
            _SHELL.sendJoinRoom(roomName, x, y);
        }
        function destroy() {
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
        }
        static var CLASS_NAME = "Town";
    }
