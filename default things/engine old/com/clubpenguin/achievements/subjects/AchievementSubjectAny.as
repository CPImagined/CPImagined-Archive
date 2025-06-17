
//Created by Action Script Viewer - http://www.buraks.com/asv
    class com.clubpenguin.achievements.subjects.AchievementSubjectAny extends com.clubpenguin.achievements.subjects.AchievementSubject
    {
        var _includeUserInCount, _quantity, isNumeric, _shell, _debug;
        function AchievementSubjectAny (descriptor, includeUserInCount, debug) {
            super();
            _includeUserInCount = includeUserInCount;
            var _local4 = String(descriptor.shift());
            if (_local4 == "penguin") {
                _quantity = 1;
            } else if (isNumeric(_local4)) {
                var _local3 = String(descriptor.shift());
                if (_local3 != "penguins") {
                    throw new com.clubpenguin.achievements.AchievementException(("AchievementSubjectAny was parsing type; expected token \"penguins\", instead got \"" + _local3) + "\".");
                }
                _quantity = Number(_local4);
            } else {
                throw new com.clubpenguin.achievements.AchievementException(("AchievementSubjectAny was parsing type; expected token \"" + _local3) + "\" was not handled.");
            }
        }
        function getCurrentSubjects(event) {
            return(_shell.getPlayerList());
        }
        function debugTrace(msg) {
            if (_debug) {
            }
        }
    }
