//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2013.cfc.trains.TrainManager
    {
        var _service, _trains, _trainControllers, _trainUnloadedPlayers, _playerLoadedDelegates, _passengersAddedHelper, _passengersRemovedHelper, _updateClip, _shell, _interface, _engine, _tracker;
        function TrainManager () {
            trace("HSF TrainManager CTOR");
            _service = new com.clubpenguin.world.rooms2013.cfc.trains.TrainService();
            _service.trainsUpdated.add(onTrainsUpdated, this);
            _service.trainRemoved.add(onTrainRemoved, this);
            _trains = new Object();
            _trainControllers = new Object();
            _trainUnloadedPlayers = new Object();
            _playerLoadedDelegates = new Object();
            _passengersAddedHelper = new Array();
            _passengersRemovedHelper = new Array();
            var _local_3 = com.clubpenguin.world.rooms.BaseRoom.current.getStage();
            _updateClip = _local_3._parent.createEmptyMovieClip("_updateClip", _local_3.getNextHighestDepth());
            _updateClip.onEnterFrame = com.clubpenguin.util.Delegate.create(this, onEnterFrame);
            _shell = _global.getCurrentShell();
            _interface = _global.getCurrentInterface();
            _engine = _global.getCurrentEngine();
            _tracker = com.clubpenguin.util.TrackerAS2.getInstance();
        }
        function destroy() {
            _service.destroy();
            _updateClip.onEnterFrame = null;
            _updateClip.removeMovieClip();
            for (var _local_2 in _trainControllers) {
                _trainControllers[_local_2].destroy();
            }
            for (var _local_2 in _playerLoadedDelegates) {
                _engine.penguinTransformComplete.remove(_playerLoadedDelegates[_local_2], this);
                delete _playerLoadedDelegates[_local_2];
            }
        }
        function get service() {
            return(_service);
        }
        function onEnterFrame() {
            for (var _local_2 in _trainControllers) {
                _trainControllers[_local_2].onUpdate();
            }
        }
        function onTrainsUpdated(trains) {
            trace("HSF Manager onTrainsUpdated trains=" + trains);
            var _local_4 = 0;
            while (_local_4 < trains.length) {
                var _local_2 = trains[_local_4];
                var _local_3 = _trains[_local_2.driverId];
                if (_local_3 == null) {
                    trace("HSF new train added");
                    assembleNewTrain(_local_2);
                } else {
                    trace("HSF existing train updated");
                    _local_3.getPassengerDifferences(_local_2, _passengersAddedHelper);
                    _local_2.getPassengerDifferences(_local_3, _passengersRemovedHelper);
                    var _local_5 = _trainControllers[_local_2.driverId];
                    trace("HSF _passengersAddedHelper = " + _passengersAddedHelper);
                    trace("HSF _passengersRemovedHelper = " + _passengersRemovedHelper);
                    if (_passengersAddedHelper.length > 0) {
                        if ((_local_2.driverId == _shell.getMyPlayerId()) && (_local_3.passengers.length == 0)) {
                            _tracker.trackStepTimingEvent("train_engine", "start");
                        }
                        _local_4 = 0;
                        while (_local_4 < _passengersAddedHelper.length) {
                            if (_passengersAddedHelper[_local_4] == _shell.getMyPlayerId()) {
                                _tracker.trackGameAction(_local_2.passengers.length.toString(), "train_engine_join", {message:"passenger"});
                            }
                            if (_local_2.driverId == _shell.getMyPlayerId()) {
                                _tracker.trackGameAction(_local_2.passengers.length.toString(), "train_engine_join", {message:"conductor"});
                            }
                            _local_4++;
                        }
                        _local_3.passengers = _local_2.passengers;
                        _local_5.onPassengersAdded(_passengersAddedHelper);
                    }
                    if (_passengersRemovedHelper.length > 0) {
                        if ((_local_2.driverId == _shell.getMyPlayerId()) && (_local_2.passengers.length == 0)) {
                            _tracker.trackStepTimingEvent("train_engine", "end");
                        }
                        var _local_6 = new Array();
                        _local_4 = 0;
                        while (_local_4 < _passengersRemovedHelper.length) {
                            _local_6.push(_local_3.getPassengerSlotIndex(_passengersRemovedHelper[_local_4]));
                            _local_4++;
                        }
                        _local_3.passengers = _local_2.passengers;
                        trace("HSF removedPassengerSlots = " + _local_6);
                        _local_5.onPassengersRemoved(_passengersRemovedHelper, _local_6);
                    }
                    if (_local_3.score != _local_2.score) {
                        var _local_8 = _local_3.score;
                        _local_3.score = _local_2.score;
                        _local_5.onScoreUpdated(_local_8);
                    }
                    if (_local_3.state != _local_2.state) {
                        _local_3.state = _local_2.state;
                        if (_local_2.state == com.clubpenguin.world.rooms2013.cfc.trains.states.TrainStateEnum.DRIVING) {
                            _local_5.onClosed();
                        } else if (_local_2.state == com.clubpenguin.world.rooms2013.cfc.trains.states.TrainStateEnum.BOARDING) {
                            _local_5.onOpened();
                        }
                    }
                }
                _local_4++;
            }
        }
        function assembleNewTrain(train) {
            trace("HSF assembleNewTrain " + train);
            var _local_3 = getUnloadedPlayers(train);
            if (_local_3.length == 0) {
                trace("HSF all players loaded... init train");
                initTrain(train);
            } else {
                trace("HSF all players NOT loaded... wait for loading to finish");
                _trainUnloadedPlayers[train.driverId] = _local_3;
                var _local_4 = com.clubpenguin.util.Delegate.create(this, onPlayerLoaded, train, _local_3);
                _playerLoadedDelegates[train.driverId] = _local_4;
                _engine.penguinTransformComplete.add(_local_4, this);
            }
        }
        function onPlayerLoaded(player, train, unloadedPlayers) {
            trace((("HSF onPlayerLoaded " + train) + "  ") + unloadedPlayers);
            var _local_2 = 0;
            while (_local_2 < unloadedPlayers.length) {
                if (unloadedPlayers[_local_2] == player.player_id) {
                    unloadedPlayers.splice(_local_2, 1);
                    break;
                }
                _local_2++;
            }
            trace("HSF unloadedPlayers.length = " + unloadedPlayers.length);
            if (unloadedPlayers.length == 0) {
                trace("HSF players all finished loading!!! yay");
                _engine.penguinTransformComplete.remove(_playerLoadedDelegates[train.driverId], this);
                delete _trainUnloadedPlayers[train.driverId];
                delete _playerLoadedDelegates[train.driverId];
                initTrain(train);
            }
        }
        function initTrain(train) {
            trace("HSF initTrain " + train);
            _trains[train.driverId] = train;
            _trainControllers[train.driverId] = new com.clubpenguin.world.rooms2013.cfc.trains.TrainController(train, _service);
        }
        function getUnloadedPlayers(train) {
            var _local_6 = new Array();
            trace("HSF areAllPlayersLoaded " + train);
            var _local_2 = 0;
            while (_local_2 < train.passengers.length) {
                var _local_4 = train.passengers[_local_2];
                var _local_3 = _engine.getPlayerMovieClip(_local_4);
                trace("HSF mc = " + _local_3);
                if (!_local_3.is_ready) {
                    _local_6.push(_local_4);
                }
                _local_2++;
            }
            var _local_7 = _engine.getPlayerMovieClip(train.driverId);
            if (!_local_7.is_ready) {
                _local_6.push(train.driverId);
            }
            return(_local_6);
        }
        function onTrainRemoved(train) {
            var _local_4 = _trains[train.driverId];
            if (_local_4 != null) {
                if (train.driverId == _shell.getMyPlayerId()) {
                    _tracker.trackStepTimingEvent("train_engine", "end");
                }
                var _local_3 = _trainControllers[train.driverId];
                _local_3.onTrainRemoved();
                _local_3.destroy();
                delete _trainControllers[train.driverId];
                delete _trains[train.driverId];
            }
        }
        function isPlayerADriver(playerId) {
            var _local_2 = com.clubpenguin.world.rooms2013.cfc.CFCParty.isTrainBodyItemEquipped(playerId);
            return((_trains[playerId] != null) || (_local_2 && (getPlayerTrain() == null)));
        }
        function getPlayerTrain(playerId) {
            trace(("HSF getPlayerTrain(" + playerId) + ")");
            trace("HSF _trains[playerId] = " + _trains[playerId]);
            if (_trains[playerId] != null) {
                trace("playerId is a driver, return " + _trains[playerId]);
                return(_trains[playerId]);
            }
            for (var _local_4 in _trains) {
                var _local_2 = _trains[_local_4];
                if (_local_2.containsPassenger(playerId)) {
                    trace("HSF playerId is a passenger, return " + _local_2);
                    return(_local_2);
                }
            }
            return(null);
        }
    }
