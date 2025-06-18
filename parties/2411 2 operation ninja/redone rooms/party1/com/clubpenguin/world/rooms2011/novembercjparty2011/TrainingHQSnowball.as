    class com.clubpenguin.world.rooms2011.novembercjparty2011.TrainingHQSnowball extends MovieClip
    {
        var _y, _x;
        function TrainingHQSnowball () {
            super();
            init();
        }
        function init() {
            if (_y < DIVIDE_HORIZONTAL) {
                _snow = true;
            } else if (_x < DIVIDE_VERTICAL) {
                _fire = true;
            } else {
                _water = true;
            }
        }
        static var CLASS_NAME = "TrainingHQSnowball";
        static var DIVIDE_VERTICAL = 380;
        static var DIVIDE_HORIZONTAL = 236;
        var _water = false;
        var _fire = false;
        var _snow = false;
    }
