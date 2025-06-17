//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.friendsas2.Friend
    {
        var swid, name, presence;
        function Friend (swid, name, presence) {
            this.swid = swid;
            this.name = name;
            this.presence = presence;
        }
        static function fromRaw(rawFriend) {
            var _local_2 = com.clubpenguin.friendsas2.Presence.fromRaw(rawFriend.presence);
            return(new com.clubpenguin.friendsas2.Friend(rawFriend.swid, rawFriend.name, _local_2));
        }
        function toString() {
            return(((((("Friend{swid:" + swid) + ", name:") + name) + ", presence:") + presence.toString()) + "}");
        }
    }
