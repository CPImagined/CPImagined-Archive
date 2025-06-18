dynamic class com.clubpenguin.world.rooms.weathereffects.state.color.ColorSnowState extends com.clubpenguin.world.rooms.weathereffects.state.color.ColorState implements com.clubpenguin.world.rooms.weathereffects.state.color.IColorState
{
    var _snowEffectGenerator;
    var _wem;
    var applyTinting;
    var removeClouds;
    var showClouds;
    var snowEffect;

    function ColorSnowState(manager)
    {
        super(manager);
        this._snowEffectGenerator = new com.clubpenguin.world.rooms.weathereffects.effect.SnowEffectGenerator(this._wem);
        this.setMovieClips();
    }

    function toFireState()
    {
        this.resetState();
        this._wem.__set__currentColorState(this._wem.colorFireState);
    }

    function toWaterState()
    {
        this.resetState();
        this._wem.__set__currentColorState(this._wem.colorWaterState);
    }

    function toSnowState()
    {
        if (this._wem.__get__currentColorMode().getMode() != this._wem.__get__nextColorMode().getMode()) 
        {
            this.applyTinting(this._wem.__get__nextColorMode().getMode(), com.clubpenguin.world.rooms.weathereffects.WeatherEffectsManager.EFFECT_TYPE_SNOW);
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
                this.stopSnowEffect();
            }
            if (this._wem.__get__nextColorMode().getMode() == "C") 
            {
                this.playSnowEffect();
            }
            this._wem.__set__currentColorMode(this._wem.nextColorMode);
        }
    }

    function toTieState()
    {
        this.resetState();
        this._wem.__set__currentColorState(this._wem.colorTieState);
    }

    function toDefaultState()
    {
        if (this._wem.__get__currentColorMode().getMode() == "C") 
        {
            this.stopSnowEffect();
        }
        if (this._wem.__get__currentColorMode().getMode() != "A") 
        {
            this.removeClouds();
        }
        this._wem.__set__currentColorState(this._wem.colorDefaultState);
    }

    function setMovieClips()
    {
        this.snowEffect = this._wem.getBackogrundMC().weatherEffects_mc.snowEffect;
    }

    function applyState()
    {
        this.applyTinting(this._wem.__get__currentColorMode().getMode(), com.clubpenguin.world.rooms.weathereffects.WeatherEffectsManager.EFFECT_TYPE_SNOW);
        if (this._wem.__get__currentColorMode().getMode() == "B" || this._wem.__get__currentColorMode().getMode() == "C") 
        {
            this.showClouds();
        }
        if (this._wem.__get__currentColorMode().getMode() == "C") 
        {
            this.playSnowEffect();
        }
    }

    function playWeatherEffect(effectType)
    {
    }

    function resetState()
    {
        if (this._wem.__get__currentColorMode().getMode() != "A" && this._wem.__get__nextColorMode().getMode() == "A") 
        {
            this.removeClouds();
        }
        if (this._wem.__get__currentColorMode().getMode() == "C") 
        {
            this.stopSnowEffect();
        }
    }

    function playSnowEffect()
    {
        this._snowEffectGenerator.startEffect();
    }

    function stopSnowEffect()
    {
        this._snowEffectGenerator.stopEffect();
    }

}
