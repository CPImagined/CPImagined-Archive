dynamic class com.clubpenguin.world.rooms.weathereffects.state.shadow.ShadowState
{
    var _tintObject;
    var _wem;
    var bgCloudsShadow;
    var bgDistantShadow;
    var bgSkyShadow;
    var cloudsEffect;
    var cloudsEffectShadow;
    var shadowEffect;

    function ShadowState(manager)
    {
        this._wem = manager;
        this._tintObject = new Object();
        this._tintObject.tintType = "shadow";
        this.setDefaultMovieClips();
    }

    function tweenComplete(obj)
    {
    }

    function setDefaultMovieClips()
    {
        var __reg2 = this._wem.getBackogrundMC().weatherEffects_mc;
        this.bgCloudsShadow = __reg2.bgClouds.bgCloudsShadow;
        this.bgDistantShadow = __reg2.bgDistant.bgDistantShadow;
        this.bgSkyShadow = __reg2.bgSky.bgSkyShadow;
        this.cloudsEffect = this._wem.getBackogrundMC().weatherEffects_mc.cloudsEffect.cloudsEffectColor;
        this.cloudsEffectShadow = this._wem.getBackogrundMC().weatherEffects_mc.cloudsEffect;
        this.shadowEffect = this._wem.getBackogrundMC().weatherEffects_mc.shadowEffect;
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
        this._tintObject.shell = com.clubpenguin.world.rooms.weathereffects.WeatherEffectsSettings[this._tintObject.tintType + com.clubpenguin.world.rooms.weathereffects.WeatherEffectsManager.OBJECT_TYPE_SHELL + this._tintObject.state];
        if (effectType == com.clubpenguin.world.rooms.weathereffects.WeatherEffectsManager.EFFECT_TYPE_EMPTY) 
        {
            this._tintObject.shell = com.clubpenguin.world.rooms.weathereffects.WeatherEffectsSettings[this._tintObject.tintType + effectType + com.clubpenguin.world.rooms.weathereffects.WeatherEffectsManager.OBJECT_TYPE_SHELL + this._tintObject.stateForSettings];
        }
    }

    function applyTinting(mode, effectType)
    {
        this.setTintValues(mode, effectType);
        com.greensock.TweenLite.to(this.bgSkyShadow, 2, {colorTransform: this._tintObject.sky, onComplete: this.tweenComplete});
        com.greensock.TweenLite.to(this.bgDistantShadow, 2, {colorTransform: this._tintObject.distantObjects, onComplete: this.tweenComplete});
        com.greensock.TweenLite.to(this.bgCloudsShadow, 2, {colorTransform: this._tintObject.clouds, onComplete: this.tweenComplete});
        com.greensock.TweenLite.to(this.cloudsEffectShadow, 2, {colorTransform: this._tintObject.topCoulds, onComplete: this.tweenComplete});
        com.greensock.TweenLite.to(this._wem.SHELL, 0, {colorTransform: this._tintObject.shell, onComplete: this.tweenComplete});
        trace("[SHADOW] PLAYING WEATHER EFFECT: " + this._tintObject.tintType + " " + this._tintObject.state + " " + this._tintObject.effectType);
    }

    function showClouds()
    {
        if (this.cloudsEffect._currentFrame == 1) 
        {
            this.cloudsEffect.gotoAndPlay("enter");
            trace("[SHADOW] SHOW CLOUDS");
        }
    }

    function removeClouds()
    {
        trace("[SHADOW] NEXT COLOR MODE: " + this._wem.__get__nextColorMode().getMode());
        if (this._wem.__get__nextShadowMode().getMode() == "A" && this._wem.__get__nextColorMode().getMode() == "A" && this.cloudsEffect._currentFrame != 1) 
        {
            this.cloudsEffect.gotoAndPlay("leave");
            trace("[SHADOW] REMOVE CLOUDS");
        }
    }

    function playShadowEffect()
    {
        if (this.shadowEffect._currentFrame == 1) 
        {
            this.shadowEffect.gotoAndPlay("enter");
        }
        trace("[SHADOW] START SHADOW EFFECT");
    }

    function stopShadowEffect()
    {
        if (this.shadowEffect._currentFrame != 1) 
        {
            this.shadowEffect.gotoAndPlay("leave");
        }
        trace("[SHADOW] STOP SHADOW EFFECT");
    }

}
