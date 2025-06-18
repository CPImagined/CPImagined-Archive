//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.engine.tweener.Tweener
    {
        static var _specialPropertySplitterList, _specialPropertyModifierList, _specialPropertyList, _transitionList, _currentTimeFrame, _currentTime, _tweenList;
        function Tweener () {
            trace("Tweener is an static class and should not be instantiated.");
        }
        static function addTween(p_scopes, p_parameters) {
            if (p_scopes == undefined) {
                return(false);
            }
            var _local_3;
            var _local_7;
            var _local_2;
            var _local_11;
            if (p_scopes instanceof Array) {
                _local_11 = p_scopes.concat();
            } else {
                _local_11 = [p_scopes];
            }
            var _local_5 = com.clubpenguin.engine.tweener.TweenListObj.makePropertiesChain(p_parameters);
            if (!_inited) {
                init();
            }
            if ((!_engineExists) || (_root[getControllerName()] == undefined)) {
                startEngine();
            }
            var _local_19 = (isNaN(_local_5.time) ? 0 : (_local_5.time));
            var _local_12 = (isNaN(_local_5.delay) ? 0 : (_local_5.delay));
            var _local_4 = new Object();
            var _local_24 = {time:true, delay:true, useFrames:true, skipUpdates:true, transition:true, transitionParams:true, onStart:true, onUpdate:true, onComplete:true, onOverwrite:true, onError:true, rounded:true, onStartParams:true, onUpdateParams:true, onCompleteParams:true, onOverwriteParams:true, onStartScope:true, onUpdateScope:true, onCompleteScope:true, onOverwriteScope:true, onErrorScope:true, quickAdd:true};
            var _local_13 = new Object();
            for (_local_2 in _local_5) {
                if (!_local_24[_local_2]) {
                    if (_specialPropertySplitterList[_local_2] != undefined) {
                        var _local_8 = _specialPropertySplitterList[_local_2].splitValues(_local_5[_local_2], _specialPropertySplitterList[_local_2].parameters);
                        _local_3 = 0;
                        while (_local_3 < _local_8.length) {
                            if (_specialPropertySplitterList[_local_8[_local_3].name] != undefined) {
                                var _local_9 = _specialPropertySplitterList[_local_8[_local_3].name].splitValues(_local_8[_local_3].value, _specialPropertySplitterList[_local_8[_local_3].name].parameters);
                                _local_7 = 0;
                                while (_local_7 < _local_9.length) {
                                    _local_4[_local_9[_local_7].name] = {valueStart:undefined, valueComplete:_local_9[_local_7].value, arrayIndex:_local_9[_local_7].arrayIndex, isSpecialProperty:false};
                                    _local_7++;
                                }
                            } else {
                                _local_4[_local_8[_local_3].name] = {valueStart:undefined, valueComplete:_local_8[_local_3].value, arrayIndex:_local_8[_local_3].arrayIndex, isSpecialProperty:false};
                            }
                            _local_3++;
                        }
                    } else if (_specialPropertyModifierList[_local_2] != undefined) {
                        var _local_10 = _specialPropertyModifierList[_local_2].modifyValues(_local_5[_local_2]);
                        _local_3 = 0;
                        while (_local_3 < _local_10.length) {
                            _local_13[_local_10[_local_3].name] = {modifierParameters:_local_10[_local_3].parameters, modifierFunction:_specialPropertyModifierList[_local_2].getValue};
                            _local_3++;
                        }
                    } else {
                        _local_4[_local_2] = {valueStart:undefined, valueComplete:_local_5[_local_2]};
                    }
                }
            }
            for (_local_2 in _local_4) {
                if (_specialPropertyList[_local_2] != undefined) {
                    _local_4[_local_2].isSpecialProperty = true;
                } else if (_local_11[0][_local_2] == undefined) {
                    printError(((("The property '" + _local_2) + "' doesn't seem to be a normal object property of ") + _local_11[0].toString()) + " or a registered special property.");
                }
            }
            for (_local_2 in _local_13) {
                if (_local_4[_local_2] != undefined) {
                    _local_4[_local_2].modifierParameters = _local_13[_local_2].modifierParameters;
                    _local_4[_local_2].modifierFunction = _local_13[_local_2].modifierFunction;
                }
            }
            var _local_21;
            if (typeof(_local_5.transition) == "string") {
                var _local_26 = _local_5.transition.toLowerCase();
                _local_21 = _transitionList[_local_26];
            } else {
                _local_21 = _local_5.transition;
            }
            if (_local_21 == undefined) {
                _local_21 = _transitionList.easeoutexpo;
            }
            var _local_14;
            var _local_6;
            var _local_20;
            _local_3 = 0;
            while (_local_3 < _local_11.length) {
                _local_14 = new Object();
                for (_local_2 in _local_4) {
                    _local_14[_local_2] = new com.clubpenguin.engine.tweener.PropertyInfoObj(_local_4[_local_2].valueStart, _local_4[_local_2].valueComplete, _local_4[_local_2].valueComplete, _local_4[_local_2].arrayIndex, {}, _local_4[_local_2].isSpecialProperty, _local_4[_local_2].modifierFunction, _local_4[_local_2].modifierParameters);
                }
                if (_local_5.useFrames == true) {
                    _local_6 = new com.clubpenguin.engine.tweener.TweenListObj(_local_11[_local_3], _currentTimeFrame + (_local_12 / _timeScale), _currentTimeFrame + ((_local_12 + _local_19) / _timeScale), true, _local_21, _local_5.transitionParams);
                } else {
                    _local_6 = new com.clubpenguin.engine.tweener.TweenListObj(_local_11[_local_3], _currentTime + ((_local_12 * 1000) / _timeScale), _currentTime + (((_local_12 * 1000) + (_local_19 * 1000)) / _timeScale), false, _local_21, _local_5.transitionParams);
                }
                _local_6.properties = _local_14;
                _local_6.onStart = _local_5.onStart;
                _local_6.onUpdate = _local_5.onUpdate;
                _local_6.onComplete = _local_5.onComplete;
                _local_6.onOverwrite = _local_5.onOverwrite;
                _local_6.onError = _local_5.onError;
                _local_6.onStartParams = _local_5.onStartParams;
                _local_6.onUpdateParams = _local_5.onUpdateParams;
                _local_6.onCompleteParams = _local_5.onCompleteParams;
                _local_6.onOverwriteParams = _local_5.onOverwriteParams;
                _local_6.onStartScope = _local_5.onStartScope;
                _local_6.onUpdateScope = _local_5.onUpdateScope;
                _local_6.onCompleteScope = _local_5.onCompleteScope;
                _local_6.onOverwriteScope = _local_5.onOverwriteScope;
                _local_6.onErrorScope = _local_5.onErrorScope;
                _local_6.rounded = _local_5.rounded;
                _local_6.skipUpdates = _local_5.skipUpdates;
                if (!_local_5.quickAdd) {
                    removeTweensByTime(_local_6.scope, _local_6.properties, _local_6.timeStart, _local_6.timeComplete);
                }
                _tweenList.push(_local_6);
                if ((_local_19 == 0) && (_local_12 == 0)) {
                    _local_20 = _tweenList.length - 1;
                    updateTweenByIndex(_local_20);
                    removeTweenByIndex(_local_20);
                }
                _local_3++;
            }
            return(true);
        }
        static function addCaller(p_scopes, p_parameters) {
            if (p_scopes == undefined) {
                return(false);
            }
            var _local_5;
            var _local_6;
            if (p_scopes instanceof Array) {
                _local_6 = p_scopes.concat();
            } else {
                _local_6 = [p_scopes];
            }
            var _local_3 = p_parameters;
            if (!_inited) {
                init();
            }
            if ((!_engineExists) || (_root[getControllerName()] == undefined)) {
                startEngine();
            }
            var _local_7 = (isNaN(_local_3.time) ? 0 : (_local_3.time));
            var _local_4 = (isNaN(_local_3.delay) ? 0 : (_local_3.delay));
            var _local_9;
            if (typeof(_local_3.transition) == "string") {
                var _local_11 = _local_3.transition.toLowerCase();
                _local_9 = _transitionList[_local_11];
            } else {
                _local_9 = _local_3.transition;
            }
            if (_local_9 == undefined) {
                _local_9 = _transitionList.easeoutexpo;
            }
            var _local_2;
            var _local_8;
            _local_5 = 0;
            while (_local_5 < _local_6.length) {
                if (_local_3.useFrames == true) {
                    _local_2 = new com.clubpenguin.engine.tweener.TweenListObj(_local_6[_local_5], _currentTimeFrame + (_local_4 / _timeScale), _currentTimeFrame + ((_local_4 + _local_7) / _timeScale), true, _local_9, _local_3.transitionParams);
                } else {
                    _local_2 = new com.clubpenguin.engine.tweener.TweenListObj(_local_6[_local_5], _currentTime + ((_local_4 * 1000) / _timeScale), _currentTime + (((_local_4 * 1000) + (_local_7 * 1000)) / _timeScale), false, _local_9, _local_3.transitionParams);
                }
                _local_2.properties = undefined;
                _local_2.onStart = _local_3.onStart;
                _local_2.onUpdate = _local_3.onUpdate;
                _local_2.onComplete = _local_3.onComplete;
                _local_2.onOverwrite = _local_3.onOverwrite;
                _local_2.onStartParams = _local_3.onStartParams;
                _local_2.onUpdateParams = _local_3.onUpdateParams;
                _local_2.onCompleteParams = _local_3.onCompleteParams;
                _local_2.onOverwriteParams = _local_3.onOverwriteParams;
                _local_2.onStartScope = _local_3.onStartScope;
                _local_2.onUpdateScope = _local_3.onUpdateScope;
                _local_2.onCompleteScope = _local_3.onCompleteScope;
                _local_2.onOverwriteScope = _local_3.onOverwriteScope;
                _local_2.onErrorScope = _local_3.onErrorScope;
                _local_2.isCaller = true;
                _local_2.count = _local_3.count;
                _local_2.waitFrames = _local_3.waitFrames;
                _tweenList.push(_local_2);
                if ((_local_7 == 0) && (_local_4 == 0)) {
                    _local_8 = _tweenList.length - 1;
                    updateTweenByIndex(_local_8);
                    removeTweenByIndex(_local_8);
                }
                _local_5++;
            }
            return(true);
        }
        static function removeTweensByTime(p_scope, p_properties, p_timeStart, p_timeComplete) {
            var _local_5 = false;
            var _local_4;
            var _local_1;
            var _local_7 = _tweenList.length;
            var _local_2;
            _local_1 = 0;
            while (_local_1 < _local_7) {
                if (p_scope == _tweenList[_local_1].scope) {
                    if ((p_timeComplete > _tweenList[_local_1].timeStart) && (p_timeStart < _tweenList[_local_1].timeComplete)) {
                        _local_4 = false;
                        for (_local_2 in _tweenList[_local_1].properties) {
                            if (p_properties[_local_2] != undefined) {
                                if (_tweenList[_local_1].onOverwrite != undefined) {
                                    var _local_3 = ((_tweenList[_local_1].onOverwriteScope != undefined) ? (_tweenList[_local_1].onOverwriteScope) : (_tweenList[_local_1].scope));
                                    try {
                                        _tweenList[_local_1].onOverwrite.apply(_local_3, _tweenList[_local_1].onOverwriteParams);
                                    } catch(e:Error) {
                                        handleError(_tweenList[_local_1], e, "onOverwrite");
                                    }
                                }
                                _tweenList[_local_1].properties[_local_2] = undefined;
                                delete _tweenList[_local_1].properties[_local_2];
                                _local_4 = true;
                                _local_5 = true;
                            }
                        }
                        if (_local_4) {
                            if (com.clubpenguin.engine.tweener.AuxFunctions.getObjectLength(_tweenList[_local_1].properties) == 0) {
                                removeTweenByIndex(_local_1);
                            }
                        }
                    }
                }
                _local_1++;
            }
            return(_local_5);
        }
        static function removeTweens(p_scope) {
            var _local_5 = new Array();
            var _local_3;
            _local_3 = 1;
            while (_local_3 < arguments.length) {
                if ((typeof(arguments[_local_3]) == "string") && (!com.clubpenguin.engine.tweener.AuxFunctions.isInArray(arguments[_local_3], _local_5))) {
                    if (_specialPropertySplitterList[arguments[_local_3]]) {
                        var _local_6 = _specialPropertySplitterList[arguments[_local_3]];
                        var _local_4 = _local_6.splitValues(p_scope, null);
                        var _local_2 = 0;
                        while (_local_2 < _local_4.length) {
                            _local_5.push(_local_4[_local_2].name);
                            _local_2++;
                        }
                    } else {
                        _local_5.push(arguments[_local_3]);
                    }
                }
                _local_3++;
            }
            return(affectTweens(removeTweenByIndex, p_scope, _local_5));
        }
        static function removeAllTweens() {
            var _local_2 = false;
            var _local_1;
            _local_1 = 0;
            while (_local_1 < _tweenList.length) {
                removeTweenByIndex(_local_1);
                _local_2 = true;
                _local_1++;
            }
            return(_local_2);
        }
        static function pauseTweens(p_scope) {
            var _local_3 = new Array();
            var _local_2;
            _local_2 = 1;
            while (_local_2 < arguments.length) {
                if ((typeof(arguments[_local_2]) == "string") && (!com.clubpenguin.engine.tweener.AuxFunctions.isInArray(arguments[_local_2], _local_3))) {
                    _local_3.push(arguments[_local_2]);
                }
                _local_2++;
            }
            return(affectTweens(pauseTweenByIndex, p_scope, _local_3));
        }
        static function pauseAllTweens() {
            var _local_2 = false;
            var _local_1;
            _local_1 = 0;
            while (_local_1 < _tweenList.length) {
                pauseTweenByIndex(_local_1);
                _local_2 = true;
                _local_1++;
            }
            return(_local_2);
        }
        static function resumeTweens(p_scope) {
            var _local_3 = new Array();
            var _local_2;
            _local_2 = 1;
            while (_local_2 < arguments.length) {
                if ((typeof(arguments[_local_2]) == "string") && (!com.clubpenguin.engine.tweener.AuxFunctions.isInArray(arguments[_local_2], _local_3))) {
                    _local_3.push(arguments[_local_2]);
                }
                _local_2++;
            }
            return(affectTweens(resumeTweenByIndex, p_scope, _local_3));
        }
        static function resumeAllTweens() {
            var _local_2 = false;
            var _local_1;
            _local_1 = 0;
            while (_local_1 < _tweenList.length) {
                resumeTweenByIndex(_local_1);
                _local_2 = true;
                _local_1++;
            }
            return(_local_2);
        }
        static function affectTweens(p_affectFunction, p_scope, p_properties) {
            var _local_5 = false;
            var _local_2;
            if (!_tweenList) {
                return(false);
            }
            _local_2 = 0;
            while (_local_2 < _tweenList.length) {
                if (_tweenList[_local_2].scope == p_scope) {
                    if (p_properties.length == 0) {
                        p_affectFunction(_local_2);
                        _local_5 = true;
                    } else {
                        var _local_4 = new Array();
                        var _local_1;
                        _local_1 = 0;
                        while (_local_1 < p_properties.length) {
                            if (_tweenList[_local_2].properties[p_properties[_local_1]] != undefined) {
                                _local_4.push(p_properties[_local_1]);
                            }
                            _local_1++;
                        }
                        if (_local_4.length > 0) {
                            var _local_7 = com.clubpenguin.engine.tweener.AuxFunctions.getObjectLength(_tweenList[_local_2].properties);
                            if (_local_7 == _local_4.length) {
                                p_affectFunction(_local_2);
                                _local_5 = true;
                            } else {
                                var _local_8 = splitTweens(_local_2, _local_4);
                                p_affectFunction(_local_8);
                                _local_5 = true;
                            }
                        }
                    }
                }
                _local_2++;
            }
            return(_local_5);
        }
        static function splitTweens(p_tween, p_properties) {
            var _local_6 = _tweenList[p_tween];
            var _local_5 = _local_6.clone(false);
            var _local_1;
            var _local_2;
            _local_1 = 0;
            while (_local_1 < p_properties.length) {
                _local_2 = p_properties[_local_1];
                if (_local_6.properties[_local_2] != undefined) {
                    _local_6.properties[_local_2] = undefined;
                    delete _local_6.properties[_local_2];
                }
                _local_1++;
            }
            var _local_4;
            for (_local_2 in _local_5.properties) {
                _local_4 = false;
                _local_1 = 0;
                while (_local_1 < p_properties.length) {
                    if (p_properties[_local_1] == _local_2) {
                        _local_4 = true;
                        break;
                    }
                    _local_1++;
                }
                if (!_local_4) {
                    _local_5.properties[_local_2] = undefined;
                    delete _local_5.properties[_local_2];
                }
            }
            _tweenList.push(_local_5);
            return(_tweenList.length - 1);
        }
        static function updateTweens() {
            if (_tweenList.length == 0) {
                return(false);
            }
            var _local_1;
            _local_1 = 0;
            while (_local_1 < _tweenList.length) {
                if (!_tweenList[_local_1].isPaused) {
                    if (!updateTweenByIndex(_local_1)) {
                        removeTweenByIndex(_local_1);
                    }
                    if (_tweenList[_local_1] == null) {
                        removeTweenByIndex(_local_1, true);
                        _local_1--;
                    }
                }
                _local_1++;
            }
            return(true);
        }
        static function removeTweenByIndex(p_tween, p_finalRemoval) {
            _tweenList[p_tween] = null;
            if (p_finalRemoval) {
                _tweenList.splice(p_tween, 1);
            }
            return(true);
        }
        static function pauseTweenByIndex(p_tween) {
            var _local_1 = _tweenList[p_tween];
            if ((_local_1 == null) || (_local_1.isPaused)) {
                return(false);
            }
            _local_1.timePaused = getCurrentTweeningTime(_local_1);
            _local_1.isPaused = true;
            return(true);
        }
        static function resumeTweenByIndex(p_tween) {
            var _local_1 = _tweenList[p_tween];
            if ((_local_1 == null) || (!_local_1.isPaused)) {
                return(false);
            }
            var _local_2 = getCurrentTweeningTime(_local_1);
            _local_1.timeStart = _local_1.timeStart + (_local_2 - _local_1.timePaused);
            _local_1.timeComplete = _local_1.timeComplete + (_local_2 - _local_1.timePaused);
            _local_1.timePaused = undefined;
            _local_1.isPaused = false;
            return(true);
        }
        static function updateTweenByIndex(i) {
            var _local_1 = _tweenList[i];
            if ((_local_1 == null) || (!_local_1.scope)) {
                return(false);
            }
            var _local_13 = false;
            var _local_14;
            var _local_3;
            var _local_7;
            var _local_10;
            var _local_9;
            var _local_6;
            var _local_2;
            var _local_12;
            var _local_5;
            var _local_8 = getCurrentTweeningTime(_local_1);
            var _local_4;
            if (_local_8 >= _local_1.timeStart) {
                _local_5 = _local_1.scope;
                if (_local_1.isCaller) {
                    do {
                        _local_7 = ((_local_1.timeComplete - _local_1.timeStart) / _local_1.count) * (_local_1.timesCalled + 1);
                        _local_10 = _local_1.timeStart;
                        _local_9 = _local_1.timeComplete - _local_1.timeStart;
                        _local_6 = _local_1.timeComplete - _local_1.timeStart;
                        _local_3 = _local_1.transition(_local_7, _local_10, _local_9, _local_6, _local_1.transitionParams);
                        if (_local_8 >= _local_3) {
                            if (_local_1.onUpdate != undefined) {
                                _local_12 = ((_local_1.onUpdateScope != undefined) ? (_local_1.onUpdateScope) : (_local_5));
                                try {
                                    _local_1.onUpdate.apply(_local_12, _local_1.onUpdateParams);
                                } catch(e:Error) {
                                    handleError(_local_1, e, "onUpdate");
                                }
                            }
                            _local_1.timesCalled++;
                            if (_local_1.timesCalled >= _local_1.count) {
                                _local_13 = true;
                                break;
                            }
                            if (_local_1.waitFrames) {
                                break;
                            }
                        }
                    } while  (_local_8 >= _local_3);
                } else {
                    _local_14 = ((_local_1.skipUpdates < 1) || (_local_1.skipUpdates == undefined)) || (_local_1.updatesSkipped >= _local_1.skipUpdates);
                    if (_local_8 >= _local_1.timeComplete) {
                        _local_13 = true;
                        _local_14 = true;
                    }
                    if (!_local_1.hasStarted) {
                        if (_local_1.onStart != undefined) {
                            _local_12 = ((_local_1.onStartScope != undefined) ? (_local_1.onStartScope) : (_local_5));
                            try {
                                _local_1.onStart.apply(_local_12, _local_1.onStartParams);
                            } catch(e:Error) {
                                handleError(_local_1, e, "onStart");
                            }
                        }
                        var _local_11;
                        for (_local_2 in _local_1.properties) {
                            if (_local_1.properties[_local_2].isSpecialProperty) {
                                if (_specialPropertyList[_local_2].preProcess != undefined) {
                                    _local_1.properties[_local_2].valueComplete = _specialPropertyList[_local_2].preProcess(_local_5, _specialPropertyList[_local_2].parameters, _local_1.properties[_local_2].originalValueComplete, _local_1.properties[_local_2].extra);
                                }
                                _local_11 = _specialPropertyList[_local_2].getValue(_local_5, _specialPropertyList[_local_2].parameters, _local_1.properties[_local_2].extra);
                            } else {
                                _local_11 = _local_5[_local_2];
                            }
                            _local_1.properties[_local_2].valueStart = (isNaN(_local_11) ? (_local_1.properties[_local_2].valueComplete) : (_local_11));
                        }
                        _local_14 = true;
                        _local_1.hasStarted = true;
                    }
                    if (_local_14) {
                        for (_local_2 in _local_1.properties) {
                            _local_4 = _local_1.properties[_local_2];
                            if (_local_13) {
                                _local_3 = _local_4.valueComplete;
                            } else if (_local_4.hasModifier) {
                                _local_7 = _local_8 - _local_1.timeStart;
                                _local_6 = _local_1.timeComplete - _local_1.timeStart;
                                _local_3 = _local_1.transition(_local_7, 0, 1, _local_6, _local_1.transitionParams);
                                _local_3 = _local_4.modifierFunction(_local_4.valueStart, _local_4.valueComplete, _local_3, _local_4.modifierParameters);
                            } else {
                                _local_7 = _local_8 - _local_1.timeStart;
                                _local_10 = _local_4.valueStart;
                                _local_9 = _local_4.valueComplete - _local_4.valueStart;
                                _local_6 = _local_1.timeComplete - _local_1.timeStart;
                                _local_3 = _local_1.transition(_local_7, _local_10, _local_9, _local_6, _local_1.transitionParams);
                            }
                            if (_local_1.rounded) {
                                _local_3 = Math.round(_local_3);
                            }
                            if (_local_4.isSpecialProperty) {
                                _specialPropertyList[_local_2].setValue(_local_5, _local_3, _specialPropertyList[_local_2].parameters, _local_1.properties[_local_2].extra);
                            } else {
                                _local_5[_local_2] = _local_3;
                            }
                        }
                        _local_1.updatesSkipped = 0;
                        if (_local_1.onUpdate != undefined) {
                            _local_12 = ((_local_1.onUpdateScope != undefined) ? (_local_1.onUpdateScope) : (_local_5));
                            try {
                                _local_1.onUpdate.apply(_local_12, _local_1.onUpdateParams);
                            } catch(e:Error) {
                                handleError(_local_1, e, "onUpdate");
                            }
                        }
                    } else {
                        _local_1.updatesSkipped++;
                    }
                }
                if (_local_13 && (_local_1.onComplete != undefined)) {
                    _local_12 = ((_local_1.onCompleteScope != undefined) ? (_local_1.onCompleteScope) : (_local_5));
                    try {
                        _local_1.onComplete.apply(_local_12, _local_1.onCompleteParams);
                    } catch(e:Error) {
                        handleError(_local_1, e, "onComplete");
                    }
                }
                return(!_local_13);
            }
            return(true);
        }
        static function init() {
            _inited = true;
            _transitionList = new Object();
            com.clubpenguin.engine.tweener.Equations.init();
            _specialPropertyList = new Object();
            _specialPropertyModifierList = new Object();
            _specialPropertySplitterList = new Object();
        }
        static function registerTransition(p_name, p_function) {
            if (!_inited) {
                init();
            }
            _transitionList[p_name] = p_function;
        }
        static function registerSpecialProperty(p_name, p_getFunction, p_setFunction, p_parameters, p_preProcessFunction) {
            if (!_inited) {
                init();
            }
            var _local_1 = new com.clubpenguin.engine.tweener.SpecialProperty(p_getFunction, p_setFunction, p_parameters, p_preProcessFunction);
            _specialPropertyList[p_name] = _local_1;
        }
        static function registerSpecialPropertyModifier(p_name, p_modifyFunction, p_getFunction) {
            if (!_inited) {
                init();
            }
            var _local_1 = new com.clubpenguin.engine.tweener.SpecialPropertyModifier(p_modifyFunction, p_getFunction);
            _specialPropertyModifierList[p_name] = _local_1;
        }
        static function registerSpecialPropertySplitter(p_name, p_splitFunction, p_parameters) {
            if (!_inited) {
                init();
            }
            var _local_1 = new com.clubpenguin.engine.tweener.SpecialPropertySplitter(p_splitFunction, p_parameters);
            _specialPropertySplitterList[p_name] = _local_1;
        }
        static function startEngine() {
            _engineExists = true;
            _tweenList = new Array();
            var _local_2 = Math.floor(Math.random() * 999999);
            var _local_3 = _root.createEmptyMovieClip(getControllerName(), 31338 + _local_2);
            _local_3.onEnterFrame = function () {
                com.clubpenguin.engine.tweener.Tweener.onEnterFrame();
            };
            _currentTimeFrame = 0;
            updateTime();
        }
        static function stopEngine() {
            _engineExists = false;
            _tweenList = null;
            _currentTime = 0;
            _currentTimeFrame = 0;
            delete _root[getControllerName()].onEnterFrame;
            _root[getControllerName()].removeMovieClip();
        }
        static function updateTime() {
            _currentTime = getTimer();
        }
        static function updateFrame() {
            _currentTimeFrame++;
        }
        static function onEnterFrame() {
            updateTime();
            updateFrame();
            var _local_1 = false;
            _local_1 = updateTweens();
            if (!_local_1) {
                stopEngine();
            }
        }
        static function setTimeScale(p_time) {
            var _local_1;
            var _local_2;
            if (isNaN(p_time)) {
                p_time = 1;
            }
            if (p_time < 1E-5) {
                p_time = 1E-5;
            }
            if (p_time != _timeScale) {
                _local_1 = 0;
                while (_local_1 < _tweenList.length) {
                    _local_2 = getCurrentTweeningTime(_tweenList[_local_1]);
                    _tweenList[_local_1].timeStart = _local_2 - (((_local_2 - _tweenList[_local_1].timeStart) * _timeScale) / p_time);
                    _tweenList[_local_1].timeComplete = _local_2 - (((_local_2 - _tweenList[_local_1].timeComplete) * _timeScale) / p_time);
                    if (_tweenList[_local_1].timePaused != undefined) {
                        _tweenList[_local_1].timePaused = _local_2 - (((_local_2 - _tweenList[_local_1].timePaused) * _timeScale) / p_time);
                    }
                    _local_1++;
                }
                _timeScale = p_time;
            }
        }
        static function isTweening(p_scope) {
            var _local_1;
            _local_1 = 0;
            while (_local_1 < _tweenList.length) {
                if (_tweenList[_local_1].scope == p_scope) {
                    return(true);
                }
                _local_1++;
            }
            return(false);
        }
        static function getTweens(p_scope) {
            var _local_1;
            var _local_2;
            var _local_3 = new Array();
            _local_1 = 0;
            while (_local_1 < _tweenList.length) {
                if (_tweenList[_local_1].scope == p_scope) {
                    for (_local_2 in _tweenList[_local_1].properties) {
                        _local_3.push(_local_2);
                    }
                }
                _local_1++;
            }
            return(_local_3);
        }
        static function getTweenCount(p_scope) {
            var _local_1;
            var _local_2 = 0;
            _local_1 = 0;
            while (_local_1 < _tweenList.length) {
                if (_tweenList[_local_1].scope == p_scope) {
                    _local_2 = _local_2 + com.clubpenguin.engine.tweener.AuxFunctions.getObjectLength(_tweenList[_local_1].properties);
                }
                _local_1++;
            }
            return(_local_2);
        }
        static function handleError(pTweening, pError, pCallBackName) {
            if ((pTweening.onError != undefined) && (typeof(pTweening.onError == "function"))) {
                var _local_3 = ((pTweening.onErrorScope != undefined) ? (pTweening.onErrorScope) : (pTweening.scope));
                try {
                    pTweening.onError.apply(_local_3, [pTweening.scope, pError]);
                } catch(metaError:Error) {
                    printError((((pTweening.scope.toString() + " raised an error while executing the 'onError' handler. Original error:\n ") + pError) + "\nonError error: ") + metaError);
                }
            } else if (pTweening.onError == undefined) {
                printError((((pTweening.scope.toString() + " raised an error while executing the '") + pCallBackName.toString()) + "'handler. \n") + pError);
            }
        }
        static function getCurrentTweeningTime(p_tweening) {
            return((p_tweening.useFrames ? (_currentTimeFrame) : (_currentTime)));
        }
        static function getVersion() {
            return("AS2 1.31.74");
        }
        static function getControllerName() {
            return("__tweener_controller__" + com.clubpenguin.engine.tweener.Tweener.getVersion());
        }
        static function printError(p_message) {
            trace("## [Tweener] Error: " + p_message);
        }
        static var _engineExists = false;
        static var _inited = false;
        static var _timeScale = 1;
    }
