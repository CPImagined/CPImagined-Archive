//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2012.common.sequencer.easing.Back
    {
        function Back () {
        }
        static function easeIn(t, b, c, d, s) {
            if (isNaN(s)) {
                s = 1.70158;
            }
            t = t / d;
            return((((c * t) * t) * (((s + 1) * t) - s)) + b);
        }
        static function easeOut(t, b, c, d, s) {
            if (isNaN(s)) {
                s = 1.70158;
            }
            t = (t / d) - 1;
            return((c * (((t * t) * (((s + 1) * t) + s)) + 1)) + b);
        }
        static function easeInOut(t, b, c, d, s) {
            if (isNaN(s)) {
                s = 1.70158;
            }
            t = t / (d / 2);
            if (t < 1) {
                s = s * 1.525;
                return(((c / 2) * ((t * t) * (((s + 1) * t) - s))) + b);
            }
            t = t - 2;
            s = s * 1.525;
            return(((c / 2) * (((t * t) * (((s + 1) * t) + s)) + 2)) + b);
        }
    }
