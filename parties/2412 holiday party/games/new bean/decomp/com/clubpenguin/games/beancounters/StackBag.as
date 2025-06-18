//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.games.beancounters.StackBag extends MovieClip
    {
        var __floatingScore, attachMovie, getNextHighestDepth, __color, colored_part;
        function StackBag () {
            super();
            __floatingScore = this.attachMovie("FloatingScore", "floatingScore", getNextHighestDepth());
            __floatingScore._visible = false;
        }
        function get color() {
            return(__color);
        }
        function set color(param) {
            __color = param;
            var _local_2 = new Color(colored_part);
            _local_2.setRGB(__color);
            //return(color);
        }
        function tweenMe() {
            var _local_2 = new mx.transitions.Tween(__floatingScore, "_y", mx.transitions.easing.Strong.easeOut, 0, -100, 3, true);
        }
    }
