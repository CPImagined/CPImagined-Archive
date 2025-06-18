    class com.clubpenguin.world.rooms.weathereffects.state.mode.ModeA extends com.clubpenguin.world.rooms.weathereffects.state.mode.Mode implements com.clubpenguin.world.rooms.weathereffects.state.mode.IMode
    {
        var _mode;
        function ModeA () {
            super();
            _mode = "A";
        }
        function getMode() {
            return(_mode);
        }
        function toModeA() {
        }
        function toModeB() {
        }
        function toModeC() {
        }
    }
