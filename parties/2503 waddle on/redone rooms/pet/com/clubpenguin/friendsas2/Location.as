//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.friendsas2.Location
    {
        var land, room, world;
        function Location (_arg_2, _arg_3, _arg_4) {
            land = _arg_2;
            room = _arg_3;
            world = _arg_4;
        }
        static function fromRaw(_arg_1) {
            return(new com.clubpenguin.friendsas2.Location(_arg_1.land, _arg_1.room, _arg_1.world));
        }
        function toString() {
            return(((((("Location:{land:" + land) + ", room:") + room) + ", world:") + world) + "}");
        }
    }
