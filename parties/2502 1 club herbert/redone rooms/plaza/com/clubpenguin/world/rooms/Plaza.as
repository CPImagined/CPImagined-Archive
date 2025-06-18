//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms.Plaza extends com.clubpenguin.world.rooms.BaseRoom
    {
        var _stage, _SHELL, localize, setupNavigationButtons, _destroyDelegate, _abductionDelegate, aliendAbduction;
        function Plaza (stageReference) {
            super(stageReference);
            _stage.start_x = 380;
            _stage.start_y = 350;
            if (!_SHELL) {
                init();
            }
            //localize([_stage.petSign, _stage.hotelSign, _stage.mallSign, _stage.pizzaSign, _stage.background_mc.parkGate.gateOn.signText, _stage.background_mc.parkGate.gateOff.signText]);
            setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.forts_btn, 35, 290), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.epf_mc.door_btn, 508, 380), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.park_btn, 85, 265), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.pet_btn, 213, 245), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.hotel_btn, 330, 237), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.manhole_mc.manhole_btn, 270, 270), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.mall_btn, 468, 235), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.pizza_btn, 627, 245), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.forest_btn, 730, 295)]);
            _stage.background_mc.forts_btn.useHandCursor = false;
            _stage.background_mc.forest_btn.useHandCursor = false;
			_stage.epf_mc.epf_btn.onRelease = com.clubpenguin.util.Delegate.create(this, epfTube);
			_stage.epf_mc.door_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, epfRollOver);
            _stage.epf_mc.door_btn.onRollOut = com.clubpenguin.util.Delegate.create(this, epfRollOut);
            _stage.background_mc.park_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, parkRollOver);
            _stage.background_mc.park_btn.onRollOut = com.clubpenguin.util.Delegate.create(this, parkRollOut);
            _stage.manhole_mc.manhole_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, manholeRollOver);
            _stage.manhole_mc.manhole_btn.onRollOut = com.clubpenguin.util.Delegate.create(this, manholeRollOut);
            _stage.triggers_mc.forts_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "forts", 655, 235);
            _stage.triggers_mc.park_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "park", 335, 145);
            _stage.triggers_mc.pet_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "pet", 380, 210);
            _stage.triggers_mc.hotel_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "hotellobby", 380, 210);
            _stage.triggers_mc.cave_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "cave", 590, 307);
            _stage.triggers_mc.mall_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "mall", 150, 370);
            _stage.triggers_mc.pizza_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "pizza", 365, 195);
            _stage.triggers_mc.forest_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "forest", 135, 215);
			_stage.triggers_mc.epf_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "party7", 490, 110);
        }
		function epfTube() {
			if (_stage.epf_mc._currentframe == 1) {
				_stage.epf_mc.gotoAndPlay(2);
			} else if (_stage.epf_mc._currentframe == 14) {
				_stage.epf_mc.gotoAndPlay(15);
			};
		}
		function epfRollOver() {
			_stage.epf_mc.door1_mc.gotoAndPlay(2);
			_stage.epf_mc.platform1_mc.gotoAndPlay(2);
		}
		function epfRollOut() {
			_stage.epf_mc.door1_mc.gotoAndPlay(9);
			_stage.epf_mc.platform1_mc.gotoAndPlay(13);
		}
        function manholeRollOver() {
            _stage.manhole_mc.gotoAndPlay("lidOpen");
        }
        function manholeRollOut() {
            _stage.manhole_mc.gotoAndPlay("lidClose");
        }
        function parkRollOver() {
            _stage.background_mc.snow_mc.snow_mc.gate_mc.gotoAndStop(2);
        }
        function parkRollOut() {
            _stage.background_mc.snow_mc.snow_mc.gate_mc.gotoAndStop(1);
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
