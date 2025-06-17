
//Created by Action Script Viewer - http://www.buraks.com/asv
    class com.clubpenguin.engine.tweener.TweenListObj
    {
        var scope, timeStart, timeComplete, useFrames, transition, transitionParams, properties, isPaused, timePaused, isCaller, updatesSkipped, timesCalled, skipUpdates, hasStarted, onStart, onUpdate, onComplete, onOverwrite, onError, onStartParams, onUpdateParams, onCompleteParams, onOverwriteParams, onStartScope, onUpdateScope, onCompleteScope, onOverwriteScope, onErrorScope, rounded, count, waitFrames;
        function TweenListObj (p_scope, p_timeStart, p_timeComplete, p_useFrames, p_transition, p_transitionParams) {
            scope = p_scope;
            timeStart = p_timeStart;
            timeComplete = p_timeComplete;
            useFrames = p_useFrames;
            transition = p_transition;
            transitionParams = p_transitionParams;
            properties = new Object();
            isPaused = false;
            timePaused = undefined;
            isCaller = false;
            updatesSkipped = 0;
            timesCalled = 0;
            skipUpdates = 0;
            hasStarted = false;
        }
        function clone(omitEvents) {
            var _local2 = new com.clubpenguin.engine.tweener.TweenListObj(scope, timeStart, timeComplete, useFrames, transition, transitionParams);
            _local2.properties = new Object();
            for (var _local3 in properties) {
                _local2.properties[_local3] = properties[_local3].clone();
            }
            _local2.skipUpdates = skipUpdates;
            _local2.updatesSkipped = updatesSkipped;
            if (!omitEvents) {
                _local2.onStart = onStart;
                _local2.onUpdate = onUpdate;
                _local2.onComplete = onComplete;
                _local2.onOverwrite = onOverwrite;
                _local2.onError = onError;
                _local2.onStartParams = onStartParams;
                _local2.onUpdateParams = onUpdateParams;
                _local2.onCompleteParams = onCompleteParams;
                _local2.onOverwriteParams = onOverwriteParams;
                _local2.onStartScope = onStartScope;
                _local2.onUpdateScope = onUpdateScope;
                _local2.onCompleteScope = onCompleteScope;
                _local2.onOverwriteScope = onOverwriteScope;
                _local2.onErrorScope = onErrorScope;
            }
            _local2.rounded = rounded;
            _local2.isPaused = isPaused;
            _local2.timePaused = timePaused;
            _local2.isCaller = isCaller;
            _local2.count = count;
            _local2.timesCalled = timesCalled;
            _local2.waitFrames = waitFrames;
            _local2.hasStarted = hasStarted;
            return(_local2);
        }
        function toString() {
            var _local2 = "\n[TweenListObj ";
            _local2 = _local2 + ("scope:" + String(scope));
            _local2 = _local2 + ", properties:";
            var _local3 = true;
            for (var _local4 in properties) {
                if (!_local3) {
                    _local2 = _local2 + ",";
                }
                _local2 = _local2 + ("[name:" + properties[_local4].name);
                _local2 = _local2 + (",valueStart:" + properties[_local4].valueStart);
                _local2 = _local2 + (",valueComplete:" + properties[_local4].valueComplete);
                _local2 = _local2 + "]";
                _local3 = false;
            }
            _local2 = _local2 + (", timeStart:" + String(timeStart));
            _local2 = _local2 + (", timeComplete:" + String(timeComplete));
            _local2 = _local2 + (", useFrames:" + String(useFrames));
            _local2 = _local2 + (", transition:" + String(transition));
            _local2 = _local2 + (", transitionParams:" + String(transitionParams));
            if (skipUpdates) {
                _local2 = _local2 + (", skipUpdates:" + String(skipUpdates));
            }
            if (updatesSkipped) {
                _local2 = _local2 + (", updatesSkipped:" + String(updatesSkipped));
            }
            if (onStart) {
                _local2 = _local2 + (", onStart:" + String(onStart));
            }
            if (onUpdate) {
                _local2 = _local2 + (", onUpdate:" + String(onUpdate));
            }
            if (onComplete) {
                _local2 = _local2 + (", onComplete:" + String(onComplete));
            }
            if (onOverwrite) {
                _local2 = _local2 + (", onOverwrite:" + String(onOverwrite));
            }
            if (onError) {
                _local2 = _local2 + (", onError:" + String(onError));
            }
            if (onStartParams) {
                _local2 = _local2 + (", onStartParams:" + String(onStartParams));
            }
            if (onUpdateParams) {
                _local2 = _local2 + (", onUpdateParams:" + String(onUpdateParams));
            }
            if (onCompleteParams) {
                _local2 = _local2 + (", onCompleteParams:" + String(onCompleteParams));
            }
            if (onOverwriteParams) {
                _local2 = _local2 + (", onOverwriteParams:" + String(onOverwriteParams));
            }
            if (onStartScope) {
                _local2 = _local2 + (", onStartScope:" + String(onStartScope));
            }
            if (onUpdateScope) {
                _local2 = _local2 + (", onUpdateScope:" + String(onUpdateScope));
            }
            if (onCompleteScope) {
                _local2 = _local2 + (", onCompleteScope:" + String(onCompleteScope));
            }
            if (onOverwriteScope) {
                _local2 = _local2 + (", onOverwriteScope:" + String(onOverwriteScope));
            }
            if (onErrorScope) {
                _local2 = _local2 + (", onErrorScope:" + String(onErrorScope));
            }
            if (rounded) {
                _local2 = _local2 + (", rounded:" + String(rounded));
            }
            if (isPaused) {
                _local2 = _local2 + (", isPaused:" + String(isPaused));
            }
            if (timePaused) {
                _local2 = _local2 + (", timePaused:" + String(timePaused));
            }
            if (isCaller) {
                _local2 = _local2 + (", isCaller:" + String(isCaller));
            }
            if (count) {
                _local2 = _local2 + (", count:" + String(count));
            }
            if (timesCalled) {
                _local2 = _local2 + (", timesCalled:" + String(timesCalled));
            }
            if (waitFrames) {
                _local2 = _local2 + (", waitFrames:" + String(waitFrames));
            }
            if (hasStarted) {
                _local2 = _local2 + (", hasStarted:" + String(hasStarted));
            }
            _local2 = _local2 + "]\n";
            return(_local2);
        }
        static function makePropertiesChain(p_obj) {
            var _local6 = p_obj.base;
            if (_local6) {
                var _local5 = {};
                var _local2;
                if (_local6 instanceof Array) {
                    _local2 = [];
                    var _local3 = 0;
                    while (_local3 < _local6.length) {
                        _local2.push(_local6[_local3]);
                        _local3++;
                    }
                } else {
                    _local2 = [_local6];
                }
                _local2.push(p_obj);
                var _local4;
                var _local7 = _local2.length;
                var _local1 = 0;
                while (_local1 < _local7) {
                    if (_local2[_local1].base) {
                        _local4 = com.clubpenguin.engine.tweener.AuxFunctions.concatObjects(makePropertiesChain(_local2[_local1].base), _local2[_local1]);
                    } else {
                        _local4 = _local2[_local1];
                    }
                    _local5 = com.clubpenguin.engine.tweener.AuxFunctions.concatObjects(_local5, _local4);
                    _local1++;
                }
                if (_local5.base) {
                    delete _local5.base;
                }
                return(_local5);
            } else {
                return(p_obj);
            }
        }
    }
