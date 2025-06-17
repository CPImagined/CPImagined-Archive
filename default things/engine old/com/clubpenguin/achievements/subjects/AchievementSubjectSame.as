
//Created by Action Script Viewer - http://www.buraks.com/asv
    class com.clubpenguin.achievements.subjects.AchievementSubjectSame extends com.clubpenguin.achievements.subjects.AchievementSubject
    {
        var _achievementCheck, _quantity, _includeUserInCount, _debug;
        function AchievementSubjectSame (descriptor, achievementCheck, debug) {
            super();
            _achievementCheck = achievementCheck;
        }
        function getCurrentSubjects(event) {
            var _local2 = _achievementCheck.__get__subjectsSatisfyingPreviousCondition();
            _quantity = _achievementCheck.quantity;
            _includeUserInCount = _achievementCheck.includeUserInCount;
            return(_local2);
        }
        function debugTrace(msg) {
            if (_debug) {
            }
        }
    }
