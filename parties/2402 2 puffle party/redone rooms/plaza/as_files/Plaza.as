//Created by Action Script Viewer - https://www.buraks.com/asv
    class as_files.Plaza extends com.clubpenguin.world.rooms.BaseRoom
    {
        var _stage, _SHELL, _currentParty, _abductionDelegate, _minuteCheckIntervalID, _currentTime, _currentMinute, _currentSecond, aliendAbduction, _destroyDelegate, localize, setupNavigationButtons, _ENGINE;
        function Plaza (stageReference) {
            super(stageReference);
            _stage.start_x = 325;
            _stage.start_y = 345;
            if (!_SHELL) {
                init();
            }
            _currentParty = _global.getCurrentParty().BaseParty.CURRENT_PARTY;
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
        function init() {
            _destroyDelegate = com.clubpenguin.util.Delegate.create(this, destroy);
            _SHELL.addListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            _stage.manhole_mc.manhole_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, manholeRollOver);
            _stage.manhole_mc.manhole_btn.onRollOut = com.clubpenguin.util.Delegate.create(this, manholeRollOut);
            localize([_stage.signs_mc, _stage.banner_clip, _stage.puffleparade_mc, _stage.adopt_mc, _stage.background_mc.back2_mc.cache1.petshop_all_mc.petshopsign_mc]);
            var _local_2 = 1;
            if (_currentParty.CONSTANTS.PARTY_DAY != undefined) {
                _local_2 = _local_2 + _currentParty.CONSTANTS.PARTY_DAY;
            }
            if (_local_2 >= 13) {
                _local_2 = 13;
            }
            _stage.banner_clip.banner_mc.gotoAndStop(_local_2);
            _stage.balloons1.gotoAndStop(_local_2);
            _stage.balloons2.gotoAndStop(_local_2);
            _stage.balloons3.gotoAndStop(_local_2);
            setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.forts_btn, 20, 260), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.nav_park, 100, 230), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.nav_petshop, 240, 240), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.nav_hotel, 350, 240), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.manhole_mc.manhole_btn, 310, 280), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.nav_mall01, 430, 230), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.nav_mall02, 530, 220), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.nav_pizza, 640, 250), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.nav_adopt, 603, 332), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.forest_btn, 760, 260)]);
            _stage.forts_btn.useHandCursor = false;
            _stage.forest_btn.useHandCursor = false;
            _stage.cannon_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, cannonAnimate);
            _stage.cannon_btn.useHandCursor = false;
            _stage.nav_park.onRollOver = com.clubpenguin.util.Delegate.create(this, parkRollOver);
            _stage.nav_park.onRollOut = com.clubpenguin.util.Delegate.create(this, parkRollOut);
            _stage.nav_petshop.onRollOver = com.clubpenguin.util.Delegate.create(this, petshopDoorRollOver);
            _stage.nav_petshop.onRollOut = com.clubpenguin.util.Delegate.create(this, petshopDoorRollOut);
            _stage.nav_hotel.onRollOver = com.clubpenguin.util.Delegate.create(this, hotelDoorRollOver);
            _stage.nav_hotel.onRollOut = com.clubpenguin.util.Delegate.create(this, hotelDoorRollOut);
            _stage.nav_mall02.onRollOver = com.clubpenguin.util.Delegate.create(this, mall02DoorRollOver);
            _stage.nav_mall02.onRollOut = com.clubpenguin.util.Delegate.create(this, mall02DoorRollOut);
            _stage.nav_mall01.onRollOver = com.clubpenguin.util.Delegate.create(this, mall01DoorRollOver);
            _stage.nav_mall01.onRollOut = com.clubpenguin.util.Delegate.create(this, mall01DoorRollOut);
            _stage.nav_pizza.onRollOver = com.clubpenguin.util.Delegate.create(this, pizzaDoorRollOver);
            _stage.nav_pizza.onRollOut = com.clubpenguin.util.Delegate.create(this, pizzaDoorRollOut);
            _stage.triggers_mc.forts_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "forts", 660, 260);
            _stage.triggers_mc.park_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "park", 335, 145);
            _stage.triggers_mc.pet_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "pet", 380, 210);
            _stage.triggers_mc.hotel_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "hotellobby", 380, 210);
            _stage.triggers_mc.cave_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "cave", 590, 307);
            _stage.triggers_mc.stage01_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "mall", 55, 219);
            _stage.triggers_mc.stage02_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "mall", 55, 219);
            _stage.triggers_mc.pizza_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "pizza", 365, 195);
            _stage.triggers_mc.forest_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "forest", 90, 325);
            _stage.triggers_mc.adopt_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, displayAdoptionUI);
			// STAGE STUFF
			configureStagePerformance();
			clearInterval(_minuteCheckIntervalID);
			_minuteCheckIntervalID = setInterval(com.clubpenguin.util.Delegate.create(this, updateTime), ONE_SECOND);
			_currentTime = fetchTime();
			_currentMinute = _currentTime.getMinutes();
			updateTime();
        }
        function displayAdoptionUI() {
            _global.getCurrentInterface().showContent(_currentParty.CONSTANTS.PUFFLE_ADOPTION_UI_PATH);
        }
        function cannonAnimate() {
            _stage.foreground_mc.cannonpuffle_mc.gotoAndPlay(2);
            _stage.background_mc.cannonsmoke_mc.gotoAndPlay(2);
            _stage.background_mc.cannon_mc.gotoAndPlay(2);
        }
        function moveToMouse() {
            _ENGINE.sendPlayerMove(_xmouse, _ymouse);
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
        function petshopDoorRollOver() {
            _stage.petdoor_mc.gotoAndStop(2);
        }
        function petshopDoorRollOut() {
            _stage.petdoor_mc.gotoAndStop(1);
        }
        function hotelDoorRollOver() {
            _stage.doorpethotel_mc.gotoAndStop(2);
        }
        function hotelDoorRollOut() {
            _stage.doorpethotel_mc.gotoAndStop(1);
        }
        function mall01DoorRollOver() {
            _stage.stage1_door_mc.gotoAndStop(2);
        }
        function mall01DoorRollOut() {
            _stage.stage1_door_mc.gotoAndStop(1);
        }
        function mall02DoorRollOver() {
            _stage.stage2_door_mc.gotoAndStop(2);
        }
        function mall02DoorRollOut() {
            _stage.stage2_door_mc.gotoAndStop(1);
        }
        function pizzaDoorRollOver() {
            _stage.pizzadoor_mc.gotoAndStop(2);
        }
        function pizzaDoorRollOut() {
            _stage.pizzadoor_mc.gotoAndStop(1);
        }
        function exit(name, x, y) {
            if (name == "cave") {
                _SHELL.stampEarned(UNDERGROUND_STAMP_ID);
            }
            _SHELL.sendJoinRoom(name, x, y);
        }
		// STAGE STUFF
		function fetchTime() {
            if (_SHELL == undefined) {
                return(new Date());
            } else {
                return(_SHELL.getPenguinStandardTime());
            }
        }
        function updateTime() {
            _currentTime.setTime(_currentTime.getTime() + ONE_SECOND);
            _currentMinute = _currentTime.getMinutes();
            _currentSecond = _currentTime.getSeconds();
            if ((((_currentMinute % 5) == 1) && (!_showing4MinsLeft)) && (!_playingShow)) {
                _showing4MinsLeft = true;
                showTimerBoard();
                _stage.puffleStage.showTimerComp.minuteDigit.numberOfMinutes.digit.text = "4";
                setTimerMinutesPlural(true);
            }
            if ((((_currentMinute % 5) == 2) && (!_showing3MinsLeft)) && (!_playingShow)) {
                _showing3MinsLeft = true;
                showTimerBoard();
                _stage.puffleStage.showTimerComp.minuteDigit.numberOfMinutes.digit.text = "3";
                setTimerMinutesPlural(true);
            }
            if ((((_currentMinute % 5) == 3) && (!_showing2MinsLeft)) && (!_playingShow)) {
                _showing2MinsLeft = true;
                showTimerBoard();
                _stage.puffleStage.showTimerComp.minuteDigit.numberOfMinutes.digit.text = "2";
                setTimerMinutesPlural(true);
            }
            if ((((_currentMinute % 5) == 4) && (!_showing1MinsLeft)) && (!_playingShow)) {
                _showing1MinsLeft = true;
                showTimerBoard();
                _stage.puffleStage.showTimerComp.minuteDigit.numberOfMinutes.digit.text = "1";
                setTimerMinutesPlural(false);
            }
            if (((_currentMinute % 5) == 0) && (!_playingShow)) {
                _playingShow = true;
                _showing1MinsLeft = false;
                _showing2MinsLeft = false;
                _showing3MinsLeft = false;
                _showing4MinsLeft = false;
                _stage.puffleStage.showTimerComp.minuteDigit.numberOfMinutes.digit.text = "0";
                setTimerMinutesPlural(true);
                startPerformanceAnimation();
            }
            if (_currentMinute != _currentTime.getMinutes()) {
                _currentMinute = _currentTime.getMinutes();
                _currentTime = fetchTime();
            }
        }
        function setTimerMinutesPlural(isPlural) {
            var _local_2 = "singular";
            if (isPlural) {
                _local_2 = "plural";
            }
            _stage.puffleStage.showTimerComp.nextShowIn.gotoAndStop(_local_2);
            localize([_stage.puffleStage.showTimerComp.nextShowIn.nextShowText]);
        }
        function showTimerBoard() {
            if (_stage.puffleStage.showTimerComp._currentframe < 40) {
                _stage.puffleStage.showTimerComp.gotoAndPlay(2);
            }
        }
        function configureStagePerformance() {
            _stage.puffleStage.showTimerComp.minuteDigit.numberOfMinutes.digit.text = "5";
            turnOffStageLighting();
        }
        function turnOffStageLighting() {
            _stage.puffleStage.platform.lighting.stageLighting.light1.gotoAndStop(1);
            _stage.puffleStage.platform.lighting.stageLighting.light2.gotoAndStop(1);
            _stage.puffleStage.platform.penguinBand.stageLightingFront.light1.gotoAndStop(1);
            _stage.puffleStage.platform.penguinBand.stageLightingFront.light2.gotoAndStop(1);
            _stage.puffleStage.platform.penguinBand.stageLightingBack.light1.gotoAndStop(1);
            _stage.puffleStage.platform.penguinBand.stageLightingBack.light2.gotoAndStop(1);
            _stage.puffleStage.platform.speakers.stageLighting.light1.gotoAndStop(1);
            _stage.puffleStage.platform.speakers.stageLighting.light2.gotoAndStop(1);
        }
        function turnOnStageLighting() {
            _stage.puffleStage.platform.lighting.stageLighting.light1.gotoAndPlay(2);
            _stage.puffleStage.platform.lighting.stageLighting.light2.gotoAndPlay(2);
            _stage.puffleStage.platform.penguinBand.stageLightingFront.light1.gotoAndPlay(2);
            _stage.puffleStage.platform.penguinBand.stageLightingFront.light2.gotoAndPlay(2);
            _stage.puffleStage.platform.penguinBand.stageLightingBack.light1.gotoAndPlay(2);
            _stage.puffleStage.platform.penguinBand.stageLightingBack.light2.gotoAndPlay(2);
            _stage.puffleStage.platform.speakers.stageLighting.light1.gotoAndPlay(2);
            _stage.puffleStage.platform.speakers.stageLighting.light2.gotoAndPlay(2);
        }
        function startPerformanceAnimation() {
            _stage.puffleStage.showTimerComp.gotoAndPlay(41);
            turnOnStageLighting();
            _stage.puffleStage.platform.stageAnimation.gotoAndPlay(2);
            _stage.puffleStage.platform.penguinBand.gotoAndPlay(2);
            _stage.puffleStage.platform.speakers.gotoAndPlay(2);
            _stage.puffleStage.platform.lighting.gotoAndPlay(2);
            _stage.puffleStage.platform.penguinBand.penguinBandAnimation.speaker1.gotoAndStop("on");
            _stage.puffleStage.platform.penguinBand.penguinBandAnimation.speaker2.gotoAndStop("on");
        }
        function stopPerformanceAnimation() {
            _playingShow = false;
            turnOffStageLighting();
            _stage.puffleStage.platform.stageAnimation.gotoAndPlay(170);
            _stage.puffleStage.platform.penguinBand.gotoAndPlay(170);
            _stage.puffleStage.platform.speakers.gotoAndPlay(170);
            _stage.puffleStage.platform.lighting.gotoAndPlay(170);
            _stage.puffleStage.platform.penguinBand.penguinBandAnimation.speaker1.gotoAndStop("off");
            _stage.puffleStage.platform.penguinBand.penguinBandAnimation.speaker2.gotoAndStop("off");
        }
		// END STAGE STUFF
        function destroy() {
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            _global.getCurrentAirtower().removeListener("beamup", _abductionDelegate);
            _abductionDelegate = null;
			// STAGE STUFF 2
			clearInterval(_minuteCheckIntervalID);
        }
		var _playingShow = false;
        var _showing1MinsLeft = false;
        var _showing2MinsLeft = false;
        var _showing3MinsLeft = false;
        var _showing4MinsLeft = false;
        static var CLASS_NAME = "Plaza";
        var UNDERGROUND_STAMP_ID = 10;
		var ONE_MINUTE = 60000;
        var ONE_SECOND = 1000;
    }
