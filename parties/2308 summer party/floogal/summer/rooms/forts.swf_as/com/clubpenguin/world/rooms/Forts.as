class com.clubpenguin.world.rooms.Forts extends com.clubpenguin.world.rooms.BaseRoom
{
    var _stage, _SHELL, localize, setupNavigationButtons, IS_24_HOUR_CLOCK, _now, _secondCheckIntervalID, _destroyDelegate, _checkClockTagetDelegate, showContent, wem, _abductionDelegate, aliendAbduction, _ct_minutes, _ct_hours, _pm_trigger, _ct_day, _today;
    function Forts(stageReference)
    {
        super(stageReference);
        _stage.start_x = 380;
        _stage.start_y = 285;
        if (!_SHELL)
        {
            this.init();
        } // end if
    } // End of the function
    function exit(name, x, y)
    {
        _SHELL.sendJoinRoom(name, x, y);
    } // End of the function
    function init()
    {
        this.localize([_stage.clocktext]);
        this.setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.town_btn, 80, 250), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.rink_btn, 245, 200), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.plaza_btn, 685, 225)]);
        IS_24_HOUR_CLOCK = _SHELL.getLanguageAbbreviation() == "de";
        if (IS_24_HOUR_CLOCK)
        {
            _stage.clock_txt._x = _stage.clock_txt._x + 15;
        } // end if
        if (_SHELL.getPenguinStandardTime != undefined)
        {
            _now = _SHELL.getPenguinStandardTime();
        }
        else
        {
            _now = new Date();
        } // end else if
        clearInterval(_secondCheckIntervalID);
        _secondCheckIntervalID = setInterval(com.clubpenguin.util.Delegate.create(this, clockTimer), com.clubpenguin.world.rooms.Forts.ONE_SECOND);
        this.clockTimer();
        _stage.background_mc.town_btn.useHandCursor = false;
        _stage.background_mc.rink_btn.useHandCursor = false;
        _stage.background_mc.plaza_btn.useHandCursor = false;
        _stage.triggers_mc.town_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "town", 660, 325);
        _stage.triggers_mc.rink_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "rink", 380, 135);
        _stage.triggers_mc.plaza_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "plaza", 85, 330);
        _destroyDelegate = com.clubpenguin.util.Delegate.create(this, destroy);
        _SHELL.addListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
        _checkClockTagetDelegate = com.clubpenguin.util.Delegate.create(this, onSnowballLand);
        _SHELL.addListener(_SHELL.BALL_LAND, _checkClockTagetDelegate);
        this.showContent([new com.clubpenguin.world.rooms.common.PopupContentVO(_stage.clock_btn, true, "clock_help", "")]);
        wem = new com.clubpenguin.world.rooms.weathereffects.WeatherEffectsManager(_SHELL, _stage.background_mc);
        wem.setupFireAnimationHeight(25);
        wem.setupRainAnimationHeight(35);
        wem.setupSnowAnimationHeight(35);
        wem.setupRainAnimationSpeed(0.300000);
        wem.setupSnowAnimationSpeed(0.600000);
        wem.setupRainDelayTime(2);
        wem.setupSnowDelayTime(2);
        wem.startWeatherEffectCheck();
        _abductionDelegate = com.clubpenguin.util.Delegate.create(this, abductPenguin);
        _global.getCurrentAirtower().addListener("beamup", _abductionDelegate);
    } // End of the function
    function abductPenguin(data)
    {
        var _loc4 = data[1];
        var _loc3 = _global.getCurrentEngine().getPlayerMovieClip(_loc4);
        _stage.attachMovie("TractorBeam", "tractorBeam_mc", _stage.getNextHighestDepth());
        _stage.tractorBeam_mc.swapDepths(_loc3);
        _stage.tractorBeam_mc._x = _loc3._x;
        _stage.tractorBeam_mc._y = _loc3._y - 1;
        aliendAbduction = new com.clubpenguin.world.rooms.aliens.AlienAbduction();
        aliendAbduction.abductPlayer(_loc4, _stage, this);
    } // End of the function
    function abductedPlayerGoToUFO(player_id)
    {
        _stage.tractorBeam_mc.removeMovieClip();
        if (_SHELL.isMyPlayer(player_id))
        {
            _global.getCurrentAirtower().removeListener("beamup", _abductionDelegate);
            _abductionDelegate = null;
            _SHELL.sendJoinRoom("ufo", 380, 320);
        } // end if
    } // End of the function
    function clockTimer()
    {
        var _loc6 = 0;
        var _loc5 = 11;
        var _loc2 = 12;
        _now.setTime(_now.getTime() + com.clubpenguin.world.rooms.Forts.ONE_SECOND);
        if (_ct_minutes != _now.getMinutes())
        {
            _ct_minutes = _now.getMinutes();
            if (_ct_hours != _now.getMinutes())
            {
                _ct_hours = _now.getHours();
                if (_ct_hours > _loc5)
                {
                    _pm_trigger = true;
                    if (_ct_hours > _loc2 && !IS_24_HOUR_CLOCK)
                    {
                        _ct_hours = _ct_hours - _loc2;
                    } // end if
                }
                else
                {
                    _pm_trigger = false;
                    if (_ct_hours == _loc6 && !IS_24_HOUR_CLOCK)
                    {
                        _ct_hours = _loc2;
                    } // end if
                } // end else if
                if (!IS_24_HOUR_CLOCK)
                {
                    if (_pm_trigger)
                    {
                        _stage.am_pm.text = "PM";
                    }
                    else
                    {
                        _stage.am_pm.text = "AM";
                    } // end else if
                }
                else
                {
                    _stage.am_pm.text = "";
                } // end else if
                if (_ct_day != _now.getDay())
                {
                    var _loc4;
                    _ct_day = _now.getDay();
                    _loc4 = _daysOfTheWeek[_ct_day];
                    _today = _SHELL.getLocalizedString(_loc4);
                } // end if
            } // end if
            _stage.day_mc.label_txt.text = _today.toUpperCase();
            if (IS_24_HOUR_CLOCK)
            {
                var _loc3 = new TextFormat();
                _loc3.size = 10;
                _stage.day_txt.setTextFormat(_loc3);
            } // end if
            if (_ct_minutes < 10)
            {
                _stage.clock_txt.text = _ct_hours + ":0" + _ct_minutes;
            }
            else
            {
                _stage.clock_txt.text = _ct_hours + ":" + _ct_minutes;
            } // end if
        } // end else if
    } // End of the function
    function onSnowballLand(snowballInfo)
    {
        if (_stage.tower.target.target.hitTest(snowballInfo.x, snowballInfo.y, true))
        {
            _stage.tower.play();
            _stage.tower.target.play();
            _stage.tower.play();
            snowballInfo.snowballMC._visible = false;
            ++_clockTargetHits;
            if (_clockTargetHits >= com.clubpenguin.world.rooms.Forts.TARGET_STAMP_THRESHOLD)
            {
                _clockTargetHits = 0;
                _SHELL.stampEarned(com.clubpenguin.world.rooms.Forts.TARGET_STAMP_ID);
            } // end if
        } // end if
    } // End of the function
    function destroy()
    {
        clearInterval(_secondCheckIntervalID);
        _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
        _SHELL.removeListener(_SHELL.BALL_LAND, _checkClockTagetDelegate);
        wem.destroy();
        _global.getCurrentAirtower().removeListener("beamup", _abductionDelegate);
        _abductionDelegate = null;
    } // End of the function
    static var CLASS_NAME = "Forts";
    static var ONE_SECOND = 1000;
    static var TARGET_STAMP_ID = 13;
    static var TARGET_STAMP_THRESHOLD = 10;
    var _daysOfTheWeek = ["sunday", "monday", "tuesday", "wednesday", "thursday", "friday", "saturday"];
    var _clockTargetHits = 0;
} // End of Class
