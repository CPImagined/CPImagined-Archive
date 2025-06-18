dynamic class com.clubpenguin.world.rooms.weathereffects.state.shadow.ShadowSnowState extends com.clubpenguin.world.rooms.weathereffects.state.shadow.ShadowState implements com.clubpenguin.world.rooms.weathereffects.state.shadow.IShadowState
{
    var _wem;
    var applyTinting;
    var playShadowEffect;
    var removeClouds;
    var showClouds;
    var stopShadowEffect;

    function ShadowSnowState(manager)
    {
        super(manager);
    }

    function toFireState()
    {
        this.resetState();
        this._wem.__set__currentShadowState(this._wem.shadowFireState);
    }

    function toWaterState()
    {
        this.resetState();
        this._wem.__set__currentShadowState(this._wem.shadowWaterState);
    }

    function toSnowState()
    {
        if (this._wem.__get__currentShadowMode().getMode() != this._wem.__get__nextShadowMode().getMode()) 
        {
            this.applyTinting(this._wem.__get__nextShadowMode().getMode(), com.clubpenguin.world.rooms.weathereffects.WeatherEffectsManager.EFFECT_TYPE_SNOW);
            if (this._wem.__get__currentShadowMode().getMode() == "A") 
            {
                this.showClouds();
            }
            if (this._wem.__get__nextShadowMode().getMode() == "A") 
            {
                this.removeClouds();
            }
            if (this._wem.__get__currentShadowMode().getMode() == "C") 
            {
                this.stopShadowEffect();
            }
            if (this._wem.__get__nextShadowMode().getMode() == "C") 
            {
                this.playShadowEffect();
            }
            this._wem.__set__currentShadowMode(this._wem.nextShadowMode);
        }
    }

    function toTieState()
    {
        this.resetState();
        this._wem.__set__currentShadowState(this._wem.shadowTieState);
    }

    function toDefaultState()
    {
        this.resetState();
        this._wem.__set__currentShadowState(this._wem.shadowDefaultState);
    }

    function toEmptyState()
    {
        this.resetState();
        this._wem.__set__currentShadowState(this._wem.shadowEmptyState);
    }

    function applyState()
    {
        this.applyTinting(this._wem.__get__currentShadowMode().getMode(), com.clubpenguin.world.rooms.weathereffects.WeatherEffectsManager.EFFECT_TYPE_SNOW);
        if (this._wem.__get__currentShadowMode().getMode() == "B" || this._wem.__get__currentShadowMode().getMode() == "C") 
        {
            this.showClouds();
        }
        if (this._wem.__get__currentShadowMode().getMode() == "C") 
        {
            this.playShadowEffect();
        }
        if (this._wem.__get__currentShadowMode().getMode() == "A") 
        {
            this.removeClouds();
        }
    }

    function resetState()
    {
        if (this._wem.__get__currentShadowMode().getMode() != "A" && this._wem.__get__nextShadowMode().getMode() == "A") 
        {
            this.removeClouds();
        }
        if (this._wem.__get__currentShadowMode().getMode() == "C" && this._wem.__get__nextShadowMode().getMode() != "C") 
        {
            this.stopShadowEffect();
        }
    }

}
