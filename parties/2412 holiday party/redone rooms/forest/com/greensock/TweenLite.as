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
            var a = masterList[_targetID].tweens;
            if (a.length == 0) {
                a[0] = this;
            } else if (_overwrite == 1) {
                var i = a.length;
                while ((--i) > -1) {
                    if (!a[i].gc) {
                        a[i].setEnabled(false, false);
                    }
                }
                masterList[_targetID].tweens = [this];
            } else {
                a[a.length] = this;
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
            var p;
            var i;
            var plugin;
            var prioritize;
            var siblings;
            if (typeof(vars.ease) == "function") {
                _ease = vars.ease;
            }
            if (vars.easeParams != undefined) {
                vars.proxiedEase = _ease;
                _ease = easeProxy;
            }
            cachedPT1 = undefined;
            propTweenLookup = {};
            for (p in vars) {
                if (_reservedProps[p] && (!((p == "timeScale") && (target instanceof com.greensock.core.TweenCore)))) {
                } else if (plugins[p] && (((plugin = new plugins[p]())).onInitTween(target, vars[p], this))) {
                    cachedPT1 = new com.greensock.core.PropTween(plugin, "changeFactor", 0, 1, ((plugin.overwriteProps.length == 1) ? (plugin.overwriteProps[0]) : "_MULTIPLE_"), true, cachedPT1);
                    if (cachedPT1.name == "_MULTIPLE_") {
                        i = plugin.overwriteProps.length;
                        while ((--i) > -1) {
                            propTweenLookup[plugin.overwriteProps[i]] = cachedPT1;
                        }
                    } else {
                        propTweenLookup[cachedPT1.name] = cachedPT1;
                    }
                    if (plugin.priority) {
                        cachedPT1.priority = plugin.priority;
                        prioritize = true;
                    }
                    if (plugin.onDisable || (plugin.onEnable)) {
                        _notifyPluginsOfEnabled = true;
                    }
                    _hasPlugins = true;
                } else {
                    cachedPT1 = new com.greensock.core.PropTween(target, p, Number(target[p]), ((typeof(vars[p]) == "number") ? (Number(vars[p]) - target[p]) : (Number(vars[p]))), p, false, cachedPT1);
                    propTweenLookup[p] = cachedPT1;
                }
            }
            if (prioritize) {
                onPluginEvent("onInitAllProps", this);
            }
            if (vars.runBackwards) {
                var pt = cachedPT1;
                while (pt) {
                    pt.start = pt.start + pt.change;
                    pt.change = -pt.change;
                    pt = pt.nextNode;
                }
            }
            _hasUpdate = Boolean(typeof(vars.onUpdate) == "function");
            if (_overwrittenProps) {
                killVars(_overwrittenProps);
                if (cachedPT1 == undefined) {
                    setEnabled(false, false);
                }
            }
            if ((((_overwrite > 1) && (cachedPT1)) && ((siblings = masterList[_targetID].tweens))) && (siblings.length > 1)) {
                if (overwriteManager.manageOverwrites(this, propTweenLookup, siblings, _overwrite)) {
                    init();
                }
            }
            initted = true;
        }
        function renderTime(time, suppressEvents, force) {
            var isComplete;
            var prevTime = cachedTime;
            if (time >= cachedDuration) {
                cachedTotalTime = (cachedTime = cachedDuration);
                ratio = 1;
                isComplete = true;
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
                            isComplete = true;
                        }
                        _rawPrevTime = time;
                    }
                }
                if (cachedReversed && (prevTime != 0)) {
                    isComplete = true;
                }
            } else {
                cachedTotalTime = (cachedTime = time);
                ratio = _ease(time, 0, 1, cachedDuration);
            }
            if ((cachedTime == prevTime) && (!force)) {
                return(undefined);
            } else if (!initted) {
                init();
                if ((!isComplete) && (cachedTime)) {
                    ratio = _ease(cachedTime, 0, 1, cachedDuration);
                }
            }
            if ((!active) && (!cachedPaused)) {
                active = true;
            }
            if ((((prevTime == 0) && (vars.onStart)) && ((cachedTime != 0) || (cachedDuration == 0))) && (!suppressEvents)) {
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
            if (isComplete && (!gc)) {
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
            var p;
            var pt;
            var changed;
            for (p in vars) {
                if (propTweenLookup[p]) {
                    pt = propTweenLookup[p];
                    if (pt.isPlugin && (pt.name == "_MULTIPLE_")) {
                        pt.target.killProps(vars);
                        if (pt.target.overwriteProps.length == 0) {
                            pt.name = "";
                        }
                        if ((p != pt.target.propName) || (pt.name == "")) {
                            delete propTweenLookup[p];
                        }
                    }
                    if (pt.name != "_MULTIPLE_") {
                        if (pt.nextNode) {
                            pt.nextNode.prevNode = pt.prevNode;
                        }
                        if (pt.prevNode) {
                            pt.prevNode.nextNode = pt.nextNode;
                        } else if (cachedPT1 == pt) {
                            cachedPT1 = pt.nextNode;
                        }
                        if (pt.isPlugin && (pt.target.onDisable)) {
                            pt.target.onDisable();
                            if (pt.target.activeDisable) {
                                changed = true;
                            }
                        }
                        delete propTweenLookup[p];
                    }
                }
                if ((permanent != false) && (vars != _overwrittenProps)) {
                    _overwrittenProps[p] = 1;
                }
            }
            return(changed);
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
                var a = masterList[_targetID].tweens;
                if (a) {
                    var i = a.length;
                    a[i] = this;
                    while ((--i) > -1) {
                        if (a[i] == this) {
                            a.splice(i, 1);
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
                var ml = masterList;
                var i;
                var a;
                for (var p in ml) {
                    a = ml[p].tweens;
                    i = a.length;
                    while ((--i) > -1) {
                        if (a[i].gc) {
                            a.splice(i, 1);
                        }
                    }
                    if (a.length == 0) {
                        delete ml[p];
                    }
                }
            }
        }
        static function killTweensOf(target, complete, vars) {
            var id = getID(target, true);
            var a = masterList[id].tweens;
            var i;
            var tween;
            if (a != undefined) {
                i = a.length;
                while ((--i) > -1) {
                    tween = a[i];
                    if (!tween.gc) {
                        if (complete == true) {
                            tween.complete(false, false);
                        }
                        if (vars != undefined) {
                            tween.killVars(vars);
                        }
                        if ((vars == undefined) || ((tween.cachedPT1 == undefined) && (tween.initted))) {
                            tween.setEnabled(false, false);
                        }
                    }
                }
                if (vars == undefined) {
                    delete masterList[id];
                }
            }
        }
        static function getID(target, lookup) {
            var id;
            if (lookup) {
                var ml = masterList;
                if (typeof(target) == "movieclip") {
                    if (ml[String(target)] != undefined) {
                        return(String(target));
                    } else {
                        id = String(target);
                        masterList[id] = {target:target, tweens:[]};
                        return(id);
                    }
                } else {
                    for (var p in ml) {
                        if (ml[p].target == target) {
                            return(p);
                        }
                    }
                }
            }
            _cnt++;
            id = "t" + _cnt;
            masterList[id] = {target:target, tweens:[]};
            return(id);
        }
        static function easeOut(t, b, c, d) {
            return((-1 * ((t = t / d))) * (t - 2));
        }
        static function findSubloadedSWF(mc) {
            for (var p in mc) {
                if (typeof(mc[p]) == "movieclip") {
                    if ((mc[p]._url != _root._url) && (mc[p].getBytesLoaded() != undefined)) {
                        return(mc[p]);
                    } else if (findSubloadedSWF(mc[p]) != undefined) {
                        return(findSubloadedSWF(mc[p]));
                    }
                }
            }
            return(undefined);
        }
        static function jumpStart(root) {
            if (_timingClip != undefined) {
                _timingClip.removeMovieClip();
            }
            var mc = ((root.getBytesLoaded() == undefined) ? (findSubloadedSWF(root)) : (root));
            var l = 999;
            while (mc.getInstanceAtDepth(l) != undefined) {
                l++;
            }
            _timingClip = mc.createEmptyMovieClip("__tweenLite" + String(version).split(".").join("_"), l);
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
