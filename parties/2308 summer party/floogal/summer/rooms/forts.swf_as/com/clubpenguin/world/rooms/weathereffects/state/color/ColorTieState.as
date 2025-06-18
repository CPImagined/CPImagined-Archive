dynamic class com.clubpenguin.world.rooms.weathereffects.state.color.ColorTieState extends com.clubpenguin.world.rooms.weathereffects.state.color.ColorState implements com.clubpenguin.world.rooms.weathereffects.state.color.IColorState
{
    var _fireEffectGenerator;
    var _rainEffectGenerator;
    var _snowEffectGenerator;
    var _wem;
    var applyTinting;
    var fireEffect;
    var lightningEffect;
    var removeClouds;
    var showClouds;
    var snowEffect;
    var tieEffect;
    var waterEffect;

    function ColorTieState(manager)
    {
        super(manager);
        this._fireEffectGenerator = new com.clubpenguin.world.rooms.weathereffects.effect.FireEffectGenerator(this._wem);
        this._rainEffectGenerator = new com.clubpenguin.world.rooms.weathereffects.effect.RainEffectGenerator(this._wem);
        this._snowEffectGenerator = new com.clubpenguin.world.rooms.weathereffects.effect.SnowEffectGenerator(this._wem);
        this.setMovieClips();
    }

    function toFireState()
    {
        this.resetState();
        this._wem.__set__currentColorState(this._wem.colorFireState);
        trace("from TIE state to FIRE state");
    }

    function toWaterState()
    {
        this.resetState();
        this._wem.__set__currentColorState(this._wem.colorWaterState);
        trace("from TIE state to WATER state");
    }

    function toSnowState()
    {
        this.resetState();
        this._wem.__set__currentColorState(this._wem.colorSnowState);
        trace("from TIE state to SNOW state");
    }

    function toTieState()
    {
        if (this._wem.__get__currentColorMode().getMode() != this._wem.__get__nextColorMode().getMode()) 
        {
            this.applyTinting(this._wem.__get__nextColorMode().getMode(), com.clubpenguin.world.rooms.weathereffects.WeatherEffectsManager.EFFECT_TYPE_TIE);
            if (this._wem.__get__currentColorMode().getMode() == "A") 
            {
                this.showClouds();
                this.showLightningEffect();
            }
            if (this._wem.__get__nextColorMode().getMode() == "A") 
            {
                this.removeClouds();
                this.hideLightningEffect();
            }
            if (this._wem.__get__currentColorMode().getMode() == "C" || this._wem.__get__nextColorMode().getMode() != "C") 
            {
                this.stopTieEffect();
            }
            if (this._wem.__get__nextColorMode().getMode() == "C") 
            {
                this.playTieEffect();
            }
            this._wem.__set__currentColorMode(this._wem.nextColorMode);
            trace("MODE CHANGED TO: " + this._wem.__get__nextColorMode());
            trace("from TIE state to TIE state");
        }
    }

    function toDefaultState()
    {
        this.resetState();
        this._wem.__set__currentColorState(this._wem.colorDefaultState);
        trace("from TIE state to DEFAULT state");
    }

    function setMovieClips()
    {
        this.lightningEffect = this._wem.getBackogrundMC().weatherEffects_mc.lightningEffect;
        this.tieEffect = this._wem.getBackogrundMC().weatherEffects_mc.tieEffect;
        this.fireEffect = this._wem.getBackogrundMC().weatherEffects_mc.fireEffect;
        this.waterEffect = this._wem.getBackogrundMC().weatherEffects_mc.waterEffect;
        this.snowEffect = this._wem.getBackogrundMC().weatherEffects_mc.snowEffect;
    }

    function applyState()
    {
        this.applyTinting(this._wem.__get__currentColorMode().getMode(), com.clubpenguin.world.rooms.weathereffects.WeatherEffectsManager.EFFECT_TYPE_TIE);
        if (this._wem.__get__currentColorMode().getMode() == "A") 
        {
            this.showTieCloudsEffect();
        }
        if (this._wem.__get__currentColorMode().getMode() == "B" || this._wem.__get__currentColorMode().getMode() == "C") 
        {
            this.showTieCloudsEffect();
            this.showLightningEffect();
            this.showClouds();
        }
        if (this._wem.__get__currentColorMode().getMode() == "C") 
        {
            this.playTieEffect();
        }
        trace("APPLYING SNOW STATE IN MODE " + this._wem.__get__currentColorMode());
    }

    function playWeatherEffect(effectType)
    {
        if (this._wem.__get__currentColorMode().getMode() == "C") 
        {
            this._fireEffectGenerator.stopEffect();
            this._rainEffectGenerator.stopEffect();
            this._snowEffectGenerator.stopEffect();
            if ((__reg0 = effectType) === "fire") 
            {
                this._fireEffectGenerator.startEffect();
                return;
            }
            else if (__reg0 === "water") 
            {
                this._rainEffectGenerator.startEffect();
                return;
            }
            else if (__reg0 !== "snow") 
            {
                return;
            }
            this._snowEffectGenerator.startEffect();
            return;
        }
    }

    function resetState()
    {
        this.removeTieCloudsEffect();
        if (this._wem.__get__currentColorMode().getMode() != "A" && this._wem.__get__nextColorMode().getMode() == "A") 
        {
            this.removeClouds();
        }
        if (this._wem.__get__currentColorMode().getMode() == "C") 
        {
            this.stopTieEffect();
        }
    }

    function playTieEffect()
    {
        this._fireEffectGenerator.startEffect();
        trace("START TIE EFFECT");
        var __reg2 = new com.clubpenguin.world.rooms.weathereffects.effect.SnowEffectGenerator(this._wem, 10, 100);
    }

    function stopTieEffect()
    {
        this._fireEffectGenerator.stopEffect();
        this._rainEffectGenerator.stopEffect();
        this._snowEffectGenerator.stopEffect();
        trace("STOP TIE EFFECT");
    }

    function showLightningEffect()
    {
        this.lightningEffect.gotoAndPlay("on");
        trace("START LIGHTNING EFFECT");
    }

    function hideLightningEffect()
    {
        this.lightningEffect.gotoAndStop("hide");
        trace("HID LIGHTNING EFFECT");
    }

    function stopLightningEffect()
    {
        this.lightningEffect.gotoAndStop("off");
        trace("STOP LIGHTNING EFFECT");
    }

    function showTieCloudsEffect()
    {
        this.hideLightningEffect();
        this.tieEffect.gotoAndPlay("enter");
        trace("START TIE CLOUDS EFFECT");
    }

    function removeTieCloudsEffect()
    {
        this.stopLightningEffect();
        this.tieEffect.gotoAndPlay("leave");
        trace("STOP TIE CLOUDS EFFECT");
    }

}
