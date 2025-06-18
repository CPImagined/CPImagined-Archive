//Created by Action Script Viewer - https://www.buraks.com/asv
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
                _achievementObjectFactory.shell = shell;
            }
            _achievementSubjectFactory.debug = _debug;
            _subject = _achievementSubjectFactory.createSubject(descriptor, _achievementCheck);
            _subject.debug = _debug;
            _subject.shell = shell;
            _achievementVerbFactory.debug = _debug;
            _verb = _achievementVerbFactory.createVerb(descriptor);
            _verb.shell = shell;
            _verb.debug = _debug;
            _achievementObjectFactory.debug = _debug;
            _object = _achievementObjectFactory.createObject(descriptor);
            _object.debug = _debug;
            _object.shell = _shell;
            while ((descriptor[0] == com.clubpenguin.achievements.objects.AchievementObject.OPERATION_OR) || (descriptor[0] == com.clubpenguin.achievements.objects.AchievementObject.OPERATION_AND)) {
                if (_object.operation == com.clubpenguin.achievements.objects.AchievementObject.OPERATION_NONE) {
                    _object.operation = descriptor[0];
                }
                if (descriptor[0] != _object.operation) {
                    throw new com.clubpenguin.achievements.AchievementException("AchievementCondition cannot mix \"or\" and \"and\" operators");
                }
                descriptor.shift();
                _object.addElement(descriptor);
            }
            if (descriptor.length > 0) {
                _verb.isList = true;
                do {
                    _object.addElement(descriptor);
                } while  (descriptor.length > 0);
            }
        }
        function check(event) {
            var _local_5 = _subject.getCurrentSubjects(event);
            _verb.clearSubjectsFoundOn();
            if (_subject.quantity > 1) {
                debugTrace(("Need to get " + _subject.quantity) + " hits to pass this check ...");
            }
            if (_subject.quantity > _local_5.length) {
                debugTrace("we don't have enough currentSubjects to meet the quantity of matches.");
                return(false);
            }
            var _local_6 = _object.getCurrentObjects();
            if (_verb.activate(_local_5, _local_6, _object.operation) < _subject.quantity) {
                debugTrace(("got " + _local_5.length) + " subjects to check, which failed.");
                return(false);
            } else if (_subject.includeUserInCount) {
                var _local_4 = _verb.subjectsFoundOn.length;
                var _local_3 = false;
                var _local_2 = 0;
                while (_local_2 < _local_4) {
                    if (_shell.isMyPlayer(_verb.subjectsFoundOn[_local_2].player_id)) {
                        _local_3 = true;
                        break;
                    }
                    _local_2++;
                }
                if (!_local_3) {
                    debugTrace("user was specified to be included in condition but was not found.");
                    return(false);
                }
            }
            debugTrace(("got " + _local_5.length) + " subjects to check, which suceeded.");
            _achievementCheck.subjectsSatisfyingPreviousCondition = _verb.subjectsFoundOn;
            _achievementCheck.quantity = _subject.quantity;
            _achievementCheck.includeUserInCount = _subject.includeUserInCount;
            return(true);
        }
        function debugTrace(msg) {
            if (_debug) {
            }
        }
        function set shell(s) {
            _shell = s;
            _subject.shell = s;
            _verb.shell = s;
            _object.shell = s;
            //return(__get__shell());
        }
        function get isOptional() {
            return(_isOptional);
        }
        function set debug(d) {
            _debug = d;
            if (_subject != null) {
                _subject.debug = d;
            }
            if (_verb != null) {
                _verb.debug = d;
            }
            if (_object != null) {
                _object.debug = d;
            }
            //return(__get__debug());
        }
    }
