//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2012.smoothie.Forts extends com.clubpenguin.world.rooms.BaseRoom
    {
        var _stage, localize, showContent, IS_24_HOUR_CLOCK, _SHELL, _now, _secondCheckIntervalID, _destroyDelegate, _opcodeJournal, _INTERFACE, _ENGINE, _ct_minutes, _ct_hours, _pm_trigger, _ct_day, _today;
        function Forts (stageReference) {
            super(stageReference);
            _stage.start_x = 385;
            _stage.start_y = 365;
        }
        function init() {
            localize([_stage.background_mc.lang_superrink_mc, _stage.background_mc.clocktower.lang_timezone_mc, _stage.background_mc.clocktower.lang_G_mc]);
            _stage.triggers_mc.party1_1_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, templeExit, "party1", 180, 250, 6);
            _stage.triggers_mc.party1_2_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, templeExit, "party1", 380, 390, 7);
            _stage.triggers_mc.party1_3_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, templeExit, "party1", 615, 215, 5);
            _stage.triggers_mc.party2_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, enterTempleIfRequirementMet);
            _stage.triggers_mc.rink_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "rink", 380, 135);
            _stage.triggers_mc.town_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "town", 579, 355);
            _stage.triggers_mc.plaza_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "plaza", 110, 350);
            _stage.bigEntrance_mc.bigEntranceDoor_mc.bigEntranceNote_btn.onRelease = com.clubpenguin.util.Delegate.create(this, checkTempleEntryRequirements);
            showContent([new com.clubpenguin.world.rooms.common.PopupContentVO(_stage.clock_btn, true, "clock_help", "")]);
            IS_24_HOUR_CLOCK = _SHELL.getLanguageAbbreviation() == "de";
            if (IS_24_HOUR_CLOCK) {
                _stage.background_mc.clocktower.clock_txt._x = _stage.background_mc.clocktower.clock_txt._x + 12;
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
            _opcodeJournal = new com.clubpenguin.world.rooms2012.smoothie.OpcodeJournal();
            _opcodeJournal.init(_SHELL.getMyPlayerId());
            setTempleDoorState();
        }
        function setTempleDoorState() {
            if ((_INTERFACE.scavengerHunt.isItemFound(com.clubpenguin.world.rooms2012.smoothie.Smoothie.SCAVENGER_PINEAPPLE) && (_INTERFACE.scavengerHunt.isItemFound(com.clubpenguin.world.rooms2012.smoothie.Smoothie.SCAVENGER_APPLE))) && (_INTERFACE.scavengerHunt.isItemFound(com.clubpenguin.world.rooms2012.smoothie.Smoothie.SCAVENGER_WATERMELON))) {
                _opcodeJournal.sendOpcode(com.clubpenguin.world.rooms2012.smoothie.OpcodeJournal.COLLECT_ALL_3_FRUIT);
                _stage.bigEntrance_mc.bigEntranceDoor_mc.gotoAndStop(2);
            }
            if (_SHELL.isMyPlayerMember && (com.clubpenguin.world.rooms2012.smoothie.Smoothie.hasScavengerHuntPin())) {
                _stage.bigEntrance_mc.bigEntranceDoor_mc.gotoAndStop(2);
            }
        }
        function enterTempleIfRequirementMet() {
            if (com.clubpenguin.world.rooms2012.smoothie.Smoothie.hasCollectedScavengerHuntItems() || (com.clubpenguin.world.rooms2012.smoothie.Smoothie.hasScavengerHuntPin())) {
                exit("party2", 95, 90);
            }
        }
        function checkTempleEntryRequirements() {
            if (!_SHELL.isMyPlayerMember()) {
                _opcodeJournal.sendOpcode(com.clubpenguin.world.rooms2012.smoothie.OpcodeJournal.NON_MEMBER_TEMPLE_OOPS);
                _INTERFACE.showContent(com.clubpenguin.world.rooms2012.smoothie.Smoothie.VOLCANO_TEMPLE_NONMEMBER_OOPS);
                return(undefined);
            } else if (com.clubpenguin.world.rooms2012.smoothie.Smoothie.hasCollectedScavengerHuntItems()) {
                _ENGINE.sendPlayerMove(_stage.triggers_mc.party2_mc._x, _stage.triggers_mc.party2_mc._y);
            } else if (com.clubpenguin.world.rooms2012.smoothie.Smoothie.hasScavengerHuntPin()) {
                _ENGINE.sendPlayerMove(_stage.triggers_mc.party2_mc._x, _stage.triggers_mc.party2_mc._y);
            } else {
                _INTERFACE.showContent(com.clubpenguin.world.rooms2012.smoothie.Smoothie.CONTENT_SCAVENGER_HUNT);
            }
        }
        function exit(roomName, x, y) {
            _SHELL.sendJoinRoom(roomName, x, y);
        }
        function templeExit(roomName, x, y, avatarID) {
            _SHELL.setAvatarTransformation(avatarID);
            _SHELL.sendJoinRoom(roomName, x, y);
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
                            _stage.background_mc.clocktower.am_pm.text = "PM";
                        } else {
                            _stage.background_mc.clocktower.am_pm.text = "AM";
                        }
                    } else {
                        _stage.background_mc.clocktower.am_pm.text = "";
                    }
                    if (_ct_day != _now.getDay()) {
                        var _local_4;
                        _ct_day = _now.getDay();
                        _local_4 = _daysOfTheWeek[_ct_day];
                        _today = _SHELL.getLocalizedString(_local_4);
                    }
                }
                _stage.background_mc.clocktower.day_txt.text = _today.toUpperCase();
                if (IS_24_HOUR_CLOCK) {
                    var _local_3 = new TextFormat();
                    _local_3.size = 6;
                    _stage.background_mc.clocktower.day_txt.setTextFormat(_local_3);
                }
                if (_ct_minutes < 10) {
                    _stage.background_mc.clocktower.clock_txt.text = (_ct_hours + ":0") + _ct_minutes;
                } else {
                    _stage.background_mc.clocktower.clock_txt.text = (_ct_hours + ":") + _ct_minutes;
                }
            }
        }
        function handleThrow(ball) {
            if (_stage.background_mc.clocktower.tower.target.hitTest(ball._x, ball._y, true)) {
                _stage.background_mc.clocktower.tower.play();
                ball._visible = false;
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
        }
        static var CLASS_NAME = "Forts";
        static var ONE_SECOND = 1000;
        static var TARGET_STAMP_ID = 13;
        static var TARGET_STAMP_THRESHOLD = 10;
        var _daysOfTheWeek = ["sunday", "monday", "tuesday", "wednesday", "thursday", "friday", "saturday"];
        var _clockTargetHits = 0;
    }
