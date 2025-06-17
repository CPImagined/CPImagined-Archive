//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.achievements.subjects.AchievementSubjectAny extends com.clubpenguin.achievements.subjects.AchievementSubject
    {
        var _includeUserInCount, _quantity, isNumeric, _shell, _debug;
        function AchievementSubjectAny (descriptor, includeUserInCount, debug) {
            super();
            _includeUserInCount = includeUserInCount;
            var _local_4 = String(descriptor.shift());
            if (_local_4 == "penguin") {
                _quantity = 1;
            } else if (isNumeric(_local_4)) {
                var _local_3 = String(descriptor.shift());
                if (_local_3 != "penguins") {
                    throw new com.clubpenguin.achievements.AchievementException(("AchievementSubjectAny was parsing type; expected token \"penguins\", instead got \"" + _local_3) + "\".");
                }
                _quantity = Number(_local_4);
            } else {
                throw new com.clubpenguin.achievements.AchievementException(("AchievementSubjectAny was parsing type; expected token \"" + _local_3) + "\" was not handled.");
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
