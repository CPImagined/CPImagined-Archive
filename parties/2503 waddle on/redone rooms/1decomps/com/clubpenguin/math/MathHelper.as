    class com.clubpenguin.math.MathHelper
    {
        function MathHelper () {
        }
        static function getRandomNumberInRange(min, max) {
            return(Math.floor(Math.random() * (max - min)) + min);
        }
        static function getAngleBetweenCoordinates(x1, y1, x2, y2) {
            var _local_3 = x2 - x1;
            var _local_2 = y2 - y1;
            var _local_1 = int((Math.atan2(_local_2, _local_3) * 57.2957795130823) - 90);
            if (_local_1 < 0) {
                return(_local_1 + 360);
            }
            return(_local_1);
        }
        static function getAngleBetweenPoints(p1, p2) {
            return(getAngleBetweenCoordinates(p1.x, p1.y, p2.x, p2.y));
        }
        static function get8DirectionByAngle(angle) {
            var _local_1 = Math.round(angle / 45) + 1;
            if (_local_1 > 8) {
                _local_1 = 1;
            }
            return(_local_1);
        }
    }
