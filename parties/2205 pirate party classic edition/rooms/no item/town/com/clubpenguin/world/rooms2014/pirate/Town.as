//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2014.pirate.Town extends com.clubpenguin.world.rooms.BasePartyRoom
    {
        var _stage, localize, setupNavigationButtons, _SHELL, _INTERFACE, _destroyDelegate;
        function Town (stageReference) {
            super(stageReference);
            _stage.start_x = 400;
            _stage.start_y = 240;
            localize([_stage.signs_mc]);
            setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.dock_btn, 20, 275), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.coffee_btn, 225, 260), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.treasure_btn, 410, 404), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.dance_btn, 390, 190), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.shop_btn, 580, 230), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.forts_btn, 730, 260)]);
            _stage.background_mc.dock_btn.useHandCursor = false;
            _stage.background_mc.forts_btn.useHandCursor = false;
            _stage.triggers_mc.dock_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "dock", 676, 201);
            _stage.triggers_mc.coffee_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "coffee", 355, 200);
            _stage.triggers_mc.dance_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "dance", 170, 270);
            _stage.triggers_mc.shop_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "shop", 555, 210);
            _stage.triggers_mc.forts_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "forts", 195, 220);
			_stage.triggers_mc.chest_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, poster);
			showContent([new com.clubpenguin.world.rooms.common.PopupContentVO(_stage.interface_mc.party_cat_btn, true, "party_catalogue", "")]);
        }
		function poster() {
            _INTERFACE.showContent("poster");
        }
        function exit(name, x, y) {
            if (_SHELL.isNewPlayerExperienceRunning == false) {
                _SHELL.sendJoinRoom(name, x, y);
            }
        }
        function init() {
            _destroyDelegate = com.clubpenguin.util.Delegate.create(this, destroy);
            _SHELL.addListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            _global.getCurrentParty().PirateParty.configureTreasureChestState(_stage.chest_mc, _stage.crabs_mc, _stage.treasure_btn);
        }
        function initializePartyCookieDependentAssets() {
            _global.getCurrentParty().PirateParty.configureTreasureChestState(_stage.chest_mc, _stage.crabs_mc, _stage.treasure_btn);
        }
        function destroy() {
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
        }
        static var CLASS_NAME = "Town";
    }
