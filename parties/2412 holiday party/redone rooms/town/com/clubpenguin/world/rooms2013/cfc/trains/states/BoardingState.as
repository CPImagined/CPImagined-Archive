//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2013.cfc.trains.states.BoardingState extends com.clubpenguin.world.rooms2013.cfc.trains.states.BaseTrainState
    {
        var _active, _shell, _interface, _engine, _joinButton, _controller;
        function BoardingState (manager, controller, train) {
            super("BoardingState", manager, controller, train);
            _active = false;
            _shell = _global.getCurrentShell();
            _interface = _global.getCurrentInterface();
            _engine = _global.getCurrentEngine();
        }
        function onEnterState() {
            _active = true;
            showJoinButton();
        }
        function onExitState() {
            _active = false;
            removeJoinButton();
        }
        function showJoinButton() {
            if (_joinButton == null) {
            }
        }
        function removeJoinButton() {
            _joinButton.btn.onRelease = null;
            _joinButton.removeMovieClip();
            _joinButton = null;
        }
        function onJoinButtonClicked() {
            if (!_controller.isLocalPlayerTrain) {
                _controller.requestJoinTrain();
            }
        }
    }
