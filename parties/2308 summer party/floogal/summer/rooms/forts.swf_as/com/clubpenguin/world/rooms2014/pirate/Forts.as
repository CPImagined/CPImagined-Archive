dynamic class com.clubpenguin.world.rooms2014.pirate.Forts extends com.clubpenguin.world.rooms.BaseRoom
{
    static var CLASS_NAME: String = "Forts";
    static var ONE_SECOND: Number = 1000;
    static var TARGET_STAMP_ID: Number = 13;
    static var TARGET_STAMP_THRESHOLD: Number = 10;
    var _daysOfTheWeek = ["sunday", "monday", "tuesday", "wednesday", "thursday", "friday", "saturday"];
    var _clockTargetHits: Number = 0;
    var IS_24_HOUR_CLOCK;
    var _AIRTOWER;
    var _ENGINE;
    var _SHELL;
    var _checkClockTagetDelegate;
    var _ct_day;
    var _ct_hours;
    var _ct_minutes;
    var _destroyDelegate;
    var _joinRoomDelegate;
    var _now;
    var _pm_trigger;
    var _secondCheckIntervalID;
    var _stage;
    var _today;
    var localize;
    var setupNavigationButtons;
    var showContent;
    var wem;

    function Forts(stageReference)
    {
        super(stageReference);
        trace(com.clubpenguin.world.rooms2014.pirate.Forts.CLASS_NAME + "()");
        this._stage.start_x = 385;
        this._stage.start_y = 375;
        if (this._SHELL) 
        {
            return;
        }
        this.init();
    }

    function exit(name, x, y)
    {
        trace(com.clubpenguin.world.rooms2014.pirate.Forts.CLASS_NAME + ": exit()");
        this._SHELL.sendJoinRoom(name, x, y);
    }

    function init()
    {
        this.localize([this._stage.lang_mc.langClockSign_mc]);
        this.setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(this._stage.town_btn, 35, 330), new com.clubpenguin.world.rooms.common.NavigationButtonVO(this._stage.rink_btn, 450, 110), new com.clubpenguin.world.rooms.common.NavigationButtonVO(this._stage.plaza_btn, 725, 350), new com.clubpenguin.world.rooms.common.NavigationButtonVO(this._stage.treasure_btn, 485, 385)]);
        this._stage.town_btn.useHandCursor = false;
        this._stage.rink_btn.useHandCursor = false;
        this._stage.plaza_btn.useHandCursor = false;
        this.IS_24_HOUR_CLOCK = this._SHELL.getLanguageAbbreviation() == "de";
        if (this.IS_24_HOUR_CLOCK) 
        {
            this._stage.clock_txt._x = this._stage.clock_txt._x + 15;
        }
        trace(com.clubpenguin.world.rooms2014.pirate.Forts.CLASS_NAME + ": init()");
        if (this._SHELL.getPenguinStandardTime == undefined) 
        {
            this._now = new Date();
        }
        else 
        {
            this._now = this._SHELL.getPenguinStandardTime();
        }
        clearInterval(this._secondCheckIntervalID);
        this._secondCheckIntervalID = setInterval(com.clubpenguin.util.Delegate.create(this, this.clockTimer), com.clubpenguin.world.rooms2014.pirate.Forts.ONE_SECOND);
        this.clockTimer();
        this._stage.party2_btn.useHandCursor = false;
        this._stage.triggers_mc.town_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, this.exit, "town", 685, 285);
        this._stage.triggers_mc.rink_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, this.exit, "rink", 390, 185);
        this._stage.triggers_mc.plaza_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, this.exit, "plaza", 95, 360);
        this._destroyDelegate = com.clubpenguin.util.Delegate.create(this, this.destroy);
        this._SHELL.addListener(this._SHELL.ROOM_DESTROYED, this._destroyDelegate);
        this._checkClockTagetDelegate = com.clubpenguin.util.Delegate.create(this, this.onSnowballLand);
        this._SHELL.addListener(this._SHELL.BALL_LAND, this._checkClockTagetDelegate);
        this.showContent([new com.clubpenguin.world.rooms.common.PopupContentVO(this._stage.clock_btn, true, "clock_help", "")]);
        this.wem = new com.clubpenguin.world.rooms.weathereffects.WeatherEffectsManager(this._SHELL, this._stage.background_mc);
        this.wem.setupFireAnimationHeight(25);
        this.wem.setupRainAnimationHeight(35);
        this.wem.setupSnowAnimationHeight(35);
        this.wem.setupRainAnimationSpeed(0.3);
        this.wem.setupSnowAnimationSpeed(0.6);
        this.wem.setupRainDelayTime(2);
        this.wem.setupSnowDelayTime(2);
        this.wem.startWeatherEffectCheck();
        this._AIRTOWER = _global.getCurrentAirtower();
        this._joinRoomDelegate = com.clubpenguin.util.Delegate.create(this, this.handleJoinRoom);
        this._ENGINE.penguinTransformComplete.add(this._joinRoomDelegate);
        _global.getCurrentParty().PirateParty.configureTreasureChestState(this._stage.chest_mc, this._stage.crabs_mc, this._stage.treasure_btn);
    }

    function initializePartyCookieDependentAssets()
    {
        _global.getCurrentParty().PirateParty.configureTreasureChestState(this._stage.chest_mc, this._stage.crabs_mc, this._stage.treasure_btn);
    }

    function handleJoinRoom(playerObj)
    {
        if (playerObj.player_id == this._SHELL.getMyPlayerId()) 
        {
            var __reg2 = this._ENGINE.getPlayerMovieClip(playerObj.player_id);
            if (this._stage.triggers_mc.forts_mc.hitTest(__reg2._x, __reg2._y, true)) 
            {
                this._ENGINE.sendPlayerMove(328, 254);
            }
        }
    }

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
        trace(com.clubpenguin.world.rooms2014.pirate.Forts.CLASS_NAME + ": handleThrow()");
        if (this._stage.tower.target.target.hitTest(snowballInfo.x, snowballInfo.y, true)) 
        {
            this._stage.tower.play();
            this._stage.tower.target.play();
            this._stage.tower.play();
            snowballInfo.snowballMC._visible = false;
            ++this._clockTargetHits;
            if (this._clockTargetHits >= com.clubpenguin.world.rooms2014.pirate.Forts.TARGET_STAMP_THRESHOLD) 
            {
                this._clockTargetHits = 0;
                this._SHELL.stampEarned(com.clubpenguin.world.rooms2014.pirate.Forts.TARGET_STAMP_ID);
            }
        }
    }

    function destroy()
    {
        clearInterval(this._secondCheckIntervalID);
        trace(com.clubpenguin.world.rooms2014.pirate.Forts.CLASS_NAME + ": destroy()");
        this._SHELL.removeListener(this._SHELL.ROOM_DESTROYED, this._destroyDelegate);
        this._SHELL.removeListener(this._SHELL.BALL_LAND, this._checkClockTagetDelegate);
        this._ENGINE.penguinTransformComplete.remove(this._joinRoomDelegate);
        this._stage._quality = "HIGH";
        this.wem.destroy();
    }

}
