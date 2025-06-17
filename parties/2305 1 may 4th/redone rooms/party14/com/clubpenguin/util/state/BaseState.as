//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.util.state.BaseState implements com.clubpenguin.util.state.IState
    {
        var _manager, _transitionMap;
        function BaseState (manager) {
            _manager = manager;
            _transitionMap = {};
        }
        function onEnterState() {
        }
        function onExitState() {
        }
        function getManager() {
            return(_manager);
        }
        function addTransition(transition) {
            _transitionMap[transition.eventName] = transition;
        }
        function removeTransition(transition) {
            _transitionMap[transition.eventName] = null;
        }
        function clearTransitions() {
            _transitionMap = {};
        }
        function hasTransitionForEvent(eventName) {
            return(_transitionMap[eventName] != null);
        }
        function getTransitionForEvent(eventName) {
            return(_transitionMap[eventName]);
        }
    }
