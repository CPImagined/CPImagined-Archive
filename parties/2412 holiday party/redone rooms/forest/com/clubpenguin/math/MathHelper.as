//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.math.MathHelper
    {
        function MathHelper () {
        }
        static function getRandomNumberInRange(min, max) {
            return(Math.floor(Math.random() * (max - min)) + min);
        }
        static function getAngleBetweenCoordinates(x1, y1, x2, y2) {
            var diffx = (x2 - x1);
            var diffy = (y2 - y1);
            var angle = int((Math.atan2(diffy, diffx) * 57.2957795130823) - 90);
            if (angle < 0) {
                return(angle + 360);
            } else {
                return(angle);
            }
        }
        static function getAngleBetweenPoints(p1, p2) {
            return(getAngleBetweenCoordinates(p1.x, p1.y, p2.x, p2.y));
        }
        static function get8DirectionByAngle(angle) {
            var direction = (Math.round(angle / 45) + 1);
            if (direction > 8) {
                direction = 1;
            }
            return(direction);
        }
    }
