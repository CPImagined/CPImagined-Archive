//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2014.muppets.performance.states.BoardingState extends com.clubpenguin.world.rooms2014.muppets.performance.states.BasePerformanceState
    {
        var _active, _shell, _interface, _engine, _joinButton, _performance, _controller, _playerMoveDelegate;
        function BoardingState (manager, controller, performance) {
            super("BoardingState", manager, controller, performance);
            _active = false;
            _shell = _global.getCurrentShell();
            _interface = _global.getCurrentInterface();
            _engine = _global.getCurrentEngine();
        }
        function onEnterState() {
            com.clubpenguin.util.Log.info("[BoardingState] onEnterState");
            _active = true;
            showJoinButton();
        }
        function onExitState() {
            _active = false;
            removeJoinButton();
        }
        function onParticipantAdded(added) {
            var _local_2 = 0;
            while (_local_2 < added.length) {
                if (_shell.isMyPlayer(added[_local_2])) {
                    _engine.disableMouseMovement();
                }
                _local_2++;
            }
        }
        function onParticipantRemoved(removed) {
            var _local_2 = 0;
            while (_local_2 < removed.length) {
                if (_shell.isMyPlayer(removed[_local_2])) {
                    _engine.enableMouseMovement();
                }
                _local_2++;
            }
        }
        function showJoinButton() {
            com.clubpenguin.util.Log.info("[BoardingState] showJoinButton");
            _global.getCurrentParty().BaseParty.pebug("BoardingState - showJoinButton");
            if (_joinButton == null) {
                var _local_3 = _global.getCurrentParty().MuppetsParty.determineInteractiveItemIcon(_performance.hostId);
                com.clubpenguin.util.Log.info("[BoardingState] icon " + _local_3);
                _joinButton = _engine.avatarManager.effectManager.playEffectForPlayer(_local_3, _shell.getPlayerObjectById(_performance.hostId));
                _joinButton.btn.onRelease = com.clubpenguin.util.Delegate.create(this, onJoinButtonClicked);
                if (_controller.isLocalPlayerPerformance) {
                    _global.getCurrentParty().MuppetsParty.logMuppetDanceEvent(_performance.hostId);
                }
            }
        }
        function removeJoinButton() {
            _joinButton.btn.onRelease = null;
            _joinButton.removeMovieClip();
            _joinButton = null;
        }
        function onJoinButtonClicked() {
            if (!_controller.isLocalPlayerPerformance) {
                var _local_2 = _engine.getPlayerMovieClip(_performance.hostId);
                var _local_3 = _engine.getPlayerMovieClip(_shell.getMyPlayerId());
                if (_local_3.hitTest(_local_2._x, _local_2._y, true)) {
                    _controller.requestJoinPerformance();
                } else {
                    _engine.sendPlayerMove(_local_2._x, _local_2._y);
                    _playerMoveDelegate = com.clubpenguin.util.Delegate.create(this, handlePlayerMoveDone);
                    _shell.addListener(_shell.PLAYER_MOVE_DONE, _playerMoveDelegate);
                }
            }
        }
        function handlePlayerMoveDone() {
            com.clubpenguin.util.Log.info("[BoardingState] handlePlayerMoveDone");
            _shell.removeListener(_shell.PLAYER_MOVE_DONE, _playerMoveDelegate);
            var _local_2 = _engine.getPlayerMovieClip(_performance.hostId);
            var _local_3 = _engine.getPlayerMovieClip(_shell.getMyPlayerId());
            if (_local_3.hitTest(_local_2._x, _local_2._y, true)) {
                _controller.requestJoinPerformance();
            }
        }
    }
