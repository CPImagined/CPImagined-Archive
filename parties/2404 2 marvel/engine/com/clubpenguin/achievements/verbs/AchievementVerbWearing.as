//Created by Action Script Viewer - https://www.buraks.com/asv
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
            var _local_14 = ["feet", "hand", "body", "neck", "face", "head", "colour_id"];
            var _local_16 = 0;
            var _local_17 = subjects.length;
            var _local_11 = objects.length;
            var _local_15 = _local_14.length;
            var _local_4 = 0;
            while (_local_4 < _local_17) {
                var _local_10 = 0;
                var _local_9 = 0;
                var _local_6 = false;
                var _local_5 = 0;
                while (_local_5 < _local_15) {
                    if (((!_onlyClause) && (objectOperation != com.clubpenguin.achievements.objects.AchievementObject.OPERATION_AND)) && (_local_6)) {
                        break;
                    }
                    var _local_3 = _local_14[_local_5];
                    if ((_local_3 != "colour_id") && (subjects[_local_4][_local_3] != 0)) {
                        _local_10++;
                    }
                    var _local_2 = 0;
                    while (_local_2 < _local_11) {
                        if (subjects[_local_4][_local_3] == objects[_local_2]) {
                            _local_6 = true;
                            _local_9++;
                            debugTrace((((("activate - peng:" + _local_4) + " is wearing ") + objects[_local_2]) + " on their ") + _local_3);
                            break;
                        }
                        _local_2++;
                    }
                    _local_5++;
                }
                var _local_13 = _local_9 == _local_11;
                if (_local_6 && ((!_onlyClause) || (_local_10 == 1))) {
                    if ((objectOperation != com.clubpenguin.achievements.objects.AchievementObject.OPERATION_AND) || (_local_13)) {
                        _local_16++;
                        addSubjectFound(subjects[_local_4]);
                    }
                }
                _local_4++;
            }
            debugTrace("activate hits: " + _local_16);
            return(_local_16);
        }
        function debugTrace(msg) {
            if (_debug) {
            }
        }
        static var ONLY_TAG = "only";
    }
