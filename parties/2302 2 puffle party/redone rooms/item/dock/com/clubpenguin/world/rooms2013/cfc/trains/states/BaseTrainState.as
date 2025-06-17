//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2013.cfc.trains.states.BaseTrainState extends com.clubpenguin.util.state.BaseState
    {
        var _stateName, _controller, _train, _shell, _engine, _interface;
        function BaseTrainState (stateName, manager, controller, train) {
            super(manager);
            _stateName = stateName;
            _controller = controller;
            _train = train;
            _shell = _global.getCurrentShell();
            _engine = _global.getCurrentEngine();
            _interface = _global.getCurrentInterface();
        }
        function toString() {
            return("BaseTrainState:" + _stateName);
        }
    }
