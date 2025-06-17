//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2014.puffles.Plaza extends com.clubpenguin.world.rooms.BaseRoom
    {
        var _stage, _SHELL, localize, setupNavigationButtons, _INTERFACE, _destroyDelegate;
        function Plaza (stageReference) {
            super(stageReference);
            _stage.start_x = 325;
            _stage.start_y = 345;
            if (!_SHELL) {
                init();
            }
            localize([_stage.background_mc.signs_mc, _stage.background_mc.back2_mc.cache1.petshop_all_mc.petshopsign_mc, _stage.background_mc.back2_mc.thestage_all_mc.stagesign_mc, _stage.background_mc.back2_mc.cache1.pizza_all_mc.pizzasign_mc, _stage.background_mc.back2_mc.thestage_all_mc.playtitle_mc, _stage.background_mc.back2_mc.cache1.parkGate.gateOn.signText, _stage.background_mc.back2_mc.cache1.parkGate.gateOff.signText]);
            _global.getCurrentParty().PuffleParty.configureItemBooth(_stage.boothContainer_mc);
            _stage.triggers_mc.booth_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, openQuestInterface);
            setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.forts_btn, 20, 260), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.park_btn, 100, 230), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.pet_btn, 240, 240), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.back2_mc.hotel_btn, 350, 240), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.manhole_mc.manhole_btn, 310, 280), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.stage01_btn, 430, 230), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.stage02_btn, 530, 220), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.boothContainer_mc.booth_btn, 505, 350), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.pizza_btn, 640, 250), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.forest_btn, 760, 260)]);
            _stage.background_mc.forts_btn.useHandCursor = false;
            _stage.background_mc.forest_btn.useHandCursor = false;
            _stage.boothContainer_mc.ticketbooth_btn.useHandCursor = false;
            _stage.tickets_btn.useHandCursor = false;
            _stage.background_mc.cannon_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, cannonAnimate);
            _stage.background_mc.cannon_btn.useHandCursor = false;
            _stage.background_mc.park_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, parkRollOver);
            _stage.background_mc.park_btn.onRollOut = com.clubpenguin.util.Delegate.create(this, parkRollOut);
            _stage.triggers_mc.forts_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "forts", 660, 260);
            _stage.triggers_mc.park_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "park", 335, 145);
            _stage.triggers_mc.pet_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "pet", 380, 210);
            _stage.triggers_mc.hotel_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "hotellobby", 380, 210);
            _stage.triggers_mc.cave_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "cave", 590, 307);
            _stage.triggers_mc.stage01_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "mall", 130, 200);
            _stage.triggers_mc.stage02_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "mall", 130, 200);
            _stage.triggers_mc.pizza_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "pizza", 365, 195);
            _stage.triggers_mc.forest_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "forest", 90, 325);
        }
		function openQuestInterface() {
			_INTERFACE.showContent("w.app.p2014.itembooth");
		}
        function cannonAnimate() {
            _stage.foreground_mc.cannonpuffle_mc.gotoAndPlay(2);
            _stage.background_mc.cannonsmoke_mc.gotoAndPlay(2);
            _stage.background_mc.cannon_mc.gotoAndPlay(2);
        }
        function manholeRollOver() {
            if (_stage.manhole_mc._currentframe == 1) {
                _stage.manhole_mc.gotoAndPlay("lidOpen");
            }
        }
        function manholeRollOut() {
            _stage.manhole_mc.gotoAndPlay("lidClose");
        }
        function parkRollOver() {
            _stage.background_mc.back2_mc.cache1.parkGate.gotoAndStop("on");
        }
        function parkRollOut() {
            _stage.background_mc.back2_mc.cache1.parkGate.gotoAndStop("off");
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
            _stage.manhole_mc.manhole_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, manholeRollOver);
            _stage.manhole_mc.manhole_btn.onRollOut = com.clubpenguin.util.Delegate.create(this, manholeRollOut);
        }
        function destroy() {
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
        }
        function updateItemBoothState() {
            _global.getCurrentParty().PuffleParty.configureItemBooth(_stage.boothContainer_mc);
        }
        static var CLASS_NAME = "Plaza";
        var UNDERGROUND_STAMP_ID = 10;
    }
