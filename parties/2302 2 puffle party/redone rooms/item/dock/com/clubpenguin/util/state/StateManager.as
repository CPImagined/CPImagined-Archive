//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.util.state.StateManager
    {
        var _defaultTransitionMap, _currentState;
        function StateManager () {
            _defaultTransitionMap = {};
        }
        function addDefaultTransition(transition) {
            _defaultTransitionMap[transition.eventName] = transition;
        }
        function removeDefaultTransition(transition) {
            _defaultTransitionMap[transition.eventName] = null;
        }
        function changeState(state) {
            debugTrace("changeState to " + state);
            debugTrace("oldState = " + _currentState);
            var _local_2 = _currentState;
            _currentState = state;
            if (_local_2 != null) {
                _local_2.onExitState();
            }
            _currentState.onEnterState();
        }
        function get currentState() {
            return(_currentState);
        }
        function onEvent(eventName) {
            debugTrace("onEvent " + eventName);
            if (_currentState.hasTransitionForEvent(eventName)) {
                debugTrace(("Use _currentState transition for event '" + eventName) + "'");
                changeState(_currentState.getTransitionForEvent(eventName).state);
            } else if (_defaultTransitionMap[eventName] != null) {
                debugTrace(("Use default transition for event '" + eventName) + "'");
                changeState(_defaultTransitionMap[eventName].state);
            }
        }
        function debugTrace(msg) {
            com.clubpenguin.util.Log.debug("StateManager > " + msg, com.clubpenguin.util.Log.DEFAULT);
        }
    }
