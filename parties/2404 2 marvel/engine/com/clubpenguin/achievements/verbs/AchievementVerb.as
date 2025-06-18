//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.achievements.verbs.AchievementVerb
    {
        var _debug, _subjectsFoundOn, _isList, __get__isList, __get__debug, _shell, __get__shell;
        function AchievementVerb (descriptor, debug) {
            _debug = debug;
            _subjectsFoundOn = [];
        }
        function set isList(flag) {
            _isList = flag;
            //return(__get__isList());
        }
        function activate(subjects, objects, objectOperation) {
            throw new com.clubpenguin.achievements.AchievementException("AchievementVerb::activate - this function should be overridden!");
            return(-1);
        }
        function debugTrace(msg) {
            if (_debug) {
            }
        }
        function set debug(d) {
            _debug = d;
            //return(__get__debug());
        }
        function set shell(s) {
            _shell = s;
            //return(__get__shell());
        }
        function addSubjectFound(subject) {
            var _local_3 = _subjectsFoundOn.length;
            var _local_2 = 0;
            while (_local_2 < _local_3) {
                if (_subjectsFoundOn[_local_2] == subject) {
                    return(undefined);
                }
                _local_2++;
            }
            _subjectsFoundOn.push(subject);
        }
        function clearSubjectsFoundOn() {
            _subjectsFoundOn = [];
        }
        function get subjectsFoundOn() {
            return(_subjectsFoundOn);
        }
    }
