﻿//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms.weathereffects.state.shadow.ShadowDefaultState extends com.clubpenguin.world.rooms.weathereffects.state.shadow.ShadowState implements com.clubpenguin.world.rooms.weathereffects.state.shadow.IShadowState
    {
        var _wem, applyTinting, showClouds, removeClouds, playShadowEffect, stopShadowEffect;
        function ShadowDefaultState (manager) {
            super(manager);
        }
        function toFireState() {
            resetState();
            _wem.currentShadowState = _wem.shadowFireState;
            trace("[SHADOW] from DEFAULT state to FIRE state");
        }
        function toWaterState() {
            resetState();
            _wem.currentShadowState = _wem.shadowWaterState;
            trace("[SHADOW] from DEFAULT state to WATER state");
        }
        function toSnowState() {
            resetState();
            _wem.currentShadowState = _wem.shadowSnowState;
            trace("[SHADOW] from DEFAULT state to SNOW state");
        }
        function toTieState() {
            resetState();
            _wem.currentShadowState = _wem.shadowTieState;
            trace("[SHADOW] from DEFAULT state to TIE state");
        }
        function toDefaultState() {
            if (_wem.currentShadowMode == _wem.nextShadowMode) {
                return(undefined);
            }
            trace((("[SHADOW] CURRENT SHADOW MODE: " + _wem.currentShadowMode.getMode()) + " NEXT SHADOW MODE: ") + _wem.nextShadowMode.getMode());
            applyTinting(_wem.nextShadowMode.getMode(), com.clubpenguin.world.rooms.weathereffects.WeatherEffectsManager.EFFECT_TYPE_DEFAULT);
            if (_wem.currentShadowMode.getMode() == "A") {
                showClouds();
            }
            if (_wem.nextShadowMode.getMode() == "A") {
                removeClouds();
            }
            if (_wem.nextShadowMode.getMode() == "C") {
                playShadowEffect();
            }
            if (_wem.currentShadowMode.getMode() == "C") {
                stopShadowEffect();
            }
            _wem.currentShadowState = _wem.shadowDefaultState;
            trace("[SHADOW] from DEFAULT state to DEFAULT state");
        }
        function toEmptyState() {
            resetState();
            _wem.currentShadowState = _wem.shadowEmptyState;
            trace("[SHADOW] from DEFAULT state to EMPTY state");
        }
        function applyState() {
            applyTinting(_wem.currentShadowMode.getMode(), com.clubpenguin.world.rooms.weathereffects.WeatherEffectsManager.EFFECT_TYPE_DEFAULT);
            if ((_wem.currentShadowMode.getMode() == "B") || (_wem.currentShadowMode.getMode() == "C")) {
                showClouds();
            }
            if (_wem.currentShadowMode.getMode() == "C") {
                playShadowEffect();
            }
            if (_wem.currentShadowMode.getMode() == "A") {
                removeClouds();
            }
            trace("[SHADOW] APPLYING DEFAULT STATE IN MODE " + _wem.currentShadowMode);
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
