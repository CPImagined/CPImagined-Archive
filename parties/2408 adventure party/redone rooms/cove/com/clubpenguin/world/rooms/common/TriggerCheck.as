//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms.common.TriggerCheck
    {
        var _triggerManagerList, _triggerManagerListLength, _playersInteracting, _SHELL, _playerMoveDelegate, _playerRemovedDelegate, _playerMoveDoneDelegate, _playerUpdateDelegate;
        function TriggerCheck (triggerManagerList) {
            _triggerManagerList = triggerManagerList;
            _triggerManagerListLength = _triggerManagerList.length;
            _playersInteracting = [];
            init();
        }
        function init() {
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
            initialPlayerCheck();
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
                _local_2 = null;
            }
        }
        function clearInteractingLists() {
            var _local_2 = 0;
            while (_local_2 < _triggerManagerListLength) {
                _triggerManagerList[_local_2].clearInteractingList();
                _local_2++;
            }
        }
        function clearPlayerLists() {
            var _local_2 = 0;
            while (_local_2 < _triggerManagerListLength) {
                _triggerManagerList[_local_2].clearPlayerLists();
                _local_2++;
            }
        }
        function initialPlayerCheck() {
            var _local_3 = _SHELL.getPlayerList();
            var _local_2 = 0;
            while (_local_2 < _local_3.length) {
                playerMoveDone(_local_3[_local_2]);
                playerUpdate(_local_3[_local_2]);
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
            if (player.player_id == undefined) {
                player = _SHELL.getPlayerObjectById(player);
            }
            if (player.frame != DANCE_FRAME) {
                return(undefined);
            }
            var _local_2 = 0;
            while (_local_2 < _triggerManagerListLength) {
                var _local_4 = _SHELL.getSecretFrame(player.player_id, player.frame);
                if (_triggerManagerList[_local_2].isPlayerInteracting(player, _local_4)) {
                    break;
                }
                _local_2++;
            }
        }
        static var CLASS_NAME = "TriggerCheck";
        static var DANCE_FRAME = 26;
    }
