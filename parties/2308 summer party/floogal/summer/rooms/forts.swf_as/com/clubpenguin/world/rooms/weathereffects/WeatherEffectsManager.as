dynamic class com.clubpenguin.world.rooms.weathereffects.WeatherEffectsManager
{
    var SHELL = undefined;
    static var _NECK_AMULET_ID: Number = 3032;
    static var _SPECIAL_DANCE_FRAME: Number = 26;
    static var _FIRE_NINJA_HEAD_ITEM_ID: Number = 1086;
    static var _FIRE_NINJA_FACE_ITEM_ID: Number = 2013;
    static var _FIRE_NINJA_BODY_ITEM_ID: Number = 4120;
    static var _FIRE_NINJA_FEET_ITEM_ID: Number = 6025;
    static var _WATER_NINJA_HEAD_ITEM_ID: Number = 1087;
    static var _WATER_NINJA_FACE_ITEM_ID: Number = 2025;
    static var _WATER_NINJA_BODY_ITEM_ID: Number = 4121;
    static var _WATER_NINJA_FEET_ITEM_ID: Number = 6026;
    static var _SNOW_NINJA_HEAD_ITEM_ID: Number = 1581;
    static var _SNOW_NINJA_FACE_ITEM_ID: Number = 2119;
    static var _SNOW_NINJA_BODY_ITEM_ID: Number = 4834;
    static var _SNOW_NINJA_FEET_ITEM_ID: Number = 6163;
    static var _SHADOW_NINJA_HEAD_ITEM_ID: Number = 1271;
    static var _SHADOW_NINJA_FACE_ITEM_ID: Number = 2033;
    static var _SHADOW_NINJA_BODY_ITEM_ID: Number = 4380;
    static var _SHADOW_NINJA_FEET_ITEM_ID: Number = 6077;
    var _intervalId: Number = -1;
    var _dancingFirePlayers: Number = 0;
    var _dancingWaterPlayers: Number = 0;
    var _dancingSnowPlayers: Number = 0;
    var _dancingShadowPlayers: Number = 0;
    var _playFireEffect: Boolean = false;
    var _playWaterEffect: Boolean = false;
    var _playSnowEffect: Boolean = false;
    var _playShadowEffect: Boolean = false;
    var _checkInterval: Number = 4000;
    var _fireAnimationHeight: Number = 55;
    var _fireAnimationSpeed: Number = 1;
    var _fireAmount: Number = 3;
    var _fireShrinkSize: Number = 100;
    var _fireDelayTime: Number = 2;
    var _rainAnimationHeight: Number = 85;
    var _rainAnimationSpeed: Number = 0.5;
    var _rainAmount: Number = 25;
    var _rainShrinkSize: Number = 25;
    var _rainFadeAmount: Number = 50;
    var _rainDelayTime: Number = 2;
    var _rainRotation: Number = -26;
    var _snowAnimationHeight: Number = 85;
    var _snowAnimationSpeed: Number = 1;
    var _snowAmount: Number = 25;
    var _snowShrinkSize: Number = 50;
    var _snowFadeAmount: Number = 50;
    var _snowDelayTime: Number = 2;
    static var EFFECT_TYPE_FIRE: String = "Fire";
    static var EFFECT_TYPE_WATER: String = "Water";
    static var EFFECT_TYPE_SNOW: String = "Snow";
    static var EFFECT_TYPE_TIE: String = "Tie";
    static var EFFECT_TYPE_DEFAULT: String = "Default";
    static var EFFECT_TYPE_EMPTY: String = "Empty";
    static var OBJECT_TYPE_SKY: String = "Sky";
    static var OBJECT_TYPE_CLOUDS: String = "Clouds";
    static var OBJECT_TYPE_DISTANT_OBJ: String = "DistantObjects";
    static var OBJECT_TYPE_TOP_CLOUDS: String = "TopClouds";
    static var OBJECT_TYPE_SHELL: String = "TintShell";
    var _colorDefaultState;
    var _colorFireState;
    var _colorModeA;
    var _colorModeB;
    var _colorModeC;
    var _colorSnowState;
    var _colorTieState;
    var _colorWaterState;
    var _currentColorMode;
    var _currentColorState;
    var _currentShadowMode;
    var _currentShadowState;
    var _nextColorMode;
    var _nextShadowMode;
    var _shadowDefaultState;
    var _shadowEmptyState;
    var _shadowFireState;
    var _shadowModeA;
    var _shadowModeB;
    var _shadowModeC;
    var _shadowSnowState;
    var _shadowTieState;
    var _shadowWaterState;
    var background_mc;

    function WeatherEffectsManager(shell, background)
    {
        trace("WeatherEffectsManager()");
        this.SHELL = shell;
        this.background_mc = background;
        com.greensock.plugins.TweenPlugin.activate([com.greensock.plugins.ColorTransformPlugin]);
        this.setDefaultTintValues(2, com.clubpenguin.world.rooms.weathereffects.WeatherEffectsManager.EFFECT_TYPE_DEFAULT);
    }

    function getDancingFirePlayers()
    {
        return this._dancingFirePlayers;
    }

    function getDancingWaterPlayers()
    {
        return this._dancingWaterPlayers;
    }

    function getDancingSnowPlayers()
    {
        return this._dancingSnowPlayers;
    }

    function getDancingShadowPlayers()
    {
        return this._dancingShadowPlayers;
    }

    function set checkInterval(interval)
    {
        this._checkInterval = interval;
    }

    function get fireAnimationHeight()
    {
        return this._fireAnimationHeight;
    }

    function get fireAnimationSpeed()
    {
        return this._fireAnimationSpeed;
    }

    function get fireAmount()
    {
        return this._fireAmount;
    }

    function get fireShrinkSize()
    {
        return this._fireShrinkSize;
    }

    function get fireDelayTime()
    {
        return this._fireDelayTime;
    }

    function get rainAnimationHeight()
    {
        return this._rainAnimationHeight;
    }

    function get rainAnimationSpeed()
    {
        return this._rainAnimationSpeed;
    }

    function get rainAmount()
    {
        return this._rainAmount;
    }

    function get rainShrinkSize()
    {
        return this._rainShrinkSize;
    }

    function get rainFadeAmount()
    {
        return this._rainFadeAmount;
    }

    function get rainDelayTime()
    {
        return this._rainDelayTime;
    }

    function get rainRotation()
    {
        return this._rainRotation;
    }

    function get snowAnimationHeight()
    {
        return this._snowAnimationHeight;
    }

    function get snowAnimationSpeed()
    {
        return this._snowAnimationSpeed;
    }

    function get snowAmount()
    {
        return this._snowAmount;
    }

    function get snowShrinkSize()
    {
        return this._snowShrinkSize;
    }

    function get snowFadeAmount()
    {
        return this._snowFadeAmount;
    }

    function get snowDelayTime()
    {
        return this._snowDelayTime;
    }

    function get currentColorState()
    {
        return this._currentColorState;
    }

    function get colorFireState()
    {
        return this._colorFireState;
    }

    function get colorWaterState()
    {
        return this._colorWaterState;
    }

    function get colorSnowState()
    {
        return this._colorSnowState;
    }

    function get colorTieState()
    {
        return this._colorTieState;
    }

    function get colorDefaultState()
    {
        return this._colorDefaultState;
    }

    function get currentColorMode()
    {
        return this._currentColorMode;
    }

    function set currentColorMode(mode)
    {
        this._currentColorMode = mode;
    }

    function get nextColorMode()
    {
        return this._nextColorMode;
    }

    function get colorModeA()
    {
        return this._colorModeA;
    }

    function get colorModeB()
    {
        return this._colorModeB;
    }

    function get colorModeC()
    {
        return this._colorModeC;
    }

    function get currentShadowState()
    {
        return this._currentShadowState;
    }

    function get shadowFireState()
    {
        return this._shadowFireState;
    }

    function get shadowWaterState()
    {
        return this._shadowWaterState;
    }

    function get shadowSnowState()
    {
        return this._shadowSnowState;
    }

    function get shadowTieState()
    {
        return this._shadowTieState;
    }

    function get shadowDefaultState()
    {
        return this._shadowDefaultState;
    }

    function get shadowEmptyState()
    {
        return this._shadowEmptyState;
    }

    function get currentShadowMode()
    {
        return this._currentShadowMode;
    }

    function set currentShadowMode(mode)
    {
        this._currentShadowMode = mode;
    }

    function get nextShadowMode()
    {
        return this._nextShadowMode;
    }

    function get shadowModeA()
    {
        return this._shadowModeA;
    }

    function get shadowModeB()
    {
        return this._shadowModeB;
    }

    function get shadowModeC()
    {
        return this._shadowModeC;
    }

    function startWeatherEffectCheck()
    {
        trace("WeatherEffectsManager: startWeatherEffectCheck()");
        this.initStates();
        this._intervalId = setInterval(com.clubpenguin.util.Delegate.create(this, this.checkOutfitandSpecialDance), this._checkInterval);
    }

    function stopWeatherEffectCheck()
    {
        clearInterval(this._intervalId);
        this._intervalId = -1;
    }

    function initialize(fireAnimationHeight, fireAnimationSpeed, fireAmount, fireDelayTime, rainAnimationHeight, rainAmount, rainShrinkSize, rainFadeAmount, rainDelayTime, rainRotation, snowAnimationHeight, snowAmount, snowShrinkSize, snowFadeAmount, snowDelayTime)
    {
        this.setupFireAnimationHeight(fireAnimationHeight);
        this.setupFireAnimationSpeed(fireAnimationSpeed);
        this.setupFireAmount(fireAmount);
        this.setupFireDelayTime(fireDelayTime);
        this.setupRainAnimationHeight(rainAnimationHeight);
        this.setupRainAmount(rainAmount);
        this.setupRainShrinkSize(rainShrinkSize);
        this.setupRainFadeAmount(rainFadeAmount);
        this.setupRainDelayTime(rainDelayTime);
        this.setupRainRotation(rainRotation);
        this.setupSnowAnimationHeight(snowAnimationHeight);
        this.setupSnowAmount(snowAmount);
        this.setupSnowShrinkSize(snowShrinkSize);
        this.setupSnowFadeAmount(snowFadeAmount);
        this.setupSnowDelayTime(snowDelayTime);
    }

    function setupIntervalCheck(interval)
    {
        this._checkInterval = interval;
    }

    function setupFireAnimationHeight(height)
    {
        this._fireAnimationHeight = height;
    }

    function setupFireAnimationSpeed(speed)
    {
        this._fireAnimationSpeed = speed;
    }

    function setupFireAmount(amount)
    {
        this._fireAmount = amount;
    }

    function setupFireDelayTime(delay)
    {
        this._fireDelayTime = delay;
    }

    function setupRainAnimationHeight(height)
    {
        this._rainAnimationHeight = height;
    }

    function setupRainAnimationSpeed(speed)
    {
        this._rainAnimationSpeed = speed;
    }

    function setupRainAmount(amount)
    {
        this._rainAmount = amount;
    }

    function setupRainShrinkSize(shrinkSize)
    {
        this._rainShrinkSize = shrinkSize;
    }

    function setupRainFadeAmount(rainFadeAmount)
    {
        this._rainFadeAmount = rainFadeAmount;
    }

    function setupRainDelayTime(delay)
    {
        this._rainDelayTime = delay;
    }

    function setupRainRotation(rotation)
    {
        this._rainRotation = rotation;
    }

    function setupSnowAnimationHeight(height)
    {
        this._snowAnimationHeight = height;
    }

    function setupSnowAnimationSpeed(speed)
    {
        this._snowAnimationSpeed = speed;
    }

    function setupSnowAmount(amount)
    {
        this._snowAmount = amount;
    }

    function setupSnowShrinkSize(shrinkSize)
    {
        this._snowShrinkSize = shrinkSize;
    }

    function getBackogrundMC()
    {
        return this.background_mc;
    }

    function setupSnowFadeAmount(snowFadeAmount)
    {
        this._snowFadeAmount = snowFadeAmount;
    }

    function setupSnowDelayTime(snowDelayTime)
    {
        this._snowDelayTime = snowDelayTime;
    }

    function playWeatherEffect(effectType)
    {
        this._currentColorState.playWeatherEffect(effectType);
    }

    function set currentColorState(state)
    {
        this._currentColorState = state;
        this._currentColorMode = this._nextColorMode;
        this._currentColorState.applyState();
    }

    function initStates()
    {
        this._colorFireState = new com.clubpenguin.world.rooms.weathereffects.state.color.ColorFireState(this);
        this._colorWaterState = new com.clubpenguin.world.rooms.weathereffects.state.color.ColorWaterState(this);
        this._colorSnowState = new com.clubpenguin.world.rooms.weathereffects.state.color.ColorSnowState(this);
        this._colorTieState = new com.clubpenguin.world.rooms.weathereffects.state.color.ColorTieState(this);
        this._colorDefaultState = new com.clubpenguin.world.rooms.weathereffects.state.color.ColorDefaultState(this);
        this._colorModeA = new com.clubpenguin.world.rooms.weathereffects.state.mode.ModeA();
        this._colorModeB = new com.clubpenguin.world.rooms.weathereffects.state.mode.ModeB();
        this._colorModeC = new com.clubpenguin.world.rooms.weathereffects.state.mode.ModeC();
        this._currentColorMode = this._nextColorMode = this._colorModeA;
        this._currentColorState = this._colorDefaultState;
        this._shadowFireState = new com.clubpenguin.world.rooms.weathereffects.state.shadow.ShadowFireState(this);
        this._shadowWaterState = new com.clubpenguin.world.rooms.weathereffects.state.shadow.ShadowWaterState(this);
        this._shadowSnowState = new com.clubpenguin.world.rooms.weathereffects.state.shadow.ShadowSnowState(this);
        this._shadowTieState = new com.clubpenguin.world.rooms.weathereffects.state.shadow.ShadowTieState(this);
        this._shadowDefaultState = new com.clubpenguin.world.rooms.weathereffects.state.shadow.ShadowDefaultState(this);
        this._shadowEmptyState = new com.clubpenguin.world.rooms.weathereffects.state.shadow.ShadowEmptyState(this);
        this._shadowModeA = new com.clubpenguin.world.rooms.weathereffects.state.mode.ModeA();
        this._shadowModeB = new com.clubpenguin.world.rooms.weathereffects.state.mode.ModeB();
        this._shadowModeC = new com.clubpenguin.world.rooms.weathereffects.state.mode.ModeC();
        this._currentShadowMode = this._nextShadowMode = this._shadowModeA;
        this._currentShadowState = this._shadowEmptyState;
    }

    function determineColorMode(numberOfUsers)
    {
        if (numberOfUsers <= 2) 
        {
            return this._colorModeA;
        }
        if (numberOfUsers == 3) 
        {
            return this._colorModeB;
        }
        if (numberOfUsers >= 4) 
        {
            return this._colorModeC;
        }
        return this._colorModeA;
    }

    function set currentShadowState(state)
    {
        this._currentShadowState = state;
        this._currentShadowMode = this._nextShadowMode;
        this._currentShadowState.applyState();
    }

    function determineShadowMode(numberOfUsers)
    {
        if (numberOfUsers <= 2) 
        {
            return this._shadowModeA;
        }
        if (numberOfUsers == 3) 
        {
            return this._shadowModeB;
        }
        if (numberOfUsers >= 4) 
        {
            return this._shadowModeC;
        }
        return this._shadowModeA;
    }

    function determineShadowState()
    {
        if ((__reg0 = this._currentColorState) === this._colorFireState) 
        {
            this._currentShadowState.toFireState();
            return;
        }
        else if (__reg0 === this._colorWaterState) 
        {
            this._currentShadowState.toWaterState();
            return;
        }
        else if (__reg0 === this._colorSnowState) 
        {
            this._currentShadowState.toSnowState();
            return;
        }
        else if (__reg0 === this._colorTieState) 
        {
            this._currentShadowState.toTieState();
            return;
        }
        else if (__reg0 !== this._colorDefaultState) 
        {
            return;
        }
        this._currentShadowState.toDefaultState();
        return;
    }

    function checkOutfitandSpecialDance()
    {
        this._dancingFirePlayers = 0;
        this._dancingWaterPlayers = 0;
        this._dancingSnowPlayers = 0;
        this._dancingShadowPlayers = 0;
        var __reg3 = 0;
        while (__reg3 < this.SHELL.getPlayerList().length) 
        {
            var __reg2 = this.SHELL.getPlayerList()[__reg3];
            if (this.isWearingFireOutfit(__reg2) && this.isDoingSpecialDance(__reg2)) 
            {
                ++this._dancingFirePlayers;
            }
            if (this.isWearingWaterOutfit(__reg2) && this.isDoingSpecialDance(__reg2)) 
            {
                ++this._dancingWaterPlayers;
            }
            if (this.isWearingSnowOutfit(__reg2) && this.isDoingSpecialDance(__reg2)) 
            {
                ++this._dancingSnowPlayers;
            }
            if (this.isWearingShadowOutfit(__reg2) && this.isDoingSpecialDance(__reg2)) 
            {
                ++this._dancingShadowPlayers;
            }
            ++__reg3;
        }
        if (this.SHELL.getPlayerList().length < 2) 
        {
            this.resetToDefaultValues();
            this._nextShadowMode = this.determineShadowMode(this._dancingShadowPlayers);
            this._currentShadowState.toEmptyState();
            return undefined;
        }
        this.determinePlayableWeatherEffects();
    }

    function determinePlayableWeatherEffects()
    {
        this._playFireEffect = false;
        this._playWaterEffect = false;
        this._playSnowEffect = false;
        this._playShadowEffect = false;
        if (this._dancingFirePlayers >= 2) 
        {
            this._playFireEffect = true;
        }
        if (this._dancingWaterPlayers >= 2) 
        {
            this._playWaterEffect = true;
        }
        if (this._dancingSnowPlayers >= 2) 
        {
            this._playSnowEffect = true;
        }
        if (this._dancingShadowPlayers >= 2) 
        {
            this._playShadowEffect = true;
        }
        if (this._dancingWaterPlayers >= this._dancingFirePlayers) 
        {
            this._playFireEffect = false;
        }
        if (this._dancingFirePlayers >= this._dancingSnowPlayers) 
        {
            this._playSnowEffect = false;
        }
        if (this._dancingSnowPlayers >= this._dancingWaterPlayers) 
        {
            this._playWaterEffect = false;
        }
        if (this._dancingWaterPlayers < this._dancingFirePlayers) 
        {
            this._playWaterEffect = false;
        }
        if (this._dancingSnowPlayers < this._dancingWaterPlayers) 
        {
            this._playSnowEffect = false;
        }
        if (this._dancingFirePlayers < this._dancingSnowPlayers) 
        {
            this._playFireEffect = false;
        }
        if (this._dancingFirePlayers >= 2 && this._dancingFirePlayers == this._dancingWaterPlayers && this._dancingFirePlayers == this._dancingSnowPlayers) 
        {
            this._playFireEffect = true;
            this._playWaterEffect = true;
            this._playSnowEffect = true;
        }
        if (this._playFireEffect || this._playWaterEffect || this._playSnowEffect) 
        {
            this.determineWhichStateShouldBePlayed();
        }
        else 
        {
            this.resetToDefaultValues();
        }
        if (this._playShadowEffect) 
        {
            this.determineWhichShadowStateShouldBePlayed();
        }
        if (this._playShadowEffect) 
        {
            return;
        }
        this._nextShadowMode = this.determineShadowMode(this._dancingShadowPlayers);
        if (this._nextShadowMode != this._currentShadowMode || this._currentShadowState != this._shadowEmptyState) 
        {
            trace("RESET SHADOW");
            this._currentShadowState.toEmptyState();
        }
    }

    function determineWhichStateShouldBePlayed()
    {
        if (!this._playShadowEffect) 
        {
            this._nextShadowMode = this.determineShadowMode(this._dancingShadowPlayers);
            if (this._nextShadowMode != this._currentShadowMode || this._currentShadowState != this._shadowEmptyState) 
            {
                trace("RESET SHADOW");
                this._currentShadowState.toEmptyState();
            }
        }
        if (this._playFireEffect && this._playWaterEffect && this._playSnowEffect) 
        {
            this._nextColorMode = this.determineColorMode(this._dancingFirePlayers);
            this._currentColorState.toTieState();
            if (this._playShadowEffect) 
            {
                this.determineWhichShadowStateShouldBePlayed();
            }
            return undefined;
        }
        if (this._playFireEffect) 
        {
            this._nextColorMode = this.determineColorMode(this._dancingFirePlayers);
            this._currentColorState.toFireState();
            if (this._playShadowEffect) 
            {
                this.determineWhichShadowStateShouldBePlayed();
            }
            return undefined;
        }
        if (this._playWaterEffect) 
        {
            this._nextColorMode = this.determineColorMode(this._dancingWaterPlayers);
            this._currentColorState.toWaterState();
            if (this._playShadowEffect) 
            {
                this.determineWhichShadowStateShouldBePlayed();
            }
            return undefined;
        }
        if (this._playSnowEffect) 
        {
            this._nextColorMode = this.determineColorMode(this._dancingSnowPlayers);
            this._currentColorState.toSnowState();
            if (this._playShadowEffect) 
            {
                this.determineWhichShadowStateShouldBePlayed();
            }
            return undefined;
        }
        if (!this._playFireEffect && !this._playWaterEffect && !this._playSnowEffect) 
        {
            this.resetToDefaultValues();
        }
    }

    function determineWhichShadowStateShouldBePlayed()
    {
        trace("DETERMINING WHICH SHADOW STATE SHOULD BE PLAYED");
        this._nextShadowMode = this.determineShadowMode(this._dancingShadowPlayers);
        if (this._playShadowEffect) 
        {
            this.determineShadowState();
            return undefined;
        }
        this._currentShadowState.toEmptyState();
    }

    function setDefaultTintValues(numOfPlayers, effectType)
    {
        var __reg2 = new Object();
        __reg2.tintType = this._playShadowEffect ? "shadow" : "color";
        __reg2.state = "Mode" + (numOfPlayers - 1 <= 2 ? (numOfPlayers - 1 == 2 ? "B" : "A") : "C");
        __reg2.effectType = effectType;
        __reg2.stateForSettings = "Mode" + (numOfPlayers <= 2 ? "A" : "B");
        if (effectType == com.clubpenguin.world.rooms.weathereffects.WeatherEffectsManager.EFFECT_TYPE_DEFAULT && !this._playShadowEffect) 
        {
            __reg2.state = "ModeA";
        }
        __reg2.sky = com.clubpenguin.world.rooms.weathereffects.WeatherEffectsSettings[__reg2.tintType + effectType + com.clubpenguin.world.rooms.weathereffects.WeatherEffectsManager.OBJECT_TYPE_SKY + __reg2.stateForSettings];
        __reg2.clouds = com.clubpenguin.world.rooms.weathereffects.WeatherEffectsSettings[__reg2.tintType + effectType + com.clubpenguin.world.rooms.weathereffects.WeatherEffectsManager.OBJECT_TYPE_CLOUDS + __reg2.stateForSettings];
        __reg2.distantObjects = com.clubpenguin.world.rooms.weathereffects.WeatherEffectsSettings[__reg2.tintType + effectType + com.clubpenguin.world.rooms.weathereffects.WeatherEffectsManager.OBJECT_TYPE_DISTANT_OBJ + __reg2.stateForSettings];
        __reg2.topCoulds = com.clubpenguin.world.rooms.weathereffects.WeatherEffectsSettings[__reg2.tintType + effectType + com.clubpenguin.world.rooms.weathereffects.WeatherEffectsManager.OBJECT_TYPE_TOP_CLOUDS + __reg2.stateForSettings];
        com.greensock.TweenMax.to(this.background_mc.weatherEffects_mc.bgSky.bgSkyShadow.bgSkyColor, 0, {colorTransform: __reg2.sky});
    }

    function resetToDefaultValues()
    {
        if (this._currentColorState != this._colorDefaultState) 
        {
            this._nextColorMode = this.determineColorMode(0);
            this._currentColorState.toDefaultState();
        }
    }

    function isWearingFireOutfit(player)
    {
        if (player.head != com.clubpenguin.world.rooms.weathereffects.WeatherEffectsManager._FIRE_NINJA_HEAD_ITEM_ID) 
        {
            return false;
        }
        if (player.face != com.clubpenguin.world.rooms.weathereffects.WeatherEffectsManager._FIRE_NINJA_FACE_ITEM_ID) 
        {
            return false;
        }
        if (player.body != com.clubpenguin.world.rooms.weathereffects.WeatherEffectsManager._FIRE_NINJA_BODY_ITEM_ID) 
        {
            return false;
        }
        if (player.feet != com.clubpenguin.world.rooms.weathereffects.WeatherEffectsManager._FIRE_NINJA_FEET_ITEM_ID) 
        {
            return false;
        }
        return true;
    }

    function isWearingWaterOutfit(player)
    {
        if (player.head != com.clubpenguin.world.rooms.weathereffects.WeatherEffectsManager._WATER_NINJA_HEAD_ITEM_ID) 
        {
            return false;
        }
        if (player.face != com.clubpenguin.world.rooms.weathereffects.WeatherEffectsManager._WATER_NINJA_FACE_ITEM_ID) 
        {
            return false;
        }
        if (player.body != com.clubpenguin.world.rooms.weathereffects.WeatherEffectsManager._WATER_NINJA_BODY_ITEM_ID) 
        {
            return false;
        }
        if (player.feet != com.clubpenguin.world.rooms.weathereffects.WeatherEffectsManager._WATER_NINJA_FEET_ITEM_ID) 
        {
            return false;
        }
        return true;
    }

    function isWearingSnowOutfit(player)
    {
        if (player.head != com.clubpenguin.world.rooms.weathereffects.WeatherEffectsManager._SNOW_NINJA_HEAD_ITEM_ID) 
        {
            return false;
        }
        if (player.face != com.clubpenguin.world.rooms.weathereffects.WeatherEffectsManager._SNOW_NINJA_FACE_ITEM_ID) 
        {
            return false;
        }
        if (player.body != com.clubpenguin.world.rooms.weathereffects.WeatherEffectsManager._SNOW_NINJA_BODY_ITEM_ID) 
        {
            return false;
        }
        if (player.feet != com.clubpenguin.world.rooms.weathereffects.WeatherEffectsManager._SNOW_NINJA_FEET_ITEM_ID) 
        {
            return false;
        }
        return true;
    }

    function isWearingShadowOutfit(player)
    {
        if (player.head != com.clubpenguin.world.rooms.weathereffects.WeatherEffectsManager._SHADOW_NINJA_HEAD_ITEM_ID) 
        {
            return false;
        }
        if (player.face != com.clubpenguin.world.rooms.weathereffects.WeatherEffectsManager._SHADOW_NINJA_FACE_ITEM_ID) 
        {
            return false;
        }
        if (player.body != com.clubpenguin.world.rooms.weathereffects.WeatherEffectsManager._SHADOW_NINJA_BODY_ITEM_ID) 
        {
            return false;
        }
        if (player.feet != com.clubpenguin.world.rooms.weathereffects.WeatherEffectsManager._SHADOW_NINJA_FEET_ITEM_ID) 
        {
            return false;
        }
        return true;
    }

    function isDoingSpecialDance(player)
    {
        var __reg3 = this.SHELL.getSecretFrame(player.player_id, player.frame);
        if (player.frame == com.clubpenguin.world.rooms.weathereffects.WeatherEffectsManager._SPECIAL_DANCE_FRAME && player.frame != __reg3) 
        {
            return true;
        }
        return false;
    }

    function traceCurrentRoomStatus()
    {
        trace("=====================================");
        trace("FIRE DANCERS   " + this._dancingFirePlayers);
        trace("WATER DANCERS  " + this._dancingWaterPlayers);
        trace("SNOW DANCERS   " + this._dancingSnowPlayers);
        trace("SHADOW DANCERS " + this._dancingShadowPlayers);
        trace("PLAY FIRE EFFECT:   " + this._playFireEffect);
        trace("PLAY WATER EFFECT:  " + this._playWaterEffect);
        trace("PLAY SNOW EFFECT:   " + this._playSnowEffect);
        trace("PLAY SHADOW EFFECT: " + this._playShadowEffect);
        trace("===========================");
    }

    function destroy()
    {
        trace("WeatherEffectsManager -> destroy()");
        this.stopWeatherEffectCheck();
    }

}
