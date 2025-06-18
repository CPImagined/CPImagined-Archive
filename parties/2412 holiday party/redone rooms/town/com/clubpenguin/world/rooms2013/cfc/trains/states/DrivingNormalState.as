//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2013.cfc.trains.states.DrivingNormalState extends com.clubpenguin.world.rooms2013.cfc.trains.states.BaseTrainState
    {
        var _active;
        function DrivingNormalState (manager, controller, train) {
            super("DrivingNormalState", manager, controller, train);
            _active = false;
        }
        function onEnterState() {
            _active = true;
        }
        function onExitState() {
            _active = false;
        }
    }
