//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.greensock.TweenLite extends com.greensock.core.TweenCore
    {
        static var _timingClip, overwriteManager, rootFrame, rootTimeline, rootFramesTimeline, onPluginEvent;
        var ratio, target, _targetID, vars, cachedTimeScale, propTweenLookup, _ease, _overwrite, active, cachedPT1, _notifyPluginsOfEnabled, _hasPlugins, _hasUpdate, _overwrittenProps, initted, cachedTime, cachedDuration, cachedTotalTime, _rawPrevTime, cachedReversed, cachedPaused, gc, complete;
        function TweenLite (target, duration, vars) {
            super(duration, vars);
            if (_timingClip.onEnterFrame != updateAll) {
                jumpStart(_root);
            }
            ratio = 0;
            this.target = target;
            _targetID = getID(target, true);
            if ((this.vars.timeScale != undefined) && (this.target instanceof com.greensock.core.TweenCore)) {
                cachedTimeScale = 1;
            }
            propTweenLookup = {};
            _ease = defaultEase;
            _overwrite = (((vars.overwrite == undefined) || ((!overwriteManager.enabled) && (vars.overwrite > 1))) ? (overwriteManager.mode) : (Number(vars.overwrite)));
            var _local_5 = masterList[_targetID].tweens;
            if (_local_5.length == 0) {
                _local_5[0] = this;
            } else if (_overwrite == 1) {
                var _local_4 = _local_5.length;
                while (_local_4-- , _local_4 > -1) {
                    if (!_local_5[_local_4].gc) {
                        _local_5[_local_4].setEnabled(false, false);
                    }
                }
                masterList[_targetID].tweens = [this];
            } else {
                _local_5[_local_5.length] = this;
            }
            if (active || (this.vars.immediateRender)) {
                renderTime(0, false, true);
            }
        }
        static function initClass() {
            rootFrame = 0;
            rootTimeline = new com.greensock.core.SimpleTimeline(null);
            rootFramesTimeline = new com.greensock.core.SimpleTimeline(null);
            rootTimeline.autoRemoveChildren = (rootFramesTimeline.autoRemoveChildren = true);
            rootTimeline.cachedStartTime = getTimer() * 0.001;
            rootTimeline.cachedTotalTime = (rootFramesTimeline.cachedTotalTime = 0);
            rootFramesTimeline.cachedStartTime = rootFrame;
            if (overwriteManager == undefined) {
                overwriteManager = {mode:1, enabled:false};
            }
            jumpStart(_root);
        }
        function init() {
            if (vars.onInit) {
                vars.onInit.apply(null, vars.onInitParams);
            }
            var _local_2;
            var _local_5;
            var _local_3;
            var _local_6;
            var _local_7;
            if (typeof(vars.ease) == "function") {
                _ease = vars.ease;
            }
            if (vars.easeParams != undefined) {
                vars.proxiedEase = _ease;
                _ease = easeProxy;
            }
            cachedPT1 = undefined;
            propTweenLookup = {};
            for (_local_2 in vars) {
                if (_reservedProps[_local_2] && (!((_local_2 == "timeScale") && (target instanceof com.greensock.core.TweenCore)))) {
                } else if (plugins[_local_2] && ((_local_3 = new plugins[_local_2]()).onInitTween(target, vars[_local_2], this))) {
                    cachedPT1 = new com.greensock.core.PropTween(_local_3, "changeFactor", 0, 1, ((_local_3.overwriteProps.length == 1) ? (_local_3.overwriteProps[0]) : "_MULTIPLE_"), true, cachedPT1);
                    if (cachedPT1.name == "_MULTIPLE_") {
                        _local_5 = _local_3.overwriteProps.length;
                        while (_local_5-- , _local_5 > -1) {
                            propTweenLookup[_local_3.overwriteProps[_local_5]] = cachedPT1;
                        }
                    } else {
                        propTweenLookup[cachedPT1.name] = cachedPT1;
                    }
                    if (_local_3.priority) {
                        cachedPT1.priority = _local_3.priority;
                        _local_6 = true;
                    }
                    if (_local_3.onDisable || (_local_3.onEnable)) {
                        _notifyPluginsOfEnabled = true;
                    }
                    _hasPlugins = true;
                } else {
                    cachedPT1 = new com.greensock.core.PropTween(target, _local_2, Number(target[_local_2]), ((typeof(vars[_local_2]) == "number") ? (Number(vars[_local_2]) - target[_local_2]) : (Number(vars[_local_2]))), _local_2, false, cachedPT1);
                    propTweenLookup[_local_2] = cachedPT1;
                }
            }
            if (_local_6) {
                onPluginEvent("onInitAllProps", this);
            }
            if (vars.runBackwards) {
                var _local_4 = cachedPT1;
                while (_local_4) {
                    _local_4.start = _local_4.start + _local_4.change;
                    _local_4.change = -_local_4.change;
                    _local_4 = _local_4.nextNode;
                }
            }
            _hasUpdate = Boolean(typeof(vars.onUpdate) == "function");
            if (_overwrittenProps) {
                killVars(_overwrittenProps);
                if (cachedPT1 == undefined) {
                    setEnabled(false, false);
                }
            }
            if ((((_overwrite > 1) && (cachedPT1)) && (_local_7 = masterList[_targetID].tweens)) && (_local_7.length > 1)) {
                if (overwriteManager.manageOverwrites(this, propTweenLookup, _local_7, _overwrite)) {
                    init();
                }
            }
            initted = true;
        }
        function renderTime(time, suppressEvents, force) {
            var _local_4;
            var _local_5 = cachedTime;
            if (time >= cachedDuration) {
                cachedTotalTime = (cachedTime = cachedDuration);
                ratio = 1;
                _local_4 = true;
                if (cachedDuration == 0) {
                    if (((time == 0) || (_rawPrevTime < 0)) && (_rawPrevTime != time)) {
                        force = true;
                    }
                    _rawPrevTime = time;
                }
            } else if (time <= 0) {
                cachedTotalTime = (cachedTime = (ratio = 0));
                if (time < 0) {
                    active = false;
                    if (cachedDuration == 0) {
                        if (_rawPrevTime >= 0) {
                            force = true;
                            _local_4 = true;
                        }
                        _rawPrevTime = time;
                    }
                }
                if (cachedReversed && (_local_5 != 0)) {
                    _local_4 = true;
                }
            } else {
                cachedTotalTime = (cachedTime = time);
                ratio = _ease(time, 0, 1, cachedDuration);
            }
            if ((cachedTime == _local_5) && (!force)) {
                return(undefined);
            } else if (!initted) {
                init();
                if ((!_local_4) && (cachedTime)) {
                    ratio = _ease(cachedTime, 0, 1, cachedDuration);
                }
            }
            if ((!active) && (!cachedPaused)) {
                active = true;
            }
            if ((((_local_5 == 0) && (vars.onStart)) && ((cachedTime != 0) || (cachedDuration == 0))) && (!suppressEvents)) {
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
            if (_local_4 && (!gc)) {
                if (_hasPlugins && (cachedPT1)) {
                    onPluginEvent("onComplete", this);
                }
                complete(true, suppressEvents);
            }
        }
        function killVars(vars, permanent) {
            if (_overwrittenProps == undefined) {
                _overwrittenProps = {};
            }
            var _local_3;
            var _local_2;
            var _local_5;
            for (_local_3 in vars) {
                if (propTweenLookup[_local_3]) {
                    _local_2 = propTweenLookup[_local_3];
                    if (_local_2.isPlugin && (_local_2.name == "_MULTIPLE_")) {
                        _local_2.target.killProps(vars);
                        if (_local_2.target.overwriteProps.length == 0) {
                            _local_2.name = "";
                        }
                        if ((_local_3 != _local_2.target.propName) || (_local_2.name == "")) {
                            delete propTweenLookup[_local_3];
                        }
                    }
                    if (_local_2.name != "_MULTIPLE_") {
                        if (_local_2.nextNode) {
                            _local_2.nextNode.prevNode = _local_2.prevNode;
                        }
                        if (_local_2.prevNode) {
                            _local_2.prevNode.nextNode = _local_2.nextNode;
                        } else if (cachedPT1 == _local_2) {
                            cachedPT1 = _local_2.nextNode;
                        }
                        if (_local_2.isPlugin && (_local_2.target.onDisable)) {
                            _local_2.target.onDisable();
                            if (_local_2.target.activeDisable) {
                                _local_5 = true;
                            }
                        }
                        delete propTweenLookup[_local_3];
                    }
                }
                if ((permanent != false) && (vars != _overwrittenProps)) {
                    _overwrittenProps[_local_3] = 1;
                }
            }
            return(_local_5);
        }
        function invalidate() {
            if (_notifyPluginsOfEnabled) {
                onPluginEvent("onDisable", this);
            }
            cachedPT1 = undefined;
            _overwrittenProps = undefined;
            _hasUpdate = (initted = (active = (_notifyPluginsOfEnabled = false)));
            propTweenLookup = {};
        }
        function setEnabled(enabled, ignoreTimeline) {
            if (enabled && (gc)) {
                var _local_4 = masterList[_targetID].tweens;
                if (_local_4) {
                    var _local_3 = _local_4.length;
                    _local_4[_local_3] = this;
                    while (_local_3-- , _local_3 > -1) {
                        if (_local_4[_local_3] == this) {
                            _local_4.splice(_local_3, 1);
                        }
                    }
                } else {
                    masterList[_targetID] = {target:target, tweens:[this]};
                }
            }
            super.setEnabled(enabled, ignoreTimeline);
            if (_notifyPluginsOfEnabled && (cachedPT1)) {
                return(onPluginEvent((enabled ? "onEnable" : "onDisable"), this));
            }
            return(false);
        }
        function easeProxy(t, b, c, d) {
            return(vars.proxiedEase.apply(null, arguments.concat(vars.easeParams)));
        }
        static function to(target, duration, vars) {
            return(new com.greensock.TweenLite(target, duration, vars));
        }
        static function from(target, duration, vars) {
            vars.runBackwards = true;
            if (vars.immediateRender != false) {
                vars.immediateRender = true;
            }
            return(new com.greensock.TweenLite(target, duration, vars));
        }
        static function delayedCall(delay, onComplete, onCompleteParams, onCompleteScope, useFrames) {
            return(new com.greensock.TweenLite(onComplete, 0, {delay:delay, onComplete:onComplete, onCompleteParams:onCompleteParams, onCompleteScope:onCompleteScope, immediateRender:false, useFrames:useFrames, overwrite:0}));
        }
        static function updateAll() {
            rootTimeline.renderTime(((getTimer() * 0.001) - rootTimeline.cachedStartTime) * rootTimeline.cachedTimeScale, false, false);
            rootFrame++;
            rootFramesTimeline.renderTime((rootFrame - rootFramesTimeline.cachedStartTime) * rootFramesTimeline.cachedTimeScale, false, false);
            if (!(rootFrame % 60)) {
                var _local_3 = masterList;
                var _local_2;
                var _local_1;
                for (var _local_4 in _local_3) {
                    _local_1 = _local_3[_local_4].tweens;
                    _local_2 = _local_1.length;
                    while (_local_2-- , _local_2 > -1) {
                        if (_local_1[_local_2].gc) {
                            _local_1.splice(_local_2, 1);
                        }
                    }
                    if (_local_1.length == 0) {
                        delete _local_3[_local_4];
                    }
                }
            }
        }
        static function killTweensOf(target, complete, vars) {
            var _local_6 = getID(target, true);
            var _local_4 = masterList[_local_6].tweens;
            var _local_3;
            var _local_1;
            if (_local_4 != undefined) {
                _local_3 = _local_4.length;
                while (_local_3-- , _local_3 > -1) {
                    _local_1 = _local_4[_local_3];
                    if (!_local_1.gc) {
                        if (complete == true) {
                            _local_1.complete(false, false);
                        }
                        if (vars != undefined) {
                            _local_1.killVars(vars);
                        }
                        if ((vars == undefined) || ((_local_1.cachedPT1 == undefined) && (_local_1.initted))) {
                            _local_1.setEnabled(false, false);
                        }
                    }
                }
                if (vars == undefined) {
                    delete masterList[_local_6];
                }
            }
        }
        static function getID(target, lookup) {
            var _local_2;
            if (lookup) {
                var _local_1 = masterList;
                if (typeof(target) == "movieclip") {
                    if (_local_1[String(target)] != undefined) {
                        return(String(target));
                    } else {
                        _local_2 = String(target);
                        masterList[_local_2] = {target:target, tweens:[]};
                        return(_local_2);
                    }
                } else {
                    for (var _local_3 in _local_1) {
                        if (_local_1[_local_3].target == target) {
                            return(_local_3);
                        }
                    }
                }
            }
            _cnt++;
            _local_2 = "t" + _cnt;
            masterList[_local_2] = {target:target, tweens:[]};
            return(_local_2);
        }
        static function easeOut(t, b, c, d) {
            t = t / d;
            return((-1 * t) * (t - 2));
        }
        static function findSubloadedSWF(mc) {
            for (var _local_3 in mc) {
                if (typeof(mc[_local_3]) == "movieclip") {
                    if ((mc[_local_3]._url != _root._url) && (mc[_local_3].getBytesLoaded() != undefined)) {
                        return(mc[_local_3]);
                    } else if (findSubloadedSWF(mc[_local_3]) != undefined) {
                        return(findSubloadedSWF(mc[_local_3]));
                    }
                }
            }
            return(undefined);
        }
        static function jumpStart(root) {
            if (_timingClip != undefined) {
                _timingClip.removeMovieClip();
            }
            var _local_2 = ((root.getBytesLoaded() == undefined) ? (findSubloadedSWF(root)) : (root));
            var _local_1 = 999;
            while (_local_2.getInstanceAtDepth(_local_1) != undefined) {
                _local_1++;
            }
            _timingClip = _local_2.createEmptyMovieClip("__tweenLite" + String(version).split(".").join("_"), _local_1);
            _timingClip.onEnterFrame = updateAll;
            to({}, 0, {});
            rootTimeline.cachedTime = (rootTimeline.cachedTotalTime = ((getTimer() * 0.001) - rootTimeline.cachedStartTime) * rootTimeline.cachedTimeScale);
        }
        static var version = 11.691;
        static var plugins = {};
        static var killDelayedCallsTo = killTweensOf;
        static var defaultEase = easeOut;
        static var masterList = {};
        static var _cnt = -16000;
        static var _reservedProps = {ease:1, delay:1, overwrite:1, onComplete:1, onCompleteParams:1, useFrames:1, runBackwards:1, startAt:1, onUpdate:1, onUpdateParams:1, onStart:1, onStartParams:1, onReverseComplete:1, onReverseCompleteParams:1, onRepeat:1, onRepeatParams:1, proxiedEase:1, easeParams:1, yoyo:1, onCompleteListener:1, onUpdateListener:1, onStartListener:1, orientToBezier:1, timeScale:1, immediateRender:1, repeat:1, repeatDelay:1, timeline:1, data:1, paused:1};
    }
