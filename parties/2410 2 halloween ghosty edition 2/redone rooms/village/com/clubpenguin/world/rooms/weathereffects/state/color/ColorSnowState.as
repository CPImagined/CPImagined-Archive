//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms.weathereffects.state.color.ColorSnowState extends com.clubpenguin.world.rooms.weathereffects.state.color.ColorState implements com.clubpenguin.world.rooms.weathereffects.state.color.IColorState
    {
        var _snowEffectGenerator, _wem, applyTinting, showClouds, removeClouds, snowEffect;
        function ColorSnowState (manager) {
            super(manager);
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
            if (_wem.currentColorMode.getMode() == _wem.nextColorMode.getMode()) {
                return(undefined);
            }
            applyTinting(_wem.nextColorMode.getMode(), com.clubpenguin.world.rooms.weathereffects.WeatherEffectsManager.EFFECT_TYPE_SNOW);
            if (_wem.currentColorMode.getMode() == "A") {
                showClouds();
            }
            if (_wem.nextColorMode.getMode() == "A") {
                removeClouds();
            }
            if (_wem.currentColorMode.getMode() == "C") {
                stopSnowEffect();
            }
            if (_wem.nextColorMode.getMode() == "C") {
                playSnowEffect();
            }
            _wem.currentColorMode = _wem.nextColorMode;
        }
        function toTieState() {
            resetState();
            _wem.currentColorState = _wem.colorTieState;
        }
        function toDefaultState() {
            if (_wem.currentColorMode.getMode() == "C") {
                stopSnowEffect();
            }
            if (_wem.currentColorMode.getMode() != "A") {
                removeClouds();
            }
            _wem.currentColorState = _wem.colorDefaultState;
        }
        function setMovieClips() {
            snowEffect = _wem.getBackogrundMC().weatherEffects_mc.snowEffect;
        }
        function applyState() {
            applyTinting(_wem.currentColorMode.getMode(), com.clubpenguin.world.rooms.weathereffects.WeatherEffectsManager.EFFECT_TYPE_SNOW);
            if ((_wem.currentColorMode.getMode() == "B") || (_wem.currentColorMode.getMode() == "C")) {
                showClouds();
            }
            if (_wem.currentColorMode.getMode() == "C") {
                playSnowEffect();
            }
        }
        function playWeatherEffect(effectType) {
        }
        function resetState() {
            if ((_wem.currentColorMode.getMode() != "A") && (_wem.nextColorMode.getMode() == "A")) {
                removeClouds();
            }
            if (_wem.currentColorMode.getMode() == "C") {
                stopSnowEffect();
            }
        }
        function playSnowEffect() {
            _snowEffectGenerator.startEffect();
        }
        function stopSnowEffect() {
            _snowEffectGenerator.stopEffect();
        }
    }
