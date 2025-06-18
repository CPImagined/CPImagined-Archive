dynamic class com.clubpenguin.math.MathHelper
{

    function MathHelper()
    {
    }

    static function getRandomNumberInRange(min, max)
    {
        return Math.floor(Math.random() * (max - min)) + min;
    }

    static function getAngleBetweenCoordinates(x1, y1, x2, y2)
    {
        var __reg2 = x2 - x1;
        var __reg3 = y2 - y1;
        var __reg1 = int(Math.atan2(__reg3, __reg2) * 57.2957795131 - 90);
        if (__reg1 < 0) 
        {
            return __reg1 + 360;
        }
        return __reg1;
    }

    static function getAngleBetweenPoints(p1, p2)
    {
        return com.clubpenguin.math.MathHelper.getAngleBetweenCoordinates(p1.x, p1.y, p2.x, p2.y);
    }

    static function get8DirectionByAngle(angle)
    {
        var __reg1 = Math.round(angle / 45) + 1;
        if (__reg1 > 8) 
        {
            __reg1 = 1;
        }
        return __reg1;
    }

}
