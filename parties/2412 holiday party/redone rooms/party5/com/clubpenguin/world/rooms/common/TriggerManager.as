//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms.common.TriggerManager
    {
        var id, _triggerClip, _updateMethod, _playersOnTrigger, _playersInteracting, _interactionRequirements, _lastPlayersOnTriggerLength;
        function TriggerManager (id, triggerClip, updateMethod) {
            this.id = id;
            _triggerClip = triggerClip;
            _updateMethod = updateMethod;
            _playersOnTrigger = [];
            _playersInteracting = [];
        }
        function destroy() {
            _interactionRequirements.destroy();
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
        function isPlayerInteracting(player, secretFrame) {
            if (((_interactionRequirements == undefined) || (playerIndex(player.player_id, _playersOnTrigger) == NOT_LISTED)) || (playerIndex(player.player_id, _playersInteracting) != NOT_LISTED)) {
                return(false);
            }
            if (_interactionRequirements.isPlayerInteracting(player, secretFrame)) {
                _playersInteracting.push(player);
                udpateCheck(player.player_id);
                return(true);
            } else {
                return(false);
            }
        }
        function clearInteractingPlayers() {
            _playersInteracting = [];
        }
        function allAreNeeded(value) {
            defineInteractionRequirements();
            _interactionRequirements.areAllNeeded = value;
        }
        function anyAreNeeded(value) {
            defineInteractionRequirements();
            _interactionRequirements.areAnyNeeded = value;
        }
        function dancingRequired(value) {
            defineInteractionRequirements();
            _interactionRequirements.dancingRequired = value;
        }
        function specialDanceRequired(value) {
            defineInteractionRequirements();
            _interactionRequirements.specialDance = value;
        }
        function colour(value) {
            defineInteractionRequirements();
            _interactionRequirements.colour = value;
        }
        function head(value) {
            defineInteractionRequirements();
            _interactionRequirements.head = value;
        }
        function face(value) {
            defineInteractionRequirements();
            _interactionRequirements.face = value;
        }
        function neck(value) {
            defineInteractionRequirements();
            _interactionRequirements.neck = value;
        }
        function body(value) {
            defineInteractionRequirements();
            _interactionRequirements.body = value;
        }
        function hand(value) {
            defineInteractionRequirements();
            _interactionRequirements.hand = value;
        }
        function feet(value) {
            defineInteractionRequirements();
            _interactionRequirements.feet = value;
        }
        function flag(value) {
            defineInteractionRequirements();
            _interactionRequirements.flag = value;
        }
        function photo(value) {
            defineInteractionRequirements();
            _interactionRequirements.photo = value;
        }
        function defineInteractionRequirements() {
            if (!_interactionRequirements) {
                _interactionRequirements = new com.clubpenguin.world.rooms.common.InteractionRequirements();
            }
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
        function udpateCheck(updatedPlayerID) {
            if (!_interactionRequirements) {
                if (_playersOnTrigger.length == _lastPlayersOnTriggerLength) {
                    return(undefined);
                }
                _lastPlayersOnTriggerLength = _playersOnTrigger.length;
                _updateMethod(updatedPlayerID, _playersOnTrigger);
            } else {
                _updateMethod(updatedPlayerID, _playersInteracting);
            }
        }
        static var CLASS_NAME = "TriggerManager";
        static var NOT_LISTED = -1;
    }
