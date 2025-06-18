//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2013.cfc.trains.TrainController
    {
        var _shell, _interface, _engine, scoreUpdated, passengersAdded, passengersRemoved, _train, _service, _stateManager, _isLocalPlayerTrain, _movement, _playerMoveDelegate;
        function TrainController (train, service) {
            _shell = _global.getCurrentShell();
            _interface = _global.getCurrentInterface();
            _engine = _global.getCurrentEngine();
            scoreUpdated = new org.osflash.signals.Signal(Number);
            passengersAdded = new org.osflash.signals.Signal(Array);
            passengersRemoved = new org.osflash.signals.Signal(Array);
            _train = train;
            _service = service;
            initTrain();
        }
        function get train() {
            return(_train);
        }
        function initTrain() {
            _stateManager = new com.clubpenguin.util.state.StateManager();
            checkIsLocalPlayerTrain();
            if (_train.state == com.clubpenguin.world.rooms2013.cfc.trains.states.TrainStateEnum.DRIVING) {
                _stateManager.changeState(createDrivingState());
            } else {
                _stateManager.changeState(new com.clubpenguin.world.rooms2013.cfc.trains.states.BoardingState(_stateManager, this, _train));
            }
            checkIsLocalPlayerTrain();
            if (_isLocalPlayerTrain && (_train.driverId != _shell.getMyPlayerId())) {
                _engine.disableMouseMovement();
            }
            if (_shell.getMyPlayerId() != _train.driverId) {
                var _local_3 = _engine.getPlayerMovieClip(_train.driverId);
                if ((_local_3._x == 0) && (_local_3._y == 0)) {
                    var _local_2 = _engine.getPlayerMovieClip(_shell.getMyPlayerId());
                    updatePlayerPosition(_train.driverId, _local_2._x, _local_2._y);
                }
            }
            addCartToPlayers(_train.passengers);
            _movement = createMovementController();
            addPassengersToMovement(_train.passengers);
            _playerMoveDelegate = com.clubpenguin.util.Delegate.create(this, onPlayerMove);
            if (!_shell.isMyPlayer(_train.driverId)) {
                _shell.addListener(_shell.PLAYER_MOVE, _playerMoveDelegate);
            } else {
                _shell.addListener(_shell.LOCAL_PLAYER_MOVE, _playerMoveDelegate);
            }
        }
        function createDrivingState() {
            var _local_2;
            if (com.clubpenguin.world.rooms2013.cfc.CFCParty.isInTrainGameRoom()) {
                _local_2 = new com.clubpenguin.world.rooms2013.cfc.trains.states.DrivingGameState(_stateManager, this, _train);
            } else {
                _local_2 = new com.clubpenguin.world.rooms2013.cfc.trains.states.DrivingNormalState(_stateManager, this, _train);
            }
            return(_local_2);
        }
        function createMovementController() {
            var _local_2;
            if (com.clubpenguin.world.rooms2013.cfc.CFCParty.isInTrainGameRoom()) {
                _local_2 = new com.clubpenguin.world.rooms2013.cfc.trains.movement.TrainGameMovement(_train.driverId, _engine.getPlayerMovieClip(_train.driverId));
            } else {
                _local_2 = new com.clubpenguin.world.rooms2013.cfc.trains.movement.TrainNormalMovement(_train.driverId, _engine.getPlayerMovieClip(_train.driverId));
            }
            _local_2.requestMovePlayer.add(com.clubpenguin.util.Delegate.create(this, updatePlayerPosition));
            _local_2.requestChangePlayerFrame.add(com.clubpenguin.util.Delegate.create(this, updatePlayerFrame));
            return(_local_2);
        }
        function destroy() {
            _stateManager.changeState(null);
            if (!_shell.isMyPlayer(_train.driverId)) {
                _shell.removeListener(_shell.PLAYER_MOVE, _playerMoveDelegate);
            } else {
                _shell.removeListener(_shell.LOCAL_PLAYER_MOVE, _playerMoveDelegate);
            }
            if (_isLocalPlayerTrain) {
                _engine.enableMouseMovement();
            }
        }
        function onUpdate() {
            _movement.update();
        }
        function get isLocalPlayerTrain() {
            return(_isLocalPlayerTrain);
        }
        function onOpened() {
            _stateManager.changeState(new com.clubpenguin.world.rooms2013.cfc.trains.states.BoardingState(_stateManager, this, _train));
        }
        function onClosed() {
            _stateManager.changeState(createDrivingState());
        }
        function onTrainRemoved() {
            removeCartFromPlayers(_train.passengers);
            if (com.clubpenguin.world.rooms2013.cfc.CFCParty.isInTrainGameRoom() && (_train.containsPassenger(_shell.getMyPlayerId()))) {
                com.clubpenguin.world.rooms2013.cfc.CFCParty.showRunAwayTrainOnJoinRoom = true;
            }
        }
        function onScoreUpdated(oldScore) {
            scoreUpdated.dispatch(oldScore);
        }
        function onPassengersAdded(newPassengers) {
            var _local_2 = _isLocalPlayerTrain;
            checkIsLocalPlayerTrain();
            if (_isLocalPlayerTrain && (!_local_2)) {
                _engine.disableMouseMovement();
            }
            addCartToPlayers(newPassengers);
            addPassengersToMovement(newPassengers);
            passengersAdded.dispatch(newPassengers);
        }
        function onPassengersRemoved(removedPassengers, removedPassengerSlots) {
            var _local_4 = _isLocalPlayerTrain;
            checkIsLocalPlayerTrain();
            if ((!_isLocalPlayerTrain) && (_local_4)) {
                _engine.enableMouseMovement();
            }
            removeCartFromPlayers(removedPassengers);
            removePassengersFromMovement(removedPassengerSlots);
            passengersRemoved.dispatch();
            if (com.clubpenguin.world.rooms2013.cfc.CFCParty.isInTrainGameRoom()) {
                var _local_2 = 0;
                if (_local_2 < removedPassengers.length) {
                    if (removedPassengers[_local_2] == _shell.getMyPlayerId()) {
                        com.clubpenguin.world.rooms2013.cfc.CFCParty.showRunAwayTrainOnJoinRoom = true;
                    }
                }
            }
        }
        function updatePlayerPosition(playerId, x, y) {
            _engine.updatePlayerPosition(playerId, x, y);
        }
        function updatePlayerFrame(playerId, frame) {
            _engine.updatePlayerFrame(playerId, frame);
        }
        function addPassengersToMovement(passengers) {
            var _local_3 = 0;
            while (_local_3 < passengers.length) {
                var _local_2 = passengers[_local_3];
                _movement.addPassenger(_train.getPassengerSlotIndex(_local_2), _local_2, _engine.getPlayerMovieClip(_local_2));
                _local_3++;
            }
        }
        function removePassengersFromMovement(passengerSlots) {
            var _local_2 = 0;
            while (_local_2 < passengerSlots.length) {
                _movement.removePassenger(passengerSlots[_local_2]);
                _local_2++;
            }
        }
        function onPlayerMove(event) {
            if (event.player_id == _train.driverId) {
                _movement.changeTargetPosition(event.x, event.y);
            }
        }
        function checkIsLocalPlayerTrain() {
            _isLocalPlayerTrain = _train.containsPlayer(_shell.getMyPlayerId());
        }
        function addCartToPlayers(players) {
            var _local_1 = 0;
            while (_local_1 < players.length) {
                com.clubpenguin.world.rooms2013.cfc.trains.TrainLoader.addPenguinToTrain(players[_local_1]);
                _local_1++;
            }
        }
        function removeCartFromPlayers(players) {
            var _local_1 = 0;
            while (_local_1 < players.length) {
                com.clubpenguin.world.rooms2013.cfc.trains.TrainLoader.removePenguinFromTrain(players[_local_1]);
                _local_1++;
            }
        }
        function requestJoinTrain() {
            var _local_3 = _global.getCurrentRoom().trainManager;
            if (_local_3.getPlayerTrain(_shell.getMyPlayerId()) == null) {
                _service.sendJoinTrain(_train.driverId);
            }
        }
    }
