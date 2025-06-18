    class com.clubpenguin.world.rooms.weathereffects.state.color.ColorFireState extends com.clubpenguin.world.rooms.weathereffects.state.color.ColorState implements com.clubpenguin.world.rooms.weathereffects.state.color.IColorState
    {
        var _fireEffectGenerator, _wem, applyTinting, showClouds, removeClouds, fireEffect;
        function ColorFireState (manager) {
            super(manager);
            _fireEffectGenerator = new com.clubpenguin.world.rooms.weathereffects.effect.FireEffectGenerator(_wem);
            setMovieClips();
        }
        function tweenComplete(obj) {
        }
        function toFireState() {
            if (_wem.currentColorMode.getMode() == _wem.nextColorMode.getMode()) {
                return(undefined);
            }
            applyTinting(_wem.nextColorMode.getMode(), com.clubpenguin.world.rooms.weathereffects.WeatherEffectsManager.EFFECT_TYPE_FIRE);
            if (_wem.currentColorMode.getMode() == "A") {
                showClouds();
            }
            if (_wem.nextColorMode.getMode() == "A") {
                removeClouds();
            }
            if (_wem.currentColorMode.getMode() == "C") {
                stopFireEffect();
            }
            if (_wem.nextColorMode.getMode() == "C") {
                playFireEffect();
            }
            _wem.currentColorMode = _wem.nextColorMode;
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
            resetState();
            _wem.currentColorState = _wem.colorTieState;
        }
        function toDefaultState() {
            if (_wem.currentColorMode.getMode() == "C") {
                stopFireEffect();
            }
            if (_wem.currentColorMode.getMode() != "A") {
                removeClouds();
            }
            _wem.currentColorState = _wem.colorDefaultState;
        }
        function setMovieClips() {
            fireEffect = _wem.getBackogrundMC().weatherEffects_mc.fireEffect;
        }
        function applyState() {
            applyTinting(_wem.currentColorMode.getMode(), com.clubpenguin.world.rooms.weathereffects.WeatherEffectsManager.EFFECT_TYPE_FIRE);
            if ((_wem.currentColorMode.getMode() == "B") || (_wem.currentColorMode.getMode() == "C")) {
                showClouds();
            }
            if (_wem.currentColorMode.getMode() == "C") {
                playFireEffect();
            }
        }
        function playWeatherEffect(effectType) {
        }
        function resetState() {
            if ((_wem.currentColorMode.getMode() != "A") && (_wem.nextColorMode.getMode() == "A")) {
                removeClouds();
            }
            if (_wem.currentColorMode.getMode() == "C") {
                stopFireEffect();
            }
        }
        function playFireEffect() {
            _fireEffectGenerator.startEffect();
        }
        function stopFireEffect() {
            _fireEffectGenerator.stopEffect();
            fireEffect.gotoAndStop("off");
        }
    }
