//Created by Action Script Viewer - https://www.buraks.com/asv
    class as_files.Town extends com.clubpenguin.world.rooms.BaseRoom
    {
        var _stage, _SHELL, _currentParty, _minuteCheckIntervalID, _currentTime, _currentMinute, _currentSecond, _abductionDelegate, aliendAbduction, _destroyDelegate, localize, setupNavigationButtons, _ENGINE, _INTERFACE;
        function Town (stageReference) {
            super(stageReference);
            _stage.start_x = 355;
            _stage.start_y = 310;
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
            localize([_stage.signs_mc, _stage.adopt_mc]);
            var _local_2 = 1 + Number(_currentParty.CONSTANTS.PARTY_DAY);
            if (_local_2 >= 13) {
                _local_2 = 13;
            }
            _stage.signs_mc.partyBanner.gotoAndStop(_local_2);
            _stage.balloons1.gotoAndStop(_local_2);
            _stage.balloons2.gotoAndStop(_local_2);
            _stage.balloons3.gotoAndStop(_local_2);
            _stage.balloons4.gotoAndStop(_local_2);
            setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.dock_btn, 80, 285), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.coffee_btn, 265, 225), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.dance_btn, 390, 215), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.shop_btn, 530, 240), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.nav_adopt, 225, 297), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.forts_btn, 690, 270)]);
            _stage.dock_btn.useHandCursor = false;
            _stage.forts_btn.useHandCursor = false;
            _stage.coffee_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, coffeeRollOver);
            _stage.coffee_btn.onRollOut = com.clubpenguin.util.Delegate.create(this, coffeeRollOut);
            _stage.dance_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, danceRollOver);
            _stage.dance_btn.onRollOut = com.clubpenguin.util.Delegate.create(this, danceRollOut);
            _stage.shop_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, shopRollOver);
            _stage.shop_btn.onRollOut = com.clubpenguin.util.Delegate.create(this, shopRollOut);
            _stage.triggers_mc.dock_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "dock", 570, 165);
            _stage.triggers_mc.coffee_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "coffee", 360, 180);
            _stage.triggers_mc.dance_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "dance", 170, 270);
            _stage.triggers_mc.shop_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "shop", 650, 220);
            _stage.triggers_mc.forts_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "forts", 70, 215);
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
        function danceRollOver() {
            _stage.background_mc.nightclub_mc.clubinside_mc.dance_door.gotoAndStop(2);
        }
        function danceRollOut() {
            _stage.background_mc.nightclub_mc.clubinside_mc.dance_door.gotoAndStop(1);
        }
        function coffeeRollOver() {
            _stage.background_mc.coffee_door.gotoAndStop(2);
        }
        function coffeeRollOut() {
            _stage.background_mc.coffee_door.gotoAndStop(1);
        }
        function shopRollOver() {
            _stage.background_mc.giftshop_mc.giftinside_mc.shop_door.gotoAndStop(2);
        }
        function shopRollOut() {
            _stage.background_mc.giftshop_mc.giftinside_mc.shop_door.gotoAndStop(1);
        }
        function moveToMouse() {
            _ENGINE.sendPlayerMove(_xmouse, _ymouse);
        }
        function showContent(contentID) {
            _INTERFACE.showContent(contentID);
        }
        function exit(name, x, y) {
            if (_SHELL.isNewPlayerExperienceRunning == false) {
                _SHELL.sendJoinRoom(name, x, y);
            }
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
        function updateItemBoothState() {
            _global.getCurrentParty().PuffleParty.configureItemBooth(_stage.boothContainer_mc);
        }
        static var CLASS_NAME = "Town";
		var _playingShow = false;
        var _showing1MinsLeft = false;
        var _showing2MinsLeft = false;
        var _showing3MinsLeft = false;
        var _showing4MinsLeft = false;
		var ONE_MINUTE = 60000;
        var ONE_SECOND = 1000;
    }
