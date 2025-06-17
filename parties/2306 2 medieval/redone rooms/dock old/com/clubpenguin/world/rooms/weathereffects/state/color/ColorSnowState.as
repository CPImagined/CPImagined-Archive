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
            trace("from SNOW state to FIRE state");
        }
        function toWaterState() {
            resetState();
            _wem.currentColorState = _wem.colorWaterState;
            trace("from SNOW state to WATER state");
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
            trace("MODE CHANGED TO: " + _wem.nextColorMode);
            trace("from SNOW state to SNOW state");
        }
        function toTieState() {
            resetState();
            _wem.currentColorState = _wem.colorTieState;
            trace("from SNOW state to TIE state");
        }
        function toDefaultState() {
            if (_wem.currentColorMode.getMode() == "C") {
                stopSnowEffect();
            }
            if (_wem.currentColorMode.getMode() != "A") {
                removeClouds();
            }
            _wem.currentColorState = _wem.colorDefaultState;
            trace("from SNOW state to DEFAULT state");
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
            trace("APPLYING SNOW STATE IN MODE " + _wem.currentColorMode);
        }
        function playWeatherEffect(effectType) {
            trace("DO NOTHING");
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
            trace("START SNOW EFFECT");
        }
        function stopSnowEffect() {
            _snowEffectGenerator.stopEffect();
            trace("STOP SNOW EFFECT");
        }
    }
