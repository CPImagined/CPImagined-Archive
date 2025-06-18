
//Created by Action Script Viewer - http://www.buraks.com/asv
    class com.clubpenguin.engine.projectiles.SnowballHitController
    {
        var _SHELL, _INTERFACE, _hitSnowballs, _activeRoomId, _joinRoomDelegate, _playerMoveDelegate, _playerTransformDelegate, _playerRemovedDelegate;
        function SnowballHitController (_arg_3, _arg_2) {
            _SHELL = _arg_3;
            _INTERFACE = _arg_2;
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
        function playerSnowballHitCheck(_arg_2, _arg_4) {
            var _local_3 = _arg_4.hitCheck(_arg_2);
            if (_local_3 > 0) {
                _arg_2.hit_player_id = _local_3;
                _hitSnowballs[_arg_2.id] = _arg_2;
                if (_SHELL.isMyPlayer(_arg_2.hit_player_id)) {
                    _INTERFACE.stopQuickKeys();
                }
                _SHELL.updateListeners(com.clubpenguin.engine.projectiles.events.SnowballEvent.SNOWBALL_HIT, _arg_2);
            }
        }
        function handleJoinRoom() {
            if (_activeRoomId != _SHELL.getCurrentRoomId()) {
                _activeRoomId = _SHELL.getCurrentRoomId();
                _hitSnowballs = {};
            }
        }
        function handlePlayerRemoved(_arg_2) {
            handlePlayerMove(_SHELL.getPlayerObjectById(_arg_2));
        }
        function handlePlayerTransform(_arg_2) {
            if (_arg_2.avatarId != 0) {
                handlePlayerMove(_arg_2.player);
            }
        }
        function handlePlayerMove(_arg_4) {
            if (_SHELL.isMyPlayer(_arg_4.player_id)) {
                _INTERFACE.startQuickKeys();
            }
            var _local_3 = [];
            for (var _local_5 in _hitSnowballs) {
                if (_arg_4.player_id == _hitSnowballs[_local_5].hit_player_id) {
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
        function removeSnowball(_arg_4) {
            for (var _local_3 in _hitSnowballs) {
                var _local_2 = _hitSnowballs[_local_3];
                if ((_local_2.snowballMC == _arg_4) && (_local_2.hit_player_id != undefined)) {
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
