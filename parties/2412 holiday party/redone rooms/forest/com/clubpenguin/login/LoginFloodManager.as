//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.login.LoginFloodManager
    {
        function LoginFloodManager () {
        }
        static function clearFloodControl() {
            try {
                var so = SharedObject.getLocal(SHARED_OBJECT_NAME, "/");
                so.clear();
                so = null;
            } catch(e:Error) {
            }
        }
        static function setLoginAttempt() {
            var so = SharedObject.getLocal(SHARED_OBJECT_NAME, "/");
            var soResult;
            var now = new Date();
            var loginAttempts = 0;
            var randomMin = 0;
            try {
                if (so.data[LOGIN_ATTEMPTS] != undefined) {
                    loginAttempts = so.data[LOGIN_ATTEMPTS];
                }
                loginAttempts++;
                if (loginAttempts > (LOGIN_DELAYS.length - 1)) {
                    loginAttempts = 0;
                }
                if (loginAttempts == 0) {
                    randomMin = MIN_DELAY;
                }
                so.data[LOGIN_ATTEMPTS] = loginAttempts;
                so.data[NEXT_LOGIN_TIME] = Number(now.getTime() + ((LOGIN_DELAYS[loginAttempts] + com.clubpenguin["math"].MathHelper.getRandomNumberInRange(randomMin, RANDOM_RANGE)) * ONE_SECOND));
                soResult = so.flush();
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
        static var MIN_DELAY = 10;
        static var ONE_SECOND = 1000;
    }
