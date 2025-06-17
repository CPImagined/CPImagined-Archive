//Created by Action Script Viewer - https://www.buraks.com/asv
    class as_files.Forts extends com.clubpenguin.world.rooms.BaseRoom
    {
        var _stage, _SHELL, _cadenceSongIsPlaying, localize, setupNavigationButtons, IS_24_HOUR_CLOCK, _now, _secondCheckIntervalID, _destroyDelegate, _checkClockTagetDelegate, showContent, wem, _abductionDelegate, _minuteCheckIntervalID, _currentTime, _currentMinute, aliendAbduction, _ct_minutes, _ct_hours, _pm_trigger, _ct_day, _today, _musicTrack, _currentSecond, _INTERFACE, _playMusicIntervalID;
        function Forts (stageReference) {
            super(stageReference);
            _stage.start_x = 380;
            _stage.start_y = 285;
            if (!_SHELL) {
                init();
            }
        }
        function exit(name, x, y) {
            _SHELL.sendJoinRoom(name, x, y);
        }
        function init() {
            localize([_stage.clocktower.clocktext, _stage.foreground_mc.backstage_mc, _stage.puffleStage.showTimerComp.nextShowIn.nextShowText]);
            setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.town_btn, 25, 380), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.background2_mc.epicshow_mc.stagedoor_btn, 365, 146), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.plaza_btn, 735, 377), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.rink_btn, 210, 195), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.backstage_btn, 100, 260)]);
            _stage.background_mc.town_btn.useHandCursor = false;
            _stage.background_mc.plaza_btn.useHandCursor = false;
            _stage.triggers_mc.town_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "town", 675, 340);
            _stage.triggers_mc.plaza_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "plaza", 85, 315);
            _stage.triggers_mc.rink_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "rink", 380, 140);
			_stage.triggers_mc.party12_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "party12", 380, 380);
            _stage.triggers_mc.backstage_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "party11", 370, 255);
			_stage.triggers_mc.mascotTrigger_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, checkIfPlayerIsMascot, "party13", 150, 190);
            _stage.background_mc.backstage_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, backstageRollOver);
            _stage.background_mc.backstage_btn.onRollOut = com.clubpenguin.util.Delegate.create(this, backstageRollOut);
            _stage.background_mc.backstage_btn.onReleaseOutside = com.clubpenguin.util.Delegate.create(this, backstageRollOut);
            IS_24_HOUR_CLOCK = _SHELL.getLanguageAbbreviation() == "de";
            if (IS_24_HOUR_CLOCK) {
                _stage.clocktower.clock_txt._x = _stage.clocktower.clock_txt._x + 15;
            }
            if (_SHELL.getPenguinStandardTime != undefined) {
                _now = _SHELL.getPenguinStandardTime();
            } else {
                _now = new Date();
            }
            clearInterval(_secondCheckIntervalID);
            _secondCheckIntervalID = setInterval(com.clubpenguin.util.Delegate.create(this, clockTimer), ONE_SECOND);
            clockTimer();
            _destroyDelegate = com.clubpenguin.util.Delegate.create(this, destroy);
            _SHELL.addListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            _checkClockTagetDelegate = com.clubpenguin.util.Delegate.create(this, onSnowballLand);
            _SHELL.addListener(_SHELL.BALL_LAND, _checkClockTagetDelegate);
            showContent([new com.clubpenguin.world.rooms.common.PopupContentVO(_stage.clock_btn, true, "clock_help", "")]);
            wem = new com.clubpenguin.world.rooms.weathereffects.WeatherEffectsManager(_SHELL, _stage.background_mc);
            wem.setupFireAnimationHeight(25);
            wem.setupRainAnimationHeight(35);
            wem.setupSnowAnimationHeight(35);
            wem.setupRainAnimationSpeed(0.3);
            wem.setupSnowAnimationSpeed(0.6);
            wem.setupRainDelayTime(2);
            wem.setupSnowDelayTime(2);
            wem.startWeatherEffectCheck();
            _abductionDelegate = com.clubpenguin.util.Delegate.create(this, abductPenguin);
            _global.getCurrentAirtower().addListener("beamup", _abductionDelegate);
            configureStagePerformance();
            clearInterval(_minuteCheckIntervalID);
            _minuteCheckIntervalID = setInterval(com.clubpenguin.util.Delegate.create(this, updateTime), ONE_SECOND);
            _currentTime = fetchTime();
            _currentMinute = _currentTime.getMinutes();
            updateTime();
        }
        function checkIfPlayerIsMascot(roomName, x, y) {
            if (_SHELL.isPlayerMascotById(_SHELL.getMyPlayerId())) {
                _SHELL.sendJoinRoom(roomName, x, y);
            }
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
        function clockTimer() {
            var _local_6 = 0;
            var _local_5 = 11;
            var _local_2 = 12;
            _now.setTime(_now.getTime() + ONE_SECOND);
            if (_ct_minutes != _now.getMinutes()) {
                _ct_minutes = _now.getMinutes();
                if (_ct_hours != _now.getMinutes()) {
                    _ct_hours = _now.getHours();
                    if (_ct_hours > _local_5) {
                        _pm_trigger = true;
                        if ((_ct_hours > _local_2) && (!IS_24_HOUR_CLOCK)) {
                            _ct_hours = _ct_hours - _local_2;
                        }
                    } else {
                        _pm_trigger = false;
                        if ((_ct_hours == _local_6) && (!IS_24_HOUR_CLOCK)) {
                            _ct_hours = _local_2;
                        }
                    }
                    if (!IS_24_HOUR_CLOCK) {
                        if (_pm_trigger) {
                            _stage.clocktower.am_pm.text = "PM";
                        } else {
                            _stage.clocktower.am_pm.text = "AM";
                        }
                    } else {
                        _stage.clocktower.am_pm.text = "";
                    }
                    if (_ct_day != _now.getDay()) {
                        var _local_4;
                        _ct_day = _now.getDay();
                        _local_4 = _daysOfTheWeek[_ct_day];
                        _today = _SHELL.getLocalizedString(_local_4);
                    }
                }
                _stage.clocktower.day_mc.label_txt.text = _today.toUpperCase();
                if (IS_24_HOUR_CLOCK) {
                    var _local_3 = new TextFormat();
                    _local_3.size = 10;
                    _stage.clocktower.day_txt.setTextFormat(_local_3);
                }
                if (_ct_minutes < 10) {
                    _stage.clocktower.clock_txt.text = (_ct_hours + ":0") + _ct_minutes;
                } else {
                    _stage.clocktower.clock_txt.text = (_ct_hours + ":") + _ct_minutes;
                }
            }
        }
        function backstageRollOver() {
            _stage.background_mc.idolDoor_mc.gotoAndStop(2);
        }
        function backstageRollOut() {
            _stage.background_mc.idolDoor_mc.gotoAndStop(1);
        }
        function onSnowballLand(snowballInfo) {
            if (_stage.clocktower.tower.target.target.hitTest(snowballInfo.x, snowballInfo.y, true)) {
                _stage.clocktower.tower.play();
                _stage.clocktower.tower.target.play();
                _stage.clocktower.tower.play();
                snowballInfo.snowballMC._visible = false;
                _clockTargetHits++;
                if (_clockTargetHits >= TARGET_STAMP_THRESHOLD) {
                    _clockTargetHits = 0;
                    _SHELL.stampEarned(TARGET_STAMP_ID);
                }
            }
        }
        function loadExternalMusic(url) {
            _musicTrack = new Sound();
            _musicTrack.onLoad = com.clubpenguin.util.Delegate.create(this, onMusicTrackLoaded);
            _musicTrack.onSoundComplete = com.clubpenguin.util.Delegate.create(this, stopPerformanceAnimation);
            _musicTrack.loadSound(url, true);
        }
        function onMusicTrackLoaded(success) {
            if (success) {
                _musicTrack.stop();
                startPerformanceAnimation();
            }
        }
        function fetchTime() {
            if (_SHELL == undefined) {
                return(new Date());
            } else {
                return(_SHELL.getPenguinStandardTime());
            }
        }
		function updateCountdownTime() {
            var _local_4 = _SHELL.getPenguinStandardTime();
            var _local_7 = ((_local_4.getHours() * 3600) + (_local_4.getMinutes() * 60)) + _local_4.getSeconds();
            var _local_3 = _local_7 % 1251;
            if ((_local_3 < 51) && ((_cadenceSongIsPlaying == undefined) || (_cadenceSongIsPlaying == false))) {
                _cadenceSongIsPlaying = true;
                _stage.countdown_mc.countdown_clock_txt.text = "";
                _stage.countdown_mc.concert_arrow._visible = true;
                _stage.background_mc.background2_mc.backlights1._visible = true;
                _stage.background_mc.background2_mc.backlights2._visible = true;
                _stage.background_mc.background2_mc.backlights3._visible = true;
                _stage.background_mc.background2_mc.backlights4._visible = true;
                _stage.background_mc.background2_mc.backlights1.play();
                _stage.background_mc.background2_mc.backlights2.play();
                _stage.background_mc.background2_mc.backlights3.play();
                _stage.background_mc.background2_mc.backlights4.play();
            } else if ((_local_3 > 51) && ((_cadenceSongIsPlaying == undefined) || (_cadenceSongIsPlaying == true))) {
                _cadenceSongIsPlaying = false;
                _stage.countdown_mc.concert_arrow._visible = false;
                _stage.background_mc.background2_mc.backlights1._visible = false;
                _stage.background_mc.background2_mc.backlights2._visible = false;
                _stage.background_mc.background2_mc.backlights3._visible = false;
                _stage.background_mc.background2_mc.backlights4._visible = false;
                _stage.background_mc.background2_mc.backlights1.stop();
                _stage.background_mc.background2_mc.backlights2.stop();
                _stage.background_mc.background2_mc.backlights3.stop();
                _stage.background_mc.background2_mc.backlights4.stop();
            }
            if (!_cadenceSongIsPlaying) {
                var _local_5 = 1251 - _local_3;
                var _local_6 = Math.floor(_local_5 / 60);
                var _local_2 = _local_5 % 60;
                _stage.countdown_mc.concert_arrow.visible = false;
                if (_local_2 < 10) {
                    _stage.countdown_mc.countdown_clock_txt.text = (_local_6 + ":0") + _local_2;
                } else {
                    _stage.countdown_mc.countdown_clock_txt.text = (_local_6 + ":") + _local_2;
                }
            }
        }
        function updateTime() {
			updateCountdownTime();
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
                _stage.puffleStage.showTimerComp.minuteDigit.numberOfMinutes.digit.text = "5";
                setTimerMinutesPlural(true);
                var _local_2 = (_currentMinute / 5) + 1;
                if (_local_2 > TOTAL_MUSIC_TRACKS) {
                    _local_2 = _local_2 - TOTAL_MUSIC_TRACKS;
                }
                loadExternalMusic(_SHELL.getPath("w.app.music.forts.stage.track" + _local_2));
            }
            if (((_currentMinute % 20) == 1) && (_currentSecond == 13)) {
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
        function firePyro() {
            _stage.foreground_mc.pyro.gotoAndPlay(2);
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
            _stage.puffleStage.platform.penguinBand.penguinBandAnimation.band1.gotoAndStop("playing");
            _stage.puffleStage.platform.penguinBand.penguinBandAnimation.band2.gotoAndStop("playing");
            _stage.puffleStage.platform.penguinBand.penguinBandAnimation.band3.gotoAndStop("playing");
            _stage.puffleStage.platform.penguinBand.penguinBandAnimation.band4.gotoAndStop("playing");
            _stage.puffleStage.platform.penguinBand.penguinBandAnimation.band5.gotoAndStop("playing");
        }
        function collectedPenguinBandItem() {
            _INTERFACE.buyInventory(_global.getCurrentParty().FairParty.CONSTANTS.PENGUIN_BAND_ITEM);
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
            _stage.puffleStage.platform.penguinBand.penguinBandAnimation.band1.gotoAndPlay("waving");
            _stage.puffleStage.platform.penguinBand.penguinBandAnimation.band2.gotoAndPlay("waving");
            _stage.puffleStage.platform.penguinBand.penguinBandAnimation.band3.gotoAndPlay("waving");
            _stage.puffleStage.platform.penguinBand.penguinBandAnimation.band4.gotoAndPlay("waving");
            _stage.puffleStage.platform.penguinBand.penguinBandAnimation.band5.gotoAndPlay("waving");
        }
        function destroy() {
            clearInterval(_secondCheckIntervalID);
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            _SHELL.removeListener(_SHELL.BALL_LAND, _checkClockTagetDelegate);
            _musicTrack.stop();
            _musicTrack = new Sound();
            clearInterval(_playMusicIntervalID);
            clearInterval(_minuteCheckIntervalID);
            wem.destroy();
            _global.getCurrentAirtower().removeListener("beamup", _abductionDelegate);
            _abductionDelegate = null;
        }
        static var CLASS_NAME = "Forts";
        var ONE_MINUTE = 60000;
        static var ONE_SECOND = 1000;
        static var TARGET_STAMP_ID = 13;
        static var TARGET_STAMP_THRESHOLD = 10;
        var TOTAL_MUSIC_TRACKS = 9;
        var _playingShow = false;
        var _showing1MinsLeft = false;
        var _showing2MinsLeft = false;
        var _showing3MinsLeft = false;
        var _showing4MinsLeft = false;
        var _daysOfTheWeek = ["sunday", "monday", "tuesday", "wednesday", "thursday", "friday", "saturday"];
        var _clockTargetHits = 0;
    }
