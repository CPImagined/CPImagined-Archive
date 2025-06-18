//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2012.common.sequencer.easing.Expo
    {
        function Expo () {
        }
        static function easeIn(t, b, c, d) {
            return(((t == 0) ? (b) : ((c * Math.pow(2, 10 * ((t / d) - 1))) + b)));
        }
        static function easeOut(t, b, c, d) {
            return(((t == d) ? (b + c) : ((c * ((-Math.pow(2, (-10 * t) / d)) + 1)) + b)));
        }
        static function easeInOut(t, b, c, d) {
            if (t == 0) {
                return(b);
            }
            if (t == d) {
                return(b + c);
            }
            t = t / (d / 2);
            if (t < 1) {
                return(((c / 2) * Math.pow(2, 10 * (t - 1))) + b);
            }
            t--;
            return(((c / 2) * ((-Math.pow(2, -10 * t)) + 2)) + b);
        }
    }
