//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.achievements.verbs.AchievementVerbHasProperty extends com.clubpenguin.achievements.verbs.AchievementVerb
    {
        var _property, _comparison, addSubjectFound, _debug;
        function AchievementVerbHasProperty (descriptor, debug) {
            super(descriptor, debug);
            _property = String(descriptor.shift());
            var _local_3 = "comparison_" + String(descriptor.shift());
            _comparison = com.clubpenguin.achievements.verbs.AchievementVerbHasProperty[_local_3];
            if (_comparison == undefined) {
                throw new com.clubpenguin.achievements.AchievementException(((("AchievementVerbHasProperty: The comparison was not defined for \"" + _local_3) + "\". The property named was: \"") + _property) + "\".");
            }
        }
        function activate(subjects, objects, objectOperation) {
            debugTrace("activate - property: " + _property);
            var _local_8 = 0;
            var _local_9 = subjects.length;
            var _local_7 = objects.length;
            var _local_3 = 0;
            while (_local_3 < _local_9) {
                var _local_4 = false;
                var _local_2 = 0;
                while ((_local_2 < _local_7) && (!_local_4)) {
                    debugTrace((("activate - does " + subjects[_local_3][_property]) + " match ") + objects[_local_2]);
                    if (_comparison(subjects[_local_3][_property], objects[_local_2])) {
                        _local_4 = true;
                    }
                    _local_2++;
                }
                if (_local_4) {
                    _local_8++;
                    addSubjectFound(subjects[_local_3]);
                }
                _local_3++;
            }
            debugTrace("activate - hits: " + _local_8);
            return(_local_8);
        }
        function debugTrace(msg) {
            if (_debug) {
            }
        }
        static function comparison_greaterThan(value, comparison) {
            return(value > comparison);
        }
        static function comparison_lessThan(value, comparison) {
            return(value < comparison);
        }
        static function comparison_equals(value, comparison) {
            return(value == comparison);
        }
        static function comparison_stringEquals(value, comparison) {
            return(value == comparison);
        }
        static function comparison_stringNotEquals(value, comparison) {
            return(value != comparison);
        }
    }
