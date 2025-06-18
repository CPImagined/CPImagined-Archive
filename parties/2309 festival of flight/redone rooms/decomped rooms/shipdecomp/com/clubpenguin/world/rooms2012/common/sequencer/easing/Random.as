//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2012.common.sequencer.easing.Random
    {
        function Random () {
        }
        static function easeNone(t, b, c, d, a) {
            return(((((c * t) / d) + b) + (Math.random() * a)) - (a * 0.5));
        }
        static function easeIn(t, b, c, d, a) {
            return(((((c * t) / d) + b) + (Math.random() * a)) - (a * 0.5));
        }
        static function easeOut(t, b, c, d, a) {
            return(((((c * t) / d) + b) + (Math.random() * a)) - (a * 0.5));
        }
        static function easeInOut(t, b, c, d, a) {
            return(((((c * t) / d) + b) + (Math.random() * a)) - (a * 0.5));
        }
    }
