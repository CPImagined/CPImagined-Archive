//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.util.FrameAnimationUtils
    {
        function FrameAnimationUtils () {
        }
        static function getDirectionFrameByPoint(pointA, pointB) {
            var _local_2;
            _local_2 = getDirection(getNormalizedVector(pointA, pointB));
            var _local_1;
            switch (_local_2) {
                case FACE_LEFT : 
                    _local_1 = 3;
                    break;
                case FACE_RIGHT : 
                    _local_1 = 7;
                    break;
                case FACE_BACK : 
                    _local_1 = 5;
                    break;
                case FACE_FRONT : 
                    _local_1 = 1;
                    break;
                case FACE_BACKLEFT : 
                    _local_1 = 4;
                    break;
                case FACE_BACKRIGHT : 
                    _local_1 = 6;
                    break;
                case FACE_FRONTLEFT : 
                    _local_1 = 2;
                    break;
                case FACE_FRONTRIGHT : 
                    _local_1 = 8;
                    break;
                default : 
                    _local_1 = 0;
            }
            return(_local_1);
        }
        static function getNormalizedVector(pointA, pointB) {
            var _local_1 = new flash.geom.Point();
            _local_1.x = pointB.x - pointA.x;
            _local_1.y = pointB.y - pointA.y;
            _local_1.normalize(1);
            return(_local_1);
        }
        static function getDirection(vector) {
            var _local_1 = FACE_NONE;
            if (vector.x <= -0.33) {
                _local_1 = _local_1 + FACE_LEFT;
            } else if (vector.x >= 0.33) {
                _local_1 = _local_1 + FACE_RIGHT;
            }
            if (vector.y <= -0.33) {
                _local_1 = _local_1 + FACE_BACK;
            } else if (vector.y >= 0.33) {
                _local_1 = _local_1 + FACE_FRONT;
            }
            return(_local_1);
        }
        static var FACE_NONE = 0;
        static var FACE_LEFT = 1;
        static var FACE_RIGHT = 2;
        static var FACE_FRONT = 4;
        static var FACE_BACK = 8;
        static var FACE_BACKLEFT = 9;
        static var FACE_BACKRIGHT = 10;
        static var FACE_FRONTLEFT = 5;
        static var FACE_FRONTRIGHT = 6;
    }
