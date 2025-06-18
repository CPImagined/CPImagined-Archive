//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms.hotel.hotelspa.HotelSpaSnowball extends MovieClip
    {
        var _x;
        function HotelSpaSnowball () {
            super();
            init();
        }
        function init() {
            if (_x < ROOM_MIDPOINT) {
                _soap = false;
            } else {
                _soap = true;
            }
        }
        static var CLASS_NAME = "HotelSpaSnowball";
        static var ROOM_MIDPOINT = 400;
        var _soap = false;
    }
