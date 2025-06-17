//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.math.MathHelper
    {
        function MathHelper () {
        }
        static function getRandomNumberInRange(_arg_1, _arg_2) {
            return(Math.floor(Math.random() * (_arg_2 - _arg_1)) + _arg_1);
        }
        static function getAngleBetweenCoordinates(_arg_7, _arg_5, _arg_6, _arg_4) {
            var _local_3 = _arg_6 - _arg_7;
            var _local_2 = _arg_4 - _arg_5;
            var _local_1 = int((Math.atan2(_local_2, _local_3) * 57.2957795130823) - 90);
            if (_local_1 < 0) {
                return(_local_1 + 360);
            }
            return(_local_1);
        }
        static function getAngleBetweenPoints(_arg_2, _arg_1) {
            return(getAngleBetweenCoordinates(_arg_2.x, _arg_2.y, _arg_1.x, _arg_1.y));
        }
        static function get8DirectionByAngle(_arg_2) {
            var _local_1 = Math.round(_arg_2 / 45) + 1;
            if (_local_1 > 8) {
                _local_1 = 1;
            }
            return(_local_1);
        }
    }
