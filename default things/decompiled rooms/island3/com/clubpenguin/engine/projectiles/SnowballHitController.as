//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.engine.projectiles.SnowballHitController
    {
        var _SHELL, _INTERFACE, _hitSnowballs, _activeRoomId, _joinRoomDelegate, _playerMoveDelegate, _playerTransformDelegate, _playerRemovedDelegate;
        function SnowballHitController (shell, _interface) {
            _SHELL = shell;
            _INTERFACE = _interface;
            _hitSnowballs = {};
            _activeRoomId = -1;
            _joinRoomDelegate = com.clubpenguin.util.Delegate.create(this, handleJoinRoom);
            _playerMoveDelegate = com.clubpenguin.util.Delegate.create(this, handlePlayerMove);
            _playerTransformDelegate = com.clubpenguin.util.Delegate.create(this, handlePlayerTransform);
            _playerRemovedDelegate = com.clubpenguin.util.Delegate.create(this, handlePlayerRemoved);
            _SHELL.addListener(_SHELL.JOIN_ROOM, _joinRoomDelegate);
            _SHELL.addListener(_SHELL.PLAYER_MOVE, _playerMoveDelegate);
            _SHELL.addListener(_SHELL.PLAYER_AVATAR_TRANSFORMED, _playerTransformDelegate);
            _SHELL.addListener(_SHELL.REMOVE_PLAYER, _playerRemovedDelegate);
        }
        function playerSnowballHitCheck(snowballEvent, snowballHitCheck) {
            var _local_3 = snowballHitCheck.hitCheck(snowballEvent);
            if (_local_3 > 0) {
                snowballEvent.hit_player_id = _local_3;
                _hitSnowballs[snowballEvent.id] = snowballEvent;
                if (_SHELL.isMyPlayer(snowballEvent.hit_player_id)) {
                    _INTERFACE.stopQuickKeys();
                }
                _SHELL.updateListeners(com.clubpenguin.engine.projectiles.events.SnowballEvent.SNOWBALL_HIT, snowballEvent);
            }
        }
        function handleJoinRoom() {
            if (_activeRoomId != _SHELL.getCurrentRoomId()) {
                _activeRoomId = _SHELL.getCurrentRoomId();
                _hitSnowballs = {};
            }
        }
        function handlePlayerRemoved(player_id) {
            handlePlayerMove(_SHELL.getPlayerObjectById(player_id));
        }
        function handlePlayerTransform(eventData) {
            if (eventData.avatarId != 0) {
                handlePlayerMove(eventData.player);
            }
        }
        function handlePlayerMove(playerObj) {
            if (_SHELL.isMyPlayer(playerObj.player_id)) {
                _INTERFACE.startQuickKeys();
            }
            var _local_3 = [];
            for (var _local_5 in _hitSnowballs) {
                if (playerObj.player_id == _hitSnowballs[_local_5].hit_player_id) {
                    _local_3.push(_local_5);
                }
            }
            var _local_2 = _local_3.length - 1;
            while (_local_2 > -1) {
                _hitSnowballs[_local_3[_local_2]].snowballMC._visible = false;
                delete _hitSnowballs[_local_3[_local_2]];
                _local_2--;
            }
            _local_3 = null;
        }
        function removeSnowball(snowballMC) {
            for (var _local_3 in _hitSnowballs) {
                var _local_2 = _hitSnowballs[_local_3];
                if ((_local_2.snowballMC == snowballMC) && (_local_2.hit_player_id != undefined)) {
                    if (_SHELL.isMyPlayer(_local_2.hit_player_id)) {
                        _INTERFACE.startQuickKeys();
                    }
                    delete _hitSnowballs[_local_3];
                    break;
                }
            }
        }
        function get hitSnowballCount() {
            return(_hitSnowballs.length);
        }
    }
