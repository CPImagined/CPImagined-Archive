//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2012.common.triggers.PlayerWalkTrigger extends com.clubpenguin.world.rooms2012.common.triggers.PlayerTrigger
    {
        var _prevPlayerSnapshot, _playerSnapshot, _playerCount, playersWalking, playersStanding, playersAdded, playersRemoved;
        function PlayerWalkTrigger (triggerArea) {
            super(triggerArea);
        }
        function endSnapshot() {
            for (var _local_5 in _prevPlayerSnapshot) {
                if (!_playerSnapshot[_local_5]) {
                    _playerSnapshot[_local_5] = com.clubpenguin.world.rooms2012.common.triggers.PlayerTrigger.GONE;
                    continue;
                } else if (((_prevPlayerSnapshot[_local_5] == com.clubpenguin.world.rooms2012.common.triggers.PlayerTrigger.STOPPED) || (_prevPlayerSnapshot[_local_5] == com.clubpenguin.world.rooms2012.common.triggers.PlayerTrigger.STANDING)) && (_playerSnapshot[_local_5] == com.clubpenguin.world.rooms2012.common.triggers.PlayerTrigger.STOPPED)) {
                    _playerSnapshot[_local_5] = com.clubpenguin.world.rooms2012.common.triggers.PlayerTrigger.STANDING;
                }
            }
            var _local_4 = [];
            var _local_2 = [];
            var _local_6 = [];
            var _local_3 = [];
            for (var _local_5 in _playerSnapshot) {
                _playerCount++;
                switch (_playerSnapshot[_local_5]) {
                    case com.clubpenguin.world.rooms2012.common.triggers.PlayerTrigger.WALKING : 
                        _local_4.push(_local_5);
                        if (!_prevPlayerSnapshot[_local_5]) {
                            _local_2.push(_local_5);
                        }
                        break;
                    case com.clubpenguin.world.rooms2012.common.triggers.PlayerTrigger.GONE : 
                        _local_3.push(_local_5);
                        delete _playerSnapshot[_local_5];
                        break;
                }
            }
            if (_local_4.length >= 0) {
                playersWalking.dispatch(_local_4);
            }
            if (_local_6.length >= 0) {
                playersStanding.dispatch(_local_6);
            }
            if (_local_2.length > 0) {
                playersAdded.dispatch(_local_2);
            }
            if (_local_3.length > 0) {
                playersRemoved.dispatch(_local_3);
            }
        }
    }
