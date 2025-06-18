    class com.greensock.TweenMax extends com.greensock.TweenLite
    {
        var _cyclesComplete, yoyo, vars, _repeat, _repeatDelay, cacheIsDirty, target, cachedTimeScale, setDirtyCache, ratio, timeline, cachedStartTime, gc, setEnabled, _delay, initted, _notifyPluginsOfEnabled, cachedPT1, cachedDuration, cachedTime, killVars, cachedTotalDuration, cachedTotalTime, _rawPrevTime, active, cachedReversed, cachedPaused, _ease, _hasUpdate, _hasPlugins, complete, __get__duration, setTotalTime, __set__duration, cachedPauseTime;
        function TweenMax (target, duration, vars) {
            super(target, duration, vars);
            if (com.greensock.TweenLite.version < 11.2) {
            }
            _cyclesComplete = 0;
            yoyo = Boolean(this.vars.yoyo);
            _repeat = this.vars.repeat || 0;
            _repeatDelay = this.vars.repeatDelay || 0;
            cacheIsDirty = true;
            if ((this.vars.timeScale != undefined) && (!(this.target instanceof com.greensock.core.TweenCore))) {
                cachedTimeScale = this.vars.timeScale;
            }
        }
        function init() {
            if (vars.startAt) {
                vars.startAt.overwrite = 0;
                vars.startAt.immediateRender = true;
                var _local_3 = new com.greensock.TweenMax(target, 0, vars.startAt);
            }
            super.init();
        }
        function invalidate() {
            yoyo = Boolean(vars.yoyo);
            _repeat = vars.repeat || 0;
            _repeatDelay = vars.repeatDelay || 0;
            setDirtyCache(true);
            super.invalidate();
        }
        function updateTo(vars, resetDuration) {
            var _local_7 = ratio;
            if ((resetDuration && (timeline != undefined)) && (cachedStartTime < timeline.cachedTime)) {
                cachedStartTime = timeline.cachedTime;
                setDirtyCache(false);
                if (gc) {
                    setEnabled(true, false);
                } else {
                    timeline.insert(this, cachedStartTime - _delay);
                }
            }
            for (var _local_6 in vars) {
                this.vars[_local_6] = vars[_local_6];
            }
            if (initted) {
                if (resetDuration) {
                    initted = false;
                } else {
                    if (_notifyPluginsOfEnabled && (cachedPT1)) {
                        com.greensock.TweenLite.onPluginEvent("onDisable", this);
                    }
                    if ((cachedTime / cachedDuration) > 0.998) {
                        var _local_8 = cachedTime;
                        renderTime(0, true, false);
                        initted = false;
                        renderTime(_local_8, true, false);
                    } else if (cachedTime > 0) {
                        initted = false;
                        init();
                        var _local_5 = 1 / (1 - _local_7);
                        var _local_2 = cachedPT1;
                        var _local_3;
                        while (_local_2) {
                            _local_3 = _local_2.start + _local_2.change;
                            _local_2.change = _local_2.change * _local_5;
                            _local_2.start = _local_3 - _local_2.change;
                            _local_2 = _local_2.nextNode;
                        }
                    }
                }
            }
        }
        function setDestination(property, value, adjustStartValues) {
            var _local_2 = {};
            _local_2[property] = value;
            updateTo(_local_2, Boolean(adjustStartValues != false));
        }
        function killProperties(names) {
            var _local_3 = {};
            var _local_2 = names.length;
            while (_local_2-- , _local_2 > -1) {
                _local_3[names[_local_2]] = true;
            }
            killVars(_local_3);
        }
        function renderTime(time, suppressEvents, force) {
            var _local_9 = (cacheIsDirty ? (totalDuration) : (cachedTotalDuration));
            var _local_7 = cachedTotalTime;
            var _local_5;
            var _local_11;
            var _local_6;
            if (time >= _local_9) {
                cachedTotalTime = _local_9;
                cachedTime = cachedDuration;
                ratio = 1;
                _local_5 = true;
                if (cachedDuration == 0) {
                    if (((time == 0) || (_rawPrevTime < 0)) && (_rawPrevTime != time)) {
                        force = true;
                    }
                    _rawPrevTime = time;
                }
            } else if (time <= 0) {
                if (time < 0) {
                    active = false;
                    if (cachedDuration == 0) {
                        if (_rawPrevTime >= 0) {
                            force = true;
                            _local_5 = true;
                        }
                        _rawPrevTime = time;
                    }
                } else if ((time == 0) && (!initted)) {
                    force = true;
                }
                cachedTotalTime = (cachedTime = (ratio = 0));
                if (cachedReversed && (_local_7 != 0)) {
                    _local_5 = true;
                }
            } else {
                cachedTotalTime = (cachedTime = time);
                _local_6 = true;
            }
            if (_repeat != 0) {
                var _local_4 = cachedDuration + _repeatDelay;
                var _local_12 = _cyclesComplete;
                _cyclesComplete = (cachedTotalTime / _local_4) >> 0;
                if (_cyclesComplete == (cachedTotalTime / _local_4)) {
                    _cyclesComplete--;
                }
                if (_local_12 != _cyclesComplete) {
                    _local_11 = true;
                }
                if (_local_5) {
                    if (yoyo && (_repeat % 2)) {
                        cachedTime = (ratio = 0);
                    }
                } else if (time > 0) {
                    cachedTime = ((cachedTotalTime / _local_4) - _cyclesComplete) * _local_4;
                    if (yoyo && (_cyclesComplete % 2)) {
                        cachedTime = cachedDuration - cachedTime;
                    } else if (cachedTime >= cachedDuration) {
                        cachedTime = cachedDuration;
                        ratio = 1;
                        _local_6 = false;
                    }
                    if (cachedTime <= 0) {
                        cachedTime = (ratio = 0);
                        _local_6 = false;
                    }
                } else {
                    _cyclesComplete = 0;
                }
            }
            if ((_local_7 == cachedTotalTime) && (!force)) {
                return(undefined);
            }
            if (!initted) {
                init();
            }
            if ((!active) && (!cachedPaused)) {
                active = true;
            }
            if (_local_6) {
                ratio = _ease(cachedTime, 0, 1, cachedDuration);
            }
            if ((((_local_7 == 0) && (vars.onStart)) && ((cachedTotalTime != 0) || (cachedDuration == 0))) && (!suppressEvents)) {
                vars.onStart.apply(vars.onStartScope, vars.onStartParams);
            }
            var _local_2 = cachedPT1;
            while (_local_2) {
                _local_2.target[_local_2.property] = _local_2.start + (ratio * _local_2.change);
                _local_2 = _local_2.nextNode;
            }
            if (_hasUpdate && (!suppressEvents)) {
                vars.onUpdate.apply(vars.onUpdateScope, vars.onUpdateParams);
            }
            if ((_local_11 && (!suppressEvents)) && (!gc)) {
                if (vars.onRepeat) {
                    vars.onRepeat.apply(vars.onRepeatScope, vars.onRepeatParams);
                }
            }
            if (_local_5 && (!gc)) {
                if (_hasPlugins && (cachedPT1)) {
                    com.greensock.TweenLite.onPluginEvent("onComplete", this);
                }
                complete(true, suppressEvents);
            }
        }
        static function to(target, duration, vars) {
            return(new com.greensock.TweenMax(target, duration, vars));
        }
        static function from(target, duration, vars) {
            vars.runBackwards = true;
            if (vars.immediateRender != false) {
                vars.immediateRender = true;
            }
            return(new com.greensock.TweenMax(target, duration, vars));
        }
        static function fromTo(target, duration, fromVars, toVars) {
            toVars.startAt = fromVars;
            if (fromVars.immediateRender) {
                toVars.immediateRender = true;
            }
            return(new com.greensock.TweenMax(target, duration, toVars));
        }
        static function allTo(targets, duration, vars, stagger, onCompleteAll, onCompleteAllParams, onCompleteAllScope) {
            var _local_2;
            var _local_3;
            var _local_1;
            if (stagger == undefined) {
                stagger = 0;
            }
            var _local_7 = targets.length;
            var _local_6 = [];
            var _local_5 = vars.delay || 0;
            var onCompleteProxy = vars.onComplete;
            var onCompleteParamsProxy = vars.onCompleteParams;
            var onCompleteScopeProxy = vars.onCompleteScope;
            var _local_9 = _local_7 - 1;
            _local_2 = 0;
            while (_local_2 < _local_7) {
                _local_3 = {};
                for (_local_1 in vars) {
                    _local_3[_local_1] = vars[_local_1];
                }
                _local_3.delay = _local_5;
                if ((_local_2 == _local_9) && (onCompleteAll != undefined)) {
                    _local_3.onComplete = function () {
                        if (onCompleteProxy != undefined) {
                            onCompleteProxy.apply(onCompleteScopeProxy, onCompleteParamsProxy);
                        }
                        onCompleteAll.apply(onCompleteAllScope, onCompleteAllParams);
                    };
                }
                _local_6[_local_2] = new com.greensock.TweenMax(targets[_local_2], duration, _local_3);
                _local_5 = _local_5 + stagger;
                _local_2++;
            }
            return(_local_6);
        }
        static function allFrom(targets, duration, vars, stagger, onCompleteAll, onCompleteAllParams, onCompleteAllScope) {
            vars.runBackwards = true;
            if (vars.immediateRender != false) {
                vars.immediateRender = true;
            }
            return(allTo(targets, duration, vars, stagger, onCompleteAll, onCompleteAllParams, onCompleteAllScope));
        }
        static function allFromTo(targets, duration, fromVars, toVars, stagger, onCompleteAll, onCompleteAllParams, onCompleteAllScope) {
            toVars.startAt = fromVars;
            if (fromVars.immediateRender) {
                toVars.immediateRender = true;
            }
            return(allTo(targets, duration, toVars, stagger, onCompleteAll, onCompleteAllParams, onCompleteAllScope));
        }
        static function delayedCall(delay, onComplete, onCompleteParams, onCompleteScope, useFrames) {
            return(new com.greensock.TweenMax(onComplete, 0, {delay:delay, onComplete:onComplete, onCompleteParams:onCompleteParams, onCompleteScope:onCompleteScope, immediateRender:false, useFrames:useFrames, overwrite:0}));
        }
        static function getTweensOf(target) {
            var _local_2 = com.greensock.TweenLite.masterList[target].tweens;
            var _local_3 = [];
            if (_local_2) {
                var _local_1 = _local_2.length;
                while (_local_1-- , _local_1 > -1) {
                    if (!_local_2[_local_1].gc) {
                        _local_3[_local_3.length] = _local_2[_local_1];
                    }
                }
            }
            return(_local_3);
        }
        static function isTweening(target) {
            var _local_3 = getTweensOf(target);
            var _local_2 = _local_3.length;
            var _local_1;
            while (_local_2-- , _local_2 > -1) {
                _local_1 = _local_3[_local_2];
                if (_local_1.active || ((_local_1.cachedStartTime == _local_1.timeline.cachedTime) && (_local_1.timeline.active))) {
                    return(true);
                }
            }
            return(false);
        }
        static function getAllTweens() {
            var _local_5 = com.greensock.TweenLite.masterList;
            var _local_4 = 0;
            var _local_3 = [];
            var _local_2;
            var _local_1;
            for (var _local_6 in _local_5) {
                _local_2 = _local_5[_local_6].tweens;
                _local_1 = _local_2.length;
                while (_local_1-- , _local_1 > -1) {
                    if (!_local_2[_local_1].gc) {
                        _local_3[_local_4++] = _local_2[_local_1];
                    }
                }
            }
            return(_local_3);
        }
        static function killAll(complete, tweens, delayedCalls) {
            if (tweens == undefined) {
                tweens = true;
            }
            if (delayedCalls == undefined) {
                delayedCalls = true;
            }
            var _local_2 = getAllTweens();
            var _local_3;
            var _local_1 = _local_2.length;
            while (_local_1-- , _local_1 > -1) {
                _local_3 = _local_2[_local_1].target == _local_2[_local_1].vars.onComplete;
                if ((_local_3 == delayedCalls) || (_local_3 != tweens)) {
                    if (complete == true) {
                        _local_2[_local_1].complete(false, false);
                    } else {
                        _local_2[_local_1].setEnabled(false, false);
                    }
                }
            }
        }
        static function killChildTweensOf(parent, complete) {
            var _local_3 = getAllTweens();
            var _local_4;
            var _local_1;
            var _local_2 = _local_3.length;
            while (_local_2-- , _local_2 > -1) {
                _local_4 = _local_3[_local_2].target;
                if (_local_4 instanceof MovieClip) {
                    _local_1 = _local_4._parent;
                    while (_local_1) {
                        if (_local_1 == parent) {
                            if (complete == true) {
                                _local_3[_local_2].complete(false, false);
                            } else {
                                _local_3[_local_2].setEnabled(false, false);
                            }
                        }
                        _local_1 = _local_1._parent;
                    }
                }
            }
        }
        static function pauseAll(tweens, delayedCalls) {
            changePause(true, tweens, delayedCalls);
        }
        static function resumeAll(tweens, delayedCalls) {
            changePause(false, tweens, delayedCalls);
        }
        static function changePause(pause, tweens, delayedCalls) {
            if (tweens == undefined) {
                tweens = true;
            }
            if (delayedCalls == undefined) {
                delayedCalls = true;
            }
            var _local_2 = getAllTweens();
            var _local_3;
            var _local_1 = _local_2.length;
            while (_local_1-- , _local_1 > -1) {
                _local_3 = Boolean(_local_2[_local_1].target == _local_2[_local_1].vars.onComplete);
                if ((_local_3 == delayedCalls) || (_local_3 != tweens)) {
                    _local_2[_local_1].paused = pause;
                }
            }
        }
        function get currentProgress() {
            return(cachedTime / __get__duration());
        }
        function set currentProgress(n) {
            if (_cyclesComplete == 0) {
                setTotalTime(__get__duration() * n, false);
            } else {
                setTotalTime((__get__duration() * n) + (_cyclesComplete * cachedDuration), false);
            }
            //return(currentProgress);
        }
        function get totalProgress() {
            return(cachedTotalTime / totalDuration);
        }
        function set totalProgress(n) {
            setTotalTime(totalDuration * n, false);
            //return(totalProgress);
        }
        function get currentTime() {
            return(cachedTime);
        }
        function set currentTime(n) {
            if (_cyclesComplete == 0) {
            } else if (yoyo && ((_cyclesComplete % 2) == 1)) {
                n = (__get__duration() - n) + (_cyclesComplete * (cachedDuration + _repeatDelay));
            } else {
                n = n + (_cyclesComplete * (__get__duration() + _repeatDelay));
            }
            setTotalTime(n, false);
            //return(currentTime);
        }
        function get totalDuration() {
            if (cacheIsDirty) {
                cachedTotalDuration = ((_repeat == -1) ? 999999999999 : ((cachedDuration * (_repeat + 1)) + (_repeatDelay * _repeat)));
                cacheIsDirty = false;
            }
            return(cachedTotalDuration);
        }
        function set totalDuration(n) {
            if (_repeat == -1) {
                return;
            }
            __set__duration((n - (_repeat * _repeatDelay)) / (_repeat + 1));
            //return(totalDuration);
        }
        function get timeScale() {
            return(cachedTimeScale);
        }
        function set timeScale(n) {
            if (n == 0) {
                n = 0.0001;
            }
            var _local_3 = ((cachedPauseTime || (cachedPauseTime == 0)) ? (cachedPauseTime) : (timeline.cachedTotalTime));
            cachedStartTime = _local_3 - (((_local_3 - cachedStartTime) * cachedTimeScale) / n);
            cachedTimeScale = n;
            setDirtyCache(false);
            //return(timeScale);
        }
        function get repeat() {
            return(_repeat);
        }
        function set repeat(n) {
            _repeat = n;
            setDirtyCache(true);
            //return(repeat);
        }
        function get repeatDelay() {
            return(_repeatDelay);
        }
        function set repeatDelay(n) {
            _repeatDelay = n;
            setDirtyCache(true);
            //return(repeatDelay);
        }
        static function get globalTimeScale() {
            return(((com.greensock.TweenLite.rootTimeline == undefined) ? 1 : (com.greensock.TweenLite.rootTimeline.cachedTimeScale)));
        }
        static function set globalTimeScale(n) {
            if (n == 0) {
                n = 0.0001;
            }
            if (com.greensock.TweenLite.rootTimeline == undefined) {
                com.greensock.TweenLite.to({}, 0, {});
            }
            var _local_1 = com.greensock.TweenLite.rootTimeline;
            var _local_2 = getTimer() * 0.001;
            _local_1.cachedStartTime = _local_2 - (((_local_2 - _local_1.cachedStartTime) * _local_1.cachedTimeScale) / n);
            _local_1 = com.greensock.TweenLite.rootFramesTimeline;
            _local_2 = com.greensock.TweenLite.rootFrame;
            _local_1.cachedStartTime = _local_2 - (((_local_2 - _local_1.cachedStartTime) * _local_1.cachedTimeScale) / n);
            com.greensock.TweenLite.rootFramesTimeline.cachedTimeScale = (com.greensock.TweenLite.rootTimeline.cachedTimeScale = n);
            //return(globalTimeScale);
        }
        static var version = 11.691;
        static var _activatedPlugins = com.greensock.plugins.TweenPlugin.activate([com.greensock.plugins.AutoAlphaPlugin, com.greensock.plugins.EndArrayPlugin, com.greensock.plugins.FramePlugin, com.greensock.plugins.RemoveTintPlugin, com.greensock.plugins.TintPlugin, com.greensock.plugins.VisiblePlugin, com.greensock.plugins.VolumePlugin, com.greensock.plugins.BevelFilterPlugin, com.greensock.plugins.BezierPlugin, com.greensock.plugins.BezierThroughPlugin, com.greensock.plugins.BlurFilterPlugin, com.greensock.plugins.ColorMatrixFilterPlugin, com.greensock.plugins.ColorTransformPlugin, com.greensock.plugins.DropShadowFilterPlugin, com.greensock.plugins.FrameLabelPlugin, com.greensock.plugins.GlowFilterPlugin, com.greensock.plugins.HexColorsPlugin, com.greensock.plugins.RoundPropsPlugin, com.greensock.plugins.ShortRotationPlugin, {}]);
        static var _overwriteMode = (com.greensock.OverwriteManager.enabled ? (com.greensock.OverwriteManager.mode) : (com.greensock.OverwriteManager.init(2)));
        static var killTweensOf = com.greensock.TweenLite.killTweensOf;
        static var killDelayedCallsTo = com.greensock.TweenLite.killTweensOf;
    }
