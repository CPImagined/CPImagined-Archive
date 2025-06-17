
//Created by Action Script Viewer - http://www.buraks.com/asv
    class com.clubpenguin.achievements.verbs.AchievementVerbHasProperty extends com.clubpenguin.achievements.verbs.AchievementVerb
    {
        var _property, _comparison, addSubjectFound, _debug;
        function AchievementVerbHasProperty (descriptor, debug) {
            super(descriptor, debug);
            _property = String(descriptor.shift());
            var _local3 = "comparison_" + String(descriptor.shift());
            _comparison = com.clubpenguin.achievements.verbs.AchievementVerbHasProperty[_local3];
            if (_comparison == undefined) {
                throw new com.clubpenguin.achievements.AchievementException(((("AchievementVerbHasProperty: The comparison was not defined for \"" + _local3) + "\". The property named was: \"") + _property) + "\".");
            }
        }
        function activate(subjects, objects, objectOperation) {
            debugTrace("activate - property: " + _property);
            var _local8 = 0;
            var _local9 = subjects.length;
            var _local7 = objects.length;
            var _local3 = 0;
            while (_local3 < _local9) {
                var _local4 = false;
                var _local2 = 0;
                while ((_local2 < _local7) && (!_local4)) {
                    debugTrace((("activate - does " + subjects[_local3][_property]) + " match ") + objects[_local2]);
                    if (_comparison(subjects[_local3][_property], objects[_local2])) {
                        _local4 = true;
                    }
                    _local2++;
                }
                if (_local4) {
                    _local8++;
                    addSubjectFound(subjects[_local3]);
                }
                _local3++;
            }
            debugTrace("activate - hits: " + _local8);
            return(_local8);
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
