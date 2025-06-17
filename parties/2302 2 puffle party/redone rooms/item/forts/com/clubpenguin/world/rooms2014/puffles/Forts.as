//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2014.puffles.Forts extends com.clubpenguin.world.rooms.BaseRoom
    {
        var _stage, _SHELL, _INTERFACE, localize, setupNavigationButtons, IS_24_HOUR_CLOCK, _now, _secondCheckIntervalID, _destroyDelegate, _checkClockTagetDelegate, showContent, wem, _triggerWatcher, _triggerWatcherInterval, _ct_minutes, _ct_hours, _pm_trigger, _ct_day, _today, _bedStation1, _bedStation2, _bedStationTrigger1, _bedStationTrigger2;
        function Forts (stageReference) {
            super(stageReference);
            trace(CLASS_NAME + "()");
            _stage.start_x = 380;
            _stage.start_y = 285;
            if (!_SHELL) {
                init();
            }
        }
        function exit(name, x, y) {
            trace(CLASS_NAME + ": exit()");
            _SHELL.sendJoinRoom(name, x, y);
        }
        function init() {
            trace("Hello");
            _stage.triggers_mc.booth_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, openQuestInterface);
            setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.town_btn, 60, 205), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.foreground_mc.treeIgloo_btn, 160, 125), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.rink_btn, 295, 150), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.plaza_btn, 705, 195), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.bed01_btn, 118, 390), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.boothContainer_mc.booth_btn, 575, 350), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.bed02_btn, 605, 97)]);
            IS_24_HOUR_CLOCK = _SHELL.getLanguageAbbreviation() == "de";
            if (IS_24_HOUR_CLOCK) {
                _stage.clocktower.clock_txt._x = _stage.clocktower.clock_txt._x + 15;
            }
            trace(CLASS_NAME + ": init()");
            if (_SHELL.getPenguinStandardTime != undefined) {
                _now = _SHELL.getPenguinStandardTime();
            } else {
                _now = new Date();
            }
            clearInterval(_secondCheckIntervalID);
            _secondCheckIntervalID = setInterval(com.clubpenguin.util.Delegate.create(this, clockTimer), ONE_SECOND);
            clockTimer();
            _stage.town_btn.useHandCursor = false;
            _stage.rink_btn.useHandCursor = false;
            _stage.plaza_btn.useHandCursor = false;
            _stage.bed01_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, bed01RollOver);
            _stage.bed01_btn.onRollOut = com.clubpenguin.util.Delegate.create(this, bed01RollOut);
            _stage.bed01_btn.onReleaseOutside = com.clubpenguin.util.Delegate.create(this, bed01RollOut);
            _stage.bed02_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, bed02RollOver);
            _stage.bed02_btn.onRollOut = com.clubpenguin.util.Delegate.create(this, bed02RollOut);
            _stage.bed02_btn.onReleaseOutside = com.clubpenguin.util.Delegate.create(this, bed02RollOut);
            _stage.triggers_mc.town_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "town", 660, 325);
            _stage.triggers_mc.rink_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "rink", 380, 135);
            _stage.triggers_mc.plaza_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "plaza", 85, 330);
            _stage.triggers_mc.igloos_mc.triggerFunction = com.clubpenguin.util.Delegate.create(com.clubpenguin.world.rooms2014.puffles.PuffleParty, com.clubpenguin.world.rooms2014.puffles.PuffleParty.showIglooList);
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
            _triggerWatcher = new com.clubpenguin.world.rooms.common.triggers.TriggerWatcher(_stage, _SHELL);
            clearInterval(_triggerWatcherInterval);
            _triggerWatcherInterval = setInterval(_triggerWatcher, "checkAllPlayers", 40);
            configureBedStationTriggers();
        }
		function openQuestInterface() {
			_INTERFACE.showContent("w.app.p2014.itembooth");
		}
        function bed01RollOver() {
            _stage.foreground_mc.bed01Front_mc.gotoAndStop("rollOver");
            _stage.bed01Back_mc.gotoAndStop("rollOver");
        }
        function bed01RollOut() {
            _stage.foreground_mc.bed01Front_mc.gotoAndStop("rollOut");
            _stage.bed01Back_mc.gotoAndStop("rollOut");
        }
        function bed02RollOver() {
            _stage.bed02Front_mc.gotoAndStop("rollOver");
            _stage.background_mc.bed02Back_mc.gotoAndStop("rollOver");
        }
        function bed02RollOut() {
            _stage.bed02Front_mc.gotoAndStop("rollOut");
            _stage.background_mc.bed02Back_mc.gotoAndStop("rollOut");
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
        function onSnowballLand(snowballInfo) {
            trace(CLASS_NAME + ": handleThrow()");
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
        function destroy() {
            clearInterval(_secondCheckIntervalID);
            trace(CLASS_NAME + ": destroy()");
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            _SHELL.removeListener(_SHELL.BALL_LAND, _checkClockTagetDelegate);
            wem.destroy();
        }
        function updateItemBoothState() {
            trace("updating item booth state in room");
            _global.getCurrentParty().PuffleParty.configureItemBooth(_stage.boothContainer_mc);
        }
        function configureBedStationTriggers() {
            var _local_3 = new com.clubpenguin.world.rooms.hotel.hotelcarestations.HotelCareSound("snoringLoopSFX", _stage.bed01Back_mc);
            var _local_2 = new com.clubpenguin.world.rooms.hotel.hotelcarestations.HotelCareStationVO();
            _local_2.taskEnum = SLEEPING_TASK;
            _local_2.puffleFrame = SLEEP_FRAME;
            _local_2.careSound = _local_3;
            _bedStation1 = new com.clubpenguin.world.rooms.hotel.hotelcarestations.HotelCareStation(_local_2);
            _bedStation2 = new com.clubpenguin.world.rooms.hotel.hotelcarestations.HotelCareStation(_local_2);
            _bedStation1.stationBIInfo("puffleparty_bed", com.clubpenguin.engine.puffles.pufflecarestations.PuffleCareStationsConstants.PUFFLE_SLEEP_STATION);
            _bedStation2.stationBIInfo("puffleparty_bed", com.clubpenguin.engine.puffles.pufflecarestations.PuffleCareStationsConstants.PUFFLE_SLEEP_STATION);
            configureStationTrigger(_bedStation1, _bedStationTrigger1, _stage.triggers_mc.bedStation01_mc);
            configureStationTrigger(_bedStation2, _bedStationTrigger2, _stage.triggers_mc.bedStation02_mc);
        }
        function configureStationTrigger(careStation, playerTrigger, triggerClip) {
            playerTrigger = new com.clubpenguin.world.rooms.common.triggers.PlayerTrigger(triggerClip);
            playerTrigger.playersAdded.add(com.clubpenguin.util.Delegate.create(careStation, careStation.beginActivity));
            playerTrigger.playersRemoved.add(com.clubpenguin.util.Delegate.create(careStation, careStation.endActivity));
            _triggerWatcher.addTrigger(playerTrigger);
        }
        static var CLASS_NAME = "Forts";
        static var ONE_SECOND = 1000;
        static var TARGET_STAMP_ID = 13;
        static var TARGET_STAMP_THRESHOLD = 10;
        var _daysOfTheWeek = ["sunday", "monday", "tuesday", "wednesday", "thursday", "friday", "saturday"];
        var _clockTargetHits = 0;
        static var SLEEPING_TASK = com.clubpenguin.world.rooms.hotel.hotelcarestations.HotelCareTaskEnum.SLEEPING_TASK;
        static var SLEEP_FRAME = com.clubpenguin.puffleavatar.PuffleAvatarConstants.PUFFLE_SLEEP_FRAME;
    }
