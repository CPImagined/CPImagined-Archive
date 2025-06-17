class com.clubpenguin.world.rooms.weathereffects.state.color.ColorTieState extends com.clubpenguin.world.rooms.weathereffects.state.color.ColorState implements com.clubpenguin.world.rooms.weathereffects.state.color.IColorState
{
    var _wem, _fireEffectGenerator, _rainEffectGenerator, _snowEffectGenerator, applyTinting, showClouds, removeClouds, lightningEffect, tieEffect, fireEffect, waterEffect, snowEffect;
    function ColorTieState(manager)
    {
        super(manager);
        _fireEffectGenerator = new com.clubpenguin.world.rooms.weathereffects.effect.FireEffectGenerator(_wem);
        _rainEffectGenerator = new com.clubpenguin.world.rooms.weathereffects.effect.RainEffectGenerator(_wem);
        _snowEffectGenerator = new com.clubpenguin.world.rooms.weathereffects.effect.SnowEffectGenerator(_wem);
        this.setMovieClips();
    } // End of the function
    function toFireState()
    {
        this.resetState();
        _wem.__set__currentColorState(_wem.colorFireState);
    } // End of the function
    function toWaterState()
    {
        this.resetState();
        _wem.__set__currentColorState(_wem.colorWaterState);
    } // End of the function
    function toSnowState()
    {
        this.resetState();
        _wem.__set__currentColorState(_wem.colorSnowState);
    } // End of the function
    function toTieState()
    {
        if (_wem.__get__currentColorMode().getMode() == _wem.__get__nextColorMode().getMode())
        {
            return;
        } // end if
        this.applyTinting(_wem.__get__nextColorMode().getMode(), com.clubpenguin.world.rooms.weathereffects.WeatherEffectsManager.EFFECT_TYPE_TIE);
        if (_wem.__get__currentColorMode().getMode() == "A")
        {
            this.showClouds();
            this.showLightningEffect();
        } // end if
        if (_wem.__get__nextColorMode().getMode() == "A")
        {
            this.removeClouds();
            this.hideLightningEffect();
        } // end if
        if (_wem.__get__currentColorMode().getMode() == "C" || _wem.__get__nextColorMode().getMode() != "C")
        {
            this.stopTieEffect();
        } // end if
        if (_wem.__get__nextColorMode().getMode() == "C")
        {
            this.playTieEffect();
        } // end if
        _wem.__set__currentColorMode(_wem.nextColorMode);
    } // End of the function
    function toDefaultState()
    {
        this.resetState();
        _wem.__set__currentColorState(_wem.colorDefaultState);
    } // End of the function
    function setMovieClips()
    {
        lightningEffect = _wem.getBackogrundMC().weatherEffects_mc.lightningEffect;
        tieEffect = _wem.getBackogrundMC().weatherEffects_mc.tieEffect;
        fireEffect = _wem.getBackogrundMC().weatherEffects_mc.fireEffect;
        waterEffect = _wem.getBackogrundMC().weatherEffects_mc.waterEffect;
        snowEffect = _wem.getBackogrundMC().weatherEffects_mc.snowEffect;
    } // End of the function
    function applyState()
    {
        this.applyTinting(_wem.__get__currentColorMode().getMode(), com.clubpenguin.world.rooms.weathereffects.WeatherEffectsManager.EFFECT_TYPE_TIE);
        if (_wem.__get__currentColorMode().getMode() == "A")
        {
            this.showTieCloudsEffect();
        } // end if
        if (_wem.__get__currentColorMode().getMode() == "B" || _wem.__get__currentColorMode().getMode() == "C")
        {
            this.showTieCloudsEffect();
            this.showLightningEffect();
            this.showClouds();
        } // end if
        if (_wem.__get__currentColorMode().getMode() == "C")
        {
            this.playTieEffect();
        } // end if
    } // End of the function
    function playWeatherEffect(effectType)
    {
        if (_wem.__get__currentColorMode().getMode() != "C")
        {
            return;
        } // end if
        _fireEffectGenerator.stopEffect();
        _rainEffectGenerator.stopEffect();
        _snowEffectGenerator.stopEffect();
        switch (effectType)
        {
            case "fire":
            {
                _fireEffectGenerator.startEffect();
                break;
            } 
            case "water":
            {
                _rainEffectGenerator.startEffect();
                break;
            } 
            case "snow":
            {
                _snowEffectGenerator.startEffect();
                break;
            } 
        } // End of switch
    } // End of the function
    function resetState()
    {
        this.removeTieCloudsEffect();
        if (_wem.__get__currentColorMode().getMode() != "A" && _wem.__get__nextColorMode().getMode() == "A")
        {
            this.removeClouds();
        } // end if
        if (_wem.__get__currentColorMode().getMode() == "C")
        {
            this.stopTieEffect();
        } // end if
    } // End of the function
    function playTieEffect()
    {
        _fireEffectGenerator.startEffect();
        var _loc2 = new com.clubpenguin.world.rooms.weathereffects.effect.SnowEffectGenerator(_wem, 10, 100);
    } // End of the function
    function stopTieEffect()
    {
        _fireEffectGenerator.stopEffect();
        _rainEffectGenerator.stopEffect();
        _snowEffectGenerator.stopEffect();
    } // End of the function
    function showLightningEffect()
    {
        lightningEffect.gotoAndPlay("on");
    } // End of the function
    function hideLightningEffect()
    {
        lightningEffect.gotoAndStop("hide");
    } // End of the function
    function stopLightningEffect()
    {
        lightningEffect.gotoAndStop("off");
    } // End of the function
    function showTieCloudsEffect()
    {
        this.hideLightningEffect();
        tieEffect.gotoAndPlay("enter");
    } // End of the function
    function removeTieCloudsEffect()
    {
        this.stopLightningEffect();
        tieEffect.gotoAndPlay("leave");
    } // End of the function
} // End of Class
