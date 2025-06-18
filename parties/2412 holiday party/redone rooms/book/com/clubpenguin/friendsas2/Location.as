//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.friendsas2.Location
    {
        var land, room, world;
        function Location (land, room, world) {
            this.land = land;
            this.room = room;
            this.world = world;
        }
        static function fromRaw(rawLocation) {
            return(new com.clubpenguin.friendsas2.Location(rawLocation.land, rawLocation.room, rawLocation.world));
        }
        function toString() {
            return(((((("Location:{land:" + land) + ", room:") + room) + ", world:") + world) + "}");
        }
    }
