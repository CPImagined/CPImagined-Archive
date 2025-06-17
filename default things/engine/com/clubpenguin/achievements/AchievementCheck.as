//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.achievements.AchievementCheck
    {
        var _events, _conditions, _optionalConditions, _results, _shell, _debug, _complete, _descriptor, _enabled, __get__debug, _name, _id, _subjectsSatisfyingPreviousCondition, _quantity, _includeUserInCount;
        function AchievementCheck (shell) {
            _events = null;
            _conditions = null;
            _optionalConditions = null;
            _results = null;
            _shell = shell;
            _debug = false;
            _complete = false;
            enabled = (true);
            _descriptor = "";
        }
        function addEvent(descriptor) {
            if (_events == null) {
                _events = [];
            }
            _descriptor = _descriptor + (descriptor + " ");
            debugTrace(("addEvent '" + descriptor) + "'");
            try {
                var _local_4 = descriptor.split(" ");
                var _local_3 = new com.clubpenguin.achievements.AchievementEvent(_shell, _local_4, _debug);
                _local_3.eventCallback = com.clubpenguin.util.Delegate.create(this, onCheck);
                _events.push(_local_3);
            } catch(ae:com.clubpenguin.achievements.AchievementException) {
                throw new com.clubpenguin.achievements.AchievementException(((("Error adding event from string \"" + descriptor) + "\".\nThe error reported was:\n\"") + ae.message) + "\"");
            }
        }
        function addCondition(descriptor, isOptional) {
            if (_conditions == null) {
                _conditions = [];
            }
            if (_optionalConditions == null) {
                _optionalConditions = [];
            }
            _descriptor = _descriptor + (descriptor + " ");
            debugTrace(("addCondition '" + descriptor) + "'");
            try {
                var _local_4 = descriptor.split(" ");
                var _local_3 = new com.clubpenguin.achievements.AchievementCondition(_shell, _local_4, this, isOptional, _debug);
                (isOptional ? (_optionalConditions.push(_local_3)) : (_conditions.push(_local_3)));
            } catch(ae:com.clubpenguin.achievements.AchievementException) {
                throw new com.clubpenguin.achievements.AchievementException(((("Error adding condition from string \"" + descriptor) + "\".\nThe error reported was:\n\"") + ae.message) + "\"");
            }
        }
        function addResult(descriptor) {
            if (_results == null) {
                _results = [];
            }
            _descriptor = _descriptor + (descriptor + " ");
            try {
                var _local_3 = null;
                debugTrace(((("addResult type:'" + typeof(descriptor)) + "' desc:'") + descriptor) + "'");
                if (typeof(descriptor) == "string") {
                    var _local_4 = descriptor.split(" ");
                    _local_3 = new com.clubpenguin.achievements.AchievementResult(_shell, _local_4, _debug);
                } else if (typeof(descriptor) == "object") {
                    _local_3 = new com.clubpenguin.achievements.AchievementResult(_shell, descriptor, _debug);
                }
                _results.push(_local_3);
            } catch(ae:com.clubpenguin.achievements.AchievementException) {
                throw new com.clubpenguin.achievements.AchievementException(((("Error adding result from string \"" + descriptor) + "\".\nThe error reported was:\n\"") + ae.message) + "\"");
            }
        }
        function onCheck(event) {
            if (!_enabled) {
                debugTrace(("onCheck '" + _descriptor) + "' - is not enabled.");
                return(undefined);
            }
            debugTrace((((("onCheck '" + _descriptor) + "' pid:") + event.player_id) + " type:") + event.type);
            try {
                debugTrace(((("Checking " + _conditions.length) + " conditions and ") + _optionalConditions.length) + " optionalConditions:");
                var _local_12 = _conditions.length;
                var _local_9 = _optionalConditions.length;
                var _local_10 = false;
                var _local_3 = 0;
                while (_local_3 < _local_12) {
                    var _local_7 = _conditions[_local_3];
                    var _local_6 = _local_7.check(event);
                    if (!_local_6) {
                        debugTrace(("  condition " + _local_3) + " failed for condition.");
                        return(undefined);
                    }
                    _local_3++;
                }
                _local_3 = 0;
                while (_local_3 < _local_9) {
                    var _local_7 = _optionalConditions[_local_3];
                    var _local_6 = _local_7.check(event);
                    if (_local_6) {
                        debugTrace("  check succeeded for optionalCondition.");
                        _local_10 = true;
                        break;
                    }
                    _local_3++;
                }
                if ((_local_9 > 0) && (!_local_10)) {
                    return(undefined);
                }
                complete = (true);
                var _local_11 = _results.length;
                debugTrace(("achievement suceeded! Firing " + _local_11) + " results.");
                var _local_2 = 0;
                while (_local_2 < _local_11) {
                    _results[_local_2].fire();
                    _local_2++;
                }
                _shell.updateListeners(_shell.ACHIEVEMENT_DONE, id);
            } catch(ae:com.clubpenguin.achievements.AchievementException) {
                var _local_4 = "Error evaluating condition.\nThe error reported was:\n\"" + ae.message;
                _local_4 = _local_4 + (("\nThe check has " + _events.length) + " events:\n");
                var _local_5 = 0;
                while (_local_5 < _events.length) {
                    _local_4 = _local_4 + (("  " + _events[_local_5].type) + newline);
                    _local_5++;
                }
                _local_4 = _local_4 + (("\nThe check has " + _conditions.length) + " conditions:");
                var _local_3 = 0;
                while (_local_3 < _conditions.length) {
                    _local_4 = _local_4 + (((("  [" + _local_3) + "] verb type ") + _conditions[_local_3]._verb) + newline);
                    _local_3++;
                }
                _local_4 = _local_4 + (("\nThe check has " + _optionalConditions.length) + " optionalConditions:");
                _local_3 = 0;
                while (_local_3 < _optionalConditions.length) {
                    _local_4 = _local_4 + (((("  [" + _local_3) + "] verb type ") + _optionalConditions[_local_3]._verb) + newline);
                    _local_3++;
                }
                _local_4 = _local_4 + (("\nThe check has " + _results.length) + " results:");
                var _local_2 = 0;
                while (_local_2 < _results.length) {
                    _local_4 = _local_4 + (((("  [" + _local_2) + "] callback param ") + _results[_local_2]._callbackParams) + newline);
                    _local_2++;
                }
                com.clubpenguin.util.Log.error("[AchievementCheck]" + _local_4);
            }
        }
        function destroy() {
            delete _conditions;
            delete _optionalConditions;
            var _local_2 = 0;
            while (_local_2 < _events.length) {
                _events[_local_2].destroy();
                delete _events[_local_2];
                _local_2++;
            }
            delete _events;
            _local_2 = 0;
            while (_local_2 < _results.length) {
                _results[_local_2].destroy();
                delete _results[_local_2];
                _local_2++;
            }
            delete _results;
        }
        function set debug(d) {
            _debug = d;
            //return(__get__debug());
        }
        function set name(checkName) {
            _name = checkName;
            //return(name);
        }
        function get name() {
            return(_name);
        }
        function set id(checkID) {
            _id = checkID;
            //return(id);
        }
        function get id() {
            return(_id);
        }
        function set enabled(isEnabled) {
            _enabled = isEnabled;
            //return(enabled);
        }
        function get enabled() {
            return(_enabled);
        }
        function set complete(isComplete) {
            _complete = isComplete;
            //return(complete);
        }
        function get complete() {
            return(_complete);
        }
        function get subjectsSatisfyingPreviousCondition() {
            return(_subjectsSatisfyingPreviousCondition);
        }
        function set subjectsSatisfyingPreviousCondition(subjects) {
            _subjectsSatisfyingPreviousCondition = [];
            _subjectsSatisfyingPreviousCondition = _subjectsSatisfyingPreviousCondition.concat(subjects);
            //return(subjectsSatisfyingPreviousCondition);
        }
        function get quantity() {
            return(_quantity);
        }
        function set quantity(quantity) {
            _quantity = quantity;
            //return(this.quantity);
        }
        function get includeUserInCount() {
            return(_includeUserInCount);
        }
        function set includeUserInCount(include) {
            _includeUserInCount = include;
            //return(includeUserInCount);
        }
        function debugTrace(msg) {
            if (_debug) {
            }
        }
    }
