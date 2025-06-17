//Created by Action Script Viewer - https://www.buraks.com/asv
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
            var _local_2 = new com.clubpenguin.engine.tweener.TweenListObj(scope, timeStart, timeComplete, useFrames, transition, transitionParams);
            _local_2.properties = new Object();
            for (var _local_3 in properties) {
                _local_2.properties[_local_3] = properties[_local_3].clone();
            }
            _local_2.skipUpdates = skipUpdates;
            _local_2.updatesSkipped = updatesSkipped;
            if (!omitEvents) {
                _local_2.onStart = onStart;
                _local_2.onUpdate = onUpdate;
                _local_2.onComplete = onComplete;
                _local_2.onOverwrite = onOverwrite;
                _local_2.onError = onError;
                _local_2.onStartParams = onStartParams;
                _local_2.onUpdateParams = onUpdateParams;
                _local_2.onCompleteParams = onCompleteParams;
                _local_2.onOverwriteParams = onOverwriteParams;
                _local_2.onStartScope = onStartScope;
                _local_2.onUpdateScope = onUpdateScope;
                _local_2.onCompleteScope = onCompleteScope;
                _local_2.onOverwriteScope = onOverwriteScope;
                _local_2.onErrorScope = onErrorScope;
            }
            _local_2.rounded = rounded;
            _local_2.isPaused = isPaused;
            _local_2.timePaused = timePaused;
            _local_2.isCaller = isCaller;
            _local_2.count = count;
            _local_2.timesCalled = timesCalled;
            _local_2.waitFrames = waitFrames;
            _local_2.hasStarted = hasStarted;
            return(_local_2);
        }
        function toString() {
            var _local_2 = "\n[TweenListObj ";
            _local_2 = _local_2 + ("scope:" + String(scope));
            _local_2 = _local_2 + ", properties:";
            var _local_3 = true;
            for (var _local_4 in properties) {
                if (!_local_3) {
                    _local_2 = _local_2 + ",";
                }
                _local_2 = _local_2 + ("[name:" + properties[_local_4].name);
                _local_2 = _local_2 + (",valueStart:" + properties[_local_4].valueStart);
                _local_2 = _local_2 + (",valueComplete:" + properties[_local_4].valueComplete);
                _local_2 = _local_2 + "]";
                _local_3 = false;
            }
            _local_2 = _local_2 + (", timeStart:" + String(timeStart));
            _local_2 = _local_2 + (", timeComplete:" + String(timeComplete));
            _local_2 = _local_2 + (", useFrames:" + String(useFrames));
            _local_2 = _local_2 + (", transition:" + String(transition));
            _local_2 = _local_2 + (", transitionParams:" + String(transitionParams));
            if (skipUpdates) {
                _local_2 = _local_2 + (", skipUpdates:" + String(skipUpdates));
            }
            if (updatesSkipped) {
                _local_2 = _local_2 + (", updatesSkipped:" + String(updatesSkipped));
            }
            if (onStart) {
                _local_2 = _local_2 + (", onStart:" + String(onStart));
            }
            if (onUpdate) {
                _local_2 = _local_2 + (", onUpdate:" + String(onUpdate));
            }
            if (onComplete) {
                _local_2 = _local_2 + (", onComplete:" + String(onComplete));
            }
            if (onOverwrite) {
                _local_2 = _local_2 + (", onOverwrite:" + String(onOverwrite));
            }
            if (onError) {
                _local_2 = _local_2 + (", onError:" + String(onError));
            }
            if (onStartParams) {
                _local_2 = _local_2 + (", onStartParams:" + String(onStartParams));
            }
            if (onUpdateParams) {
                _local_2 = _local_2 + (", onUpdateParams:" + String(onUpdateParams));
            }
            if (onCompleteParams) {
                _local_2 = _local_2 + (", onCompleteParams:" + String(onCompleteParams));
            }
            if (onOverwriteParams) {
                _local_2 = _local_2 + (", onOverwriteParams:" + String(onOverwriteParams));
            }
            if (onStartScope) {
                _local_2 = _local_2 + (", onStartScope:" + String(onStartScope));
            }
            if (onUpdateScope) {
                _local_2 = _local_2 + (", onUpdateScope:" + String(onUpdateScope));
            }
            if (onCompleteScope) {
                _local_2 = _local_2 + (", onCompleteScope:" + String(onCompleteScope));
            }
            if (onOverwriteScope) {
                _local_2 = _local_2 + (", onOverwriteScope:" + String(onOverwriteScope));
            }
            if (onErrorScope) {
                _local_2 = _local_2 + (", onErrorScope:" + String(onErrorScope));
            }
            if (rounded) {
                _local_2 = _local_2 + (", rounded:" + String(rounded));
            }
            if (isPaused) {
                _local_2 = _local_2 + (", isPaused:" + String(isPaused));
            }
            if (timePaused) {
                _local_2 = _local_2 + (", timePaused:" + String(timePaused));
            }
            if (isCaller) {
                _local_2 = _local_2 + (", isCaller:" + String(isCaller));
            }
            if (count) {
                _local_2 = _local_2 + (", count:" + String(count));
            }
            if (timesCalled) {
                _local_2 = _local_2 + (", timesCalled:" + String(timesCalled));
            }
            if (waitFrames) {
                _local_2 = _local_2 + (", waitFrames:" + String(waitFrames));
            }
            if (hasStarted) {
                _local_2 = _local_2 + (", hasStarted:" + String(hasStarted));
            }
            _local_2 = _local_2 + "]\n";
            return(_local_2);
        }
        static function makePropertiesChain(p_obj) {
            var _local_6 = p_obj.base;
            if (_local_6) {
                var _local_5 = {};
                var _local_2;
                if (_local_6 instanceof Array) {
                    _local_2 = [];
                    var _local_3 = 0;
                    while (_local_3 < _local_6.length) {
                        _local_2.push(_local_6[_local_3]);
                        _local_3++;
                    }
                } else {
                    _local_2 = [_local_6];
                }
                _local_2.push(p_obj);
                var _local_4;
                var _local_7 = _local_2.length;
                var _local_1 = 0;
                while (_local_1 < _local_7) {
                    if (_local_2[_local_1].base) {
                        _local_4 = com.clubpenguin.engine.tweener.AuxFunctions.concatObjects(makePropertiesChain(_local_2[_local_1].base), _local_2[_local_1]);
                    } else {
                        _local_4 = _local_2[_local_1];
                    }
                    _local_5 = com.clubpenguin.engine.tweener.AuxFunctions.concatObjects(_local_5, _local_4);
                    _local_1++;
                }
                if (_local_5.base) {
                    delete _local_5.base;
                }
                return(_local_5);
            } else {
                return(p_obj);
            }
        }
    }
