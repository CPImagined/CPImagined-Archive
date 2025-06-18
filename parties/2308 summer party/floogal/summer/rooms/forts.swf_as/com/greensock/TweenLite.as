dynamic class com.greensock.TweenLite extends com.greensock.core.TweenCore
{
    static var version: Number = 11.691;
    static var plugins = {};
    static var killDelayedCallsTo = com.greensock.TweenLite.killTweensOf;
    static var defaultEase = com.greensock.TweenLite.easeOut;
    static var masterList = {};
    static var _cnt: Number = -16000;
    static var _reservedProps = {ease: 1, delay: 1, overwrite: 1, onComplete: 1, onCompleteParams: 1, useFrames: 1, runBackwards: 1, startAt: 1, onUpdate: 1, onUpdateParams: 1, onStart: 1, onStartParams: 1, onReverseComplete: 1, onReverseCompleteParams: 1, onRepeat: 1, onRepeatParams: 1, proxiedEase: 1, easeParams: 1, yoyo: 1, onCompleteListener: 1, onUpdateListener: 1, onStartListener: 1, orientToBezier: 1, timeScale: 1, immediateRender: 1, repeat: 1, repeatDelay: 1, timeline: 1, data: 1, paused: 1};
    var _ease;
    var _hasPlugins;
    var _hasUpdate;
    var _notifyPluginsOfEnabled;
    var _overwrite;
    var _overwrittenProps;
    var _rawPrevTime;
    var _targetID;
    var active;
    var cachedDuration;
    var cachedPT1;
    var cachedPaused;
    var cachedReversed;
    var cachedTime;
    var cachedTimeScale;
    var cachedTotalTime;
    var complete;
    var gc;
    var initted;
    var propTweenLookup;
    var ratio;
    var target;
    var vars;

    function TweenLite(target, duration, vars)
    {
        super(duration, vars);
        if (com.greensock.TweenLite._timingClip.onEnterFrame != com.greensock.TweenLite.updateAll) 
        {
            com.greensock.TweenLite.jumpStart(_root);
        }
        this.ratio = 0;
        this.target = target;
        this._targetID = com.greensock.TweenLite.getID(target, true);
        if (this.vars.timeScale != undefined && this.target instanceof com.greensock.core.TweenCore) 
        {
            this.cachedTimeScale = 1;
        }
        this.propTweenLookup = {};
        this._ease = com.greensock.TweenLite.defaultEase;
        this._overwrite = vars.overwrite == undefined || (!com.greensock.TweenLite.overwriteManager.enabled && vars.overwrite > 1) ? com.greensock.TweenLite.overwriteManager.mode : Number(vars.overwrite);
        var __reg5 = com.greensock.TweenLite.masterList[this._targetID].tweens;
        if (__reg5.length == 0) 
        {
            __reg5[0] = this;
        }
        else if (this._overwrite == 1) 
        {
            var __reg4 = __reg5.length;
            while (--__reg4 > -1) 
            {
                if (!__reg5[__reg4].gc) 
                {
                    __reg5[__reg4].setEnabled(false, false);
                }
            }
            com.greensock.TweenLite.masterList[this._targetID].tweens = [this];
        }
        else 
        {
            __reg5[__reg5.length] = this;
        }
        if (this.active || this.vars.immediateRender) 
        {
            this.renderTime(0, false, true);
        }
    }

    static function initClass()
    {
        com.greensock.TweenLite.rootFrame = 0;
        com.greensock.TweenLite.rootTimeline = new com.greensock.core.SimpleTimeline(null);
        com.greensock.TweenLite.rootFramesTimeline = new com.greensock.core.SimpleTimeline(null);
        com.greensock.TweenLite.rootTimeline.autoRemoveChildren = com.greensock.TweenLite.rootFramesTimeline.autoRemoveChildren = true;
        com.greensock.TweenLite.rootTimeline.cachedStartTime = getTimer() * 0.001;
        com.greensock.TweenLite.rootTimeline.cachedTotalTime = com.greensock.TweenLite.rootFramesTimeline.cachedTotalTime = 0;
        com.greensock.TweenLite.rootFramesTimeline.cachedStartTime = com.greensock.TweenLite.rootFrame;
        if (com.greensock.TweenLite.overwriteManager == undefined) 
        {
            com.greensock.TweenLite.overwriteManager = {mode: 1, enabled: false};
        }
        com.greensock.TweenLite.jumpStart(_root);
    }

    function init()
    {
        if (this.vars.onInit) 
        {
            this.vars.onInit.apply(null, this.vars.onInitParams);
        }
        var __reg2 = undefined;
        var __reg5 = undefined;
        var __reg3 = undefined;
        var __reg6 = undefined;
        var __reg7 = undefined;
        if (typeof this.vars.ease == "function") 
        {
            this._ease = this.vars.ease;
        }
        if (this.vars.easeParams != undefined) 
        {
            this.vars.proxiedEase = this._ease;
            this._ease = this.easeProxy;
        }
        this.cachedPT1 = undefined;
        this.propTweenLookup = {};
        for (__reg2 in this.vars) 
        {
            if (!(com.greensock.TweenLite._reservedProps[__reg2] && !(__reg2 == "timeScale" && this.target instanceof com.greensock.core.TweenCore))) 
            {
                if (com.greensock.TweenLite.plugins[__reg2] && (__reg3 = new com.greensock.TweenLite.plugins[__reg2]()).onInitTween(this.target, this.vars[__reg2], this)) 
                {
                    this.cachedPT1 = new com.greensock.core.PropTween(__reg3, "changeFactor", 0, 1, __reg3.overwriteProps.length == 1 ? __reg3.overwriteProps[0] : "_MULTIPLE_", true, this.cachedPT1);
                    if (this.cachedPT1.name == "_MULTIPLE_") 
                    {
                        __reg5 = __reg3.overwriteProps.length;
                        while (--__reg5 > -1) 
                        {
                            this.propTweenLookup[__reg3.overwriteProps[__reg5]] = this.cachedPT1;
                        }
                    }
                    else 
                    {
                        this.propTweenLookup[this.cachedPT1.name] = this.cachedPT1;
                    }
                    if (__reg3.priority) 
                    {
                        this.cachedPT1.priority = __reg3.priority;
                        __reg6 = true;
                    }
                    if (__reg3.onDisable || __reg3.onEnable) 
                    {
                        this._notifyPluginsOfEnabled = true;
                    }
                    this._hasPlugins = true;
                }
                else 
                {
                    this.cachedPT1 = new com.greensock.core.PropTween(this.target, __reg2, Number(this.target[__reg2]), typeof this.vars[__reg2] == "number" ? Number(this.vars[__reg2]) - this.target[__reg2] : Number(this.vars[__reg2]), __reg2, false, this.cachedPT1);
                    this.propTweenLookup[__reg2] = this.cachedPT1;
                }
            }
        }
        if (__reg6) 
        {
            com.greensock.TweenLite.onPluginEvent("onInitAllProps", this);
        }
        if (this.vars.runBackwards) 
        {
            var __reg4 = this.cachedPT1;
            while (__reg4) 
            {
                __reg4.start = __reg4.start + __reg4.change;
                __reg4.change = 0 - __reg4.change;
                __reg4 = __reg4.nextNode;
            }
        }
        this._hasUpdate = Boolean(typeof this.vars.onUpdate == "function");
        if (this._overwrittenProps) 
        {
            this.killVars(this._overwrittenProps);
            if (this.cachedPT1 == undefined) 
            {
                this.setEnabled(false, false);
            }
        }
        if (this._overwrite > 1 && this.cachedPT1 && (__reg7 = com.greensock.TweenLite.masterList[this._targetID].tweens) && __reg7.length > 1) 
        {
            if (com.greensock.TweenLite.overwriteManager.manageOverwrites(this, this.propTweenLookup, __reg7, this._overwrite)) 
            {
                this.init();
            }
        }
        this.initted = true;
    }

    function renderTime(time, suppressEvents, force)
    {
        var __reg4 = undefined;
        var __reg5 = this.cachedTime;
        if (time >= this.cachedDuration) 
        {
            this.cachedTotalTime = this.cachedTime = this.cachedDuration;
            this.ratio = 1;
            __reg4 = true;
            if (this.cachedDuration == 0) 
            {
                if ((time == 0 || this._rawPrevTime < 0) && this._rawPrevTime != time) 
                {
                    force = true;
                }
                this._rawPrevTime = time;
            }
        }
        else if (time <= 0) 
        {
            this.cachedTotalTime = this.cachedTime = this.ratio = 0;
            if (time < 0) 
            {
                this.active = false;
                if (this.cachedDuration == 0) 
                {
                    if (this._rawPrevTime >= 0) 
                    {
                        force = true;
                        __reg4 = true;
                    }
                    this._rawPrevTime = time;
                }
            }
            if (this.cachedReversed && __reg5 != 0) 
            {
                __reg4 = true;
            }
        }
        else 
        {
            this.cachedTotalTime = this.cachedTime = time;
            this.ratio = this._ease(time, 0, 1, this.cachedDuration);
        }
        if (this.cachedTime == __reg5 && !force) 
        {
            return undefined;
        }
        else if (!this.initted) 
        {
            this.init();
            if (!__reg4 && this.cachedTime) 
            {
                this.ratio = this._ease(this.cachedTime, 0, 1, this.cachedDuration);
            }
        }
        if (!this.active && !this.cachedPaused) 
        {
            this.active = true;
        }
        if (__reg5 == 0 && this.vars.onStart && this.cachedTime != 0 || this.cachedDuration == 0 && !suppressEvents) 
        {
            this.vars.onStart.apply(this.vars.onStartScope, this.vars.onStartParams);
        }
        var __reg2 = this.cachedPT1;
        while (__reg2) 
        {
            __reg2.target[__reg2.property] = __reg2.start + this.ratio * __reg2.change;
            __reg2 = __reg2.nextNode;
        }
        if (this._hasUpdate && !suppressEvents) 
        {
            this.vars.onUpdate.apply(this.vars.onUpdateScope, this.vars.onUpdateParams);
        }
        if (__reg4 && !this.gc) 
        {
            if (this._hasPlugins && this.cachedPT1) 
            {
                com.greensock.TweenLite.onPluginEvent("onComplete", this);
            }
            this.complete(true, suppressEvents);
        }
    }

    function killVars(vars, permanent)
    {
        if (this._overwrittenProps == undefined) 
        {
            this._overwrittenProps = {};
        }
        var __reg3 = undefined;
        var __reg2 = undefined;
        var __reg5 = undefined;
        for (__reg3 in vars) 
        {
            if (this.propTweenLookup[__reg3]) 
            {
                __reg2 = this.propTweenLookup[__reg3];
                if (__reg2.isPlugin && __reg2.name == "_MULTIPLE_") 
                {
                    __reg2.target.killProps(vars);
                    if (__reg2.target.overwriteProps.length == 0) 
                    {
                        __reg2.name = "";
                    }
                    if (__reg3 != __reg2.target.propName || __reg2.name == "") 
                    {
                        delete this.propTweenLookup[__reg3];
                    }
                }
                if (__reg2.name != "_MULTIPLE_") 
                {
                    if (__reg2.nextNode) 
                    {
                        __reg2.nextNode.prevNode = __reg2.prevNode;
                    }
                    if (__reg2.prevNode) 
                    {
                        __reg2.prevNode.nextNode = __reg2.nextNode;
                    }
                    else if (this.cachedPT1 == __reg2) 
                    {
                        this.cachedPT1 = __reg2.nextNode;
                    }
                    if (__reg2.isPlugin && __reg2.target.onDisable) 
                    {
                        __reg2.target.onDisable();
                        if (__reg2.target.activeDisable) 
                        {
                            __reg5 = true;
                        }
                    }
                    delete this.propTweenLookup[__reg3];
                }
            }
            if (permanent != false && vars != this._overwrittenProps) 
            {
                this._overwrittenProps[__reg3] = 1;
            }
        }
        return __reg5;
    }

    function invalidate()
    {
        if (this._notifyPluginsOfEnabled) 
        {
            com.greensock.TweenLite.onPluginEvent("onDisable", this);
        }
        this.cachedPT1 = undefined;
        this._overwrittenProps = undefined;
        this._hasUpdate = this.initted = this.active = this._notifyPluginsOfEnabled = false;
        this.propTweenLookup = {};
    }

    function setEnabled(enabled, ignoreTimeline)
    {
        if (enabled && this.gc) 
        {
            var __reg4 = com.greensock.TweenLite.masterList[this._targetID].tweens;
            if (__reg4) 
            {
                var __reg3 = __reg4.length;
                __reg4[__reg3] = this;
                while (--__reg3 > -1) 
                {
                    if (__reg4[__reg3] == this) 
                    {
                        __reg4.splice(__reg3, 1);
                    }
                }
            }
            else 
            {
                com.greensock.TweenLite.masterList[this._targetID] = {target: this.target, tweens: [this]};
            }
        }
        super.setEnabled(enabled, ignoreTimeline);
        if (this._notifyPluginsOfEnabled && this.cachedPT1) 
        {
            return com.greensock.TweenLite.onPluginEvent(enabled ? "onEnable" : "onDisable", this);
        }
        return false;
    }

    function easeProxy(t, b, c, d)
    {
        return this.vars.proxiedEase.apply(null, arguments.concat(this.vars.easeParams));
    }

    static function to(target, duration, vars)
    {
        return new com.greensock.TweenLite(target, duration, vars);
    }

    static function from(target, duration, vars)
    {
        vars.runBackwards = true;
        if (vars.immediateRender != false) 
        {
            vars.immediateRender = true;
        }
        return new com.greensock.TweenLite(target, duration, vars);
    }

    static function delayedCall(delay, onComplete, onCompleteParams, onCompleteScope, useFrames)
    {
        return new com.greensock.TweenLite(onComplete, 0, {delay: delay, onComplete: onComplete, onCompleteParams: onCompleteParams, onCompleteScope: onCompleteScope, immediateRender: false, useFrames: useFrames, overwrite: 0});
    }

    static function updateAll()
    {
        com.greensock.TweenLite.rootTimeline.renderTime((getTimer() * 0.001 - com.greensock.TweenLite.rootTimeline.cachedStartTime) * com.greensock.TweenLite.rootTimeline.cachedTimeScale, false, false);
        ++com.greensock.TweenLite.rootFrame;
        com.greensock.TweenLite.rootFramesTimeline.renderTime((com.greensock.TweenLite.rootFrame - com.greensock.TweenLite.rootFramesTimeline.cachedStartTime) * com.greensock.TweenLite.rootFramesTimeline.cachedTimeScale, false, false);
        if (com.greensock.TweenLite.rootFrame % 60) 
        {
            return;
        }
        var __reg3 = com.greensock.TweenLite.masterList;
        var __reg2 = undefined;
        var __reg1 = undefined;
        for (var __reg4 in __reg3) 
        {
            __reg1 = __reg3[__reg4].tweens;
            __reg2 = __reg1.length;
            while (--__reg2 > -1) 
            {
                if (__reg1[__reg2].gc) 
                {
                    __reg1.splice(__reg2, 1);
                }
            }
            if (__reg1.length == 0) 
            {
                delete __reg3[__reg4];
            }
        }
    }

    static function killTweensOf(target, complete, vars)
    {
        var __reg6 = com.greensock.TweenLite.getID(target, true);
        var __reg4 = com.greensock.TweenLite.masterList[__reg6].tweens;
        var __reg3 = undefined;
        var __reg1 = undefined;
        if (__reg4 != undefined) 
        {
            __reg3 = __reg4.length;
            while (--__reg3 > -1) 
            {
                __reg1 = __reg4[__reg3];
                if (!__reg1.gc) 
                {
                    if (complete == true) 
                    {
                        __reg1.complete(false, false);
                    }
                    if (vars != undefined) 
                    {
                        __reg1.killVars(vars);
                    }
                    if (vars == undefined || (__reg1.cachedPT1 == undefined && __reg1.initted)) 
                    {
                        __reg1.setEnabled(false, false);
                    }
                }
            }
            if (vars == undefined) 
            {
                delete com.greensock.TweenLite.masterList[__reg6];
            }
        }
    }

    static function getID(target, lookup)
    {
        var __reg2 = undefined;
        if (lookup) 
        {
            var __reg1 = com.greensock.TweenLite.masterList;
            if (typeof target == "movieclip") 
            {
                if (__reg1[String(target)] == undefined) 
                {
                    __reg2 = String(target);
                    com.greensock.TweenLite.masterList[__reg2] = {target: target, tweens: []};
                    return __reg2;
                }
                else 
                {
                    return String(target);
                }
            }
            else 
            {
                for (var __reg3 in __reg1) 
                {
                    if (__reg1[__reg3].target == target) 
                    {
                        do 
                        {
                        }
                        while (undefined != null);
                        return __reg3;
                    }
                }
            }
        }
        ++com.greensock.TweenLite._cnt;
        __reg2 = "t" + com.greensock.TweenLite._cnt;
        com.greensock.TweenLite.masterList[__reg2] = {target: target, tweens: []};
        return __reg2;
    }

    static function easeOut(t, b, c, d)
    {
        return -1 * (t = t / d) * (t - 2);
    }

    static function findSubloadedSWF(mc)
    {
        for (var __reg3 in mc) 
        {
            if (typeof mc[__reg3] == "movieclip") 
            {
                if (mc[__reg3]._url != _root._url && mc[__reg3].getBytesLoaded() != undefined) 
                {
                    do 
                    {
                    }
                    while (undefined != null);
                    return mc[__reg3];
                }
                else if (com.greensock.TweenLite.findSubloadedSWF(mc[__reg3]) != undefined) 
                {
                    do 
                    {
                    }
                    while (undefined != null);
                    return com.greensock.TweenLite.findSubloadedSWF(mc[__reg3]);
                }
            }
        }
        return undefined;
    }

    static function jumpStart(root)
    {
        if (com.greensock.TweenLite._timingClip != undefined) 
        {
            com.greensock.TweenLite._timingClip.removeMovieClip();
        }
        var __reg2 = root.getBytesLoaded() == undefined ? com.greensock.TweenLite.findSubloadedSWF(root) : root;
        var __reg1 = 999;
        while (__reg2.getInstanceAtDepth(__reg1) != undefined) 
        {
            ++__reg1;
        }
        com.greensock.TweenLite._timingClip = __reg2.createEmptyMovieClip("__tweenLite" + String(com.greensock.TweenLite.version).split(".").join("_"), __reg1);
        com.greensock.TweenLite._timingClip.onEnterFrame = com.greensock.TweenLite.updateAll;
        com.greensock.TweenLite.to({}, 0, {});
        com.greensock.TweenLite.rootTimeline.cachedTime = com.greensock.TweenLite.rootTimeline.cachedTotalTime = (getTimer() * 0.001 - com.greensock.TweenLite.rootTimeline.cachedStartTime) * com.greensock.TweenLite.rootTimeline.cachedTimeScale;
    }

}
