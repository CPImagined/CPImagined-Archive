//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms.common.TriggerCheck
    {
        static var triggerCheckInstance;
        var _triggerManagerList, _SHELL, _playerMoveDelegate, _playerRemovedDelegate, _playerMoveDoneDelegate, _playerUpdateDelegate, _triggerManagerListLength;
        function TriggerCheck () {
            _triggerManagerList = [];
            if (!_SHELL) {
                _SHELL = _global.getCurrentShell();
                _playerMoveDelegate = com.clubpenguin.util.Delegate.create(this, playerMove);
                _playerRemovedDelegate = com.clubpenguin.util.Delegate.create(this, playerRemoved);
                _playerMoveDoneDelegate = com.clubpenguin.util.Delegate.create(this, playerMoveDone);
                _playerUpdateDelegate = com.clubpenguin.util.Delegate.create(this, playerUpdate);
                _SHELL.addListener(_SHELL.PLAYER_MOVE, _playerMoveDelegate);
                _SHELL.addListener(_SHELL.REMOVE_PLAYER, _playerRemovedDelegate);
                _SHELL.addListener(_SHELL.PLAYER_MOVE_DONE, _playerMoveDoneDelegate);
                _SHELL.addListener(_SHELL.UPDATE_PLAYER, _playerUpdateDelegate);
                _SHELL.addListener(_SHELL.PLAYER_FRAME, _playerUpdateDelegate);
                _SHELL.addListener(_SHELL.PLAYER_ACTION, _playerUpdateDelegate);
            }
        }
        static function fetchInstance() {
            if (!triggerCheckInstance) {
                triggerCheckInstance = new com.clubpenguin.world.rooms.common.TriggerCheck();
            }
            return(triggerCheckInstance);
        }
        function init() {
            var _local_3 = _SHELL.getPlayerList();
            var _local_2 = 0;
            while (_local_2 < _local_3.length) {
                if (_SHELL.isMyPlayer(_local_3[_local_2].player_id)) {
                } else {
                    playerMoveDone(_local_3[_local_2]);
                    playerUpdate(_local_3[_local_2]);
                }
                _local_2++;
            }
        }
        function destroy() {
            _SHELL.removeListener(_SHELL.PLAYER_MOVE, _playerMoveDelegate);
            _SHELL.removeListener(_SHELL.REMOVE_PLAYER, _playerRemovedDelegate);
            _SHELL.removeListener(_SHELL.PLAYER_MOVE_DONE, _playerMoveDoneDelegate);
            _SHELL.removeListener(_SHELL.UPDATE_PLAYER, _playerUpdateDelegate);
            _SHELL.removeListener(_SHELL.PLAYER_FRAME, _playerUpdateDelegate);
            _SHELL.removeListener(_SHELL.PLAYER_ACTION, _playerUpdateDelegate);
            var _local_2 = 0;
            while (_local_2 < _triggerManagerListLength) {
                _triggerManagerList[_local_2].destroy();
                _local_2++;
            }
            for (_local_2 in this) {
                this[_local_2] = null;
            }
            triggerCheckInstance = null;
        }
        function addTrigger(triggerClip, updateMethod) {
            _nextId++;
            _triggerManagerList.push(new com.clubpenguin.world.rooms.common.TriggerManager(_nextId, triggerClip, updateMethod));
            _triggerManagerListLength = _triggerManagerList.length;
            return(_nextId);
        }
        function defineAreAllNeededRequirement(id, value) {
            fetchManager(id).allAreNeeded(value);
        }
        function defineAreAnyNeededRequirement(id, value) {
            fetchManager(id).anyAreNeeded(value);
        }
        function defineDancingRequiredRequirement(id, value) {
            fetchManager(id).dancingRequired(value);
        }
        function defineSpecialDanceRequirement(id, value) {
            fetchManager(id).specialDanceRequired(value);
        }
        function defineColourRequirement(id, value) {
            fetchManager(id).colour(value);
        }
        function defineHeadRequirement(id, value) {
            fetchManager(id).head(value);
        }
        function defineFaceRequirement(id, value) {
            fetchManager(id).face(value);
        }
        function defineNeckRequirement(id, value) {
            fetchManager(id).neck(value);
        }
        function defineBodyRequirement(id, value) {
            fetchManager(id).body(value);
        }
        function defineHandRequirement(id, value) {
            fetchManager(id).hand(value);
        }
        function defineFeetRequirement(id, value) {
            fetchManager(id).feet(value);
        }
        function defineFlagRequirement(id, value) {
            fetchManager(id).flag(value);
        }
        function definePhotoRequirement(id, value) {
            fetchManager(id).photo(value);
        }
        function clearInteractingPlayers(id) {
            fetchManager(id).clearInteractingPlayers();
        }
        function fetchManager(id) {
            var _local_2 = 0;
            while (_local_2 < _triggerManagerListLength) {
                if (_triggerManagerList[_local_2].id == id) {
                    return(_triggerManagerList[_local_2]);
                }
                _local_2++;
            }
        }
        function playerMove(player) {
            removePlayerFromAllLists(player.player_id);
        }
        function playerRemoved(playerID) {
            removePlayerFromAllLists(playerID);
        }
        function removePlayerFromAllLists(playerID) {
            var _local_2 = 0;
            while (_local_2 < _triggerManagerListLength) {
                if (_triggerManagerList[_local_2].removePlayer(playerID)) {
                    break;
                }
                _local_2++;
            }
        }
        function playerMoveDone(player) {
            var _local_2 = 0;
            while (_local_2 < _triggerManagerListLength) {
                if (_triggerManagerList[_local_2].isPlayerOverLocation(player)) {
                    break;
                }
                _local_2++;
            }
        }
        function playerUpdate(player) {
            if (!player) {
                return(undefined);
            }
            var _local_3;
            if (player.player_id == undefined) {
                _local_3 = _SHELL.getPlayerObjectById(player);
            } else {
                _local_3 = _SHELL.getPlayerObjectById(player.player_id);
            }
            var _local_2 = 0;
            while (_local_2 < _triggerManagerListLength) {
                var _local_4 = _SHELL.getSecretFrame(_local_3.player_id, _local_3.frame);
                if (_triggerManagerList[_local_2].isPlayerInteracting(_local_3, _local_4)) {
                    break;
                }
                _local_2++;
            }
        }
        static var CLASS_NAME = "TriggerCheck";
        var _nextId = -1;
    }
