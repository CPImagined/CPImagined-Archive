//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2012.common.sequencer.easing.Sine
    {
        function Sine () {
        }
        static function easeIn(t, b, c, d) {
            return((((-c) * Math.cos((t / d) * (Math.PI/2))) + c) + b);
        }
        static function easeOut(t, b, c, d) {
            return((c * Math.sin((t / d) * (Math.PI/2))) + b);
        }
        static function easeInOut(t, b, c, d) {
            return((((-c) / 2) * (Math.cos((Math.PI * t) / d) - 1)) + b);
        }
    }
