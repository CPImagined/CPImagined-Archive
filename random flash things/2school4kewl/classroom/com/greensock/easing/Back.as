class com.greensock.easing.Back
{
    function Back()
    {
    } // End of the function
    static function easeIn(t, b, c, d, s)
    {
        if (s == undefined)
        {
            s = 1.701580;
        } // end if
        t = t / d;
        return (c * (t) * t * ((s + 1) * t - s) + b);
    } // End of the function
    static function easeOut(t, b, c, d, s)
    {
        if (s == undefined)
        {
            s = 1.701580;
        } // end if
        t = t / d - 1;
        return (c * ((t) * t * ((s + 1) * t + s) + 1) + b);
    } // End of the function
    static function easeInOut(t, b, c, d, s)
    {
        if (s == undefined)
        {
            s = 1.701580;
        } // end if
        t = t / (d * 0.500000);
        if (t < 1)
        {
            s = s * 1.525000;
            return (c * 0.500000 * (t * t * ((s + 1) * t - s)) + b);
        } // end if
        t = t - 2;
        s = s * 1.525000;
        return (c * 0.500000 * ((t) * t * ((s + 1) * t + s) + 2) + b);
    } // End of the function
} // End of Class
