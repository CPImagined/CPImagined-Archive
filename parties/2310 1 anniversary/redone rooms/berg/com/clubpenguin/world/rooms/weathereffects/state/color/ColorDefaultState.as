//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms.weathereffects.state.color.ColorDefaultState extends com.clubpenguin.world.rooms.weathereffects.state.color.ColorState implements com.clubpenguin.world.rooms.weathereffects.state.color.IColorState
    {
        var _wem, applyTinting;
        function ColorDefaultState (manager) {
            super(manager);
        }
        function toFireState() {
            _wem.currentColorState = _wem.colorFireState;
            trace("from DEFAULT state to FIRE state");
        }
        function toWaterState() {
            _wem.currentColorState = _wem.colorWaterState;
            trace("from DEFAULT state to WATER state");
        }
        function toSnowState() {
            _wem.currentColorState = _wem.colorSnowState;
            trace("from DEFAULT state to SNOW state");
        }
        function toTieState() {
            _wem.currentColorState = _wem.colorTieState;
            trace("from DEFAULT state to TIE state");
        }
        function toDefaultState() {
            if (_wem.currentColorMode.getMode() == _wem.nextColorMode.getMode()) {
                return(undefined);
            }
            applyTinting(_wem.nextColorMode.getMode(), com.clubpenguin.world.rooms.weathereffects.WeatherEffectsManager.EFFECT_TYPE_DEFAULT);
            _wem.currentColorState = _wem.colorDefaultState;
            trace("from DEFAULT state to DEFAULT state");
        }
        function applyState() {
            applyTinting(_wem.currentColorMode.getMode(), com.clubpenguin.world.rooms.weathereffects.WeatherEffectsManager.EFFECT_TYPE_DEFAULT);
            trace("APPLYING DEFAULT STATE IN MODE " + _wem.currentColorMode);
        }
        function playWeatherEffect(effectType) {
            trace("DO NOTHING");
        }
    }
