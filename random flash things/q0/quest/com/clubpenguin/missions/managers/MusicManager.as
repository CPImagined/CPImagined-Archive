//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.missions.managers.MusicManager
    {
        function MusicManager () {
        }
        static function init() {
            _tracks = {};
        }
        static function addTrack($name, $url, $target) {
            if (($name == undefined) || ($name == "")) {
            }
            if (_tracks[$name]) {
            }
            if (($url == undefined) || ($url == "")) {
            }
            if (!$target) {
            }
            var _local_2 = new com.clubpenguin.missions.managers.MusicTrack($name, $url, $target);
            _tracks[$name] = _local_2;
            return(_local_2);
        }
        static function getTrack($name) {
            if (!_tracks[$name]) {
            } else {
                return(_tracks[$name]);
            }
        }
        static function removeTrack($name) {
            if (!_tracks[$name]) {
            } else {
                var _local_2 = _tracks[$name];
                _local_2.remove();
                delete _tracks[$name];
                return(true);
            }
        }
        static var _tracks = {};
    }
