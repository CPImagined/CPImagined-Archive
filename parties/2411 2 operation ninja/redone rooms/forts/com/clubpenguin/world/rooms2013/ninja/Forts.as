//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2013.ninja.Forts extends com.clubpenguin.world.rooms.BaseRoom
    {
        var _stage, _SHELL, localize, setupNavigationButtons, IS_24_HOUR_CLOCK, _now, _secondCheckIntervalID, _INTERFACE, _destroyDelegate, _checkClockTagetDelegate, showContent, wem, _ct_minutes, _ct_hours, _pm_trigger, _ct_day, _today;
        function Forts (stageReference) {
            super(stageReference);
            _stage.start_x = 380;
            _stage.start_y = 285;
        }
        function exit(name, x, y) {
            _SHELL.sendJoinRoom(name, x, y);
        }
        function init() {
            localize([_stage.background_mc.fire_mc.firefightsign_mc, _stage.background_mc.water_mc.waterfightsign_mc, _stage.background_mc.gate_mc.gatesign_mc, _stage.background_mc.backgroundbit_mc.textall_mc, _stage.clocktower.clocktext, _stage.clocktower.lang_timezone_mc]);
            setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.town_btn, 75, 245), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.rink_btn, 270, 190), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.plaza_btn, 695, 205)]);
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
            _stage.background_mc.town_btn.useHandCursor = false;
            _stage.background_mc.rink_btn.useHandCursor = false;
            _stage.background_mc.plaza_btn.useHandCursor = false;
            _stage.interface_mc.party_cat_btn.onRelease = com.clubpenguin.util.Delegate.create(_INTERFACE, _INTERFACE.showContent, "party_catalogue");
            _stage.triggers_mc.town_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "town", 660, 325);
            _stage.triggers_mc.senseirink_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "rink", 380, 130);
            _stage.triggers_mc.rink_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "rink", 380, 220);
            _stage.triggers_mc.plaza_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "plaza", 130, 340);
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
            if (_stage.clocktower.tower.target.hitTest(snowballInfo.x, snowballInfo.y, true)) {
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
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            _SHELL.removeListener(_SHELL.BALL_LAND, _checkClockTagetDelegate);
            wem.destroy();
        }
        static var CLASS_NAME = "Forts";
        static var ONE_SECOND = 1000;
        static var TARGET_STAMP_ID = 13;
        static var TARGET_STAMP_THRESHOLD = 10;
        var _daysOfTheWeek = ["sunday", "monday", "tuesday", "wednesday", "thursday", "friday", "saturday"];
        var _clockTargetHits = 0;
    }
