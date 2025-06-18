//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2012.common.sequencer.easing.Bounce
    {
        function Bounce () {
        }
        static function easeOut(t, b, c, d) {
            t = t / d;
            if (t < 0.363636363636364) {
                return((c * ((7.5625 * t) * t)) + b);
            } else if (t < 0.727272727272727) {
                t = t - 0.545454545454545;
                return((c * (((7.5625 * t) * t) + 0.75)) + b);
            } else if (t < 0.909090909090909) {
                t = t - 0.818181818181818;
                return((c * (((7.5625 * t) * t) + 0.9375)) + b);
            } else {
                t = t - 0.954545454545455;
                return((c * (((7.5625 * t) * t) + 0.984375)) + b);
            }
        }
        static function easeIn(t, b, c, d) {
            return((c - easeOut(d - t, 0, c, d)) + b);
        }
        static function easeInOut(t, b, c, d) {
            if (t < (d / 2)) {
                return((easeIn(t * 2, 0, c, d) * 0.5) + b);
            } else {
                return(((easeOut((t * 2) - d, 0, c, d) * 0.5) + (c * 0.5)) + b);
            }
        }
    }
