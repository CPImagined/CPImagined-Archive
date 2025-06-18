//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2012.common.sequencer.easing.Quad
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
            t = t / (d / 2);
            if (t < 1) {
                return((((c / 2) * t) * t) + b);
            }
            t--;
            return((((-c) / 2) * ((t * (t - 2)) - 1)) + b);
        }
    }
