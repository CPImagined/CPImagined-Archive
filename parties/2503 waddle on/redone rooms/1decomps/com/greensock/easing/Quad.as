    class com.greensock.easing.Quad
    {
        function Quad () {
        }
        static function easeIn(t, b, c, d) {
            t = t / d;
            return(((c * t) * t) + b);
        }
        static function easeOut(t, b, c, d) {
            t = t / d;
            return((((-c) * t) * (t - 2)) + b);
        }
        static function easeInOut(t, b, c, d) {
            t = t / (d * 0.5);
            if (t < 1) {
                return((((c * 0.5) * t) * t) + b);
            }
            t--;
            return((((-c) * 0.5) * ((t * (t - 2)) - 1)) + b);
        }
    }
