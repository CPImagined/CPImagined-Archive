//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2013.prehistoric.scavengerhunt.RoarScavengerHunt
    {
        var _INTERFACE, _SHELL, _handlePlayerFrameDelegate, _roomsRoaredIn, _roomsJustRoaredIn;
        function RoarScavengerHunt () {
            _INTERFACE = _global.getCurrentInterface();
            _SHELL = _global.getCurrentShell();
            _handlePlayerFrameDelegate = com.clubpenguin.util.Delegate.create(this, handlePlayerFrame);
            _SHELL.addListener(_SHELL.PLAYER_FRAME, _handlePlayerFrameDelegate);
            reset();
        }
        function reset() {
            _roomsRoaredIn = [];
            _roomsJustRoaredIn = [];
        }
        function handlePlayerFrame(event) {
            var _local_6 = event.player_id;
            var _local_7 = event.frame;
            var _local_3 = _global.getCurrentShell();
            var _local_8 = _local_3.getPlayerObjectById(_local_3.getMyPlayerId());
            if ((_local_3.isMyPlayer(_local_6) && (com.clubpenguin.world.rooms2013.prehistoric.Prehistoric.isPlayerDinosaur(_local_8.avatar_id))) && (_local_7 == com.clubpenguin.world.rooms2013.prehistoric.Prehistoric.DANCE_FRAME)) {
                var _local_5 = _local_3.getRoomObject().room_key;
                var _local_4;
                switch (_local_5) {
                    case "party2" : 
                    case "party5" : 
                    case "party9" : 
                    case "party10" : 
                    case "party12" : 
                        _local_4 = _local_5;
                        break;
                    default : 
                        _local_4 = null;
                        break;
                }
                if (_local_4 != null) {
                    roomRoared(_local_4);
                }
            }
        }
        function roomRoared(roomKey) {
            var _local_3 = false;
            var _local_2 = 0;
            while (_local_2 < _roomsRoaredIn.length) {
                if (_roomsRoaredIn[_local_2] == roomKey) {
                    _local_3 = true;
                    break;
                }
                _local_2++;
            }
            if (!_local_3) {
                _roomsRoaredIn.push(roomKey);
                _roomsJustRoaredIn.push(roomKey);
                setShowUiInterval();
            }
        }
        function setShowUiInterval() {
            if (_completedTimeout != -1) {
                clearInterval(_completedTimeout);
            }
            _completedTimeout = setInterval(this, "onCompletedTimeout", 2200);
        }
        function onCompletedTimeout() {
            _INTERFACE.showContent(com.clubpenguin.world.rooms2013.prehistoric.Prehistoric.PARTY_MAP);
            clearInterval(_completedTimeout);
        }
        function getRoomsRoaredIn() {
            return(_roomsRoaredIn);
        }
        function getRoomsJustRoaredIn() {
            return(_roomsJustRoaredIn);
        }
        function clearRoomsJustRoaredIn() {
            _roomsJustRoaredIn = [];
        }
        var _completedTimeout = -1;
    }
