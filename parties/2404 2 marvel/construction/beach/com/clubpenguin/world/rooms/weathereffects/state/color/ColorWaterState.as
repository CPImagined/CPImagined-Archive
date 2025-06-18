//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms.weathereffects.state.color.ColorWaterState extends com.clubpenguin.world.rooms.weathereffects.state.color.ColorState implements com.clubpenguin.world.rooms.weathereffects.state.color.IColorState
    {
        var _rainEffectGenerator, _wem, applyTinting, showClouds, removeClouds, waterEffect;
        function ColorWaterState (manager) {
            super(manager);
            _rainEffectGenerator = new com.clubpenguin.world.rooms.weathereffects.effect.RainEffectGenerator(_wem);
            setMovieClips();
        }
        function toFireState() {
            resetState();
            _wem.currentColorState = _wem.colorFireState;
        }
        function toWaterState() {
            if (_wem.currentColorMode.getMode() == _wem.nextColorMode.getMode()) {
                return(undefined);
            }
            applyTinting(_wem.nextColorMode.getMode(), com.clubpenguin.world.rooms.weathereffects.WeatherEffectsManager.EFFECT_TYPE_WATER);
            if (_wem.currentColorMode.getMode() == "A") {
                showClouds();
            }
            if (_wem.nextColorMode.getMode() == "A") {
                removeClouds();
            }
            if (_wem.currentColorMode.getMode() == "C") {
                stopWaterEffect();
            }
            if (_wem.nextColorMode.getMode() == "C") {
                playWaterEffect();
            }
            _wem.currentColorMode = _wem.nextColorMode;
        }
        function toSnowState() {
            resetState();
            _wem.currentColorState = _wem.colorSnowState;
        }
        function toTieState() {
            resetState();
            _wem.currentColorState = _wem.colorTieState;
        }
        function toDefaultState() {
            if (_wem.currentColorMode.getMode() == "C") {
                stopWaterEffect();
            }
            if (_wem.currentColorMode.getMode() != "A") {
                removeClouds();
            }
            _wem.currentColorState = _wem.colorDefaultState;
        }
        function setMovieClips() {
            waterEffect = _wem.getBackogrundMC().weatherEffects_mc.waterEffect;
        }
        function applyState() {
            applyTinting(_wem.currentColorMode.getMode(), com.clubpenguin.world.rooms.weathereffects.WeatherEffectsManager.EFFECT_TYPE_WATER);
            if ((_wem.currentColorMode.getMode() == "B") || (_wem.currentColorMode.getMode() == "C")) {
                showClouds();
            }
            if (_wem.currentColorMode.getMode() == "C") {
                playWaterEffect();
            }
        }
        function playWeatherEffect(effectType) {
        }
        function resetState() {
            if ((_wem.currentColorMode.getMode() != "A") && (_wem.nextColorMode.getMode() == "A")) {
                removeClouds();
            }
            if (_wem.currentColorMode.getMode() == "C") {
                stopWaterEffect();
            }
        }
        function playWaterEffect() {
            _rainEffectGenerator.startEffect();
        }
        function stopWaterEffect() {
            _rainEffectGenerator.stopEffect();
        }
    }
