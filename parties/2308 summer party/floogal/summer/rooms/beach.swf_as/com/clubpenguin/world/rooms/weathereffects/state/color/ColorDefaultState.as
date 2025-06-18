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
    }

    function toWaterState()
    {
        this._wem.__set__currentColorState(this._wem.colorWaterState);
    }

    function toSnowState()
    {
        this._wem.__set__currentColorState(this._wem.colorSnowState);
    }

    function toTieState()
    {
        this._wem.__set__currentColorState(this._wem.colorTieState);
    }

    function toDefaultState()
    {
        if (this._wem.__get__currentColorMode().getMode() != this._wem.__get__nextColorMode().getMode()) 
        {
            this.applyTinting(this._wem.__get__nextColorMode().getMode(), com.clubpenguin.world.rooms.weathereffects.WeatherEffectsManager.EFFECT_TYPE_DEFAULT);
            this._wem.__set__currentColorState(this._wem.colorDefaultState);
        }
    }

    function applyState()
    {
        this.applyTinting(this._wem.__get__currentColorMode().getMode(), com.clubpenguin.world.rooms.weathereffects.WeatherEffectsManager.EFFECT_TYPE_DEFAULT);
    }

    function playWeatherEffect(effectType)
    {
    }

}
