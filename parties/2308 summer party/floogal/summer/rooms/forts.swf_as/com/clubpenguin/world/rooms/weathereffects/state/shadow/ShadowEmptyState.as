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
        trace("[SHADOW] from EMPTY state to FIRE state");
    }

    function toWaterState()
    {
        this._wem.__set__currentShadowState(this._wem.shadowWaterState);
        trace("[SHADOW] from EMPTY state to WATER state");
    }

    function toSnowState()
    {
        this._wem.__set__currentShadowState(this._wem.shadowSnowState);
        trace("[SHADOW] from EMPTY state to SNOW state");
    }

    function toTieState()
    {
        this._wem.__set__currentShadowState(this._wem.shadowTieState);
        trace("[SHADOW] from EMPTY state to TIE state");
    }

    function toDefaultState()
    {
        this._wem.__set__currentShadowState(this._wem.shadowDefaultState);
        trace("[SHADOW] from EMPTY state to DEFAULT state");
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
        trace("[SHADOW] APPLYING EMPTY STATE IN MODE " + this._wem.__get__currentShadowMode());
    }

}
