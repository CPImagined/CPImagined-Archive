//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2012.common.sequencer.easing.Quart
    {
        function Quart () {
        }
        static function easeIn(t, b, c, d) {
            t = t / d;
            return(((((c * t) * t) * t) * t) + b);
        }
        static function easeOut(t, b, c, d) {
            t = (t / d) - 1;
            return(((-c) * ((((t * t) * t) * t) - 1)) + b);
        }
        static function easeInOut(t, b, c, d) {
            t = t / (d / 2);
            if (t < 1) {
                return((((((c / 2) * t) * t) * t) * t) + b);
            }
            t = t - 2;
            return((((-c) / 2) * ((((t * t) * t) * t) - 2)) + b);
        }
    }
