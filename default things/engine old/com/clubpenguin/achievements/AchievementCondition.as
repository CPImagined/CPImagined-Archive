
//Created by Action Script Viewer - http://www.buraks.com/asv
    class com.clubpenguin.achievements.AchievementCondition
    {
        static var _achievementVerbFactory, _achievementSubjectFactory, _achievementObjectFactory;
        var _shell, _debug, _achievementCheck, _isOptional, _subject, _verb, _object, __get__shell, __get__debug;
        function AchievementCondition (shell, descriptor, achievementCheck, isOptional, debug) {
            _shell = shell;
            _debug = debug || false;
            _achievementCheck = achievementCheck;
            _isOptional = isOptional;
            if (_achievementVerbFactory == null) {
                _achievementVerbFactory = new com.clubpenguin.achievements.verbs.AchievementVerbFactory(false);
            }
            if (_achievementSubjectFactory == null) {
                _achievementSubjectFactory = new com.clubpenguin.achievements.subjects.AchievementSubjectFactory(false);
            }
            if (_achievementObjectFactory == null) {
                _achievementObjectFactory = new com.clubpenguin.achievements.objects.AchievementObjectFactory(false);
                _achievementObjectFactory.__set__shell(shell);
            }
            _achievementSubjectFactory.__set__debug(_debug);
            _subject = _achievementSubjectFactory.createSubject(descriptor, _achievementCheck);
            _subject.__set__debug(_debug);
            _subject.__set__shell(shell);
            _achievementVerbFactory.__set__debug(_debug);
            _verb = _achievementVerbFactory.createVerb(descriptor);
            _verb.__set__shell(shell);
            _verb.__set__debug(_debug);
            _achievementObjectFactory.__set__debug(_debug);
            _object = _achievementObjectFactory.createObject(descriptor);
            _object.__set__debug(_debug);
            _object.__set__shell(_shell);
            while ((descriptor[0] == com.clubpenguin.achievements.objects.AchievementObject.OPERATION_OR) || (descriptor[0] == com.clubpenguin.achievements.objects.AchievementObject.OPERATION_AND)) {
                if (_object.__get__operation() == com.clubpenguin.achievements.objects.AchievementObject.OPERATION_NONE) {
                    _object.__set__operation(descriptor[0]);
                }
                if (descriptor[0] != _object.__get__operation()) {
                    throw new com.clubpenguin.achievements.AchievementException("AchievementCondition cannot mix \"or\" and \"and\" operators");
                }
                descriptor.shift();
                _object.addElement(descriptor);
            }
            if (descriptor.length > 0) {
                _verb.__set__isList(true);
                do {
                    _object.addElement(descriptor);
                } while  (descriptor.length > 0);
            }
        }
        function check(event) {
            var _local5 = _subject.getCurrentSubjects(event);
            _verb.clearSubjectsFoundOn();
            if (_subject.__get__quantity() > 1) {
                debugTrace(("Need to get " + _subject.__get__quantity()) + " hits to pass this check ...");
            }
            if (_subject.__get__quantity() > _local5.length) {
                debugTrace("we don't have enough currentSubjects to meet the quantity of matches.");
                return(false);
            }
            var _local6 = _object.getCurrentObjects();
            if (_verb.activate(_local5, _local6, _object.__get__operation()) < _subject.__get__quantity()) {
                debugTrace(("got " + _local5.length) + " subjects to check, which failed.");
                return(false);
            } else if (_subject.__get__includeUserInCount()) {
                var _local4 = _verb.__get__subjectsFoundOn().length;
                var _local3 = false;
                var _local2 = 0;
                while (_local2 < _local4) {
                    if (_shell.isMyPlayer(_verb.__get__subjectsFoundOn()[_local2].player_id)) {
                        _local3 = true;
                        break;
                    }
                    _local2++;
                }
                if (!_local3) {
                    debugTrace("user was specified to be included in condition but was not found.");
                    return(false);
                }
            }
            debugTrace(("got " + _local5.length) + " subjects to check, which suceeded.");
            _achievementCheck.__set__subjectsSatisfyingPreviousCondition(_verb.subjectsFoundOn);
            _achievementCheck.__set__quantity(_subject.quantity);
            _achievementCheck.__set__includeUserInCount(_subject.includeUserInCount);
            return(true);
        }
        function debugTrace(msg) {
            if (_debug) {
            }
        }
        function set shell(s) {
            _shell = s;
            _subject.__set__shell(s);
            _verb.__set__shell(s);
            _object.__set__shell(s);
            //return(__get__shell());
        }
        function get isOptional() {
            return(_isOptional);
        }
        function set debug(d) {
            _debug = d;
            if (_subject != null) {
                _subject.__set__debug(d);
            }
            if (_verb != null) {
                _verb.__set__debug(d);
            }
            if (_object != null) {
                _object.__set__debug(d);
            }
            //return(__get__debug());
        }
    }
