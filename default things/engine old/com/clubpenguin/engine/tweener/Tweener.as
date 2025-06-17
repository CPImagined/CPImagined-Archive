
//Created by Action Script Viewer - http://www.buraks.com/asv
    class com.clubpenguin.engine.tweener.Tweener
    {
        static var _specialPropertySplitterList, _specialPropertyModifierList, _specialPropertyList, _transitionList, _currentTimeFrame, _currentTime, _tweenList;
        function Tweener () {
        }
        static function addTween(p_scopes, p_parameters) {
            if (p_scopes == undefined) {
                return(false);
            }
            var _local3;
            var _local7;
            var _local2;
            var _local11;
            if (p_scopes instanceof Array) {
                _local11 = p_scopes.concat();
            } else {
                _local11 = [p_scopes];
            }
            var _local5 = com.clubpenguin.engine.tweener.TweenListObj.makePropertiesChain(p_parameters);
            if (!_inited) {
                init();
            }
            if ((!_engineExists) || (_root[getControllerName()] == undefined)) {
                startEngine();
            }
            var _local19 = (isNaN(_local5.time) ? 0 : (_local5.time));
            var _local12 = (isNaN(_local5.delay) ? 0 : (_local5.delay));
            var _local4 = new Object();
            var _local24 = {time:true, delay:true, useFrames:true, skipUpdates:true, transition:true, transitionParams:true, onStart:true, onUpdate:true, onComplete:true, onOverwrite:true, onError:true, rounded:true, onStartParams:true, onUpdateParams:true, onCompleteParams:true, onOverwriteParams:true, onStartScope:true, onUpdateScope:true, onCompleteScope:true, onOverwriteScope:true, onErrorScope:true, quickAdd:true};
            var _local13 = new Object();
            for (_local2 in _local5) {
                if (!_local24[_local2]) {
                    if (_specialPropertySplitterList[_local2] != undefined) {
                        var _local8 = _specialPropertySplitterList[_local2].splitValues(_local5[_local2], _specialPropertySplitterList[_local2].parameters);
                        _local3 = 0;
                        while (_local3 < _local8.length) {
                            if (_specialPropertySplitterList[_local8[_local3].name] != undefined) {
                                var _local9 = _specialPropertySplitterList[_local8[_local3].name].splitValues(_local8[_local3].value, _specialPropertySplitterList[_local8[_local3].name].parameters);
                                _local7 = 0;
                                while (_local7 < _local9.length) {
                                    _local4[_local9[_local7].name] = {valueStart:undefined, valueComplete:_local9[_local7].value, arrayIndex:_local9[_local7].arrayIndex, isSpecialProperty:false};
                                    _local7++;
                                }
                            } else {
                                _local4[_local8[_local3].name] = {valueStart:undefined, valueComplete:_local8[_local3].value, arrayIndex:_local8[_local3].arrayIndex, isSpecialProperty:false};
                            }
                            _local3++;
                        }
                    } else if (_specialPropertyModifierList[_local2] != undefined) {
                        var _local10 = _specialPropertyModifierList[_local2].modifyValues(_local5[_local2]);
                        _local3 = 0;
                        while (_local3 < _local10.length) {
                            _local13[_local10[_local3].name] = {modifierParameters:_local10[_local3].parameters, modifierFunction:_specialPropertyModifierList[_local2].getValue};
                            _local3++;
                        }
                    } else {
                        _local4[_local2] = {valueStart:undefined, valueComplete:_local5[_local2]};
                    }
                }
            }
            for (_local2 in _local4) {
                if (_specialPropertyList[_local2] != undefined) {
                    _local4[_local2].isSpecialProperty = true;
                } else if (_local11[0][_local2] == undefined) {
                    printError(((("The property '" + _local2) + "' doesn't seem to be a normal object property of ") + _local11[0].toString()) + " or a registered special property.");
                }
            }
            for (_local2 in _local13) {
                if (_local4[_local2] != undefined) {
                    _local4[_local2].modifierParameters = _local13[_local2].modifierParameters;
                    _local4[_local2].modifierFunction = _local13[_local2].modifierFunction;
                }
            }
            var _local21;
            if (typeof(_local5.transition) == "string") {
                var _local26 = _local5.transition.toLowerCase();
                _local21 = _transitionList[_local26];
            } else {
                _local21 = _local5.transition;
            }
            if (_local21 == undefined) {
                _local21 = _transitionList.easeoutexpo;
            }
            var _local14;
            var _local6;
            var _local20;
            _local3 = 0;
            while (_local3 < _local11.length) {
                _local14 = new Object();
                for (_local2 in _local4) {
                    _local14[_local2] = new com.clubpenguin.engine.tweener.PropertyInfoObj(_local4[_local2].valueStart, _local4[_local2].valueComplete, _local4[_local2].valueComplete, _local4[_local2].arrayIndex, {}, _local4[_local2].isSpecialProperty, _local4[_local2].modifierFunction, _local4[_local2].modifierParameters);
                }
                if (_local5.useFrames == true) {
                    _local6 = new com.clubpenguin.engine.tweener.TweenListObj(_local11[_local3], _currentTimeFrame + (_local12 / _timeScale), _currentTimeFrame + ((_local12 + _local19) / _timeScale), true, _local21, _local5.transitionParams);
                } else {
                    _local6 = new com.clubpenguin.engine.tweener.TweenListObj(_local11[_local3], _currentTime + ((_local12 * 1000) / _timeScale), _currentTime + (((_local12 * 1000) + (_local19 * 1000)) / _timeScale), false, _local21, _local5.transitionParams);
                }
                _local6.properties = _local14;
                _local6.onStart = _local5.onStart;
                _local6.onUpdate = _local5.onUpdate;
                _local6.onComplete = _local5.onComplete;
                _local6.onOverwrite = _local5.onOverwrite;
                _local6.onError = _local5.onError;
                _local6.onStartParams = _local5.onStartParams;
                _local6.onUpdateParams = _local5.onUpdateParams;
                _local6.onCompleteParams = _local5.onCompleteParams;
                _local6.onOverwriteParams = _local5.onOverwriteParams;
                _local6.onStartScope = _local5.onStartScope;
                _local6.onUpdateScope = _local5.onUpdateScope;
                _local6.onCompleteScope = _local5.onCompleteScope;
                _local6.onOverwriteScope = _local5.onOverwriteScope;
                _local6.onErrorScope = _local5.onErrorScope;
                _local6.rounded = _local5.rounded;
                _local6.skipUpdates = _local5.skipUpdates;
                if (!_local5.quickAdd) {
                    removeTweensByTime(_local6.scope, _local6.properties, _local6.timeStart, _local6.timeComplete);
                }
                _tweenList.push(_local6);
                if ((_local19 == 0) && (_local12 == 0)) {
                    _local20 = _tweenList.length - 1;
                    updateTweenByIndex(_local20);
                    removeTweenByIndex(_local20);
                }
                _local3++;
            }
            return(true);
        }
        static function addCaller(p_scopes, p_parameters) {
            if (p_scopes == undefined) {
                return(false);
            }
            var _local5;
            var _local6;
            if (p_scopes instanceof Array) {
                _local6 = p_scopes.concat();
            } else {
                _local6 = [p_scopes];
            }
            var _local3 = p_parameters;
            if (!_inited) {
                init();
            }
            if ((!_engineExists) || (_root[getControllerName()] == undefined)) {
                startEngine();
            }
            var _local7 = (isNaN(_local3.time) ? 0 : (_local3.time));
            var _local4 = (isNaN(_local3.delay) ? 0 : (_local3.delay));
            var _local9;
            if (typeof(_local3.transition) == "string") {
                var _local11 = _local3.transition.toLowerCase();
                _local9 = _transitionList[_local11];
            } else {
                _local9 = _local3.transition;
            }
            if (_local9 == undefined) {
                _local9 = _transitionList.easeoutexpo;
            }
            var _local2;
            var _local8;
            _local5 = 0;
            while (_local5 < _local6.length) {
                if (_local3.useFrames == true) {
                    _local2 = new com.clubpenguin.engine.tweener.TweenListObj(_local6[_local5], _currentTimeFrame + (_local4 / _timeScale), _currentTimeFrame + ((_local4 + _local7) / _timeScale), true, _local9, _local3.transitionParams);
                } else {
                    _local2 = new com.clubpenguin.engine.tweener.TweenListObj(_local6[_local5], _currentTime + ((_local4 * 1000) / _timeScale), _currentTime + (((_local4 * 1000) + (_local7 * 1000)) / _timeScale), false, _local9, _local3.transitionParams);
                }
                _local2.properties = undefined;
                _local2.onStart = _local3.onStart;
                _local2.onUpdate = _local3.onUpdate;
                _local2.onComplete = _local3.onComplete;
                _local2.onOverwrite = _local3.onOverwrite;
                _local2.onStartParams = _local3.onStartParams;
                _local2.onUpdateParams = _local3.onUpdateParams;
                _local2.onCompleteParams = _local3.onCompleteParams;
                _local2.onOverwriteParams = _local3.onOverwriteParams;
                _local2.onStartScope = _local3.onStartScope;
                _local2.onUpdateScope = _local3.onUpdateScope;
                _local2.onCompleteScope = _local3.onCompleteScope;
                _local2.onOverwriteScope = _local3.onOverwriteScope;
                _local2.onErrorScope = _local3.onErrorScope;
                _local2.isCaller = true;
                _local2.count = _local3.count;
                _local2.waitFrames = _local3.waitFrames;
                _tweenList.push(_local2);
                if ((_local7 == 0) && (_local4 == 0)) {
                    _local8 = _tweenList.length - 1;
                    updateTweenByIndex(_local8);
                    removeTweenByIndex(_local8);
                }
                _local5++;
            }
            return(true);
        }
        static function removeTweensByTime(p_scope, p_properties, p_timeStart, p_timeComplete) {
            var _local5 = false;
            var _local4;
            var _local1;
            var _local7 = _tweenList.length;
            var _local2;
            _local1 = 0;
            while (_local1 < _local7) {
                if (p_scope == _tweenList[_local1].scope) {
                    if ((p_timeComplete > _tweenList[_local1].timeStart) && (p_timeStart < _tweenList[_local1].timeComplete)) {
                        _local4 = false;
                        for (_local2 in _tweenList[_local1].properties) {
                            if (p_properties[_local2] != undefined) {
                                if (_tweenList[_local1].onOverwrite != undefined) {
                                    var _local3 = ((_tweenList[_local1].onOverwriteScope != undefined) ? (_tweenList[_local1].onOverwriteScope) : (_tweenList[_local1].scope));
                                    try {
                                        _tweenList[_local1].onOverwrite.apply(_local3, _tweenList[_local1].onOverwriteParams);
                                    } catch(e:Error) {
                                        handleError(_tweenList[_local1], e, "onOverwrite");
                                    }
                                }
                                _tweenList[_local1].properties[_local2] = undefined;
                                delete _tweenList[_local1].properties[_local2];
                                _local4 = true;
                                _local5 = true;
                            }
                        }
                        if (_local4) {
                            if (com.clubpenguin.engine.tweener.AuxFunctions.getObjectLength(_tweenList[_local1].properties) == 0) {
                                removeTweenByIndex(_local1);
                            }
                        }
                    }
                }
                _local1++;
            }
            return(_local5);
        }
        static function removeTweens(p_scope) {
            var _local5 = new Array();
            var _local3;
            _local3 = 1;
            while (_local3 < arguments.length) {
                if ((typeof(arguments[_local3]) == "string") && (!com.clubpenguin.engine.tweener.AuxFunctions.isInArray(arguments[_local3], _local5))) {
                    if (_specialPropertySplitterList[arguments[_local3]]) {
                        var _local6 = _specialPropertySplitterList[arguments[_local3]];
                        var _local4 = _local6.splitValues(p_scope, null);
                        var _local2 = 0;
                        while (_local2 < _local4.length) {
                            _local5.push(_local4[_local2].name);
                            _local2++;
                        }
                    } else {
                        _local5.push(arguments[_local3]);
                    }
                }
                _local3++;
            }
            return(affectTweens(removeTweenByIndex, p_scope, _local5));
        }
        static function removeAllTweens() {
            var _local2 = false;
            var _local1;
            _local1 = 0;
            while (_local1 < _tweenList.length) {
                removeTweenByIndex(_local1);
                _local2 = true;
                _local1++;
            }
            return(_local2);
        }
        static function pauseTweens(p_scope) {
            var _local3 = new Array();
            var _local2;
            _local2 = 1;
            while (_local2 < arguments.length) {
                if ((typeof(arguments[_local2]) == "string") && (!com.clubpenguin.engine.tweener.AuxFunctions.isInArray(arguments[_local2], _local3))) {
                    _local3.push(arguments[_local2]);
                }
                _local2++;
            }
            return(affectTweens(pauseTweenByIndex, p_scope, _local3));
        }
        static function pauseAllTweens() {
            var _local2 = false;
            var _local1;
            _local1 = 0;
            while (_local1 < _tweenList.length) {
                pauseTweenByIndex(_local1);
                _local2 = true;
                _local1++;
            }
            return(_local2);
        }
        static function resumeTweens(p_scope) {
            var _local3 = new Array();
            var _local2;
            _local2 = 1;
            while (_local2 < arguments.length) {
                if ((typeof(arguments[_local2]) == "string") && (!com.clubpenguin.engine.tweener.AuxFunctions.isInArray(arguments[_local2], _local3))) {
                    _local3.push(arguments[_local2]);
                }
                _local2++;
            }
            return(affectTweens(resumeTweenByIndex, p_scope, _local3));
        }
        static function resumeAllTweens() {
            var _local2 = false;
            var _local1;
            _local1 = 0;
            while (_local1 < _tweenList.length) {
                resumeTweenByIndex(_local1);
                _local2 = true;
                _local1++;
            }
            return(_local2);
        }
        static function affectTweens(p_affectFunction, p_scope, p_properties) {
            var _local5 = false;
            var _local2;
            if (!_tweenList) {
                return(false);
            }
            _local2 = 0;
            while (_local2 < _tweenList.length) {
                if (_tweenList[_local2].scope == p_scope) {
                    if (p_properties.length == 0) {
                        p_affectFunction(_local2);
                        _local5 = true;
                    } else {
                        var _local4 = new Array();
                        var _local1;
                        _local1 = 0;
                        while (_local1 < p_properties.length) {
                            if (_tweenList[_local2].properties[p_properties[_local1]] != undefined) {
                                _local4.push(p_properties[_local1]);
                            }
                            _local1++;
                        }
                        if (_local4.length > 0) {
                            var _local7 = com.clubpenguin.engine.tweener.AuxFunctions.getObjectLength(_tweenList[_local2].properties);
                            if (_local7 == _local4.length) {
                                p_affectFunction(_local2);
                                _local5 = true;
                            } else {
                                var _local8 = splitTweens(_local2, _local4);
                                p_affectFunction(_local8);
                                _local5 = true;
                            }
                        }
                    }
                }
                _local2++;
            }
            return(_local5);
        }
        static function splitTweens(p_tween, p_properties) {
            var _local6 = _tweenList[p_tween];
            var _local5 = _local6.clone(false);
            var _local1;
            var _local2;
            _local1 = 0;
            while (_local1 < p_properties.length) {
                _local2 = p_properties[_local1];
                if (_local6.properties[_local2] != undefined) {
                    _local6.properties[_local2] = undefined;
                    delete _local6.properties[_local2];
                }
                _local1++;
            }
            var _local4;
            for (_local2 in _local5.properties) {
                _local4 = false;
                _local1 = 0;
                while (_local1 < p_properties.length) {
                    if (p_properties[_local1] == _local2) {
                        _local4 = true;
                        break;
                    }
                    _local1++;
                }
                if (!_local4) {
                    _local5.properties[_local2] = undefined;
                    delete _local5.properties[_local2];
                }
            }
            _tweenList.push(_local5);
            return(_tweenList.length - 1);
        }
        static function updateTweens() {
            if (_tweenList.length == 0) {
                return(false);
            }
            var _local1;
            _local1 = 0;
            while (_local1 < _tweenList.length) {
                if (!_tweenList[_local1].isPaused) {
                    if (!updateTweenByIndex(_local1)) {
                        removeTweenByIndex(_local1);
                    }
                    if (_tweenList[_local1] == null) {
                        removeTweenByIndex(_local1, true);
                        _local1--;
                    }
                }
                _local1++;
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
            var _local1 = _tweenList[p_tween];
            if ((_local1 == null) || (_local1.isPaused)) {
                return(false);
            }
            _local1.timePaused = getCurrentTweeningTime(_local1);
            _local1.isPaused = true;
            return(true);
        }
        static function resumeTweenByIndex(p_tween) {
            var _local1 = _tweenList[p_tween];
            if ((_local1 == null) || (!_local1.isPaused)) {
                return(false);
            }
            var _local2 = getCurrentTweeningTime(_local1);
            _local1.timeStart = _local1.timeStart + (_local2 - _local1.timePaused);
            _local1.timeComplete = _local1.timeComplete + (_local2 - _local1.timePaused);
            _local1.timePaused = undefined;
            _local1.isPaused = false;
            return(true);
        }
        static function updateTweenByIndex(i) {
            var _local1 = _tweenList[i];
            if ((_local1 == null) || (!_local1.scope)) {
                return(false);
            }
            var _local13 = false;
            var _local14;
            var _local3;
            var _local7;
            var _local10;
            var _local9;
            var _local6;
            var _local2;
            var _local12;
            var _local5;
            var _local8 = getCurrentTweeningTime(_local1);
            var _local4;
            if (_local8 >= _local1.timeStart) {
                _local5 = _local1.scope;
                if (_local1.isCaller) {
                    do {
                        _local7 = ((_local1.timeComplete - _local1.timeStart) / _local1.count) * (_local1.timesCalled + 1);
                        _local10 = _local1.timeStart;
                        _local9 = _local1.timeComplete - _local1.timeStart;
                        _local6 = _local1.timeComplete - _local1.timeStart;
                        _local3 = _local1.transition(_local7, _local10, _local9, _local6, _local1.transitionParams);
                        if (_local8 >= _local3) {
                            if (_local1.onUpdate != undefined) {
                                _local12 = ((_local1.onUpdateScope != undefined) ? (_local1.onUpdateScope) : (_local5));
                                try {
                                    _local1.onUpdate.apply(_local12, _local1.onUpdateParams);
                                } catch(e:Error) {
                                    handleError(_local1, e, "onUpdate");
                                }
                            }
                            _local1.timesCalled++;
                            if (_local1.timesCalled >= _local1.count) {
                                _local13 = true;
                                break;
                            }
                            if (_local1.waitFrames) {
                                break;
                            }
                        }
                    } while  (_local8 >= _local3);
                } else {
                    _local14 = ((_local1.skipUpdates < 1) || (_local1.skipUpdates == undefined)) || (_local1.updatesSkipped >= _local1.skipUpdates);
                    if (_local8 >= _local1.timeComplete) {
                        _local13 = true;
                        _local14 = true;
                    }
                    if (!_local1.hasStarted) {
                        if (_local1.onStart != undefined) {
                            _local12 = ((_local1.onStartScope != undefined) ? (_local1.onStartScope) : (_local5));
                            try {
                                _local1.onStart.apply(_local12, _local1.onStartParams);
                            } catch(e:Error) {
                                handleError(_local1, e, "onStart");
                            }
                        }
                        var _local11;
                        for (_local2 in _local1.properties) {
                            if (_local1.properties[_local2].isSpecialProperty) {
                                if (_specialPropertyList[_local2].preProcess != undefined) {
                                    _local1.properties[_local2].valueComplete = _specialPropertyList[_local2].preProcess(_local5, _specialPropertyList[_local2].parameters, _local1.properties[_local2].originalValueComplete, _local1.properties[_local2].extra);
                                }
                                _local11 = _specialPropertyList[_local2].getValue(_local5, _specialPropertyList[_local2].parameters, _local1.properties[_local2].extra);
                            } else {
                                _local11 = _local5[_local2];
                            }
                            _local1.properties[_local2].valueStart = (isNaN(_local11) ? (_local1.properties[_local2].valueComplete) : (_local11));
                        }
                        _local14 = true;
                        _local1.hasStarted = true;
                    }
                    if (_local14) {
                        for (_local2 in _local1.properties) {
                            _local4 = _local1.properties[_local2];
                            if (_local13) {
                                _local3 = _local4.valueComplete;
                            } else if (_local4.hasModifier) {
                                _local7 = _local8 - _local1.timeStart;
                                _local6 = _local1.timeComplete - _local1.timeStart;
                                _local3 = _local1.transition(_local7, 0, 1, _local6, _local1.transitionParams);
                                _local3 = _local4.modifierFunction(_local4.valueStart, _local4.valueComplete, _local3, _local4.modifierParameters);
                            } else {
                                _local7 = _local8 - _local1.timeStart;
                                _local10 = _local4.valueStart;
                                _local9 = _local4.valueComplete - _local4.valueStart;
                                _local6 = _local1.timeComplete - _local1.timeStart;
                                _local3 = _local1.transition(_local7, _local10, _local9, _local6, _local1.transitionParams);
                            }
                            if (_local1.rounded) {
                                _local3 = Math.round(_local3);
                            }
                            if (_local4.isSpecialProperty) {
                                _specialPropertyList[_local2].setValue(_local5, _local3, _specialPropertyList[_local2].parameters, _local1.properties[_local2].extra);
                            } else {
                                _local5[_local2] = _local3;
                            }
                        }
                        _local1.updatesSkipped = 0;
                        if (_local1.onUpdate != undefined) {
                            _local12 = ((_local1.onUpdateScope != undefined) ? (_local1.onUpdateScope) : (_local5));
                            try {
                                _local1.onUpdate.apply(_local12, _local1.onUpdateParams);
                            } catch(e:Error) {
                                handleError(_local1, e, "onUpdate");
                            }
                        }
                    } else {
                        _local1.updatesSkipped++;
                    }
                }
                if (_local13 && (_local1.onComplete != undefined)) {
                    _local12 = ((_local1.onCompleteScope != undefined) ? (_local1.onCompleteScope) : (_local5));
                    try {
                        _local1.onComplete.apply(_local12, _local1.onCompleteParams);
                    } catch(e:Error) {
                        handleError(_local1, e, "onComplete");
                    }
                }
                return(!_local13);
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
            var _local1 = new com.clubpenguin.engine.tweener.SpecialProperty(p_getFunction, p_setFunction, p_parameters, p_preProcessFunction);
            _specialPropertyList[p_name] = _local1;
        }
        static function registerSpecialPropertyModifier(p_name, p_modifyFunction, p_getFunction) {
            if (!_inited) {
                init();
            }
            var _local1 = new com.clubpenguin.engine.tweener.SpecialPropertyModifier(p_modifyFunction, p_getFunction);
            _specialPropertyModifierList[p_name] = _local1;
        }
        static function registerSpecialPropertySplitter(p_name, p_splitFunction, p_parameters) {
            if (!_inited) {
                init();
            }
            var _local1 = new com.clubpenguin.engine.tweener.SpecialPropertySplitter(p_splitFunction, p_parameters);
            _specialPropertySplitterList[p_name] = _local1;
        }
        static function startEngine() {
            _engineExists = true;
            _tweenList = new Array();
            var _local2 = Math.floor(Math.random() * 999999);
            var _local3 = _root.createEmptyMovieClip(getControllerName(), 31338 + _local2);
            _local3.onEnterFrame = function () {
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
            var _local1 = false;
            _local1 = updateTweens();
            if (!_local1) {
                stopEngine();
            }
        }
        static function setTimeScale(p_time) {
            var _local1;
            var _local2;
            if (isNaN(p_time)) {
                p_time = 1;
            }
            if (p_time < 1E-5) {
                p_time = 1E-5;
            }
            if (p_time != _timeScale) {
                _local1 = 0;
                while (_local1 < _tweenList.length) {
                    _local2 = getCurrentTweeningTime(_tweenList[_local1]);
                    _tweenList[_local1].timeStart = _local2 - (((_local2 - _tweenList[_local1].timeStart) * _timeScale) / p_time);
                    _tweenList[_local1].timeComplete = _local2 - (((_local2 - _tweenList[_local1].timeComplete) * _timeScale) / p_time);
                    if (_tweenList[_local1].timePaused != undefined) {
                        _tweenList[_local1].timePaused = _local2 - (((_local2 - _tweenList[_local1].timePaused) * _timeScale) / p_time);
                    }
                    _local1++;
                }
                _timeScale = p_time;
            }
        }
        static function isTweening(p_scope) {
            var _local1;
            _local1 = 0;
            while (_local1 < _tweenList.length) {
                if (_tweenList[_local1].scope == p_scope) {
                    return(true);
                }
                _local1++;
            }
            return(false);
        }
        static function getTweens(p_scope) {
            var _local1;
            var _local2;
            var _local3 = new Array();
            _local1 = 0;
            while (_local1 < _tweenList.length) {
                if (_tweenList[_local1].scope == p_scope) {
                    for (_local2 in _tweenList[_local1].properties) {
                        _local3.push(_local2);
                    }
                }
                _local1++;
            }
            return(_local3);
        }
        static function getTweenCount(p_scope) {
            var _local1;
            var _local2 = 0;
            _local1 = 0;
            while (_local1 < _tweenList.length) {
                if (_tweenList[_local1].scope == p_scope) {
                    _local2 = _local2 + com.clubpenguin.engine.tweener.AuxFunctions.getObjectLength(_tweenList[_local1].properties);
                }
                _local1++;
            }
            return(_local2);
        }
        static function handleError(pTweening, pError, pCallBackName) {
            if ((pTweening.onError != undefined) && (typeof(pTweening.onError == "function"))) {
                var _local3 = ((pTweening.onErrorScope != undefined) ? (pTweening.onErrorScope) : (pTweening.scope));
                try {
                    pTweening.onError.apply(_local3, [pTweening.scope, pError]);
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
        }
        static var _engineExists = false;
        static var _inited = false;
        static var _timeScale = 1;
    }
