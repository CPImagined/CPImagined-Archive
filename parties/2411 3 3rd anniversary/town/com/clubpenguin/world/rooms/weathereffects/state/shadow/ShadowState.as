    class com.clubpenguin.world.rooms.weathereffects.state.shadow.ShadowState
    {
        var _wem, _tintObject, bgCloudsShadow, bgDistantShadow, bgSkyShadow, cloudsEffect, cloudsEffectShadow, shadowEffect;
        function ShadowState (manager) {
            _wem = manager;
            _tintObject = new Object();
            _tintObject.tintType = "shadow";
            setDefaultMovieClips();
        }
        function tweenComplete(obj) {
        }
        function setDefaultMovieClips() {
            var _local_2 = _wem.getBackogrundMC().weatherEffects_mc;
            bgCloudsShadow = _local_2.bgClouds.bgCloudsShadow;
            bgDistantShadow = _local_2.bgDistant.bgDistantShadow;
            bgSkyShadow = _local_2.bgSky.bgSkyShadow;
            cloudsEffect = _wem.getBackogrundMC().weatherEffects_mc.cloudsEffect.cloudsEffectColor;
            cloudsEffectShadow = _wem.getBackogrundMC().weatherEffects_mc.cloudsEffect;
            shadowEffect = _wem.getBackogrundMC().weatherEffects_mc.shadowEffect;
        }
        function setTintValues(mode, effectType) {
            _tintObject.state = "Mode" + mode;
            _tintObject.effectType = effectType;
            _tintObject.stateForSettings = "Mode" + ((mode == "A") ? "A" : "B");
            _tintObject.sky = com.clubpenguin.world.rooms.weathereffects.WeatherEffectsSettings[((_tintObject.tintType + effectType) + com.clubpenguin.world.rooms.weathereffects.WeatherEffectsManager.OBJECT_TYPE_SKY) + _tintObject.stateForSettings];
            _tintObject.clouds = com.clubpenguin.world.rooms.weathereffects.WeatherEffectsSettings[((_tintObject.tintType + effectType) + com.clubpenguin.world.rooms.weathereffects.WeatherEffectsManager.OBJECT_TYPE_CLOUDS) + _tintObject.stateForSettings];
            _tintObject.distantObjects = com.clubpenguin.world.rooms.weathereffects.WeatherEffectsSettings[((_tintObject.tintType + effectType) + com.clubpenguin.world.rooms.weathereffects.WeatherEffectsManager.OBJECT_TYPE_DISTANT_OBJ) + _tintObject.stateForSettings];
            _tintObject.topCoulds = com.clubpenguin.world.rooms.weathereffects.WeatherEffectsSettings[((_tintObject.tintType + effectType) + com.clubpenguin.world.rooms.weathereffects.WeatherEffectsManager.OBJECT_TYPE_TOP_CLOUDS) + _tintObject.stateForSettings];
            _tintObject.shell = com.clubpenguin.world.rooms.weathereffects.WeatherEffectsSettings[(_tintObject.tintType + com.clubpenguin.world.rooms.weathereffects.WeatherEffectsManager.OBJECT_TYPE_SHELL) + _tintObject.state];
            if (effectType == com.clubpenguin.world.rooms.weathereffects.WeatherEffectsManager.EFFECT_TYPE_EMPTY) {
                _tintObject.shell = com.clubpenguin.world.rooms.weathereffects.WeatherEffectsSettings[((_tintObject.tintType + effectType) + com.clubpenguin.world.rooms.weathereffects.WeatherEffectsManager.OBJECT_TYPE_SHELL) + _tintObject.stateForSettings];
            }
        }
        function applyTinting(mode, effectType) {
            setTintValues(mode, effectType);
            com.greensock.TweenLite.to(bgSkyShadow, 2, {colorTransform:_tintObject.sky, onComplete:tweenComplete});
            com.greensock.TweenLite.to(bgDistantShadow, 2, {colorTransform:_tintObject.distantObjects, onComplete:tweenComplete});
            com.greensock.TweenLite.to(bgCloudsShadow, 2, {colorTransform:_tintObject.clouds, onComplete:tweenComplete});
            com.greensock.TweenLite.to(cloudsEffectShadow, 2, {colorTransform:_tintObject.topCoulds, onComplete:tweenComplete});
            com.greensock.TweenLite.to(_wem.SHELL, 0, {colorTransform:_tintObject.shell, onComplete:tweenComplete});
        }
        function showClouds() {
            if (cloudsEffect._currentFrame != 1) {
                return(undefined);
            }
            cloudsEffect.gotoAndPlay("enter");
        }
        function removeClouds() {
            if (((_wem.nextShadowMode.getMode() == "A") && (_wem.nextColorMode.getMode() == "A")) && (cloudsEffect._currentFrame != 1)) {
                cloudsEffect.gotoAndPlay("leave");
            }
        }
        function playShadowEffect() {
            if (shadowEffect._currentFrame == 1) {
                shadowEffect.gotoAndPlay("enter");
            }
        }
        function stopShadowEffect() {
            if (shadowEffect._currentFrame != 1) {
                shadowEffect.gotoAndPlay("leave");
            }
        }
    }
