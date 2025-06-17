//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2013.halloween.Forts extends com.clubpenguin.world.rooms.BaseRoom
    {
        var _stage, _SHELL, IS_24_HOUR_CLOCK, _destroyDelegate, _triggerWatcher, _now, _triggerWatcherInterval, _secondCheckIntervalID, _houseTrigger1, _houseTrigger2, _houseTrigger3, _houseTrigger4, setupNavigationButtons, localize, _ct_minutes, _ct_hours, _pm_trigger, _ct_day, _today;
        function Forts (stageReference) {
            super(stageReference);
            trace(CLASS_NAME + "()");
            _stage.start_x = 280;
            _stage.start_y = 285;
            if (!_SHELL) {
                init();
            }
        }
        function init() {
            IS_24_HOUR_CLOCK = _SHELL.getLanguageAbbreviation() == "de";
            trace(CLASS_NAME + ": init()");
            _destroyDelegate = com.clubpenguin.util.Delegate.create(this, destroy);
            _SHELL.addListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            _triggerWatcher = new com.clubpenguin.world.rooms.common.triggers.TriggerWatcher(_stage, _SHELL);
            configureNavigation();
            configureTriggers();
            configureRoomElements();
            if (_SHELL.getPenguinStandardTime != undefined) {
                _now = _SHELL.getPenguinStandardTime();
            } else {
                _now = new Date();
            }
            clearInterval(_triggerWatcherInterval);
            _triggerWatcherInterval = setInterval(_triggerWatcher, "checkAllPlayers", 40);
            _secondCheckIntervalID = setInterval(com.clubpenguin.util.Delegate.create(this, clockTimer), ONE_SECOND);
            clockTimer();
        }
        function configureTriggers() {
            _stage.triggers_mc.townTrigger_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "town", 710, 335);
            _stage.triggers_mc.rinkTrigger_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "rink", 380, 354);
            _stage.triggers_mc.plazaTrigger_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "plaza", 30, 295);
            _houseTrigger1 = new com.clubpenguin.world.rooms.common.triggers.PlayerTrigger(_stage.triggers_mc.house0Trigger);
            _houseTrigger1.playersAdded.add(com.clubpenguin.util.Delegate.create(this, houseCheck, 0));
            _houseTrigger1.playersRemoved.add(com.clubpenguin.util.Delegate.create(this, houseCheck, 0));
            _triggerWatcher.addTrigger(_houseTrigger1);
            _houseTrigger2 = new com.clubpenguin.world.rooms.common.triggers.PlayerTrigger(_stage.triggers_mc.house1Trigger);
            _houseTrigger2.playersAdded.add(com.clubpenguin.util.Delegate.create(this, houseCheck, 1));
            _houseTrigger2.playersRemoved.add(com.clubpenguin.util.Delegate.create(this, houseCheck, 1));
            _triggerWatcher.addTrigger(_houseTrigger2);
            _houseTrigger3 = new com.clubpenguin.world.rooms.common.triggers.PlayerTrigger(_stage.triggers_mc.house2Trigger);
            _houseTrigger3.playersAdded.add(com.clubpenguin.util.Delegate.create(this, houseCheck, 2));
            _houseTrigger3.playersRemoved.add(com.clubpenguin.util.Delegate.create(this, houseCheck, 2));
            _triggerWatcher.addTrigger(_houseTrigger3);
            _houseTrigger4 = new com.clubpenguin.world.rooms.common.triggers.PlayerTrigger(_stage.triggers_mc.house3Trigger);
            _houseTrigger4.playersAdded.add(com.clubpenguin.util.Delegate.create(this, houseCheck, 3));
            _houseTrigger4.playersRemoved.add(com.clubpenguin.util.Delegate.create(this, houseCheck, 3));
            _triggerWatcher.addTrigger(_houseTrigger4);
        }
        function configureNavigation() {
            setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.townNav_btn, 80, 135), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.rinkNav_btn, 218, 122), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.plazaNav_btn, 690, 110)]);
        }
        function configureRoomElements() {
            localize([_stage.house3.lang_G_mc, _stage.house3.lang_timezone_mc]);
            _stage.customPenguinSize = 80;
            _stage.background_mc.townNav_btn.useHandCursor = false;
            _stage.background_mc.rinkNav_btn.useHandCursor = false;
            _stage.background_mc.plazaNav_btn.useHandCursor = false;
            _stage.interface_mc.catalogue_Btn.onRelease = com.clubpenguin.util.Delegate.create(com.clubpenguin.world.rooms2013.halloween.HalloweenParty.instance, com.clubpenguin.world.rooms2013.halloween.HalloweenParty.instance.showPartyCatalogue);
        }
        function houseCheck(players, house) {
            trace(((((CLASS_NAME + ": houseCheck(players: ") + players) + ", house: ") + house) + ")");
            var _local_3 = this["_houseTrigger" + (house + 1)].getPlayerCount();
            if (_local_3 > 0) {
                if (houseStates[house] != HOUSE_STATE_OPEN) {
                    houseStates[house] = HOUSE_STATE_OPEN;
                    _stage["house" + house].door.gotoAndStop(HOUSE_STATE_OPEN);
                }
            } else if (houseStates[house] == HOUSE_STATE_OPEN) {
                houseStates[house] = HOUSE_STATE_CLOSE;
                _stage["house" + house].door.gotoAndStop(HOUSE_STATE_CLOSE);
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
                            _stage.house3.am_pm.text = "PM";
                        } else {
                            _stage.house3.am_pm.text = "AM";
                        }
                    } else {
                        _stage.house3.am_pm.text = "";
                    }
                    if (_ct_day != _now.getDay()) {
                        var _local_4;
                        _ct_day = _now.getDay();
                        _local_4 = _daysOfTheWeek[_ct_day];
                        _today = _SHELL.getLocalizedString(_local_4);
                    }
                }
                _stage.house3.day_txt.text = _today.toUpperCase();
                if (IS_24_HOUR_CLOCK) {
                    var _local_3 = new TextFormat();
                    _local_3.size = 10;
                    _stage.house3.day_txt.setTextFormat(_local_3);
                }
                if (_ct_minutes < 10) {
                    _stage.house3.clock_txt.text = (_ct_hours + ":0") + _ct_minutes;
                } else {
                    _stage.house3.clock_txt.text = (_ct_hours + ":") + _ct_minutes;
                }
            }
        }
        function exit(roomName, x, y) {
            trace(CLASS_NAME + ": exit()");
            _SHELL.sendJoinRoom(roomName, x, y);
        }
        function destroy() {
            trace(CLASS_NAME + ": destroy()");
            clearInterval(_triggerWatcherInterval);
            clearInterval(_secondCheckIntervalID);
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
        }
        static var CLASS_NAME = "Forts";
        static var ONE_SECOND = 1000;
        static var TARGET_STAMP_ID = 13;
        static var TARGET_STAMP_THRESHOLD = 10;
        var _daysOfTheWeek = ["sunday", "monday", "tuesday", "wednesday", "thursday", "friday", "saturday"];
        var _clockTargetHits = 0;
        static var HOUSES_AMOUNT = 4;
        static var HOUSE_STATE_PARK = "park";
        static var HOUSE_STATE_OPEN = "open";
        static var HOUSE_STATE_CLOSE = "close";
        var houseVisitors = [false, false, false, false];
        var houseStates = [HOUSE_STATE_PARK, HOUSE_STATE_PARK, HOUSE_STATE_PARK, HOUSE_STATE_PARK];
    }
