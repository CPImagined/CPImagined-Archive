dynamic class com.clubpenguin.world.rooms.weathereffects.state.color.ColorWaterState extends com.clubpenguin.world.rooms.weathereffects.state.color.ColorState implements com.clubpenguin.world.rooms.weathereffects.state.color.IColorState
{
    var _rainEffectGenerator;
    var _wem;
    var applyTinting;
    var removeClouds;
    var showClouds;
    var waterEffect;

    function ColorWaterState(manager)
    {
        super(manager);
        this._rainEffectGenerator = new com.clubpenguin.world.rooms.weathereffects.effect.RainEffectGenerator(this._wem);
        this.setMovieClips();
    }

    function toFireState()
    {
        this.resetState();
        this._wem.__set__currentColorState(this._wem.colorFireState);
        trace("from WATER state to FIRE state");
    }

    function toWaterState()
    {
        if (this._wem.__get__currentColorMode().getMode() != this._wem.__get__nextColorMode().getMode()) 
        {
            this.applyTinting(this._wem.__get__nextColorMode().getMode(), com.clubpenguin.world.rooms.weathereffects.WeatherEffectsManager.EFFECT_TYPE_WATER);
            if (this._wem.__get__currentColorMode().getMode() == "A") 
            {
                this.showClouds();
            }
            if (this._wem.__get__nextColorMode().getMode() == "A") 
            {
                this.removeClouds();
            }
            if (this._wem.__get__currentColorMode().getMode() == "C") 
            {
                this.stopWaterEffect();
            }
            if (this._wem.__get__nextColorMode().getMode() == "C") 
            {
                this.playWaterEffect();
            }
            this._wem.__set__currentColorMode(this._wem.nextColorMode);
            trace("MODE CHANGED TO: " + this._wem.__get__nextColorMode());
            trace("from WATER state to WATER state");
        }
    }

    function toSnowState()
    {
        this.resetState();
        this._wem.__set__currentColorState(this._wem.colorSnowState);
        trace("from WATER state to SNOW state");
    }

    function toTieState()
    {
        this.resetState();
        this._wem.__set__currentColorState(this._wem.colorTieState);
        trace("from WATER state to TIE state");
    }

    function toDefaultState()
    {
        if (this._wem.__get__currentColorMode().getMode() == "C") 
        {
            this.stopWaterEffect();
        }
        if (this._wem.__get__currentColorMode().getMode() != "A") 
        {
            this.removeClouds();
        }
        this._wem.__set__currentColorState(this._wem.colorDefaultState);
        trace("from WATER state to DEFAULT state");
    }

    function setMovieClips()
    {
        this.waterEffect = this._wem.getBackogrundMC().weatherEffects_mc.waterEffect;
    }

    function applyState()
    {
        this.applyTinting(this._wem.__get__currentColorMode().getMode(), com.clubpenguin.world.rooms.weathereffects.WeatherEffectsManager.EFFECT_TYPE_WATER);
        if (this._wem.__get__currentColorMode().getMode() == "B" || this._wem.__get__currentColorMode().getMode() == "C") 
        {
            this.showClouds();
        }
        if (this._wem.__get__currentColorMode().getMode() == "C") 
        {
            this.playWaterEffect();
        }
        trace("APPLYING WATER STATE IN MODE " + this._wem.__get__currentColorMode());
    }

    function playWeatherEffect(effectType)
    {
        trace("DO NOTHING");
    }

    function resetState()
    {
        if (this._wem.__get__currentColorMode().getMode() != "A" && this._wem.__get__nextColorMode().getMode() == "A") 
        {
            this.removeClouds();
        }
        if (this._wem.__get__currentColorMode().getMode() == "C") 
        {
            this.stopWaterEffect();
        }
    }

    function playWaterEffect()
    {
        this._rainEffectGenerator.startEffect();
        trace("START WATER EFFECT");
    }

    function stopWaterEffect()
    {
        this._rainEffectGenerator.stopEffect();
        trace("STOP WATER EFFECT");
    }

}
