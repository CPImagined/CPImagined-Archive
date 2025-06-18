//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms.weathereffects.state.shadow.ShadowFireState extends com.clubpenguin.world.rooms.weathereffects.state.shadow.ShadowState implements com.clubpenguin.world.rooms.weathereffects.state.shadow.IShadowState
    {
        var _wem, applyTinting, showClouds, removeClouds, stopShadowEffect, playShadowEffect;
        function ShadowFireState (manager) {
            super(manager);
        }
        function tweenComplete(obj) {
            trace("[SHADOW] TWEEN COMPLETED!");
        }
        function toFireState() {
            if (_wem.currentShadowMode.getMode() == _wem.nextShadowMode.getMode()) {
                return(undefined);
            }
            applyTinting(_wem.nextShadowMode.getMode(), com.clubpenguin.world.rooms.weathereffects.WeatherEffectsManager.EFFECT_TYPE_FIRE);
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
            trace("[SHADOW] MODE CHANGED TO: " + _wem.nextShadowMode.getMode());
            trace("[SHADOW] from FIRE state to FIRE state");
        }
        function toWaterState() {
            resetState();
            _wem.currentShadowState = _wem.shadowWaterState;
            trace("[SHADOW] from FIRE state to WATER state");
        }
        function toSnowState() {
            resetState();
            _wem.currentShadowState = _wem.shadowSnowState;
            trace("[SHADOW] from FIRE state to SNOW state");
        }
        function toTieState() {
            resetState();
            _wem.currentShadowState = _wem.shadowTieState;
            trace("[SHADOW] from FIRE state to TIE state");
        }
        function toDefaultState() {
            resetState();
            _wem.currentShadowState = _wem.shadowDefaultState;
            trace("[SHADOW] from FIRE state to DEFAULT state");
        }
        function toEmptyState() {
            resetState();
            _wem.currentShadowState = _wem.shadowEmptyState;
            trace("[SHADOW] from FIRE state to EMPTY state");
        }
        function applyState() {
            applyTinting(_wem.currentShadowMode.getMode(), com.clubpenguin.world.rooms.weathereffects.WeatherEffectsManager.EFFECT_TYPE_FIRE);
            if ((_wem.currentShadowMode.getMode() == "B") || (_wem.currentShadowMode.getMode() == "C")) {
                showClouds();
            }
            if (_wem.currentShadowMode.getMode() == "C") {
                playShadowEffect();
            }
            if (_wem.currentShadowMode.getMode() == "A") {
                removeClouds();
            }
            trace("[SHADOW] APPLYING FIRE STATE IN MODE " + _wem.currentShadowMode);
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
