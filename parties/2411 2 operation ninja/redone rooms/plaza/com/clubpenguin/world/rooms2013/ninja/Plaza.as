    class com.clubpenguin.world.rooms2013.ninja.Plaza extends com.clubpenguin.world.rooms.BaseRoom
    {
        var _stage, localize, setupNavigationButtons, _destroyDelegate, _SHELL, _INTERFACE;
        function Plaza (stageReference) {
            super(stageReference);
            _stage.start_x = 380;
            _stage.start_y = 350;
            localize([_stage.sign2_mc, _stage.background_mc.stagetitle_mc]);
            setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.forts_btn, 650, 210), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.pet_btn, 185, 215), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.hotel_btn, 290, 240), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.manhole_mc.manhole_btn, 340, 265), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.stage1_btn, 390, 210), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.stage2_btn, 500, 210), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.pizza_btn, 630, 230), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.forest_btn, 135, 215)]);
            _stage.background_mc.forts_btn.useHandCursor = false;
            _stage.background_mc.forest_btn.useHandCursor = false;
			_stage.background_mc.manhole_mc.manhole_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, manholeRollOver);
            _stage.background_mc.manhole_mc.manhole_btn.onRollOut = com.clubpenguin.util.Delegate.create(this, manholeRollOut);
            _stage.triggers_mc.forts_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "forts", 650, 210);
            _stage.triggers_mc.pet_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "pet", 380, 210);
            _stage.triggers_mc.hotel_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "hotellobby", 380, 210);
            _stage.triggers_mc.cave_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "cave", 590, 307);
            _stage.triggers_mc.stage_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "mall", 105, 330);
            _stage.triggers_mc.stage02_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "mall", 105, 330);
            _stage.triggers_mc.pizza_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "pizza", 414, 250);
            _stage.triggers_mc.forest_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "forest", 135, 215);
        }
        function init() {
            _destroyDelegate = com.clubpenguin.util.Delegate.create(this, destroy);
            _SHELL.addListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            _stage.interface_mc.party_cat_btn.onRelease = com.clubpenguin.util.Delegate.create(_INTERFACE, _INTERFACE.showContent, "party_catalogue");
        }
		function manholeRollOver() {
            _stage.background_mc.manhole_mc.gotoAndPlay("lidOpen");
        }
        function manholeRollOut() {
            _stage.background_mc.manhole_mc.gotoAndPlay("lidClose");
        }
        function exit(name, x, y) {
            if (name == "cave") {
                _SHELL.stampEarned(UNDERGROUND_STAMP_ID);
            }
            _SHELL.sendJoinRoom(name, x, y);
        }
        function destroy() {
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
        }
        static var CLASS_NAME = "Plaza";
        var UNDERGROUND_STAMP_ID = 10;
    }
