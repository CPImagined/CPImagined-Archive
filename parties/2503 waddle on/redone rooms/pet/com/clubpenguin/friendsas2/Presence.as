//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.friendsas2.Presence
    {
        var status, id, location;
        function Presence (_arg_4, _arg_2, _arg_3) {
            status = _arg_4;
            id = _arg_2;
            location = _arg_3;
        }
        static function fromRaw(_arg_2) {
            var _local_1 = null;
            if (_arg_2.location) {
                _local_1 = com.clubpenguin.friendsas2.Location.fromRaw(_arg_2.location);
            }
            return(new com.clubpenguin.friendsas2.Presence(_arg_2.status, _arg_2.id, _local_1));
        }
        function toString() {
            var _local_2 = "Location:null";
            if (location) {
                _local_2 = location.toString();
            }
            return(((((("Presence{status:" + status) + ", ID:") + id) + ", location:") + _local_2) + "}");
        }
        static var DEFAULT_STATUS = "online";
    }
