//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms.common.TriggerManager
    {
        var _triggerClip, _updateMethod, _interactionVO, _playersOnTrigger, _playersInteracting;
        function TriggerManager (triggerClip, updateMethod, interactionVO) {
            _triggerClip = triggerClip;
            _updateMethod = updateMethod;
            _interactionVO = interactionVO;
            _playersOnTrigger = [];
            _playersInteracting = [];
        }
        function destroy() {
            _interactionVO.destroy();
            for (var _local_2 in this) {
                var _local_2 = null;
            }
        }
        function isPlayerOverLocation(player) {
            if (_triggerClip.hitTest(player.x, player.y, true)) {
                _playersOnTrigger.push(player);
                udpateCheck(player.player_id);
                return(true);
            }
            return(false);
        }
        function isPlayerInteracting(player, secretFrame) {
            if (((_interactionVO == undefined) || (playerIndex(player.player_id, _playersOnTrigger) == NOT_LISTED)) || (playerIndex(player.player_id, _playersInteracting) != NOT_LISTED)) {
                return(false);
            }
            if (_interactionVO.specialDance) {
                if ((player.frame == DANCE_FRAME) && (player.frame == secretFrame)) {
                    return(false);
                }
            }
            if (!_interactionVO.areAnyNeeded) {
                _playersInteracting.push(player);
                udpateCheck(player.player_id);
                return(true);
            } else if (_interactionVO.areAllNeeded) {
                if (isPlayerWearingAllNeededItems(player)) {
                    _playersInteracting.push(player);
                    udpateCheck(player.player_id);
                    return(true);
                }
            } else if (isPlayerWearingAnyNeededItems(player)) {
                _playersInteracting.push(player);
                udpateCheck(player.player_id);
                return(true);
            }
            return(false);
        }
        function removePlayer(playerID) {
            var _local_3 = false;
            var _local_5 = playerIndex(playerID, _playersInteracting);
            var _local_2 = playerIndex(playerID, _playersOnTrigger);
            if (_local_5 != NOT_LISTED) {
                _playersInteracting.splice(_local_5, 1);
                _playersOnTrigger.splice(_local_2, 1);
                _local_3 = true;
                udpateCheck(playerID);
            } else if (_local_2 != NOT_LISTED) {
                _playersOnTrigger.splice(_local_2, 1);
                _local_3 = true;
                udpateCheck(playerID);
            }
            return(_local_3);
        }
        function clearInteractingList() {
            _playersInteracting = [];
            udpateCheck();
        }
        function clearPlayerLists() {
            _playersOnTrigger = [];
            _playersInteracting = [];
            udpateCheck();
        }
        function playerIndex(playerID, list) {
            var _local_1 = 0;
            while (_local_1 < list.length) {
                if (list[_local_1].player_id == playerID) {
                    return(_local_1);
                }
                _local_1++;
            }
            return(NOT_LISTED);
        }
        function isPlayerWearingAllNeededItems(player) {
            var _local_4 = [player.colour, player.head, player.face, player.neck, player.body, player.hand, player.feet, player.flag, player.photo];
            var _local_2 = 0;
            while (_local_2 < com.clubpenguin.world.rooms.common.TriggerInteractionVO.ITEM_TYPES) {
                if (_interactionVO.lengths[_local_2] != 0) {
                    if (!isPlayerWearingThis(_local_4[_local_2], _interactionVO.parts[_local_2], _interactionVO.lengths[_local_2])) {
                        return(false);
                    }
                }
                _local_2++;
            }
            return(true);
        }
        function isPlayerWearingAnyNeededItems(player) {
            var _local_4 = [player.colour, player.head, player.face, player.neck, player.body, player.hand, player.feet, player.flag, player.photo];
            var _local_2 = 0;
            while (_local_2 < com.clubpenguin.world.rooms.common.TriggerInteractionVO.ITEM_TYPES) {
                if (_interactionVO.lengths[_local_2] != 0) {
                    if (isPlayerWearingThis(_local_4[_local_2], _interactionVO.parts[_local_2], _interactionVO.lengths[_local_2])) {
                        return(true);
                    }
                }
                _local_2++;
            }
            return(false);
        }
        function isPlayerWearingThis(item, list, listLength) {
            var _local_1 = 0;
            while (_local_1 < listLength) {
                if (item == list[_local_1]) {
                    return(true);
                }
                _local_1++;
            }
            return(false);
        }
        function udpateCheck(updatedPlayerID) {
            if (_interactionVO == undefined) {
                _updateMethod(updatedPlayerID, _playersOnTrigger);
            } else if (_playersInteracting.length > 0) {
                _updateMethod(updatedPlayerID, _playersInteracting);
            }
        }
        static var CLASS_NAME = "TriggerManager";
        static var NOT_LISTED = -1;
        static var DANCE_FRAME = 26;
    }
