//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2014.muppets.performance.states.BasePerformanceState extends com.clubpenguin.util.state.BaseState
    {
        var _stateName, _controller, _manager, _performance, _shell, _engine, _interface;
        function BasePerformanceState (stateName, manager, controller, performance) {
            super(manager);
            _stateName = stateName;
            _controller = controller;
            _manager = manager;
            _performance = performance;
            _shell = _global.getCurrentShell();
            _engine = _global.getCurrentEngine();
            _interface = _global.getCurrentInterface();
        }
        function toString() {
            return("BasePerformanceState:" + _stateName);
        }
    }
