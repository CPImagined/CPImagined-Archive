
//Created by Action Script Viewer - http://www.buraks.com/asv
    class com.clubpenguin.world.rooms2025.doom.DoomParty_EngineOverrides
    {
        var _shell, _airtower, _interface, _engine, _party;
        function DoomParty_EngineOverrides () {
        }
        function init() {
            _shell = _global.getCurrent_shell();
            _airtower = _global.getCurrentAirtower();
            _interface = _global.getCurrentInterface();
            _engine = _global.getCurrentEngine();
            _party = _global.getCurrentParty();
        }
    }
