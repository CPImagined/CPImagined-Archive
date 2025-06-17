//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.friendsas2.CredentialsVO
    {
        var playerId, name, swid;
        function CredentialsVO (playerId, name, swid) {
            this.playerId = playerId;
            this.name = name;
            this.swid = swid;
        }
        static function fromRaw(rawCredentials) {
            return(new com.clubpenguin.friendsas2.CredentialsVO(rawCredentials.id, rawCredentials.name, rawCredentials.swid));
        }
        function toString() {
            return(((((("CredentialsVO{playerId:" + playerId) + ", name:") + name) + ", swid:") + swid) + "}");
        }
    }
