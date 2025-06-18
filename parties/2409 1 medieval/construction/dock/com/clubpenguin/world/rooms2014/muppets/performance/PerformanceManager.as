//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2014.muppets.performance.PerformanceManager
    {
        var _service, _performances, _performanceControllers, _performanceUnloadedPlayers, _playerLoadedDelegates, _participantsAddedHelper, _participantsRemovedHelper, _updateClip, _shell, _interface, _engine, _tracker;
        function PerformanceManager () {
            _service = new com.clubpenguin.world.rooms2014.muppets.performance.PerformanceService();
            _service.performanceUpdated.add(onPerformancesUpdated, this);
            _service.performanceRemoved.add(onPerformanceRemoved, this);
            _performances = new Object();
            _performanceControllers = new Object();
            _performanceUnloadedPlayers = new Object();
            _playerLoadedDelegates = new Object();
            _participantsAddedHelper = new Array();
            _participantsRemovedHelper = new Array();
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
            for (var _local_2 in _performanceControllers) {
                _performanceControllers[_local_2].destroy();
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
            for (var _local_2 in _performanceControllers) {
                _performanceControllers[_local_2].onUpdate();
            }
        }
        function onPerformancesUpdated(performances) {
            com.clubpenguin.util.Log.info("[PerformanceManager] onPerformancesUpdated: " + performances);
            var _local_4 = 0;
            while (_local_4 < performances.length) {
                var _local_2 = performances[_local_4];
                var _local_3 = _performances[_local_2.hostId];
                if (_local_3 == null) {
                    com.clubpenguin.util.Log.info("[PerformanceManager] assembleNewPerformance: " + _local_2);
                    assembleNewPerformance(_local_2);
                } else {
                    com.clubpenguin.util.Log.info("[PerformanceManager] existing peformance: " + _local_2);
                    var _local_5 = _performanceControllers[_local_2.hostId];
                    _local_3.participant = performances[_local_4].participant;
                    if (_local_3.state != _local_2.state) {
                        _local_3.state = _local_2.state;
                        if (_local_2.state == com.clubpenguin.world.rooms2014.muppets.performance.states.PerformanceStateEnum.PERFORMING) {
                            _local_5.onClosed();
                        } else if (_local_2.state == com.clubpenguin.world.rooms2014.muppets.performance.states.PerformanceStateEnum.BOARDING) {
                            _local_5.onOpened();
                        }
                    }
                }
                _local_4++;
            }
        }
        function assembleNewPerformance(performance) {
            com.clubpenguin.util.Log.info("[PerformanceManager] initPerformance: " + performance);
            initPerformance(performance);
        }
        function onPlayerLoaded(player, performance, unloadedPlayers) {
            var _local_2 = 0;
            while (_local_2 < unloadedPlayers.length) {
                if (unloadedPlayers[_local_2] == player.player_id) {
                    unloadedPlayers.splice(_local_2, 1);
                    break;
                }
                _local_2++;
            }
            if (unloadedPlayers.length == 0) {
                _engine.penguinTransformComplete.remove(_playerLoadedDelegates[performance.hostId], this);
                delete _performanceUnloadedPlayers[performance.hostId];
                delete _playerLoadedDelegates[performance.hostId];
                initPerformance(performance);
            }
        }
        function initPerformance(performance) {
            com.clubpenguin.util.Log.info("[PerformanceManager] initPerformance: " + performance);
            _performances[performance.hostId] = performance;
            _performanceControllers[performance.hostId] = new com.clubpenguin.world.rooms2014.muppets.performance.PerformanceController(performance, _service);
        }
        function getUnloadedPlayers(performance) {
            var _local_2 = new Array();
            var _local_3 = performance.participant;
            var _local_4 = _engine.getPlayerMovieClip(_local_3);
            if (!_local_4.is_ready) {
                _local_2.push(_local_3);
            }
            var _local_6 = _engine.getPlayerMovieClip(performance.hostId);
            if (!_local_6.is_ready) {
                _local_2.push(performance.hostId);
            }
            return(_local_2);
        }
        function onPerformanceRemoved(performance) {
            var _local_4 = _performances[performance.hostId];
            if (_local_4 != null) {
                if (performance.hostId == _shell.getMyPlayerId()) {
                }
                var _local_3 = _performanceControllers[performance.hostId];
                _local_3.onPerformanceRemoved();
                _local_3.destroy();
                delete _performanceControllers[performance.hostId];
                delete _performances[performance.hostId];
            }
        }
        function isPlayerAHost(playerId) {
            return((_performances[playerId] != null) || (com.clubpenguin.world.rooms2014.muppets.MuppetsParty.isWearingInteractiveItem(playerId) && (getPlayerPerformance() == null)));
        }
        function getPlayerPerformance(playerId) {
            if (_performances[playerId] != null) {
                return(_performances[playerId]);
            }
            for (var _local_4 in _performances) {
                var _local_2 = _performances[_local_4];
                if (_local_2.containsParticipant(playerId)) {
                    return(_local_2);
                }
            }
            return(null);
        }
    }
