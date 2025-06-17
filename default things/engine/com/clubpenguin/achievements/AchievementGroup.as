//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.achievements.AchievementGroup
    {
        var _shell, _debug, _complete, _type, _results, _achievements, _name, _id, __get__type, __get__debug;
        function AchievementGroup (shell) {
            _shell = shell;
            _debug = false;
            _complete = false;
            _type = GROUPTYPE_UNSPECIFIED;
            _results = null;
        }
        function get achievements() {
            return(_achievements);
        }
        function addAchievement(achievement) {
            debugTrace(("addAchievement '" + achievement.name) + "'");
            if (_achievements == null) {
                _achievements = [];
            }
            _achievements.push(achievement);
            achievement.addResult([com.clubpenguin.achievements.AchievementResult.ACHIEVEMENTRESULT_CALLBACK, com.clubpenguin.util.Delegate.create(this, onAchievementFired, achievement)]);
        }
        function addResult(descriptor) {
            if (_results == null) {
                _results = [];
            }
            try {
                var _local_3 = null;
                debugTrace(((("addResult - type:" + typeof(descriptor)) + " '") + descriptor) + "'");
                if (typeof(descriptor) == "string") {
                    var _local_4 = descriptor.split(" ");
                    _local_3 = new com.clubpenguin.achievements.AchievementResult(_shell, _local_4, _debug);
                } else if (typeof(descriptor) == "object") {
                    _local_3 = new com.clubpenguin.achievements.AchievementResult(_shell, Array(descriptor), _debug);
                }
                _results.push(_local_3);
            } catch(ae:com.clubpenguin.achievements.AchievementException) {
                throw new com.clubpenguin.achievements.AchievementException(((("Error adding result from string \"" + descriptor) + "\".\nThe error reported was:\n\"") + ae.message) + "\"");
            }
        }
        function completeInitialization() {
            if (_type == GROUPTYPE_SPECIFIC_ORDER) {
                var _local_3 = _achievements.length;
                if (_local_3 > 0) {
                    _achievements[0].enabled = true;
                }
                var _local_2 = 1;
                while (_local_2 < _local_3) {
                    _achievements[_local_2].enabled = false;
                    _local_2++;
                }
            }
        }
        function onAchievementFired(result, achievement) {
            debugTrace("onAchievementFired - achievement:" + achievement.name);
            switch (_type) {
                case GROUPTYPE_ANY_ORDER : 
                    var _local_3 = true;
                    var _local_2 = 0;
                    while (_local_2 < _achievements.length) {
                        if (!_achievements[_local_2].complete) {
                            debugTrace(((((((("onAchievementFired - achievement " + _local_2) + " / ") + _achievements.length) + " (") + _achievements[_local_2].name) + ") remains incomplete. (value:") + _achievements[_local_2].complete) + ")");
                            _local_3 = false;
                            break;
                        }
                        _local_2++;
                    }
                    if (_local_3) {
                        onGroupComplete();
                    }
                    break;
                case GROUPTYPE_SPECIFIC_ORDER : 
                    if (achievement.id == _achievements[_achievements.length - 1].id) {
                        onGroupComplete();
                    } else {
                        _local_2 = 0;
                        while (_local_2 < _achievements.length) {
                            if (achievement.id == _achievements[_local_2].id) {
                                _achievements[_local_2 + 1].enabled = true;
                                break;
                            }
                            _local_2++;
                        }
                    }
                    break;
                default : 
                    throw new com.clubpenguin.achievements.AchievementException("group did not have a defined group type.");
            }
        }
        function onGroupComplete() {
            debugTrace("onGroupComplete");
            if (complete) {
                return(undefined);
            }
            complete = (true);
            if (_results != null) {
                var _local_2 = 0;
                while (_local_2 < _results.length) {
                    _results[_local_2].fire();
                    _local_2++;
                }
            }
            delete _achievements;
        }
        function set complete(isComplete) {
            _complete = isComplete;
            //return(complete);
        }
        function get complete() {
            return(_complete);
        }
        function set name(groupName) {
            _name = groupName;
            //return(name);
        }
        function get name() {
            return(_name);
        }
        function set id(groupID) {
            _id = groupID;
            //return(id);
        }
        function get id() {
            return(_id);
        }
        function set type(groupType) {
            switch (groupType) {
                case "anyOrder" : 
                    _type = GROUPTYPE_ANY_ORDER;
                    break;
                case "specificOrder" : 
                    _type = GROUPTYPE_SPECIFIC_ORDER;
                    break;
                default : 
                    throw new com.clubpenguin.achievements.AchievementException(("AchievementGroup::set type(\"" + groupType) + "\") - this group type was not recognised.");
            }
            //return(__get__type());
        }
        function debugTrace(msg) {
            if (_debug) {
            }
        }
        function set debug(enabled) {
            _debug = enabled;
            //return(__get__debug());
        }
        static var GROUPTYPE_UNSPECIFIED = -1;
        static var GROUPTYPE_ANY_ORDER = 0;
        static var GROUPTYPE_SPECIFIC_ORDER = 1;
    }
