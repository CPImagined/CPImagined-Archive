//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.missions.managers.MusicTrackEvent
    {
        var _type, _target;
        function MusicTrackEvent ($type, $target) {
            _type = $type;
            _target = $target;
        }
        function toString() {
            return(((("MusicTrackEvent { _type: " + _type) + " _target: ") + _target) + "}");
        }
        function get type() {
            return(_type);
        }
        function get target() {
            return(_target);
        }
        static var INIT = "init";
    }
