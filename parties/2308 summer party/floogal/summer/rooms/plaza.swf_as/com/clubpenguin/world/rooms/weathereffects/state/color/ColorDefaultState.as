dynamic class com.clubpenguin.world.rooms.weathereffects.state.color.ColorDefaultState extends com.clubpenguin.world.rooms.weathereffects.state.color.ColorState implements com.clubpenguin.world.rooms.weathereffects.state.color.IColorState
{
    var _wem;
    var applyTinting;

    function ColorDefaultState(manager)
    {
        super(manager);
    }

    function toFireState()
    {
        this._wem.__set__currentColorState(this._wem.colorFireState);
        trace("from DEFAULT state to FIRE state");
    }

    function toWaterState()
    {
        this._wem.__set__currentColorState(this._wem.colorWaterState);
        trace("from DEFAULT state to WATER state");
    }

    function toSnowState()
    {
        this._wem.__set__currentColorState(this._wem.colorSnowState);
        trace("from DEFAULT state to SNOW state");
    }

    function toTieState()
    {
        this._wem.__set__currentColorState(this._wem.colorTieState);
        trace("from DEFAULT state to TIE state");
    }

    function toDefaultState()
    {
        if (this._wem.__get__currentColorMode().getMode() != this._wem.__get__nextColorMode().getMode()) 
        {
            this.applyTinting(this._wem.__get__nextColorMode().getMode(), com.clubpenguin.world.rooms.weathereffects.WeatherEffectsManager.EFFECT_TYPE_DEFAULT);
            this._wem.__set__currentColorState(this._wem.colorDefaultState);
            trace("from DEFAULT state to DEFAULT state");
        }
    }

    function applyState()
    {
        this.applyTinting(this._wem.__get__currentColorMode().getMode(), com.clubpenguin.world.rooms.weathereffects.WeatherEffectsManager.EFFECT_TYPE_DEFAULT);
        trace("APPLYING DEFAULT STATE IN MODE " + this._wem.__get__currentColorMode());
    }

    function playWeatherEffect(effectType)
    {
        trace("DO NOTHING");
    }

}
