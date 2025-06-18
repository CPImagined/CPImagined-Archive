//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2013.teenbeach.Plaza extends com.clubpenguin.world.rooms.BaseRoom
    {
        var _stage, localize, setupNavigationButtons, _SHELL, _destroyDelegate;
        function Plaza (stageReference) {
            super(stageReference);
            _stage.start_x = 340;
            _stage.start_y = 300;
            localize([_stage.signs_mc, _stage.background_mc.stagetitle_mc]);
            setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.forts_btn, 30, 275), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.pet_btn, 180, 245), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.hotel_btn, 310, 245), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.manhole_mc.manhole_btn, 260, 285), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.stage02_btn, 455, 240), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.pizza_btn, 585, 265), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.forest_btn, 705, 330), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.buoy_mc.buoy_btn, 150, 390), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.motor_btn, 685, 225)]);
            _stage.background_mc.forts_btn.useHandCursor = false;
            _stage.background_mc.forest_btn.useHandCursor = false;
            _stage.background_mc.tickets_btn.useHandCursor = false;
            _stage.manhole_mc.manhole_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, manholeRollOver);
            _stage.manhole_mc.manhole_btn.onRollOut = com.clubpenguin.util.Delegate.create(this, manholeRollOut);
            _stage.triggers_mc.forts_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "forts", 660, 300);
            _stage.triggers_mc.pet_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "pet", 380, 210);
            _stage.triggers_mc.hotel_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "hotellobby", 380, 210);
            _stage.triggers_mc.cave_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "cave", 590, 307);
            _stage.triggers_mc.stage01_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "mall", 105, 330);
            _stage.triggers_mc.stage02_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "mall", 105, 330);
            _stage.triggers_mc.pizza_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "pizza", 365, 195);
            _stage.triggers_mc.surf_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "party3", 365, 330);
            _stage.triggers_mc.forest_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "forest", 125, 280);
            _stage.interface_mc.catalogue_btn.onRelease = com.clubpenguin.util.Delegate.create(com.clubpenguin.world.rooms2013.teenbeach.TeenBeachParty, com.clubpenguin.world.rooms2013.teenbeach.TeenBeachParty.instance.showCatalogue);
        }
        function cannonAnimate() {
            _stage.foreground_mc.cannonpuffle_mc.gotoAndPlay(2);
            _stage.background_mc.cannonsmoke_mc.gotoAndPlay(2);
            _stage.background_mc.cannon_mc.gotoAndPlay(2);
        }
        function manholeRollOver() {
            _stage.manhole_mc.gotoAndPlay(2);
        }
        function manholeRollOut() {
            _stage.manhole_mc.gotoAndPlay(7);
        }
        function exit(name, x, y) {
            if (name == "cave") {
                _SHELL.stampEarned(UNDERGROUND_STAMP_ID);
            }
            _SHELL.sendJoinRoom(name, x, y);
        }
        function init() {
            _destroyDelegate = com.clubpenguin.util.Delegate.create(this, destroy);
            _SHELL.addListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
        }
        function destroy() {
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
        }
        static var CLASS_NAME = "Plaza";
        var UNDERGROUND_STAMP_ID = 10;
    }
