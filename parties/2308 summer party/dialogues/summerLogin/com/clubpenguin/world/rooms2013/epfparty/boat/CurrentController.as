//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2013.epfparty.boat.CurrentController
    {
        static var _SHELL, _ENGINE, _INTERFACE, _joinRoomDelegate, handleRoomDestroyedDelegate, _playerTeleportDelegate, _triggerArea, _waypointMap, _playersOnCurrent, _playerMoveCompleteDelegate;
        function CurrentController () {
            com.clubpenguin.world.rooms2013.epfparty.EPFParty.pebug("!!!!! CREATING CURRENT CONTROLLER ");
            _SHELL = _global.getCurrentShell();
            _ENGINE = _global.getCurrentEngine();
            _INTERFACE = _global.getCurrentInterface();
            cleanPlayersOnCurrentList();
            addListeners();
        }
        static function addListeners() {
            com.clubpenguin.world.rooms2013.epfparty.EPFParty.pebug("[CURRENT CONTROLLER] add listeners");
            _SHELL = _global.getCurrentShell();
            _ENGINE = _global.getCurrentEngine();
            _joinRoomDelegate = com.clubpenguin.util.Delegate.create(com.clubpenguin.world.rooms2013.epfparty.boat.CurrentController, handleJoinRoom);
            _ENGINE.penguinTransformComplete.add(_joinRoomDelegate);
            handleRoomDestroyedDelegate = com.clubpenguin.util.Delegate.create(com.clubpenguin.world.rooms2013.epfparty.boat.CurrentController, handleRoomDestroyed);
            _SHELL.addListener(_SHELL.ROOM_DESTROYED, handleRoomDestroyedDelegate);
            _playerTeleportDelegate = com.clubpenguin.util.Delegate.create(com.clubpenguin.world.rooms2013.epfparty.boat.CurrentController, handlePlayerTeleport);
            _SHELL.addListener(_SHELL.PLAYER_TELEPORT, _playerTeleportDelegate);
            _SHELL.addListener(_SHELL.PLAYER_MOVE_DONE, _playerTeleportDelegate);
        }
        static function handlePlayerTeleport(playerObj) {
            var _local_2 = _ENGINE.getPlayerMovieClip(playerObj.player_id);
            if (_triggerArea.hitTest(_local_2._x, _local_2._y, true)) {
                addPenguinToCurrent(playerObj.player_id);
            } else if (isPlayerOnCurrent(playerObj.player_id)) {
                removePenguinFromCurrent(playerObj.player_id);
            }
        }
        static function createCurrentTrigger(triggerArea, roomTriggerWatcher, waypointMC) {
            com.clubpenguin.world.rooms2013.epfparty.EPFParty.pebug("[CurrentController] createCurrentTrigger ");
            _triggerArea = triggerArea;
            _waypointMap = waypointMC;
            var _local_1 = new com.clubpenguin.world.rooms.common.triggers.PlayerWalkTrigger(_triggerArea);
            _local_1.playersAdded.add(com.clubpenguin.util.Delegate.create(com.clubpenguin.world.rooms2013.epfparty.boat.CurrentController, penguinsOnWaterTrigger));
            _local_1.playersRemoved.add(com.clubpenguin.util.Delegate.create(com.clubpenguin.world.rooms2013.epfparty.boat.CurrentController, penguinsRemovedFromWaterTrigger));
            roomTriggerWatcher.addTrigger(_local_1);
            waypointMC._visible = false;
            setUpWayPointDetection();
        }
        static function setUpWayPointDetection() {
            for (var _local_1 in _waypointMap) {
                if (_waypointMap[_local_1] instanceof MovieClip) {
                    NUM_WAYPOINTS++;
                }
            }
            com.clubpenguin.world.rooms2013.epfparty.EPFParty.pebug("[CurrentController] NUM_WAYPOINTS " + NUM_WAYPOINTS);
        }
        static function closestWaypointToPlayer(player_id) {
            var _local_6 = _ENGINE.getPlayerMovieClip(player_id);
            var _local_7 = 0;
            var _local_3;
            var _local_1 = 1;
            while (_local_1 <= NUM_WAYPOINTS) {
                var _local_5 = new flash.geom.Point(_waypointMap["wp_" + _local_1]._x, _waypointMap["wp_" + _local_1]._y);
                var _local_4 = new flash.geom.Point(_local_6._x, _local_6._y);
                var _local_2 = flash.geom.Point.distance(_local_5, _local_4);
                if ((_local_2 < _local_3) || (_local_3 == undefined)) {
                    _local_7 = _local_1;
                    _local_3 = _local_2;
                }
                _local_1++;
            }
            return(_local_7);
        }
        static function get playersOnCurrent() {
            return(_playersOnCurrent);
        }
        static function cleanPlayersOnCurrentList() {
            _playersOnCurrent = new Object();
        }
        static function penguinsOnWaterTrigger(playerList) {
            var _local_1 = 0;
            while (_local_1 < playerList.length) {
                if (!isPlayerOnCurrent(playerList[_local_1])) {
                    addPenguinToCurrent(playerList[_local_1]);
                }
                _local_1++;
            }
        }
        static function penguinsRemovedFromWaterTrigger(playerList) {
            var _local_1 = 0;
            while (_local_1 < playerList.length) {
                com.clubpenguin.world.rooms2013.epfparty.EPFParty.pebug("[CurrentController] penguinsRemovedFromWaterTrigger playerList " + playerList[_local_1]);
                removePenguinFromCurrent(playerList[_local_1]);
                _local_1++;
            }
        }
        static function removeAllPenguinsFromCurrent() {
            for (var _local_1 in _playersOnCurrent) {
                removePenguinFromCurrent(_playersOnCurrent[_local_1]);
            }
        }
        static function addPenguinToCurrent(player_id) {
            var _local_2 = _ENGINE.getPlayerMovieClip(player_id);
            playersOnCurrent[player_id] = true;
            if ((_SHELL.getMyPlayerId() == player_id) && (_ENGINE.getPlayerAction() != "wait")) {
                _SHELL.sendPlayerMove(_local_2._x, _local_2._y, true);
            }
            sendPlayerToNextWaypoint(player_id);
        }
        static function sendPlayerToNextWaypoint(player_id) {
            var _local_1 = closestWaypointToPlayer(player_id);
            if ((!isPlayerOnCurrent(player_id)) || (_local_1 >= NUM_WAYPOINTS)) {
                com.clubpenguin.world.rooms2013.epfparty.EPFParty.pebug("[CurrentController] sendPlayerToNextWaypoint: Player has reached last waypoint ");
                return(undefined);
            }
            var _local_2 = _ENGINE.getPlayerMovieClip(player_id);
            var _local_7 = Math.round(_waypointMap["wp_" + (_local_1 + 1)]._x);
            var _local_6 = Math.round(_waypointMap["wp_" + (_local_1 + 1)]._y);
            var _local_4 = new flash.geom.Point(_local_7, _local_6);
            var _local_3 = Math.atan(Math.abs(_local_4.y - _local_2._y) / Math.abs(_local_4.x - _local_2._x));
            if (isNaN(_local_3)) {
                return(undefined);
            }
            com.clubpenguin.world.rooms2013.epfparty.EPFParty.pebug("[CurrentController] addPenguinToCurrent destinationAngle " + _local_3);
            _local_2.onEnterFrame = com.clubpenguin.util.Delegate.create(com.clubpenguin.world.rooms2013.epfparty.boat.CurrentController, movePenguinTowardsNextWaypoint, player_id, _local_4, _local_3, Number(_local_1 + 1));
            frameCounter = 0;
        }
        static function handlePlayerMoveComplete(playerObj) {
            com.clubpenguin.world.rooms2013.epfparty.EPFParty.pebug("[CurrentController] handlePlayerMoveComplete " + playerObj.player_id);
            _SHELL.removeListener(_SHELL.PLAYER_MOVE_DONE, _playerMoveCompleteDelegate);
            sendPlayerToNextWaypoint(playerObj.player_id);
        }
        static function movePenguinTowardsNextWaypoint(player_id, destinationPoint, destinationAngle, currentWaypoint) {
            var _local_1 = _ENGINE.getPlayerMovieClip(player_id);
            var _local_5 = _ENGINE.getNicknameMovieClip(player_id);
            var _local_4 = _INTERFACE.BALLOONS.getMC(player_id);
            if ((!isPlayerOnCurrent(player_id)) || ((_SHELL.getMyPlayerId() == player_id) && (_ENGINE.getPlayerAction() == "move"))) {
                delete _local_1.onEnterFrame;
                _playerMoveCompleteDelegate = com.clubpenguin.util.Delegate.create(com.clubpenguin.world.rooms2013.epfparty.boat.CurrentController, handlePlayerMoveComplete);
                _SHELL.addListener(_SHELL.PLAYER_MOVE_DONE, _playerMoveCompleteDelegate);
                return(undefined);
            }
            var _local_6 = (((destinationPoint.x - _local_1._x) < 0) ? -1 : 1);
            var _local_7 = (((destinationPoint.y - _local_1._y) < 0) ? -1 : 1);
            _local_4._x = (_local_1._x = (_local_5._x = _local_5._x + ((Math.abs(destinationPoint.x - _local_1._x) >= 1) ? ((_local_6 * CURRENT_SPEED) * Math.cos(destinationAngle)) : 0)));
            _local_4._y = (_local_1._y = (_local_5._y = _local_5._y + ((Math.abs(destinationPoint.y - _local_1._y) >= 1) ? ((_local_7 * CURRENT_SPEED) * Math.sin(destinationAngle)) : 0)));
            _ENGINE.updatePlayerDepth(_local_1, _local_1.depth_id);
            if ((_SHELL.getMyPlayerId() == player_id) && (_ENGINE.getPlayerAction() != "wait")) {
                _ENGINE.setPlayerAction("wait");
            }
            if (flash.geom.Point.distance(destinationPoint, new flash.geom.Point(_local_1._x, _local_1._y)) <= 20) {
                delete _local_1.onEnterFrame;
                com.clubpenguin.world.rooms2013.epfparty.EPFParty.pebug("[CurrentController] movePenguinTowardsNextWaypoint Destination reached " + flash.geom.Point.distance(destinationPoint, new flash.geom.Point(_local_1._x, _local_1._y)));
                if (_SHELL.getMyPlayerId() == player_id) {
                    _ENGINE.sendPlayerTeleport(Math.round(_local_1._x), Math.round(_local_1._y));
                }
                sendPlayerToNextWaypoint(player_id);
            }
            frameCounter++;
        }
        static function removePenguinFromCurrent(player_id) {
            playersOnCurrent[player_id] = false;
            var _local_1 = _ENGINE.getPlayerMovieClip(player_id);
            delete _local_1.onEnterFrame;
        }
        static function isPlayerOnCurrent(player_id) {
            return(((_playersOnCurrent[player_id] == undefined) ? false : (_playersOnCurrent[player_id])));
        }
        static function handleJoinRoom(playerObj) {
            if (_triggerArea == undefined) {
                return(undefined);
            }
            var _local_1 = _ENGINE.getPlayerMovieClip(playerObj.player_id);
            if (_triggerArea.hitTest(_local_1._x, _local_1._y, true)) {
                addPenguinToCurrent(playerObj.player_id);
            }
        }
        static function handleRoomDestroyed() {
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, handleRoomDestroyedDelegate);
            _SHELL.removeListener(_SHELL.PLAYER_TELEPORT, _playerTeleportDelegate);
            _SHELL.removeListener(_SHELL.PLAYER_MOVE_DONE, _playerTeleportDelegate);
            _ENGINE.penguinTransformComplete.remove(_joinRoomDelegate);
            com.clubpenguin.world.rooms2013.epfparty.EPFParty.pebug("[CurrentController] handleRoomDestroyed ");
            removeAllPenguinsFromCurrent();
            cleanPlayersOnCurrentList();
            _triggerArea = undefined;
            _ENGINE.setPlayerAction("wait");
        }
        static var CURRENT_SPEED = 1.5;
        static var NUM_WAYPOINTS = 0;
        static var frameCounter = 0;
    }
