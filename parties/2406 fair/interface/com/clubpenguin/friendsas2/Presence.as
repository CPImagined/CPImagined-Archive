//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.friendsas2.Presence
    {
        var status, id, location;
        function Presence (status, id, location) {
            this.status = status;
            this.id = id;
            this.location = location;
        }
        static function fromRaw(rawPresence) {
            var _local_1 = null;
            if (rawPresence.location) {
                _local_1 = com.clubpenguin.friendsas2.Location.fromRaw(rawPresence.location);
            }
            return(new com.clubpenguin.friendsas2.Presence(rawPresence.status, rawPresence.id, _local_1));
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
