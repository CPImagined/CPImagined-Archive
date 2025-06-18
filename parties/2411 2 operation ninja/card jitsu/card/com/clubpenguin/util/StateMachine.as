//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.util.StateMachine
    {
        var sCurrentState, sNextState;
        function StateMachine () {
            sCurrentState = null;
            sNextState = null;
        }
        function getCurrentState() {
            return(sCurrentState);
        }
        function changeState(sStateName) {
            sNextState = sStateName;
            _gotoState();
        }
        function _gotoState() {
            if (sCurrentState != null) {
                this[sCurrentState]("leave");
            }
            sCurrentState = sNextState;
            sNextState = null;
            this[sCurrentState]("enter");
        }
    }
