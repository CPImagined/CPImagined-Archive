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
        trace("[SHADOW] from SNOW state to FIRE state");
    }

    function toWaterState()
    {
        this.resetState();
        this._wem.__set__currentShadowState(this._wem.shadowWaterState);
        trace("[SHADOW] from SNOW state to WATER state");
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
            trace("[SHADOW] MODE CHANGED TO: " + this._wem.__get__nextShadowMode());
            trace("[SHADOW] from SNOW state to SNOW state");
        }
    }

    function toTieState()
    {
        this.resetState();
        this._wem.__set__currentShadowState(this._wem.shadowTieState);
        trace("[SHADOW] from SNOW state to TIE state");
    }

    function toDefaultState()
    {
        this.resetState();
        this._wem.__set__currentShadowState(this._wem.shadowDefaultState);
        trace("[SHADOW] from SNOW state to DEFAULT state");
    }

    function toEmptyState()
    {
        this.resetState();
        this._wem.__set__currentShadowState(this._wem.shadowEmptyState);
        trace("[SHADOW] from SNOW state to EMPTY state");
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
        trace("[SHADOW] APPLYING SNOW STATE IN MODE " + this._wem.__get__currentShadowMode());
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
