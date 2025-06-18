//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2013.cfc.trains.states.BoardingState extends com.clubpenguin.world.rooms2013.cfc.trains.states.BaseTrainState
    {
        var _active, _shell, _interface, _engine, _joinButton, _train, _controller;
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
                _joinButton = _engine.avatarManager.effectManager.playEffectForPlayer(com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.CFC_TRAIN_JOIN_ICON, _shell.getPlayerObjectById(_train.driverId));
                _joinButton.btn.onRelease = com.clubpenguin.util.Delegate.create(this, onJoinButtonClicked);
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
