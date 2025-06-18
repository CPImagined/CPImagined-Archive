dynamic class com.clubpenguin.world.rooms.weathereffects.state.shadow.ShadowEmptyState extends com.clubpenguin.world.rooms.weathereffects.state.shadow.ShadowState implements com.clubpenguin.world.rooms.weathereffects.state.shadow.IShadowState
{
    var _wem;
    var applyTinting;

    function ShadowEmptyState(manager)
    {
        super(manager);
    }

    function toFireState()
    {
        this._wem.__set__currentShadowState(this._wem.shadowFireState);
    }

    function toWaterState()
    {
        this._wem.__set__currentShadowState(this._wem.shadowWaterState);
    }

    function toSnowState()
    {
        this._wem.__set__currentShadowState(this._wem.shadowSnowState);
    }

    function toTieState()
    {
        this._wem.__set__currentShadowState(this._wem.shadowTieState);
    }

    function toDefaultState()
    {
        this._wem.__set__currentShadowState(this._wem.shadowDefaultState);
    }

    function toEmptyState()
    {
        if (this._wem.__get__currentShadowMode().getMode() == this._wem.__get__nextShadowMode().getMode()) 
        {
            return undefined;
        }
    }

    function applyState()
    {
        this.applyTinting(this._wem.__get__currentShadowMode().getMode(), com.clubpenguin.world.rooms.weathereffects.WeatherEffectsManager.EFFECT_TYPE_EMPTY);
    }

}
