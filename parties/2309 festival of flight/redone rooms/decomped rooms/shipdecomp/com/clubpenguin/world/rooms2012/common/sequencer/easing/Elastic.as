//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2012.common.sequencer.easing.Elastic
    {
        function Elastic () {
        }
        static function easeIn(t, b, c, d, a, p) {
            if (t == 0) {
                return(b);
            }
            t = t / d;
            if (t == 1) {
                return(b + c);
            }
            if (!p) {
                p = d * 0.3;
            }
            var _local_5;
            if ((!a) || (a < Math.abs(c))) {
                a = c;
                _local_5 = p / 4;
            } else {
                _local_5 = (p / (Math.PI*2)) * Math.asin(c / a);
            }
            t = t - 1;
            return((-((a * Math.pow(2, 10 * t)) * Math.sin((((t * d) - _local_5) * (Math.PI*2)) / p))) + b);
        }
        static function easeOut(t, b, c, d, a, p) {
            if (t == 0) {
                return(b);
            }
            t = t / d;
            if (t == 1) {
                return(b + c);
            }
            if (!p) {
                p = d * 0.3;
            }
            var _local_5;
            if ((!a) || (a < Math.abs(c))) {
                a = c;
                _local_5 = p / 4;
            } else {
                _local_5 = (p / (Math.PI*2)) * Math.asin(c / a);
            }
            return((((a * Math.pow(2, -10 * t)) * Math.sin((((t * d) - _local_5) * (Math.PI*2)) / p)) + c) + b);
        }
        static function easeInOut(t, b, c, d, a, p) {
            if (t == 0) {
                return(b);
            }
            t = t / (d / 2);
            if (t == 2) {
                return(b + c);
            }
            if (!p) {
                p = d * 0.45;
            }
            var _local_5;
            if ((!a) || (a < Math.abs(c))) {
                a = c;
                _local_5 = p / 4;
            } else {
                _local_5 = (p / (Math.PI*2)) * Math.asin(c / a);
            }
            if (t < 1) {
                t = t - 1;
                return((-0.5 * ((a * Math.pow(2, 10 * t)) * Math.sin((((t * d) - _local_5) * (Math.PI*2)) / p))) + b);
            }
            t = t - 1;
            return(((((a * Math.pow(2, -10 * t)) * Math.sin((((t * d) - _local_5) * (Math.PI*2)) / p)) * 0.5) + c) + b);
        }
    }
