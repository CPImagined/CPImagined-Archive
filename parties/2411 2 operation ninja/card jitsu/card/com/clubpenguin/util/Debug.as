//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.util.Debug
    {
        function Debug () {
        }
        static function log(message, level) {
            message = message.toString();
            if ((level === undefined) || (level == "")) {
                level = "GENERAL";
            }
            if (level == "ERROR") {
                __errors.push(message);
                if (__errors.length == 10) {
                    __errors.shift();
                }
            }
            __lc.send("_trace", "trace", (level + "::") + message);
        }
        static function newSession() {
            __lc.send("_trace", "session", "");
        }
        static function getErrors() {
            return(__errors);
        }
        static var __lc = new LocalConnection();
        static var __errors = [];
    }
