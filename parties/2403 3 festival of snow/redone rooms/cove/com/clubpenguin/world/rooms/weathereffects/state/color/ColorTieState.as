//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms.weathereffects.state.color.ColorTieState extends com.clubpenguin.world.rooms.weathereffects.state.color.ColorState implements com.clubpenguin.world.rooms.weathereffects.state.color.IColorState
    {
        var _fireEffectGenerator, _wem, _rainEffectGenerator, _snowEffectGenerator, applyTinting, showClouds, removeClouds, lightningEffect, tieEffect, fireEffect, waterEffect, snowEffect;
        function ColorTieState (manager) {
            super(manager);
            _fireEffectGenerator = new com.clubpenguin.world.rooms.weathereffects.effect.FireEffectGenerator(_wem);
            _rainEffectGenerator = new com.clubpenguin.world.rooms.weathereffects.effect.RainEffectGenerator(_wem);
            _snowEffectGenerator = new com.clubpenguin.world.rooms.weathereffects.effect.SnowEffectGenerator(_wem);
            setMovieClips();
        }
        function toFireState() {
            resetState();
            _wem.currentColorState = _wem.colorFireState;
        }
        function toWaterState() {
            resetState();
            _wem.currentColorState = _wem.colorWaterState;
        }
        function toSnowState() {
            resetState();
            _wem.currentColorState = _wem.colorSnowState;
        }
        function toTieState() {
            if (_wem.currentColorMode.getMode() == _wem.nextColorMode.getMode()) {
                return(undefined);
            }
            applyTinting(_wem.nextColorMode.getMode(), com.clubpenguin.world.rooms.weathereffects.WeatherEffectsManager.EFFECT_TYPE_TIE);
            if (_wem.currentColorMode.getMode() == "A") {
                showClouds();
                showLightningEffect();
            }
            if (_wem.nextColorMode.getMode() == "A") {
                removeClouds();
                hideLightningEffect();
            }
            if ((_wem.currentColorMode.getMode() == "C") || (_wem.nextColorMode.getMode() != "C")) {
                stopTieEffect();
            }
            if (_wem.nextColorMode.getMode() == "C") {
                playTieEffect();
            }
            _wem.currentColorMode = _wem.nextColorMode;
        }
        function toDefaultState() {
            resetState();
            _wem.currentColorState = _wem.colorDefaultState;
        }
        function setMovieClips() {
            lightningEffect = _wem.getBackogrundMC().weatherEffects_mc.lightningEffect;
            tieEffect = _wem.getBackogrundMC().weatherEffects_mc.tieEffect;
            fireEffect = _wem.getBackogrundMC().weatherEffects_mc.fireEffect;
            waterEffect = _wem.getBackogrundMC().weatherEffects_mc.waterEffect;
            snowEffect = _wem.getBackogrundMC().weatherEffects_mc.snowEffect;
        }
        function applyState() {
            applyTinting(_wem.currentColorMode.getMode(), com.clubpenguin.world.rooms.weathereffects.WeatherEffectsManager.EFFECT_TYPE_TIE);
            if (_wem.currentColorMode.getMode() == "A") {
                showTieCloudsEffect();
            }
            if ((_wem.currentColorMode.getMode() == "B") || (_wem.currentColorMode.getMode() == "C")) {
                showTieCloudsEffect();
                showLightningEffect();
                showClouds();
            }
            if (_wem.currentColorMode.getMode() == "C") {
                playTieEffect();
            }
        }
        function playWeatherEffect(effectType) {
            if (_wem.currentColorMode.getMode() != "C") {
                return(undefined);
            }
            _fireEffectGenerator.stopEffect();
            _rainEffectGenerator.stopEffect();
            _snowEffectGenerator.stopEffect();
            switch (effectType) {
                case "fire" : 
                    _fireEffectGenerator.startEffect();
                    break;
                case "water" : 
                    _rainEffectGenerator.startEffect();
                    break;
                case "snow" : 
                    _snowEffectGenerator.startEffect();
                    break;
            }
        }
        function resetState() {
            removeTieCloudsEffect();
            if ((_wem.currentColorMode.getMode() != "A") && (_wem.nextColorMode.getMode() == "A")) {
                removeClouds();
            }
            if (_wem.currentColorMode.getMode() == "C") {
                stopTieEffect();
            }
        }
        function playTieEffect() {
            _fireEffectGenerator.startEffect();
            var _local_2 = new com.clubpenguin.world.rooms.weathereffects.effect.SnowEffectGenerator(_wem, 10, 100);
        }
        function stopTieEffect() {
            _fireEffectGenerator.stopEffect();
            _rainEffectGenerator.stopEffect();
            _snowEffectGenerator.stopEffect();
        }
        function showLightningEffect() {
            lightningEffect.gotoAndPlay("on");
        }
        function hideLightningEffect() {
            lightningEffect.gotoAndStop("hide");
        }
        function stopLightningEffect() {
            lightningEffect.gotoAndStop("off");
        }
        function showTieCloudsEffect() {
            hideLightningEffect();
            tieEffect.gotoAndPlay("enter");
        }
        function removeTieCloudsEffect() {
            stopLightningEffect();
            tieEffect.gotoAndPlay("leave");
        }
    }
