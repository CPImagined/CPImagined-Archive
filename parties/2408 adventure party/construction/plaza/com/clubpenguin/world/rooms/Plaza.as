//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms.Plaza extends com.clubpenguin.world.rooms.BaseRoom
    {
        var _stage, _SHELL, localize, setupNavigationButtons, _caveMineDigging, _destroyDelegate, _abductionDelegate, aliendAbduction;
        function Plaza (stageReference) {
            super(stageReference);
            _stage.start_x = 380;
            _stage.start_y = 350;
            if (!_SHELL) {
                init();
            }
            localize([_stage.petSign, _stage.hotelSign, _stage.mallSign, _stage.pizzaSign, _stage.background_mc.parkGate.gateOn.signText, _stage.background_mc.parkGate.gateOff.signText]);
            setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.forts_btn, 35, 290), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.park_btn, 85, 265), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.navPet, 213, 245), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.navHotel, 330, 237), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.manhole_mc.manhole_btn, 270, 275), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.navMall, 468, 220), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.navPizza, 627, 245), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.forest_btn, 720, 280)]);
            _stage.forts_btn.useHandCursor = false;
            _stage.forest_btn.useHandCursor = false;
            _stage.background_mc.cannon_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, cannonAnimate);
            _stage.background_mc.cannon_btn.useHandCursor = false;
            _stage.park_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, parkRollOver);
            _stage.park_btn.onRollOut = com.clubpenguin.util.Delegate.create(this, parkRollOut);
            _stage.manhole_mc.manhole_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, manholeRollOver);
            _stage.manhole_mc.manhole_btn.onRollOut = com.clubpenguin.util.Delegate.create(this, manholeRollOut);
            _stage.navPizza.onRollOver = com.clubpenguin.util.Delegate.create(this, pizzaDoorRollOver);
            _stage.navPizza.onRollOut = com.clubpenguin.util.Delegate.create(this, pizzaDoorRollOut);
            _stage.navMall.onRollOver = com.clubpenguin.util.Delegate.create(this, mallDoorRollOver);
            _stage.navMall.onRollOut = com.clubpenguin.util.Delegate.create(this, mallDoorRollOut);
            _stage.navHotel.onRollOver = com.clubpenguin.util.Delegate.create(this, hotelDoorRollOver);
            _stage.navHotel.onRollOut = com.clubpenguin.util.Delegate.create(this, hotelDoorRollOut);
            _stage.navPet.onRollOver = com.clubpenguin.util.Delegate.create(this, petDoorRollOver);
            _stage.navPet.onRollOut = com.clubpenguin.util.Delegate.create(this, petDoorRollOut);
            _stage.triggers_mc.forts_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "forts", 655, 235);
            _stage.triggers_mc.park_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "park", 335, 145);
            _stage.triggers_mc.pet_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "pet", 380, 210);
            _stage.triggers_mc.hotel_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "hotellobby", 380, 210);
            _stage.triggers_mc.cave_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "cave", 590, 307);
            _stage.triggers_mc.mall_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "mall", 150, 370);
            _stage.triggers_mc.pizza_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "pizza", 365, 195);
            _stage.triggers_mc.forest_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "forest", 135, 215);
			_stage.dig_area_mc._visible = false;
        }
        function cannonAnimate() {
            _stage.foreground_mc.cannonpuffle_mc.gotoAndPlay(2);
            _stage.background_mc.cannonsmoke_mc.gotoAndPlay(2);
            _stage.background_mc.cannon_mc.gotoAndPlay(2);
        }
        function manholeRollOver() {
            _stage.manhole_mc.gotoAndPlay("lidOpen");
        }
        function manholeRollOut() {
            _stage.manhole_mc.gotoAndPlay("lidClose");
        }
        function parkRollOver() {
            _stage.background_mc.parkGate.gotoAndStop("on");
        }
        function parkRollOut() {
            _stage.background_mc.parkGate.gotoAndStop("off");
        }
        function pizzaDoorRollOver() {
            _stage.pizzaDoor.gotoAndStop(2);
        }
        function pizzaDoorRollOut() {
            _stage.pizzaDoor.gotoAndStop(1);
        }
        function mallDoorRollOver() {
            _stage.mallDoor.gotoAndStop(2);
        }
        function mallDoorRollOut() {
            _stage.mallDoor.gotoAndStop(1);
        }
        function hotelDoorRollOver() {
            _stage.hotelDoor.gotoAndStop(2);
        }
        function hotelDoorRollOut() {
            _stage.hotelDoor.gotoAndStop(1);
        }
        function petDoorRollOver() {
            _stage.petDoor.gotoAndStop(2);
        }
        function petDoorRollOut() {
            _stage.petDoor.gotoAndStop(1);
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
            _abductionDelegate = com.clubpenguin.util.Delegate.create(this, abductPenguin);
            _global.getCurrentAirtower().addListener("beamup", _abductionDelegate);
			_caveMineDigging = new com.clubpenguin.world.rooms.cavemine.CaveMineDigging(_stage, _SHELL, _ENGINE);
        }
        function abductPenguin(data) {
            var _local_4 = data[1];
            var _local_3 = _global.getCurrentEngine().getPlayerMovieClip(_local_4);
            _stage.attachMovie("TractorBeam", "tractorBeam_mc", _stage.getNextHighestDepth());
            _stage.tractorBeam_mc.swapDepths(_local_3);
            _stage.tractorBeam_mc._x = _local_3._x;
            _stage.tractorBeam_mc._y = _local_3._y - 1;
            aliendAbduction = new com.clubpenguin.world.rooms.aliens.AlienAbduction();
            aliendAbduction.abductPlayer(_local_4, _stage, this);
        }
        function abductedPlayerGoToUFO(player_id) {
            _stage.tractorBeam_mc.removeMovieClip();
            if (_SHELL.isMyPlayer(player_id)) {
                _global.getCurrentAirtower().removeListener("beamup", _abductionDelegate);
                _abductionDelegate = null;
                _SHELL.sendJoinRoom("ufo", 380, 320);
            }
        }
        function destroy() {
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            _global.getCurrentAirtower().removeListener("beamup", _abductionDelegate);
            _abductionDelegate = null;
        }
        static var CLASS_NAME = "Plaza";
        var UNDERGROUND_STAMP_ID = 10;
    }
