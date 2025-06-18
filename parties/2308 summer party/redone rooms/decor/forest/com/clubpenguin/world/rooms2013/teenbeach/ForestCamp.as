//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2013.teenbeach.ForestCamp extends com.clubpenguin.world.rooms.BaseRoom
    {
        var _stage, _SHELL, _INTERFACE, _destroyDelegate, _triggerWatcher, _triggerWatcherInterval, setupNavigationButtons;
        function ForestCamp (stageReference) {
            super(stageReference);
            _stage.start_x = 160;
            _stage.start_y = 285;
            if (!_SHELL) {
                init();
            }
        }
        function init() {
            _destroyDelegate = com.clubpenguin.util.Delegate.create(this, destroy);
            _SHELL.addListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            _triggerWatcher = new com.clubpenguin.world.rooms.common.triggers.TriggerWatcher(_stage, _SHELL);
            com.clubpenguin.world.rooms2013.teenbeach.TeenBeachParty.instance.configureItemHut(CLASS_NAME.toLowerCase(), _stage.background_mc.itemHut_mc);
            configureNavigation();
            configureTriggers();
            configureRoomElements();
            clearInterval(_triggerWatcherInterval);
            _triggerWatcherInterval = setInterval(_triggerWatcher, "checkAllPlayers", 40);
        }
        function configureTriggers() {
            _stage.triggers_mc.plaza_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "plaza", 620, 290);
            _stage.triggers_mc.cove_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "cove", 165, 195);
            _stage.triggers_mc.surf_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "party3", 385, 250);
            _stage.triggers_mc.item_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, pickupItem);
            _stage.triggers_mc.hut_mc.triggerFunction = com.clubpenguin.util.Delegate.create(com.clubpenguin.world.rooms2013.teenbeach.TeenBeachParty, com.clubpenguin.world.rooms2013.teenbeach.TeenBeachParty.instance.collectPartyItem, CLASS_NAME.toLowerCase());
        }
		function pickupItem() {
			if(!_SHELL.isItemInMyInventory(344)) {
				_INTERFACE.buyInventory(344);
			};
		}
        function configureNavigation() {
            setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.buoy_mc.buoy_btn, 50, 450), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.itemHut_mc.itemHut_btn, 625, 155), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.seatA_btn, 435, 260), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.seatB_btn, 470, 225), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.seatC_btn, 683, 235), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.seatD_btn, 700, 210)]);
            _stage.seatA_btn.useHandCursor = false;
            _stage.seatB_btn.useHandCursor = false;
            _stage.seatC_btn.useHandCursor = false;
            _stage.seatD_btn.useHandCursor = false;
        }
        function configureRoomElements() {
            _stage.block_mc._visible = false;
            _stage.triggers_mc._visible = false;
            _stage.interface_mc.catalogue_btn.onRelease = com.clubpenguin.util.Delegate.create(this, catalogOpen);
        }
		function catalogOpen() {
			_INTERFACE.showContent("party_catalogue");
		}
        function exit(roomName, x, y) {
            _SHELL.sendJoinRoom(roomName, x, y);
        }
        function destroy() {
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
        }
        static var CLASS_NAME = "Forest";
    }
