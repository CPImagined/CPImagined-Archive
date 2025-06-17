
//Created by Action Script Viewer - http://www.buraks.com/asv
    class com.clubpenguin.achievements.verbs.AchievementVerbWearing extends com.clubpenguin.achievements.verbs.AchievementVerb
    {
        var _onlyClause, addSubjectFound, _debug;
        function AchievementVerbWearing (descriptor, debug) {
            super(descriptor, debug);
            if (descriptor[0] == ONLY_TAG) {
                _onlyClause = true;
                descriptor.shift();
            } else {
                _onlyClause = false;
            }
        }
        function activate(subjects, objects, objectOperation) {
            debugTrace("activate");
            var _local14 = ["feet", "hand", "body", "neck", "face", "head", "colour_id"];
            var _local16 = 0;
            var _local17 = subjects.length;
            var _local11 = objects.length;
            var _local15 = _local14.length;
            var _local4 = 0;
            while (_local4 < _local17) {
                var _local10 = 0;
                var _local9 = 0;
                var _local6 = false;
                var _local5 = 0;
                while (_local5 < _local15) {
                    if (((!_onlyClause) && (objectOperation != com.clubpenguin.achievements.objects.AchievementObject.OPERATION_AND)) && (_local6)) {
                        break;
                    }
                    var _local3 = _local14[_local5];
                    if ((_local3 != "colour_id") && (subjects[_local4][_local3] != 0)) {
                        _local10++;
                    }
                    var _local2 = 0;
                    while (_local2 < _local11) {
                        if (subjects[_local4][_local3] == objects[_local2]) {
                            _local6 = true;
                            _local9++;
                            debugTrace((((("activate - peng:" + _local4) + " is wearing ") + objects[_local2]) + " on their ") + _local3);
                            break;
                        }
                        _local2++;
                    }
                    _local5++;
                }
                var _local13 = _local9 == _local11;
                if (_local6 && ((!_onlyClause) || (_local10 == 1))) {
                    if ((objectOperation != com.clubpenguin.achievements.objects.AchievementObject.OPERATION_AND) || (_local13)) {
                        _local16++;
                        addSubjectFound(subjects[_local4]);
                    }
                }
                _local4++;
            }
            debugTrace("activate hits: " + _local16);
            return(_local16);
        }
        function debugTrace(msg) {
            if (_debug) {
            }
        }
        static var ONLY_TAG = "only";
    }
