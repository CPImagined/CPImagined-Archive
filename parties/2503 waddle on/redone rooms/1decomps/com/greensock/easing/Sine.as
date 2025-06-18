    class com.greensock.easing.Sine
    {
        function Sine () {
        }
        static function easeIn(t, b, c, d) {
            return((((-c) * Math.cos((t / d) * _HALF_PI)) + c) + b);
        }
        static function easeOut(t, b, c, d) {
            return((c * Math.sin((t / d) * _HALF_PI)) + b);
        }
        static function easeInOut(t, b, c, d) {
            return((((-c) * 0.5) * (Math.cos((Math.PI * t) / d) - 1)) + b);
        }
        static var _HALF_PI = (Math.PI/2);
    }
