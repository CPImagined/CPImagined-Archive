    class com.clubpenguin.world.rooms.weathereffects.state.color.ColorDefaultState extends com.clubpenguin.world.rooms.weathereffects.state.color.ColorState implements com.clubpenguin.world.rooms.weathereffects.state.color.IColorState
    {
        var _wem, applyTinting;
        function ColorDefaultState (manager) {
            super(manager);
        }
        function toFireState() {
            _wem.currentColorState = _wem.colorFireState;
        }
        function toWaterState() {
            _wem.currentColorState = _wem.colorWaterState;
        }
        function toSnowState() {
            _wem.currentColorState = _wem.colorSnowState;
        }
        function toTieState() {
            _wem.currentColorState = _wem.colorTieState;
        }
        function toDefaultState() {
            if (_wem.currentColorMode.getMode() == _wem.nextColorMode.getMode()) {
                return(undefined);
            }
            applyTinting(_wem.nextColorMode.getMode(), com.clubpenguin.world.rooms.weathereffects.WeatherEffectsManager.EFFECT_TYPE_DEFAULT);
            _wem.currentColorState = _wem.colorDefaultState;
        }
        function applyState() {
            applyTinting(_wem.currentColorMode.getMode(), com.clubpenguin.world.rooms.weathereffects.WeatherEffectsManager.EFFECT_TYPE_DEFAULT);
        }
        function playWeatherEffect(effectType) {
        }
    }
