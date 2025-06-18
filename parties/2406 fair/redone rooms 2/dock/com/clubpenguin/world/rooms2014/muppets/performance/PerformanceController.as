//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2014.muppets.performance.PerformanceController
    {
        var _shell, _interface, _engine, participantAdded, participantRemoved, _performance, _service, _stateManager, _isLocalPlayerPerformance, _playerMoveDelegate;
        function PerformanceController (performance, service) {
            _shell = _global.getCurrentShell();
            _interface = _global.getCurrentInterface();
            _engine = _global.getCurrentEngine();
            participantAdded = new org.osflash.signals.Signal(Array);
            participantRemoved = new org.osflash.signals.Signal(Array);
            _performance = performance;
            _service = service;
            initPerformance();
        }
        function get performance() {
            return(_performance);
        }
        function initPerformance() {
            com.clubpenguin.util.Log.info("[PerformanceController] initPerformance ");
            _stateManager = new com.clubpenguin.util.state.StateManager();
            checkIsLocalPlayerPerformance();
            if (_performance.state == com.clubpenguin.world.rooms2014.muppets.performance.states.PerformanceStateEnum.PERFORMING) {
                com.clubpenguin.util.Log.info("[PerformanceController] initPerformance PerformanceStateEnum.PERFORMING");
                _stateManager.changeState(createPerformingState());
            } else {
                com.clubpenguin.util.Log.info("[PerformanceController] initPerformance PerformanceStateEnum.BOARDING");
                _stateManager.changeState(new com.clubpenguin.world.rooms2014.muppets.performance.states.BoardingState(_stateManager, this, _performance));
            }
            if (_isLocalPlayerPerformance && (_performance.hostId != _shell.getMyPlayerId())) {
                _engine.disableMouseMovement();
            }
            if (_shell.getMyPlayerId() != _performance.hostId) {
                var _local_3 = _engine.getPlayerMovieClip(_performance.hostId);
                if ((_local_3._x == 0) && (_local_3._y == 0)) {
                    var _local_2 = _engine.getPlayerMovieClip(_shell.getMyPlayerId());
                    updatePlayerPosition(_performance.hostId, _local_2._x, _local_2._y);
                }
            }
            _playerMoveDelegate = com.clubpenguin.util.Delegate.create(this, onPlayerMove);
            if (!_shell.isMyPlayer(_performance.hostId)) {
                _shell.addListener(_shell.PLAYER_MOVE, _playerMoveDelegate);
            } else {
                _shell.addListener(_shell.LOCAL_PLAYER_MOVE, _playerMoveDelegate);
            }
        }
        function destroy() {
            _stateManager.changeState(null);
            if (!_shell.isMyPlayer(_performance.hostId)) {
                _shell.removeListener(_shell.PLAYER_MOVE, _playerMoveDelegate);
            } else {
                _shell.removeListener(_shell.LOCAL_PLAYER_MOVE, _playerMoveDelegate);
            }
            if (_isLocalPlayerPerformance) {
                _engine.enableMouseMovement();
            }
        }
        function onUpdate() {
        }
        function get isLocalPlayerPerformance() {
            return(_isLocalPlayerPerformance);
        }
        function onOpened() {
            _stateManager.changeState(new com.clubpenguin.world.rooms2014.muppets.performance.states.BoardingState(_stateManager, this, _performance));
        }
        function onClosed() {
            com.clubpenguin.util.Log.info("[PerformanceController] onClosed");
            _stateManager.changeState(createPerformingState());
        }
        function onPerformanceRemoved() {
            com.clubpenguin.util.Log.info("[PerformanceController] onPerformanceRemoved");
        }
        function createPerformingState() {
            com.clubpenguin.util.Log.info("[PerformanceController] createPerformingState " + _shell.getMyPlayerId());
            var _local_2;
            _local_2 = new com.clubpenguin.world.rooms2014.muppets.performance.states.PerformNormalState(_stateManager, this, _performance);
            checkIsLocalPlayerPerformance();
            return(_local_2);
        }
        function updatePlayerPosition(playerId, x, y) {
            _engine.updatePlayerPosition(playerId, x, y);
        }
        function updatePlayerFrame(playerId, frame) {
            _engine.updatePlayerFrame(playerId, frame);
        }
        function onPlayerMove(event) {
        }
        function checkIsLocalPlayerPerformance() {
            _isLocalPlayerPerformance = _performance.containsPlayer(_shell.getMyPlayerId());
        }
        function requestJoinPerformance() {
            var _local_3 = _global.getCurrentRoom().performanceManager;
            if (_local_3.getPlayerPerformance(_shell.getMyPlayerId()) == null) {
                _service.sendJoinPerformance(_performance.hostId);
            }
        }
    }
