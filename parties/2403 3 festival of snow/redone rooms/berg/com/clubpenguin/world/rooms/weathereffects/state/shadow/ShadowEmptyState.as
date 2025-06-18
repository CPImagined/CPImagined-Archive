//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms.weathereffects.state.shadow.ShadowEmptyState extends com.clubpenguin.world.rooms.weathereffects.state.shadow.ShadowState implements com.clubpenguin.world.rooms.weathereffects.state.shadow.IShadowState
    {
        var _wem, applyTinting;
        function ShadowEmptyState (manager) {
            super(manager);
        }
        function toFireState() {
            _wem.currentShadowState = _wem.shadowFireState;
            trace("[SHADOW] from EMPTY state to FIRE state");
        }
        function toWaterState() {
            _wem.currentShadowState = _wem.shadowWaterState;
            trace("[SHADOW] from EMPTY state to WATER state");
        }
        function toSnowState() {
            _wem.currentShadowState = _wem.shadowSnowState;
            trace("[SHADOW] from EMPTY state to SNOW state");
        }
        function toTieState() {
            _wem.currentShadowState = _wem.shadowTieState;
            trace("[SHADOW] from EMPTY state to TIE state");
        }
        function toDefaultState() {
            _wem.currentShadowState = _wem.shadowDefaultState;
            trace("[SHADOW] from EMPTY state to DEFAULT state");
        }
        function toEmptyState() {
            if (_wem.currentShadowMode.getMode() == _wem.nextShadowMode.getMode()) {
                return(undefined);
            }
        }
        function applyState() {
            applyTinting(_wem.currentShadowMode.getMode(), com.clubpenguin.world.rooms.weathereffects.WeatherEffectsManager.EFFECT_TYPE_EMPTY);
            trace("[SHADOW] APPLYING EMPTY STATE IN MODE " + _wem.currentShadowMode);
        }
    }
