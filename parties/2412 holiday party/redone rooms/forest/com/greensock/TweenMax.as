//Created by Action Script Viewer - https://www.buraks.com/asv
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
                var startTween = (new com.greensock.TweenMax(target, 0, vars.startAt));
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
            var curRatio = ratio;
            if ((resetDuration && (timeline != undefined)) && (cachedStartTime < timeline.cachedTime)) {
                cachedStartTime = timeline.cachedTime;
                setDirtyCache(false);
                if (gc) {
                    setEnabled(true, false);
                } else {
                    timeline.insert(this, cachedStartTime - _delay);
                }
            }
            for (var p in vars) {
                this.vars[p] = vars[p];
            }
            if (initted) {
                if (resetDuration) {
                    initted = false;
                } else {
                    if (_notifyPluginsOfEnabled && (cachedPT1)) {
                        com.greensock.TweenLite.onPluginEvent("onDisable", this);
                    }
                    if ((cachedTime / cachedDuration) > 0.998) {
                        var prevTime = cachedTime;
                        renderTime(0, true, false);
                        initted = false;
                        renderTime(prevTime, true, false);
                    } else if (cachedTime > 0) {
                        initted = false;
                        init();
                        var inv = (1 / (1 - curRatio));
                        var pt = cachedPT1;
                        var endValue;
                        while (pt) {
                            endValue = pt.start + pt.change;
                            pt.change = pt.change * inv;
                            pt.start = endValue - pt.change;
                            pt = pt.nextNode;
                        }
                    }
                }
            }
        }
        function setDestination(property, value, adjustStartValues) {
            var vars = {};
            vars[property] = value;
            updateTo(vars, Boolean(adjustStartValues != false));
        }
        function killProperties(names) {
            var v = {};
            var i = names.length;
            while ((--i) > -1) {
                v[names[i]] = true;
            }
            killVars(v);
        }
        function renderTime(time, suppressEvents, force) {
            var totalDur = (cacheIsDirty ? (totalDuration) : (cachedTotalDuration));
            var prevTime = cachedTotalTime;
            var isComplete;
            var repeated;
            var setRatio;
            if (time >= totalDur) {
                cachedTotalTime = totalDur;
                cachedTime = cachedDuration;
                ratio = 1;
                isComplete = true;
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
                            isComplete = true;
                        }
                        _rawPrevTime = time;
                    }
                } else if ((time == 0) && (!initted)) {
                    force = true;
                }
                cachedTotalTime = (cachedTime = (ratio = 0));
                if (cachedReversed && (prevTime != 0)) {
                    isComplete = true;
                }
            } else {
                cachedTotalTime = (cachedTime = time);
                setRatio = true;
            }
            if (_repeat != 0) {
                var cycleDuration = (cachedDuration + _repeatDelay);
                var prevCycles = _cyclesComplete;
                _cyclesComplete = (cachedTotalTime / cycleDuration) >> 0;
                if (_cyclesComplete == (cachedTotalTime / cycleDuration)) {
                    _cyclesComplete--;
                }
                if (prevCycles != _cyclesComplete) {
                    repeated = true;
                }
                if (isComplete) {
                    if (yoyo && (_repeat % 2)) {
                        cachedTime = (ratio = 0);
                    }
                } else if (time > 0) {
                    cachedTime = ((cachedTotalTime / cycleDuration) - _cyclesComplete) * cycleDuration;
                    if (yoyo && (_cyclesComplete % 2)) {
                        cachedTime = cachedDuration - cachedTime;
                    } else if (cachedTime >= cachedDuration) {
                        cachedTime = cachedDuration;
                        ratio = 1;
                        setRatio = false;
                    }
                    if (cachedTime <= 0) {
                        cachedTime = (ratio = 0);
                        setRatio = false;
                    }
                } else {
                    _cyclesComplete = 0;
                }
            }
            if ((prevTime == cachedTotalTime) && (!force)) {
                return(undefined);
            } else if (!initted) {
                init();
            }
            if ((!active) && (!cachedPaused)) {
                active = true;
            }
            if (setRatio) {
                ratio = _ease(cachedTime, 0, 1, cachedDuration);
            }
            if ((((prevTime == 0) && (vars.onStart)) && ((cachedTotalTime != 0) || (cachedDuration == 0))) && (!suppressEvents)) {
                vars.onStart.apply(vars.onStartScope, vars.onStartParams);
            }
            var pt = cachedPT1;
            while (pt) {
                pt.target[pt.property] = pt.start + (ratio * pt.change);
                pt = pt.nextNode;
            }
            if (_hasUpdate && (!suppressEvents)) {
                vars.onUpdate.apply(vars.onUpdateScope, vars.onUpdateParams);
            }
            if ((repeated && (!suppressEvents)) && (!gc)) {
                if (vars.onRepeat) {
                    vars.onRepeat.apply(vars.onRepeatScope, vars.onRepeatParams);
                }
            }
            if (isComplete && (!gc)) {
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
            var i;
            var varsDup;
            var p;
            if (stagger == undefined) {
                stagger = 0;
            }
            var l = targets.length;
            var a = [];
            var curDelay = (vars.delay || 0);
            var onCompleteProxy = vars.onComplete;
            var onCompleteParamsProxy = vars.onCompleteParams;
            var onCompleteScopeProxy = vars.onCompleteScope;
            var lastIndex = (l - 1);
            i = 0;
            while (i < l) {
                varsDup = {};
                for (p in vars) {
                    varsDup[p] = vars[p];
                }
                varsDup.delay = curDelay;
                if ((i == lastIndex) && (onCompleteAll != undefined)) {
                    varsDup.onComplete = function () {
                        if (onCompleteProxy != undefined) {
                            onCompleteProxy.apply(onCompleteScopeProxy, onCompleteParamsProxy);
                        }
                        onCompleteAll.apply(onCompleteAllScope, onCompleteAllParams);
                    };
                }
                a[i] = new com.greensock.TweenMax(targets[i], duration, varsDup);
                curDelay = curDelay + stagger;
                i++;
            }
            return(a);
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
            var a = com.greensock.TweenLite.masterList[target].tweens;
            var toReturn = [];
            if (a) {
                var i = a.length;
                while ((--i) > -1) {
                    if (!a[i].gc) {
                        toReturn[toReturn.length] = a[i];
                    }
                }
            }
            return(toReturn);
        }
        static function isTweening(target) {
            var a = getTweensOf(target);
            var i = a.length;
            var tween;
            while ((--i) > -1) {
                tween = a[i];
                if (tween.active || ((tween.cachedStartTime == tween.timeline.cachedTime) && (tween.timeline.active))) {
                    return(true);
                }
            }
            return(false);
        }
        static function getAllTweens() {
            var ml = com.greensock.TweenLite.masterList;
            var cnt = 0;
            var toReturn = [];
            var a;
            var i;
            for (var p in ml) {
                a = ml[p].tweens;
                i = a.length;
                while ((--i) > -1) {
                    if (!a[i].gc) {
                        toReturn[cnt++] = a[i];
                    }
                }
            }
            return(toReturn);
        }
        static function killAll(complete, tweens, delayedCalls) {
            if (tweens == undefined) {
                tweens = true;
            }
            if (delayedCalls == undefined) {
                delayedCalls = true;
            }
            var a = getAllTweens();
            var isDC;
            var i = a.length;
            while ((--i) > -1) {
                isDC = a[i].target == a[i].vars.onComplete;
                if ((isDC == delayedCalls) || (isDC != tweens)) {
                    if (complete == true) {
                        a[i].complete(false, false);
                    } else {
                        a[i].setEnabled(false, false);
                    }
                }
            }
        }
        static function killChildTweensOf(parent, complete) {
            var a = getAllTweens();
            var curTarget;
            var curParent;
            var i = a.length;
            while ((--i) > -1) {
                curTarget = a[i].target;
                if (curTarget instanceof MovieClip) {
                    curParent = curTarget._parent;
                    while (curParent) {
                        if (curParent == parent) {
                            if (complete == true) {
                                a[i].complete(false, false);
                            } else {
                                a[i].setEnabled(false, false);
                            }
                        }
                        curParent = curParent._parent;
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
            var a = getAllTweens();
            var isDC;
            var i = a.length;
            while ((--i) > -1) {
                isDC = Boolean(a[i].target == a[i].vars.onComplete);
                if ((isDC == delayedCalls) || (isDC != tweens)) {
                    a[i].paused = pause;
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
            var tlTime = ((cachedPauseTime || (cachedPauseTime == 0)) ? (cachedPauseTime) : (timeline.cachedTotalTime));
            cachedStartTime = tlTime - (((tlTime - cachedStartTime) * cachedTimeScale) / n);
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
            var tl = com.greensock.TweenLite.rootTimeline;
            var curTime = (getTimer() * 0.001);
            tl.cachedStartTime = curTime - (((curTime - tl.cachedStartTime) * tl.cachedTimeScale) / n);
            tl = com.greensock.TweenLite.rootFramesTimeline;
            curTime = com.greensock.TweenLite.rootFrame;
            tl.cachedStartTime = curTime - (((curTime - tl.cachedStartTime) * tl.cachedTimeScale) / n);
            com.greensock.TweenLite.rootFramesTimeline.cachedTimeScale = (com.greensock.TweenLite.rootTimeline.cachedTimeScale = n);
            //return(globalTimeScale);
        }
        static var version = 11.691;
        static var _activatedPlugins = com.greensock.plugins.TweenPlugin.activate([com.greensock.plugins.AutoAlphaPlugin, com.greensock.plugins.EndArrayPlugin, com.greensock.plugins.FramePlugin, com.greensock.plugins.RemoveTintPlugin, com.greensock.plugins.TintPlugin, com.greensock.plugins.VisiblePlugin, com.greensock.plugins.VolumePlugin, com.greensock.plugins.BevelFilterPlugin, com.greensock.plugins.BezierPlugin, com.greensock.plugins.BezierThroughPlugin, com.greensock.plugins.BlurFilterPlugin, com.greensock.plugins.ColorMatrixFilterPlugin, com.greensock.plugins.ColorTransformPlugin, com.greensock.plugins.DropShadowFilterPlugin, com.greensock.plugins.FrameLabelPlugin, com.greensock.plugins.GlowFilterPlugin, com.greensock.plugins.HexColorsPlugin, com.greensock.plugins.RoundPropsPlugin, com.greensock.plugins.ShortRotationPlugin, {}]);
        static var _overwriteMode = (com.greensock.OverwriteManager.enabled ? (com.greensock.OverwriteManager.mode) : (com.greensock.OverwriteManager.init(2)));
        static var killTweensOf = com.greensock.TweenLite.killTweensOf;
        static var killDelayedCallsTo = com.greensock.TweenLite.killTweensOf;
    }
