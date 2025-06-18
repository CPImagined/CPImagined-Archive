    class com.clubpenguin.world.rooms.weathereffects.state.color.ColorState
    {
        var _wem, _tintObject, bgCloudsColor, bgDistantColor, bgSkyColor, cloudsEffectColor;
        function ColorState (manager) {
            _wem = manager;
            _tintObject = new Object();
            _tintObject.tintType = "color";
            setDefaultMovieClips();
        }
        function tweenComplete(obj) {
        }
        function setDefaultMovieClips() {
            var _local_2 = _wem.getBackogrundMC().weatherEffects_mc;
            bgCloudsColor = _local_2.bgClouds.bgCloudsShadow.bgCloudsColor;
            bgDistantColor = _local_2.bgDistant.bgDistantShadow.bgDistantColor;
            bgSkyColor = _local_2.bgSky.bgSkyShadow.bgSkyColor;
            cloudsEffectColor = _wem.getBackogrundMC().weatherEffects_mc.cloudsEffect.cloudsEffectColor;
        }
        function setTintValues(mode, effectType) {
            _tintObject.state = "Mode" + mode;
            _tintObject.effectType = effectType;
            _tintObject.stateForSettings = "Mode" + ((mode == "A") ? "A" : "B");
            _tintObject.sky = com.clubpenguin.world.rooms.weathereffects.WeatherEffectsSettings[((_tintObject.tintType + effectType) + com.clubpenguin.world.rooms.weathereffects.WeatherEffectsManager.OBJECT_TYPE_SKY) + _tintObject.stateForSettings];
            _tintObject.clouds = com.clubpenguin.world.rooms.weathereffects.WeatherEffectsSettings[((_tintObject.tintType + effectType) + com.clubpenguin.world.rooms.weathereffects.WeatherEffectsManager.OBJECT_TYPE_CLOUDS) + _tintObject.stateForSettings];
            _tintObject.distantObjects = com.clubpenguin.world.rooms.weathereffects.WeatherEffectsSettings[((_tintObject.tintType + effectType) + com.clubpenguin.world.rooms.weathereffects.WeatherEffectsManager.OBJECT_TYPE_DISTANT_OBJ) + _tintObject.stateForSettings];
            _tintObject.topCoulds = com.clubpenguin.world.rooms.weathereffects.WeatherEffectsSettings[((_tintObject.tintType + effectType) + com.clubpenguin.world.rooms.weathereffects.WeatherEffectsManager.OBJECT_TYPE_TOP_CLOUDS) + _tintObject.stateForSettings];
        }
        function applyTinting(mode, effectType) {
            setTintValues(mode, effectType);
            com.greensock.TweenLite.to(bgSkyColor, 2, {colorTransform:_tintObject.sky, onComplete:tweenComplete});
            com.greensock.TweenLite.to(bgDistantColor, 2, {colorTransform:_tintObject.distantObjects, onComplete:tweenComplete});
            com.greensock.TweenLite.to(bgCloudsColor, 2, {colorTransform:_tintObject.clouds, onComplete:tweenComplete});
            com.greensock.TweenLite.to(cloudsEffectColor, 2, {colorTransform:_tintObject.topCoulds, onComplete:tweenComplete});
        }
        function showClouds() {
            if (cloudsEffectColor._currentFrame != 1) {
                return(undefined);
            }
            cloudsEffectColor.gotoAndPlay("enter");
        }
        function removeClouds() {
            if (((_wem.nextShadowMode.getMode() == "A") && (_wem.nextColorMode.getMode() == "A")) && (cloudsEffectColor._currentFrame != 1)) {
                cloudsEffectColor.gotoAndPlay("leave");
            }
        }
    }
