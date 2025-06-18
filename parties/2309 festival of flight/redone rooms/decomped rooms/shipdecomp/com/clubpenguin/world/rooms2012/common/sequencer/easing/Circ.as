//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2012.common.sequencer.easing.Circ
    {
        function Circ () {
        }
        static function easeIn(t, b, c, d) {
            t = t / d;
            return(((-c) * (Math.sqrt(1 - (t * t)) - 1)) + b);
        }
        static function easeOut(t, b, c, d) {
            t = (t / d) - 1;
            return((c * Math.sqrt(1 - (t * t))) + b);
        }
        static function easeInOut(t, b, c, d) {
            t = t / (d / 2);
            if (t < 1) {
                return((((-c) / 2) * (Math.sqrt(1 - (t * t)) - 1)) + b);
            }
            t = t - 2;
            return(((c / 2) * (Math.sqrt(1 - (t * t)) + 1)) + b);
        }
    }
