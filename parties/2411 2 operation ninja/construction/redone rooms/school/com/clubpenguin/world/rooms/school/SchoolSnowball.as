//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms.school.SchoolSnowball extends MovieClip
    {
        var _y, _x;
        function SchoolSnowball () {
            super();
            init();
        }
        function init() {
            if (_y > 320) {
                return(undefined);
            }
            if (_x < ROOM_MIDPOINT) {
                _paper = true;
                _pizza = false;
            } else {
                _paper = false;
                _pizza = true;
            }
        }
        static var CLASS_NAME = "SchoolSnowball";
        static var ROOM_MIDPOINT = 400;
        var _paper = false;
        var _pizza = false;
    }
