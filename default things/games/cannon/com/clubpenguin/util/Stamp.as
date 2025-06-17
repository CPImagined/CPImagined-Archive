//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.util.Stamp
    {
        function Stamp () {
        }
        static function sendStamp(_arg_3) {
            if (debug) {
                stamps[_arg_3] = true;
            } else {
                var _local_2 = _global.getCurrentShell();
                _local_2.stampEarned(_arg_3);
            }
            trace("--------------------------------------------------------------------------");
            trace("STAMP MESSAGE: Congratulations you just recieved stamp: " + _arg_3);
            trace("--------------------------------------------------------------------------");
        }
        static function checkStamp(_arg_4) {
            var _local_3;
            if (debug) {
                if (stamps[_arg_4]) {
                    return(true);
                }
                return(false);
            }
            var _local_2 = _global.getCurrentShell();
            _local_3 = _local_2.stampIsOwnedByMe(_arg_4);
            return(_local_3);
        }
        static function setDebug(_arg_1) {
            debug = _arg_1;
        }
        static function getDebug() {
            return(debug);
        }
        static function clearStamps() {
            stamps = new Object();
        }
        static function setStamps(_arg_2) {
            for (var _local_3 in _arg_2) {
                var _local_1 = _arg_2[_local_3];
                stamps[_local_1] = true;
            }
        }
        static var debug = false;
        static var stamps = new Object();
    }
