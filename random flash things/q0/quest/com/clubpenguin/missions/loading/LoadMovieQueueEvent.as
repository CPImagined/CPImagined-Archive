//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.missions.loading.LoadMovieQueueEvent
    {
        var _type, _target;
        function LoadMovieQueueEvent ($type, $target) {
            _type = $type;
            _target = $target;
        }
        function toString() {
            return(((("LoadMovieQueueEvent { _type: " + _type) + " _target: ") + _target) + "}");
        }
        function get type() {
            return(_type);
        }
        function get target() {
            return(_target);
        }
        static var COMPLETE = "complete";
        static var PROGRESS = "progress";
    }
