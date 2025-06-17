//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2014.muppets.MuppetsParty_EngineOverrides
    {
        var _shell, _airtower, _interface, _engine, _party, defaultUpdatePlayerFrame, defaultSendPlayerFrame;
        function MuppetsParty_EngineOverrides () {
        }
        function init() {
            _shell = _global.getCurrentShell();
            _airtower = _global.getCurrentAirtower();
            _interface = _global.getCurrentInterface();
            _engine = _global.getCurrentEngine();
            _party = _global.getCurrentParty();
            defaultUpdatePlayerFrame = _engine.updatePlayerFrame;
            defaultSendPlayerFrame = _engine.sendPlayerFrame;
        }
        function sendPlayerFrame(frame) {
            var _local_3 = this;
            var _local_6 = _local_3.SHELL.getMyPlayerId();
            if (_local_3.validateUpdateFrame(_local_6, frame)) {
                if (frame == _local_3.SHELL.DANCE_FRAME) {
                    var _local_4 = _global.getCurrentRoom().performanceManager;
                    var _local_8 = _local_3.SHELL.getMyPlayerId();
                    if (_local_4.isPlayerAHost(_local_8)) {
                        var _local_5 = _local_4.getPlayerPerformance(_local_8);
                        if ((_local_5 == null) || (_local_5.state == com.clubpenguin.world.rooms2014.muppets.performance.states.PerformanceStateEnum.PERFORMING)) {
                            _local_4.service.sendOpenPerformance();
                            return(undefined);
                        } else if (_local_5.state == com.clubpenguin.world.rooms2014.muppets.performance.states.PerformanceStateEnum.BOARDING) {
                            _local_4.service.sendCancelPerformance();
                        }
                    }
                }
                _local_3.updatePlayerFrame(_local_6, frame);
                _local_3.setPlayerAction("custom");
                _local_3.SHELL.sendPlayerFrame(frame);
            }
        }
        static var CLASS_NAME = "MuppetsParty_EngineOverrides";
    }
