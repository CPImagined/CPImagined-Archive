//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.achievements.AchievementResult
    {
        var _shell, _debug, _callbackFunc, _callbackParams, __get__shell, __get__debug;
        function AchievementResult (shell, descriptor, debug) {
            _shell = shell;
            _debug = debug;
            var _local_3 = String(descriptor.shift());
            debugTrace(((("Constructor - command:" + _local_3) + " params:'") + descriptor) + "'");
            switch (_local_3) {
                case "trace" : 
                    _callbackFunc = trace;
                    _callbackParams = [descriptor.join(" ")];
                    break;
                case ACHIEVEMENTRESULT_CALLBACK : 
                    _callbackFunc = descriptor[0];
                    _callbackParams = [this];
                    break;
                case ACHIEVEMENTRESULT_BROADCAST : 
                    _callbackFunc = com.clubpenguin.util.Delegate.create(shell, shell.updateListeners);
                    _callbackParams = descriptor;
                    break;
                case ACHIEVEMENTRESULT_STAMPEARNED : 
                    _callbackFunc = com.clubpenguin.util.Delegate.create(shell, shell.stampEarned);
                    _callbackParams = [descriptor[0], false];
                    break;
                default : 
                    throw new com.clubpenguin.achievements.AchievementException(("Result command not recognised:\"" + _local_3) + "\"");
                    break;
            }
        }
        function fire() {
            _callbackFunc.apply(null, _callbackParams);
        }
        function set shell(s) {
            _shell = s;
            //return(__get__shell());
        }
        function set debug(d) {
            _debug = d;
            //return(__get__debug());
        }
        function destroy() {
            _callbackFunc = null;
            _callbackParams = null;
        }
        function debugTrace(msg) {
            if (_debug) {
            }
        }
        static var ACHIEVEMENTRESULT_CALLBACK = "callback";
        static var ACHIEVEMENTRESULT_BROADCAST = "broadcast";
        static var ACHIEVEMENTRESULT_STAMPEARNED = "stampEarned";
    }
