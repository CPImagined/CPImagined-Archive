//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2012.common.triggers.PlayerTrigger
    {
        var _triggerArea, playersAdded, playersRemoved, playersStanding, playersWalking, _prevPlayerSnapshot, _playerSnapshot, _playerCount, _isLocalPlayerOnly, _requiredAction, _clothingRequirements;
        function PlayerTrigger (triggerArea) {
            _triggerArea = triggerArea;
            if (!_triggerArea) {
                trace("A trigger path is incorrect! Check all you trigger instance paths.");
            } else {
                trace("Tigger added successfully: " + _triggerArea);
            }
            playersAdded = new org.osflash.signals.Signal(Array);
            playersRemoved = new org.osflash.signals.Signal(Array);
            playersStanding = new org.osflash.signals.Signal(Array);
            playersWalking = new org.osflash.signals.Signal(Array);
            _prevPlayerSnapshot = {};
            _playerSnapshot = {};
            _playerCount = 0;
            _isLocalPlayerOnly = false;
        }
        function getBounds(mc) {
            if (mc) {
                return(_triggerArea.getBounds(mc));
            }
            return(_triggerArea.getBounds());
        }
        function beginSnapshot() {
            _prevPlayerSnapshot = _playerSnapshot;
            _playerSnapshot = {};
            _playerCount = 0;
        }
        function getPlayerCount() {
            return(_playerCount);
        }
        function getPlayersWhoAre(state) {
            var _local_2 = [];
            for (var _local_3 in _playerSnapshot) {
                if (_playerSnapshot[_local_3] == state) {
                    _local_2.push(Number(_local_3));
                }
            }
            return(_local_2);
        }
        function getAllPlayers() {
            var _local_2 = [];
            for (var _local_3 in _playerSnapshot) {
                _local_2.push(Number(_local_3));
            }
            return(_local_2);
        }
        function endSnapshot() {
            for (var _local_6 in _prevPlayerSnapshot) {
                if (!_playerSnapshot[_local_6]) {
                    _playerSnapshot[_local_6] = GONE;
                    continue;
                } else if (((_prevPlayerSnapshot[_local_6] == STOPPED) || (_prevPlayerSnapshot[_local_6] == STANDING)) && (_playerSnapshot[_local_6] == STOPPED)) {
                    _playerSnapshot[_local_6] = STANDING;
                }
            }
            var _local_5 = [];
            var _local_2 = [];
            var _local_3 = [];
            var _local_4 = [];
            for (var _local_6 in _playerSnapshot) {
                switch (_playerSnapshot[_local_6]) {
                    case WALKING : 
                        _playerCount++;
                        _local_5.push(_local_6);
                        break;
                    case STANDING : 
                        _playerCount++;
                        _local_3.push(_local_6);
                        break;
                    case STOPPED : 
                        _playerCount++;
                        _local_2.push(_local_6);
                        break;
                    case GONE : 
                        _local_4.push(_local_6);
                        delete _playerSnapshot[_local_6];
                        break;
                }
            }
            if (_local_5.length >= 0) {
                playersWalking.dispatch(_local_5);
            }
            if (_local_3.length >= 0) {
                playersStanding.dispatch(_local_3);
            }
            if (_local_2.length > 0) {
                playersAdded.dispatch(_local_2);
            }
            if (_local_4.length > 0) {
                playersRemoved.dispatch(_local_4);
            }
        }
        function hitTest(player, playerMC) {
            if (_isLocalPlayerOnly && (!com.clubpenguin.world.rooms2012.common.triggers.PlayerAction.isLocalPlayer(player))) {
                return(false);
            }
            if (_requiredAction && (!com.clubpenguin.world.rooms2012.common.triggers.PlayerAction.isPlayer(player, _requiredAction))) {
                return(false);
            }
            if (!clothingRequirementMet(player)) {
                return(false);
            }
            if (_triggerArea.hitTest(playerMC._x, playerMC._y, true)) {
                if (playerMC.is_moving) {
                    _playerSnapshot[player.player_id] = WALKING;
                } else {
                    _playerSnapshot[player.player_id] = STOPPED;
                }
                return(true);
            }
            return(false);
        }
        function isLocalPlayerOnly() {
            _isLocalPlayerOnly = true;
        }
        function clothingRequirementMet(player) {
            if (!_clothingRequirements) {
                return(true);
            }
            var _local_2 = 0;
            while (_local_2 < _clothingRequirements.length) {
                if (!com.clubpenguin.world.rooms2012.common.triggers.ClothingRequirement(_clothingRequirements[_local_2]).isWornBy(player)) {
                    return(false);
                }
                _local_2++;
            }
            return(true);
        }
        function addClothingRequirement(bodyPart, clothingID) {
            if (!_clothingRequirements) {
                _clothingRequirements = [];
            }
            _clothingRequirements.push(new com.clubpenguin.world.rooms2012.common.triggers.ClothingRequirement(bodyPart, clothingID));
        }
        function requireAction(action) {
            _requiredAction = action;
        }
        static var WALKING = "walking";
        static var STANDING = "standing";
        static var GONE = "gone";
        static var STOPPED = "stopped";
    }
