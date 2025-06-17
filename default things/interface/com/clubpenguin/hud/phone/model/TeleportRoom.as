//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.hud.phone.model.TeleportRoom
    {
        function TeleportRoom (key, serverID, localizedName) {
            this["key"] = key;
            this.serverID = serverID;
            this.localizedName = localizedName;
        }
        function toString() {
            return(((((("[TeleportRoom key=\"" + key) + "\" serverID=") + serverID) + " localizedName=") + localizedName) + "]");
        }
        var key = "";
        var serverID = -1;
        var localizedName = "";
    }
