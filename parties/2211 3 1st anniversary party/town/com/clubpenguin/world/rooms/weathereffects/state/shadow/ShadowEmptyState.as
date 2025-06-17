class com.clubpenguin.world.rooms.weathereffects.state.shadow.ShadowEmptyState extends com.clubpenguin.world.rooms.weathereffects.state.shadow.ShadowState implements com.clubpenguin.world.rooms.weathereffects.state.shadow.IShadowState
{
    var _wem, applyTinting;
    function ShadowEmptyState(manager)
    {
        super(manager);
    } // End of the function
    function toFireState()
    {
        _wem.__set__currentShadowState(_wem.shadowFireState);
    } // End of the function
    function toWaterState()
    {
        _wem.__set__currentShadowState(_wem.shadowWaterState);
    } // End of the function
    function toSnowState()
    {
        _wem.__set__currentShadowState(_wem.shadowSnowState);
    } // End of the function
    function toTieState()
    {
        _wem.__set__currentShadowState(_wem.shadowTieState);
    } // End of the function
    function toDefaultState()
    {
        _wem.__set__currentShadowState(_wem.shadowDefaultState);
    } // End of the function
    function toEmptyState()
    {
        if (_wem.__get__currentShadowMode().getMode() == _wem.__get__nextShadowMode().getMode())
        {
            return;
        } // end if
    } // End of the function
    function applyState()
    {
        this.applyTinting(_wem.__get__currentShadowMode().getMode(), com.clubpenguin.world.rooms.weathereffects.WeatherEffectsManager.EFFECT_TYPE_EMPTY);
    } // End of the function
} // End of Class
