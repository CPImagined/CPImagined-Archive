    class com.clubpenguin.world.rooms.weathereffects.state.shadow.ShadowWaterState extends com.clubpenguin.world.rooms.weathereffects.state.shadow.ShadowState implements com.clubpenguin.world.rooms.weathereffects.state.shadow.IShadowState
    {
        var _wem, applyTinting, showClouds, removeClouds, stopShadowEffect, playShadowEffect;
        function ShadowWaterState (manager) {
            super(manager);
        }
        function toFireState() {
            resetState();
            _wem.currentShadowState = _wem.shadowFireState;
        }
        function toWaterState() {
            if (_wem.currentShadowMode.getMode() == _wem.nextShadowMode.getMode()) {
                return(undefined);
            }
            applyTinting(_wem.nextShadowMode.getMode(), com.clubpenguin.world.rooms.weathereffects.WeatherEffectsManager.EFFECT_TYPE_WATER);
            if (_wem.currentShadowMode.getMode() == "A") {
                showClouds();
            }
            if (_wem.nextShadowMode.getMode() == "A") {
                removeClouds();
            }
            if (_wem.currentShadowMode.getMode() == "C") {
                stopShadowEffect();
            }
            if (_wem.nextShadowMode.getMode() == "C") {
                playShadowEffect();
            }
            _wem.currentShadowMode = _wem.nextShadowMode;
        }
        function toSnowState() {
            resetState();
            _wem.currentShadowState = _wem.shadowSnowState;
        }
        function toTieState() {
            resetState();
            _wem.currentShadowState = _wem.shadowTieState;
        }
        function toDefaultState() {
            resetState();
            _wem.currentShadowState = _wem.shadowDefaultState;
        }
        function toEmptyState() {
            resetState();
            _wem.currentShadowState = _wem.shadowEmptyState;
        }
        function applyState() {
            applyTinting(_wem.currentShadowMode.getMode(), com.clubpenguin.world.rooms.weathereffects.WeatherEffectsManager.EFFECT_TYPE_WATER);
            if ((_wem.currentShadowMode.getMode() == "B") || (_wem.currentShadowMode.getMode() == "C")) {
                showClouds();
            }
            if (_wem.currentShadowMode.getMode() == "C") {
                playShadowEffect();
            }
            if (_wem.currentShadowMode.getMode() == "A") {
                removeClouds();
            }
        }
        function resetState() {
            if ((_wem.currentShadowMode.getMode() != "A") && (_wem.nextShadowMode.getMode() == "A")) {
                removeClouds();
            }
            if ((_wem.currentShadowMode.getMode() == "C") && (_wem.nextShadowMode.getMode() != "C")) {
                stopShadowEffect();
            }
        }
    }
