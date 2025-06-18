//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.friendsas2.buddiesintegration.Roster
    {
        var updated;
        function Roster () {
            updated = new org.osflash.signals.Signal(Number);
        }
        function toString() {
            var _local_6 = ("Roster{\n   worldID:" + _worldID) + "\n   buddies:[\n";
            var _local_5 = 0;
            while (_local_5 < _buddies.length) {
                var _local_3 = _buddies[_local_5];
                _local_6 = _local_6 + (((((((("      Buddy{player_id:" + _local_3.player_id) + ", swid:") + _local_3.swid) + ", nickname:") + _local_3.nickname) + ", is_online:") + _local_3.is_online) + "}\n");
                _local_5++;
            }
            _local_6 = _local_6 + "   ]\n\n   ignore:[";
            var _local_4 = 0;
            while (_local_4 < _ignored.length) {
                var _local_2 = _ignored[_local_4];
                _local_6 = _local_6 + (((((((("      IgnoredBuddy{player_id:" + _local_2.player_id) + ", swid:") + _local_2.swid) + ", nickname:") + _local_2.nickname) + ", is_online:") + _local_2.is_online) + "}\n");
                _local_4++;
            }
            _local_6 = _local_6 + "   ]\n}";
            return(_local_6);
        }
        function get buddies() {
            return(_buddies);
        }
        function get ignored() {
            return(_ignored);
        }
        function get worldID() {
            return(_worldID);
        }
        function set worldID(value) {
            _worldID = value;
            //return(worldID);
        }
        var _buddies = [];
        var _ignored = [];
        var _worldID = "";
    }
