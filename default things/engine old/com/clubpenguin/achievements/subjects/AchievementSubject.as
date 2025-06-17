
//Created by Action Script Viewer - http://www.buraks.com/asv
    class com.clubpenguin.achievements.subjects.AchievementSubject
    {
        var _includeUserInCount, _debug, _quantity, _shell, __get__debug, __get__shell;
        function AchievementSubject (descriptor, includeUserInCount, debug) {
            _includeUserInCount = includeUserInCount;
            _debug = debug;
            _quantity = 1;
        }
        function get includeUserInCount() {
            return(_includeUserInCount);
        }
        function getCurrentSubjects(event) {
            throw new com.clubpenguin.achievements.AchievementException("AchievementSubject::getCurrentSubjects must be overridden.");
            return([]);
        }
        function shouldEventFire(event) {
            return(true);
        }
        function getEnterRoomEvent() {
            return(_shell.ADD_PLAYER);
        }
        function get quantity() {
            return(_quantity);
        }
        function set debug(d) {
            _debug = d;
            //return(__get__debug());
        }
        function set shell(s) {
            _shell = s;
            //return(__get__shell());
        }
        function isNumeric(s) {
            return(!isNaN(s));
        }
        function debugTrace(msg) {
            if (_debug) {
            }
        }
    }
