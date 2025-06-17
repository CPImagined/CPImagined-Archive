class com.clubpenguin.world.rooms.weathereffects.state.shadow.ShadowDefaultState extends com.clubpenguin.world.rooms.weathereffects.state.shadow.ShadowState implements com.clubpenguin.world.rooms.weathereffects.state.shadow.IShadowState
{
    var _wem, applyTinting, showClouds, removeClouds, playShadowEffect, stopShadowEffect;
    function ShadowDefaultState(manager)
    {
        super(manager);
    } // End of the function
    function toFireState()
    {
        this.resetState();
        _wem.__set__currentShadowState(_wem.shadowFireState);
    } // End of the function
    function toWaterState()
    {
        this.resetState();
        _wem.__set__currentShadowState(_wem.shadowWaterState);
    } // End of the function
    function toSnowState()
    {
        this.resetState();
        _wem.__set__currentShadowState(_wem.shadowSnowState);
    } // End of the function
    function toTieState()
    {
        this.resetState();
        _wem.__set__currentShadowState(_wem.shadowTieState);
    } // End of the function
    function toDefaultState()
    {
        if (_wem.__get__currentShadowMode() == _wem.__get__nextShadowMode())
        {
            return;
        } // end if
        this.applyTinting(_wem.__get__nextShadowMode().getMode(), com.clubpenguin.world.rooms.weathereffects.WeatherEffectsManager.EFFECT_TYPE_DEFAULT);
        if (_wem.__get__currentShadowMode().getMode() == "A")
        {
            this.showClouds();
        } // end if
        if (_wem.__get__nextShadowMode().getMode() == "A")
        {
            this.removeClouds();
        } // end if
        if (_wem.__get__nextShadowMode().getMode() == "C")
        {
            this.playShadowEffect();
        } // end if
        if (_wem.__get__currentShadowMode().getMode() == "C")
        {
            this.stopShadowEffect();
        } // end if
        _wem.__set__currentShadowState(_wem.shadowDefaultState);
    } // End of the function
    function toEmptyState()
    {
        this.resetState();
        _wem.__set__currentShadowState(_wem.shadowEmptyState);
    } // End of the function
    function applyState()
    {
        this.applyTinting(_wem.__get__currentShadowMode().getMode(), com.clubpenguin.world.rooms.weathereffects.WeatherEffectsManager.EFFECT_TYPE_DEFAULT);
        if (_wem.__get__currentShadowMode().getMode() == "B" || _wem.__get__currentShadowMode().getMode() == "C")
        {
            this.showClouds();
        } // end if
        if (_wem.__get__currentShadowMode().getMode() == "C")
        {
            this.playShadowEffect();
        } // end if
        if (_wem.__get__currentShadowMode().getMode() == "A")
        {
            this.removeClouds();
        } // end if
    } // End of the function
    function resetState()
    {
        if (_wem.__get__currentShadowMode().getMode() != "A" && _wem.__get__nextShadowMode().getMode() == "A")
        {
            this.removeClouds();
        } // end if
        if (_wem.__get__currentShadowMode().getMode() == "C" && _wem.__get__nextShadowMode().getMode() != "C")
        {
            this.stopShadowEffect();
        } // end if
    } // End of the function
} // End of Class
