dynamic class com.clubpenguin.world.rooms.weathereffects.state.color.ColorState
{
    var _tintObject;
    var _wem;
    var bgCloudsColor;
    var bgDistantColor;
    var bgSkyColor;
    var cloudsEffectColor;

    function ColorState(manager)
    {
        this._wem = manager;
        this._tintObject = new Object();
        this._tintObject.tintType = "color";
        this.setDefaultMovieClips();
    }

    function tweenComplete(obj)
    {
    }

    function setDefaultMovieClips()
    {
        var __reg2 = this._wem.getBackogrundMC().weatherEffects_mc;
        this.bgCloudsColor = __reg2.bgClouds.bgCloudsShadow.bgCloudsColor;
        this.bgDistantColor = __reg2.bgDistant.bgDistantShadow.bgDistantColor;
        this.bgSkyColor = __reg2.bgSky.bgSkyShadow.bgSkyColor;
        this.cloudsEffectColor = this._wem.getBackogrundMC().weatherEffects_mc.cloudsEffect.cloudsEffectColor;
    }

    function setTintValues(mode, effectType)
    {
        this._tintObject.state = "Mode" + mode;
        this._tintObject.effectType = effectType;
        this._tintObject.stateForSettings = "Mode" + (mode == "A" ? "A" : "B");
        this._tintObject.sky = com.clubpenguin.world.rooms.weathereffects.WeatherEffectsSettings[this._tintObject.tintType + effectType + com.clubpenguin.world.rooms.weathereffects.WeatherEffectsManager.OBJECT_TYPE_SKY + this._tintObject.stateForSettings];
        this._tintObject.clouds = com.clubpenguin.world.rooms.weathereffects.WeatherEffectsSettings[this._tintObject.tintType + effectType + com.clubpenguin.world.rooms.weathereffects.WeatherEffectsManager.OBJECT_TYPE_CLOUDS + this._tintObject.stateForSettings];
        this._tintObject.distantObjects = com.clubpenguin.world.rooms.weathereffects.WeatherEffectsSettings[this._tintObject.tintType + effectType + com.clubpenguin.world.rooms.weathereffects.WeatherEffectsManager.OBJECT_TYPE_DISTANT_OBJ + this._tintObject.stateForSettings];
        this._tintObject.topCoulds = com.clubpenguin.world.rooms.weathereffects.WeatherEffectsSettings[this._tintObject.tintType + effectType + com.clubpenguin.world.rooms.weathereffects.WeatherEffectsManager.OBJECT_TYPE_TOP_CLOUDS + this._tintObject.stateForSettings];
    }

    function applyTinting(mode, effectType)
    {
        this.setTintValues(mode, effectType);
        com.greensock.TweenLite.to(this.bgSkyColor, 2, {colorTransform: this._tintObject.sky, onComplete: this.tweenComplete});
        com.greensock.TweenLite.to(this.bgDistantColor, 2, {colorTransform: this._tintObject.distantObjects, onComplete: this.tweenComplete});
        com.greensock.TweenLite.to(this.bgCloudsColor, 2, {colorTransform: this._tintObject.clouds, onComplete: this.tweenComplete});
        com.greensock.TweenLite.to(this.cloudsEffectColor, 2, {colorTransform: this._tintObject.topCoulds, onComplete: this.tweenComplete});
        trace("PLAYING WEATHER EFFECT: " + this._tintObject.tintType + " " + this._tintObject.state + " " + this._tintObject.effectType);
    }

    function showClouds()
    {
        if (this.cloudsEffectColor._currentFrame == 1) 
        {
            this.cloudsEffectColor.gotoAndPlay("enter");
            trace("SHOW CLOUDS");
        }
    }

    function removeClouds()
    {
        trace("NEXT SHADOW MODE: " + this._wem.__get__nextShadowMode().getMode());
        trace("NEXT COLOR MODE: " + this._wem.__get__nextColorMode().getMode());
        trace("CLOUDS FRAME: " + this.cloudsEffectColor._currentFrame);
        if (this._wem.__get__nextShadowMode().getMode() == "A" && this._wem.__get__nextColorMode().getMode() == "A" && this.cloudsEffectColor._currentFrame != 1) 
        {
            this.cloudsEffectColor.gotoAndPlay("leave");
            trace("REMOVE CLOUDS");
        }
    }

}
