//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2013.medieval.Forts extends com.clubpenguin.world.rooms.BaseRoom
    {
        var _stage, _SHELL, _destroyDelegate, _airtower, _waterSlideHandlerDelegate, IS_24_HOUR_CLOCK, _now, _secondCheckIntervalID, _ct_minutes, _ct_hours, _pm_trigger, _ct_day, _today, _triggerWatcher, _triggerWatcherInterval, _waterSlideTrigger, _ENGINE;
        function Forts (stageReference) {
            super(stageReference);
            trace(CLASS_NAME + "()");
            _stage.start_x = 150;
            _stage.start_y = 200;
            if (!_SHELL) {
                init();
            }
        }
        function init() {
            trace(CLASS_NAME + ": init()");
            _destroyDelegate = com.clubpenguin.util.Delegate.create(this, destroy);
            _SHELL.addListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            _airtower = _global.getCurrentAirtower();
            _waterSlideHandlerDelegate = com.clubpenguin.util.Delegate.create(this, handlePenguinOnWaterSlide);
            _airtower.addListener(com.clubpenguin.world.rooms2013.medieval.MedievalParty.FAIRY_SLIDE_COMMAND_NAME, _waterSlideHandlerDelegate);
            IS_24_HOUR_CLOCK = _SHELL.getLanguageAbbreviation() == "de";
            if (IS_24_HOUR_CLOCK) {
                _stage.background_mc.clock_txt._x = _stage.background_mc.clock_txt._x + 15;
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
            configureNavigation();
            configureTriggers();
            configureRoomElements();
            configureWaterSlideTriggers();
            _stage.interface_mc.catalogue_Btn.onRelease = com.clubpenguin.util.Delegate.create(com.clubpenguin.world.rooms2013.medieval.MedievalParty.instance, com.clubpenguin.world.rooms2013.medieval.MedievalParty.instance.showPartyCatalogue);
        }
        function configureTriggers() {
            _stage.triggers_mc.town_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "town", 600, 320);
            _stage.triggers_mc.rink_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "rink", 380, 205);
            _stage.triggers_mc.plaza_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "plaza", 100, 310);
        }
        function configureNavigation() {
        }
        function configureRoomElements() {
            _stage.block_mc._visible = false;
            _stage.triggers_mc._visible = false;
            configureFairyDust();
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
                            _stage.background_mc.am_pm.text = "PM";
                        } else {
                            _stage.background_mc.am_pm.text = "AM";
                        }
                    } else {
                        _stage.background_mc.am_pm.text = "";
                    }
                    if (_ct_day != _now.getDay()) {
                        var _local_4;
                        _ct_day = _now.getDay();
                        _local_4 = _daysOfTheWeek[_ct_day];
                        _today = _SHELL.getLocalizedString(_local_4);
                    }
                }
                _stage.background_mc.day_mc.label_txt.text = _today.toUpperCase();
                if (IS_24_HOUR_CLOCK) {
                    var _local_3 = new TextFormat();
                    _local_3.size = 10;
                    _stage.background_mc.day_txt.setTextFormat(_local_3);
                }
                if (_ct_minutes < 10) {
                    _stage.background_mc.clock_txt.text = (_ct_hours + ":0") + _ct_minutes;
                } else {
                    _stage.background_mc.clock_txt.text = (_ct_hours + ":") + _ct_minutes;
                }
            }
        }
        function configureWaterSlideTriggers() {
            _triggerWatcher = new com.clubpenguin.world.rooms.common.triggers.TriggerWatcher(_stage, _SHELL);
            clearInterval(_triggerWatcherInterval);
            _triggerWatcherInterval = setInterval(_triggerWatcher, "checkAllPlayers", 40);
            _waterSlideTrigger = new com.clubpenguin.world.rooms.common.triggers.PlayerTrigger(_stage.triggers_mc.slide_mc);
            _waterSlideTrigger.playersAdded.add(com.clubpenguin.util.Delegate.create(this, activateWaterSlide));
            _triggerWatcher.addTrigger(_waterSlideTrigger);
        }
        function activateWaterSlide(players) {
            var _local_2 = 0;
            while (_local_2 < players.length) {
                if ((_SHELL.getPlayerObjectById(players[_local_2]).avatarVO.avatar_id == com.clubpenguin.engine.avatar.transformation.AvatarTypeEnum.FAIRY_ID) && (players[_local_2] == _SHELL.getMyPlayerId())) {
                    com.clubpenguin.world.rooms2013.medieval.MedievalParty.instance.sendPenguinOnWaterslide();
                }
                _local_2++;
            }
        }
        function addPenguintoWaterSlidePather(player_id) {
            trace("Add penguin to waterslide");
            _stage.waterSlideContainerMC.attachMovie("Waterslide_Path", "slideguide_" + player_id, _stage.waterSlideContainerMC.getNextHighestDepth(), {_x:0, _y:0});
            var _local_2 = _stage.waterSlideContainerMC["slideguide_" + player_id];
            _local_2.gotoAndStop(1);
            _ENGINE.teleportPlayer(player_id, _local_2.patherMC._x, _local_2.patherMC._y);
            _local_2.play();
            _local_2.onEnterFrame = com.clubpenguin.util.Delegate.create(this, updatePenguinSlidePosition, player_id, _local_2);
        }
        function updatePenguinSlidePosition(player_id, patherMC) {
            if (patherMC._currentframe == patherMC._totalframes) {
                patherMC.gotoAndStop(1);
                _stage.foreground_mc.slideSplash.gotoAndPlay(2);
                delete patherMC.onEnterFrame;
                patherMC.removeMovieClip();
                patherMC = null;
            } else {
                var _local_4 = _SHELL.getPlayerObjectById(player_id).x;
                _ENGINE.teleportPlayer(player_id, patherMC.patherMC._x, patherMC.patherMC._y);
                updateSlidingPenguinFrame(player_id, _local_4, patherMC.patherMC._x);
            }
        }
        function updateSlidingPenguinFrame(player_id, old_x, new_x) {
            var _local_3 = new_x - old_x;
            var _local_2 = 0;
            if (_local_3 > MINIMUM_SLIDE_DISPLACEMENT) {
                _local_2 = PENGUIN_SIT_FRONT_RIGHT;
            } else if (_local_3 < (-MINIMUM_SLIDE_DISPLACEMENT)) {
                _local_2 = PENGUIN_SIT_FRONT_LEFT;
            } else {
                _local_2 = PENGUIN_SIT_FRONT_CENTER;
            }
            if (_local_2 <= 0) {
                return(undefined);
            }
            _ENGINE.updatePlayerFrame(player_id, _local_2, true);
        }
        function handlePenguinOnWaterSlide(data) {
            var _local_2 = Number(data[1]);
            addPenguintoWaterSlidePather(_local_2);
            data = null;
        }
        function configureFairyDust() {
            if (com.clubpenguin.world.rooms2013.medieval.MedievalParty.instance.hasPlayerCollectedIngredient(com.clubpenguin.world.rooms2013.medieval.MedievalParty.FAIRY_DUST_ITEM_ID)) {
                deactivateIngredient();
                return(undefined);
            }
            _stage.foreground_mc.fairydust_MC.fairydust_Btn.onRelease = com.clubpenguin.util.Delegate.create(com.clubpenguin.world.rooms2013.medieval.MedievalParty.instance, com.clubpenguin.world.rooms2013.medieval.MedievalParty.instance.sendCollectIngredient, com.clubpenguin.world.rooms2013.medieval.MedievalParty.FAIRY_DUST_ITEM_ID);
        }
        function deactivateIngredient() {
            _stage.foreground_mc.fairydust_MC.sparkles_MC._visible = false;
            _stage.foreground_mc.fairydust_MC.fairydust_Btn.enabled = false;
        }
        function exit(roomName, x, y) {
            trace(CLASS_NAME + ": exit()");
            _SHELL.sendJoinRoom(roomName, x, y);
        }
        function destroy() {
            trace(CLASS_NAME + ": destroy()");
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
        }
        static var CLASS_NAME = "Forts";
        static var ONE_SECOND = 1000;
        static var TARGET_STAMP_ID = 13;
        static var TARGET_STAMP_THRESHOLD = 10;
        var _daysOfTheWeek = ["sunday", "monday", "tuesday", "wednesday", "thursday", "friday", "saturday"];
        var _clockTargetHits = 0;
        static var PENGUIN_SIT_FRONT_CENTER = 17;
        static var PENGUIN_SIT_FRONT_LEFT = 18;
        static var PENGUIN_SIT_LEFT = 19;
        static var PENGUIN_SIT_BACK_LEFT = 20;
        static var PENGUIN_SIT_BACK_CENTER = 21;
        static var PENGUIN_SIT_BACK_RIGHT = 22;
        static var PENGUIN_SIT_RIGHT = 23;
        static var PENGUIN_SIT_FRONT_RIGHT = 24;
        static var MINIMUM_SLIDE_DISPLACEMENT = 1;
    }
