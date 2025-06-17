//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2014.pirate.Forts extends com.clubpenguin.world.rooms.BaseRoom
    {
        var _stage, _SHELL, _INTERFACE, localize, setupNavigationButtons, IS_24_HOUR_CLOCK, _now, _secondCheckIntervalID, _destroyDelegate, _checkClockTagetDelegate, showContent, wem, _AIRTOWER, _joinRoomDelegate, _ENGINE, _ct_minutes, _ct_hours, _pm_trigger, _ct_day, _today;
        function Forts (stageReference) {
            super(stageReference);
            trace(CLASS_NAME + "()");
            _stage.start_x = 385;
            _stage.start_y = 375;
            if (!_SHELL) {
                init();
            }
        }
        function exit(name, x, y) {
            trace(CLASS_NAME + ": exit()");
            _SHELL.sendJoinRoom(name, x, y);
        }
        function init() {
            localize([_stage.lang_mc.langClockSign_mc]);
            setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.town_btn, 35, 330), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.rink_btn, 450, 110), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.treasure_btn, 483, 383), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.plaza_btn, 725, 350), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.treasure_btn, 485, 385)]);
            _stage.town_btn.useHandCursor = false;
            _stage.rink_btn.useHandCursor = false;
            _stage.plaza_btn.useHandCursor = false;
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
            _stage.party2_btn.useHandCursor = false;
            _stage.triggers_mc.town_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "town", 685, 285);
            _stage.triggers_mc.rink_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "rink", 390, 185);
            _stage.triggers_mc.plaza_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "plaza", 95, 360);
            _stage.triggers_mc.treasure_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, chest);
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
            _AIRTOWER = _global.getCurrentAirtower();
            _joinRoomDelegate = com.clubpenguin.util.Delegate.create(this, handleJoinRoom);
            _ENGINE.penguinTransformComplete.add(_joinRoomDelegate);
			showContent([new com.clubpenguin.world.rooms.common.PopupContentVO(_stage.interface_mc.party_cat_btn, true, "party_catalogue", "")]);
            _global.getCurrentParty().PirateParty.configureTreasureChestState(_stage.chest_mc, _stage.crabs_mc, _stage.treasure_btn);
        }
		function chest() {
			_INTERFACE.showContent("piratechestforts");
        }
        function initializePartyCookieDependentAssets() {
            _global.getCurrentParty().PirateParty.configureTreasureChestState(_stage.chest_mc, _stage.crabs_mc, _stage.treasure_btn);
        }
        function handleJoinRoom(playerObj) {
            if (playerObj.player_id != _SHELL.getMyPlayerId()) {
                return(undefined);
            }
            var _local_2 = _ENGINE.getPlayerMovieClip(playerObj.player_id);
            if (_stage.triggers_mc.forts_mc.hitTest(_local_2._x, _local_2._y, true)) {
                _ENGINE.sendPlayerMove(328, 254);
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
            _ENGINE.penguinTransformComplete.remove(_joinRoomDelegate);
            _stage._quality = "HIGH";
            wem.destroy();
        }
        static var CLASS_NAME = "Forts";
        static var ONE_SECOND = 1000;
        static var TARGET_STAMP_ID = 13;
        static var TARGET_STAMP_THRESHOLD = 10;
        var _daysOfTheWeek = ["sunday", "monday", "tuesday", "wednesday", "thursday", "friday", "saturday"];
        var _clockTargetHits = 0;
    }
