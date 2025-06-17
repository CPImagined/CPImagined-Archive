//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.missions.ui.ScreenFadeEvent
    {
        var _type, _target;
        function ScreenFadeEvent ($type, $target) {
            _type = $type;
            _target = $target;
        }
        function toString() {
            return(((("ScreenFadeEvent { _type: " + _type) + " _target: ") + _target) + "}");
        }
        function get type() {
            return(_type);
        }
        function get target() {
            return(_target);
        }
        static var FADE = "fade";
        static var FADE_COMPLETE = "fadeComplete";
        static var FADE_IN = "fadeIn";
        static var FADE_IN_COMPLETE = "fadeInComplete";
        static var FADE_OUT = "fadeOut";
        static var FADE_OUT_COMPLETE = "fadeOutComplete";
    }
