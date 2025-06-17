//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.login.LoginFloodManager
    {
        function LoginFloodManager () {
        }
        static function clearFloodControl() {
            trace("clearFloodControl");
            try {
                var _local_1 = SharedObject.getLocal(SHARED_OBJECT_NAME, "/");
                _local_1.clear();
                _local_1 = null;
            } catch(e:Error) {
                trace("Error while clearing floodControl SharedObject");
            }
        }
        static function setLoginAttempt() {
            var _local_2 = SharedObject.getLocal(SHARED_OBJECT_NAME, "/");
            var _local_4;
            var _local_5 = new Date();
            var _local_1 = 0;
            var _local_3 = 0;
            trace("setLoginAttempt");
            try {
                if (_local_2.data[LOGIN_ATTEMPTS] != undefined) {
                    _local_1 = _local_2.data[LOGIN_ATTEMPTS];
                }
                _local_1++;
                if (_local_1 > (LOGIN_DELAYS.length - 1)) {
                    _local_1 = 0;
                }
                if (_local_1 == 0) {
                    _local_3 = MIN_DELAY;
                }
                _local_2.data[LOGIN_ATTEMPTS] = _local_1;
                _local_2.data[NEXT_LOGIN_TIME] = Number(_local_5.getTime() + ((LOGIN_DELAYS[_local_1] + com.clubpenguin["math"].MathHelper.getRandomNumberInRange(_local_3, RANDOM_RANGE)) * ONE_SECOND));
                trace("so.data[LOGIN_ATTEMPTS] : " + _local_2.data[LOGIN_ATTEMPTS]);
                trace("so.data[NEXT_LOGIN_TIME] : " + _local_2.data[NEXT_LOGIN_TIME]);
                _local_4 = _local_2.flush();
                trace("soResult : " + _local_4);
            } catch(error:Error) {
                trace("Error writing shared object: " + error.message);
                return(false);
            }
            return(true);
        }
        static var SHARED_OBJECT_NAME = "floodControl";
        static var NEXT_LOGIN_TIME = "nlt";
        static var LOGIN_ATTEMPTS = "att";
        static var LOGIN_DELAYS = [0, 20, 40];
        static var RANDOM_RANGE = 20;
        static var MIN_DELAY = 10;
        static var ONE_SECOND = 1000;
    }
