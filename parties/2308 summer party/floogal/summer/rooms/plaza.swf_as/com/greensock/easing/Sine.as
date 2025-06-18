dynamic class com.greensock.easing.Sine
{
    static var _HALF_PI: Number = 1.57079632679;

    function Sine()
    {
    }

    static function easeIn(t, b, c, d)
    {
        return (0 - c) * Math.cos(t / d * com.greensock.easing.Sine._HALF_PI) + c + b;
    }

    static function easeOut(t, b, c, d)
    {
        return c * Math.sin(t / d * com.greensock.easing.Sine._HALF_PI) + b;
    }

    static function easeInOut(t, b, c, d)
    {
        return (0 - c) * 0.5 * (Math.cos(3.14159265359 * t / d) - 1) + b;
    }

}
