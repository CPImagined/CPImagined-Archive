//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2013.teenbeach.Forts extends com.clubpenguin.world.rooms.BaseRoom
    {
        var _stage, _SHELL, localize, setupNavigationButtons, IS_24_HOUR_CLOCK, _now, _secondCheckIntervalID, _destroyDelegate, _ct_minutes, _ct_hours, _pm_trigger, _ct_day, _today, _checkClockTagetDelegate, _countdownIntervalId, wem, _concertCountdownTimer, _INTERFACE;
        function Forts (stageReference) {
            super(stageReference);
            _stage.start_x = 445;
            _stage.start_y = 275;
            if (!_SHELL) {
                init();
            }
        }
        function exit(name, x, y) {
            _SHELL.sendJoinRoom(name, x, y);
        }
        function init() {
            com.clubpenguin.world.rooms2013.teenbeach.TeenBeachParty.instance.configureItemHut(CLASS_NAME.toLowerCase(), _stage.itemHut_mc);
            _stage.interface_mc.catalogue_btn.onRelease = com.clubpenguin.util.Delegate.create(this, catalogOpen);
            com.clubpenguin.world.rooms2013.teenbeach.TeenBeachParty.instance.countdownSignal.add(initConcertCountdown, this);
            localize([_stage.clocktower.clocktext, _stage.mamasign2_mc, _stage.mama_mc.sign5_mc.text5_mc]);
            setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.town_btn, 75, 245), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.buoy_mc.buoy_btn, 120, 405), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.rink_btn, 270, 190), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.mama_mc.mama_btn, 390, 190), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.member2_mc.member2_btn, 575, 180), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.itemHut_mc.itemHut_btn, 630, 400), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.plaza_btn, 695, 205)]);
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
            _stage.triggers_mc.town_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "town", 650, 265);
            _stage.triggers_mc.rink_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "rink", 620, 385);
            _stage.triggers_mc.mama_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "party1", 375, 370);
            _stage.triggers_mc.member_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, goBackStage);
            _stage.triggers_mc.surf_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "party3", 365, 330);
            _stage.triggers_mc.motor_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "party4", 365, 330);
            _stage.triggers_mc.plaza_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "plaza", 85, 330);
            _stage.triggers_mc.itemHutTrigger_mc.triggerFunction = com.clubpenguin.util.Delegate.create(com.clubpenguin.world.rooms2013.teenbeach.TeenBeachParty, com.clubpenguin.world.rooms2013.teenbeach.TeenBeachParty.instance.collectPartyItem, CLASS_NAME.toLowerCase());
            _stage.triggers_mc.item_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, pickupItem);
			_destroyDelegate = com.clubpenguin.util.Delegate.create(this, destroy);
            _SHELL.addListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            if (com.clubpenguin.world.rooms2013.teenbeach.TeenBeachParty.instance.isConcertTimeSet()) {
                initConcertCountdown();
            } else {
                com.clubpenguin.world.rooms2013.teenbeach.TeenBeachParty.instance.requestConcertTime();
            }
        }
		function pickupItem() {
			if(!_SHELL.isItemInMyInventory(193)) {
				_INTERFACE.buyInventory(193);
			};
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
		function catalogOpen() {
			_INTERFACE.showContent("party_catalogue");
		}
        function destroy() {
            clearInterval(_secondCheckIntervalID);
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            _SHELL.removeListener(_SHELL.BALL_LAND, _checkClockTagetDelegate);
            com.clubpenguin.world.rooms2013.teenbeach.TeenBeachParty.instance.countdownSignal.remove(initConcertCountdown, this);
            clearInterval(_countdownIntervalId);
            wem.destroy();
        }
        function initConcertCountdown() {
            _concertCountdownTimer = new com.clubpenguin.world.rooms2013.teenbeach.concert.ConcertCountdownTimer(com.clubpenguin.world.rooms2013.teenbeach.TeenBeachParty.instance.timeBetweenConcertsInMilliSeconds);
            _concertCountdownTimer.setTimeTillConcertInMilliseconds(com.clubpenguin.world.rooms2013.teenbeach.TeenBeachParty.instance.millisecondsTillStart);
            updateCountdown(true);
        }
        function goBackStage() {
            if (!_SHELL.isMyPlayerMember()) {
                _INTERFACE.showContent(com.clubpenguin.world.rooms2013.teenbeach.TeenBeachParty.OOPS_BACKSTAGE);
                com.clubpenguin.world.rooms2013.teenbeach.TeenBeachParty.instance.opcodeJournal.sendOpcode(com.clubpenguin.world.rooms2013.teenbeach.OpcodeJournal.BACK_STAGE_OOPS);
            } else {
                _SHELL.sendJoinRoom("party2", 517, 145);
            }
        }
        function updateCountdown(firstRun) {
            if (!firstRun) {
                com.clubpenguin.world.rooms2013.teenbeach.TeenBeachParty.instance.millisecondsTillStart = _concertCountdownTimer.increment(_countdownIntervalInMilliseconds);
            }
            com.clubpenguin.world.rooms2013.teenbeach.TeenBeachParty.instance.updateCountdownDisplay(_concertCountdownTimer, _stage.mama_mc.sign5_mc.digit0, _stage.mama_mc.sign5_mc.digit1);
            if ((_countdownIntervalId == undefined) || (_countdownIntervalId == null)) {
                _countdownIntervalId = setInterval(this, "updateCountdown", _countdownIntervalInMilliseconds, false);
            }
        }
        static var CLASS_NAME = "Forts";
        static var ONE_SECOND = 1000;
        static var TARGET_STAMP_ID = 13;
        static var TARGET_STAMP_THRESHOLD = 10;
        var _daysOfTheWeek = ["sunday", "monday", "tuesday", "wednesday", "thursday", "friday", "saturday"];
        var _clockTargetHits = 0;
        var _countdownIntervalInMilliseconds = 5000;
    }
