class com.clubpenguin.util.FrameAnimationUtils
{
    function FrameAnimationUtils()
    {
    } // End of the function
    static function getDirectionFrameByPoint(pointA, pointB)
    {
        var _loc2;
        _loc2 = com.clubpenguin.util.FrameAnimationUtils.getDirection(com.clubpenguin.util.FrameAnimationUtils.getNormalizedVector(pointA, pointB));
        var _loc1;
        switch (_loc2)
        {
            case com.clubpenguin.util.FrameAnimationUtils.FACE_LEFT:
            {
                _loc1 = 3;
                break;
            } 
            case com.clubpenguin.util.FrameAnimationUtils.FACE_RIGHT:
            {
                _loc1 = 7;
                break;
            } 
            case com.clubpenguin.util.FrameAnimationUtils.FACE_BACK:
            {
                _loc1 = 5;
                break;
            } 
            case com.clubpenguin.util.FrameAnimationUtils.FACE_FRONT:
            {
                _loc1 = 1;
                break;
            } 
            case com.clubpenguin.util.FrameAnimationUtils.FACE_BACKLEFT:
            {
                _loc1 = 4;
                break;
            } 
            case com.clubpenguin.util.FrameAnimationUtils.FACE_BACKRIGHT:
            {
                _loc1 = 6;
                break;
            } 
            case com.clubpenguin.util.FrameAnimationUtils.FACE_FRONTLEFT:
            {
                _loc1 = 2;
                break;
            } 
            case com.clubpenguin.util.FrameAnimationUtils.FACE_FRONTRIGHT:
            {
                _loc1 = 8;
                break;
            } 
            default:
            {
                _loc1 = 0;
            } 
        } // End of switch
        return (_loc1);
    } // End of the function
    static function getNormalizedVector(pointA, pointB)
    {
        var _loc1 = new flash.geom.Point();
        _loc1.x = pointB.x - pointA.x;
        _loc1.y = pointB.y - pointA.y;
        _loc1.normalize(1);
        return (_loc1);
    } // End of the function
    static function getDirection(vector)
    {
        var _loc1 = com.clubpenguin.util.FrameAnimationUtils.FACE_NONE;
        if (vector.x <= -0.330000)
        {
            _loc1 = _loc1 + com.clubpenguin.util.FrameAnimationUtils.FACE_LEFT;
        }
        else if (vector.x >= 0.330000)
        {
            _loc1 = _loc1 + com.clubpenguin.util.FrameAnimationUtils.FACE_RIGHT;
        } // end else if
        if (vector.y <= -0.330000)
        {
            _loc1 = _loc1 + com.clubpenguin.util.FrameAnimationUtils.FACE_BACK;
        }
        else if (vector.y >= 0.330000)
        {
            _loc1 = _loc1 + com.clubpenguin.util.FrameAnimationUtils.FACE_FRONT;
        } // end else if
        return (_loc1);
    } // End of the function
    static var FACE_NONE = 0;
    static var FACE_LEFT = 1;
    static var FACE_RIGHT = 2;
    static var FACE_FRONT = 4;
    static var FACE_BACK = 8;
    static var FACE_BACKLEFT = 9;
    static var FACE_BACKRIGHT = 10;
    static var FACE_FRONTLEFT = 5;
    static var FACE_FRONTRIGHT = 6;
} // End of Class
