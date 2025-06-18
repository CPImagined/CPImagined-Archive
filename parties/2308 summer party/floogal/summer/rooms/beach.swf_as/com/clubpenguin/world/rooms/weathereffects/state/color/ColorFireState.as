dynamic class com.clubpenguin.world.rooms.weathereffects.state.color.ColorFireState extends com.clubpenguin.world.rooms.weathereffects.state.color.ColorState implements com.clubpenguin.world.rooms.weathereffects.state.color.IColorState
{
    var _fireEffectGenerator;
    var _wem;
    var applyTinting;
    var fireEffect;
    var removeClouds;
    var showClouds;

    function ColorFireState(manager)
    {
        super(manager);
        this._fireEffectGenerator = new com.clubpenguin.world.rooms.weathereffects.effect.FireEffectGenerator(this._wem);
        this.setMovieClips();
    }

    function tweenComplete(obj)
    {
    }

    function toFireState()
    {
        if (this._wem.__get__currentColorMode().getMode() != this._wem.__get__nextColorMode().getMode()) 
        {
            this.applyTinting(this._wem.__get__nextColorMode().getMode(), com.clubpenguin.world.rooms.weathereffects.WeatherEffectsManager.EFFECT_TYPE_FIRE);
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
                this.stopFireEffect();
            }
            if (this._wem.__get__nextColorMode().getMode() == "C") 
            {
                this.playFireEffect();
            }
            this._wem.__set__currentColorMode(this._wem.nextColorMode);
        }
    }

    function toWaterState()
    {
        this.resetState();
        this._wem.__set__currentColorState(this._wem.colorWaterState);
    }

    function toSnowState()
    {
        this.resetState();
        this._wem.__set__currentColorState(this._wem.colorSnowState);
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
            this.stopFireEffect();
        }
        if (this._wem.__get__currentColorMode().getMode() != "A") 
        {
            this.removeClouds();
        }
        this._wem.__set__currentColorState(this._wem.colorDefaultState);
    }

    function setMovieClips()
    {
        this.fireEffect = this._wem.getBackogrundMC().weatherEffects_mc.fireEffect;
    }

    function applyState()
    {
        this.applyTinting(this._wem.__get__currentColorMode().getMode(), com.clubpenguin.world.rooms.weathereffects.WeatherEffectsManager.EFFECT_TYPE_FIRE);
        if (this._wem.__get__currentColorMode().getMode() == "B" || this._wem.__get__currentColorMode().getMode() == "C") 
        {
            this.showClouds();
        }
        if (this._wem.__get__currentColorMode().getMode() == "C") 
        {
            this.playFireEffect();
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
            this.stopFireEffect();
        }
    }

    function playFireEffect()
    {
        this._fireEffectGenerator.startEffect();
    }

    function stopFireEffect()
    {
        this._fireEffectGenerator.stopEffect();
        this.fireEffect.gotoAndStop("off");
    }

}
