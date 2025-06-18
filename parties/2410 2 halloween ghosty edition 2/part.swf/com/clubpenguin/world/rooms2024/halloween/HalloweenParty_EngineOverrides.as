
//Created by Action Script Viewer - http://www.buraks.com/asv
    class com.clubpenguin.world.rooms2024.halloween.HalloweenParty_EngineOverrides
    {
        var _SHELL, _AIRTOWER, _INTERFACE, _ENGINE, _PARTY;
        function HalloweenParty_EngineOverrides () {
        }
        function init() {
            _SHELL = _global.getCurrent_shell();
            _AIRTOWER = _global.getCurrentAirtower();
            _INTERFACE = _global.getCurrentInterface();
            _ENGINE = _global.getCurrentEngine();
            _PARTY = _global.getCurrentParty();
        }
    }
