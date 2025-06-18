//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms.weathereffects.state.shadow.ShadowEmptyState extends com.clubpenguin.world.rooms.weathereffects.state.shadow.ShadowState implements com.clubpenguin.world.rooms.weathereffects.state.shadow.IShadowState
    {
        var _wem, applyTinting;
        function ShadowEmptyState (manager) {
            super(manager);
        }
        function toFireState() {
            _wem.currentShadowState = _wem.shadowFireState;
        }
        function toWaterState() {
            _wem.currentShadowState = _wem.shadowWaterState;
        }
        function toSnowState() {
            _wem.currentShadowState = _wem.shadowSnowState;
        }
        function toTieState() {
            _wem.currentShadowState = _wem.shadowTieState;
        }
        function toDefaultState() {
            _wem.currentShadowState = _wem.shadowDefaultState;
        }
        function toEmptyState() {
            if (_wem.currentShadowMode.getMode() == _wem.nextShadowMode.getMode()) {
                return(undefined);
            }
        }
        function applyState() {
            applyTinting(_wem.currentShadowMode.getMode(), com.clubpenguin.world.rooms.weathereffects.WeatherEffectsManager.EFFECT_TYPE_EMPTY);
        }
    }
