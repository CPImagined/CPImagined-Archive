//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.util.Stamp
    {
        function Stamp () {
        }
        static function sendStamp($id) {
            if (debug) {
                stamps[$id] = true;
            } else {
                var _local_2 = _global.getCurrentShell();
                _local_2.stampEarned($id);
            }
            trace("--------------------------------------------------------------------------");
            trace("STAMP MESSAGE: Congratulations you just recieved stamp: " + $id);
            trace("--------------------------------------------------------------------------");
        }
        static function checkStamp($id) {
            var _local_3;
            if (debug) {
                if (stamps[$id]) {
                    return(true);
                }
                return(false);
            }
            var _local_2 = _global.getCurrentShell();
            _local_3 = _local_2.stampIsOwnedByMe($id);
            return(_local_3);
        }
        static function setDebug(mode) {
            debug = mode;
        }
        static function getDebug() {
            return(debug);
        }
        static function clearStamps() {
            stamps = new Object();
        }
        static function setStamps(new_stamps) {
            for (var _local_3 in new_stamps) {
                var _local_1 = new_stamps[_local_3];
                stamps[_local_1] = true;
            }
        }
        static var debug = false;
        static var stamps = new Object();
    }
