//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.login.LoginFloodManager
    {
        function LoginFloodManager () {
        }
        static function clearFloodControl() {
            try {
                var _local_1 = SharedObject.getLocal(SHARED_OBJECT_NAME, "/");
                _local_1.clear();
                _local_1 = null;
            } catch(e:Error) {
            }
        }
        static function setLoginAttempt() {
            var _local_1 = SharedObject.getLocal(SHARED_OBJECT_NAME, "/");
            var _local_3;
            var _local_4 = new Date();
            var _local_2 = 0;
            try {
                if (_local_1.data[LOGIN_ATTEMPTS] != undefined) {
                    _local_2 = _local_1.data[LOGIN_ATTEMPTS];
                }
                _local_2++;
                if (_local_2 > (LOGIN_DELAYS.length - 1)) {
                    _local_2 = 0;
                }
                _local_1.data[LOGIN_ATTEMPTS] = _local_2;
                _local_1.data[NEXT_LOGIN_TIME] = Number((_local_4.getTime() + LOGIN_DELAYS[_local_2]) + com.clubpenguin["math"].MathHelper.getRandomNumberInRange(0, RANDOM_RANGE));
                _local_3 = _local_1.flush();
            } catch(error:Error) {
                return(false);
            }
            return(true);
        }
        static var SHARED_OBJECT_NAME = "floodControl";
        static var NEXT_LOGIN_TIME = "nlt";
        static var LOGIN_ATTEMPTS = "att";
        static var LOGIN_DELAYS = [0, 20, 40];
        static var RANDOM_RANGE = 20;
    }
