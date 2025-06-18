//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2013.cfc.trains.states.DrivingGameState extends com.clubpenguin.world.rooms2013.cfc.trains.states.BaseTrainState
    {
        var _active;
        function DrivingGameState (manager, controller, train) {
            super("DrivingGameState", manager, controller, train);
            _active = false;
        }
        function onEnterState() {
            _active = true;
        }
        function onExitState() {
            _active = false;
        }
    }
