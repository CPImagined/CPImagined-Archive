//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.friendsas2.buddiesintegration.BuddyVO
    {
        var player_id, swid, nickname, is_online, world_id, room_id;
        function BuddyVO (playerId, swid, name, online, world, room) {
            player_id = playerId;
            this.swid = swid;
            nickname = name;
            is_online = online;
            world_id = world;
            room_id = room;
        }
        function toString() {
            return(((((((((((("BuddyVO{player_id:" + player_id) + ", swid:") + swid) + ", nickname:") + nickname) + ", is_online:") + is_online) + ", world_id:") + world_id) + ", room_id:") + room_id) + "}");
        }
    }
