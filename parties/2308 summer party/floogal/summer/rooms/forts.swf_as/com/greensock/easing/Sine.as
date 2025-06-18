class com.greensock.easing.Sine
{
    function Sine()
    {
    } // End of the function
    static function easeIn(t, b, c, d)
    {
        return (-c * Math.cos(t / d * com.greensock.easing.Sine._HALF_PI) + c + b);
    } // End of the function
    static function easeOut(t, b, c, d)
    {
        return (c * Math.sin(t / d * com.greensock.easing.Sine._HALF_PI) + b);
    } // End of the function
    static function easeInOut(t, b, c, d)
    {
        return (-c * 0.500000 * (Math.cos(3.141593 * t / d) - 1) + b);
    } // End of the function
    static var _HALF_PI = 1.570796;
} // End of Class
