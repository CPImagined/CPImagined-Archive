//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2015.september2.Plaza extends com.clubpenguin.world.rooms.BaseRoom
    {
        var _stage, localize, setupNavigationButtons, _SHELL, _destroyDelegate, _INTERFACE;
        function Plaza (stageReference) {
            super(stageReference);
            _stage.start_x = 390;
            _stage.start_y = 315;
            localize([_stage.petSign, _stage.hotelSign, _stage.mallSign, _stage.pizzaSign, _stage.background_mc.parkGate.gateOn.signText, _stage.background_mc.parkGate.gateOff.signText, _stage.foreground_mc.annBanner_mc]);
            setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.forts_btn, 30, 275), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.park_btn, 108, 243), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.pet_btn, 204, 250), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.hotel_btn, 331, 243), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.manhole_mc.manhole_btn, 276, 283), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.stage02_btn, 474, 243), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.pizza_btn, 610, 259), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.forest_btn, 740, 356), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.buoy_mc.buoy_btn, 178, 423), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.shack_btn, 715, 232)]);
            _stage.forts_btn.useHandCursor = false;
            _stage.forest_btn.useHandCursor = false;
            _stage.tickets_btn.useHandCursor = false;
            _stage.motor_btn.useHandCursor = false;
            _stage.manhole_mc.manhole_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, manholeRollOver);
            _stage.manhole_mc.manhole_btn.onRollOut = com.clubpenguin.util.Delegate.create(this, manholeRollOut);
            _stage.park_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, parkRollOver);
            _stage.park_btn.onRollOut = com.clubpenguin.util.Delegate.create(this, parkRollOut);
            _stage.pizza_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, pizzaDoorRollOver);
            _stage.pizza_btn.onRollOut = com.clubpenguin.util.Delegate.create(this, pizzaDoorRollOut);
            _stage.stage02_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, mallDoorRollOver);
            _stage.stage02_btn.onRollOut = com.clubpenguin.util.Delegate.create(this, mallDoorRollOut);
            _stage.hotel_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, hotelDoorRollOver);
            _stage.hotel_btn.onRollOut = com.clubpenguin.util.Delegate.create(this, hotelDoorRollOut);
            _stage.pet_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, petDoorRollOver);
            _stage.pet_btn.onRollOut = com.clubpenguin.util.Delegate.create(this, petDoorRollOut);
            _stage.triggers_mc.forts_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "forts", 604, 267);
            _stage.triggers_mc.pet_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "pet", 380, 210);
            _stage.triggers_mc.hotel_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "hotellobby", 380, 210);
            _stage.triggers_mc.cave_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "cave", 590, 307);
            _stage.triggers_mc.stage01_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "mall", 147, 366);
            _stage.triggers_mc.pizza_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "pizza", 419, 243);
            _stage.triggers_mc.surf_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "party3", 365, 330);
            _stage.triggers_mc.shack_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "shack", 200, 330);
            _stage.triggers_mc.forest_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "forest", 125, 280);
            _stage.triggers_mc.park_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "park", 331, 150);
            _stage.interface_mc.catalogue_btn.onRelease = com.clubpenguin.util.Delegate.create(this, catalogOpen);
        }
		function catalogOpen() {
			_INTERFACE.showContent("party_catalogue");
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
        function robotRollOver() {
            _stage.annStand_mc.robot_mc.gotoAndStop("rollOver");
        }
        function robotRollOut() {
            _stage.annStand_mc.robot_mc.gotoAndStop("rollOut");
        }
        function robotRelease() {
            var _local_2 = _global.getCurrentParty().BaseParty.CURRENT_PARTY;
            _local_2.invokeRobotPopup(_local_2.CONSTANTS.ROOKIE1_PROMPT_PATH);
            com.clubpenguin.world.rooms2015.september2.party.September2Party.sendNpcClickBI("Rookie", "plaza");
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
