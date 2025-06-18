dynamic class com.greensock.TweenMax extends com.greensock.TweenLite
{
    static var version: Number = 11.691;
    static var _activatedPlugins = com.greensock.plugins.TweenPlugin.activate([com.greensock.plugins.AutoAlphaPlugin, com.greensock.plugins.EndArrayPlugin, com.greensock.plugins.FramePlugin, com.greensock.plugins.RemoveTintPlugin, com.greensock.plugins.TintPlugin, com.greensock.plugins.VisiblePlugin, com.greensock.plugins.VolumePlugin, com.greensock.plugins.BevelFilterPlugin, com.greensock.plugins.BezierPlugin, com.greensock.plugins.BezierThroughPlugin, com.greensock.plugins.BlurFilterPlugin, com.greensock.plugins.ColorMatrixFilterPlugin, com.greensock.plugins.ColorTransformPlugin, com.greensock.plugins.DropShadowFilterPlugin, com.greensock.plugins.FrameLabelPlugin, com.greensock.plugins.GlowFilterPlugin, com.greensock.plugins.HexColorsPlugin, com.greensock.plugins.RoundPropsPlugin, com.greensock.plugins.ShortRotationPlugin, {}]);
    static var _overwriteMode = com.greensock.OverwriteManager.enabled ? com.greensock.OverwriteManager.mode : com.greensock.OverwriteManager.init(2);
    static var killTweensOf = com.greensock.TweenLite.killTweensOf;
    static var killDelayedCallsTo = com.greensock.TweenLite.killTweensOf;
    var _cyclesComplete;
    var _delay;
    var _ease;
    var _hasPlugins;
    var _hasUpdate;
    var _notifyPluginsOfEnabled;
    var _rawPrevTime;
    var _repeat;
    var _repeatDelay;
    var active;
    var cacheIsDirty;
    var cachedDuration;
    var cachedPT1;
    var cachedPauseTime;
    var cachedPaused;
    var cachedReversed;
    var cachedStartTime;
    var cachedTime;
    var cachedTimeScale;
    var cachedTotalDuration;
    var cachedTotalTime;
    var complete;
    var gc;
    var initted;
    var killVars;
    var ratio;
    var setDirtyCache;
    var setEnabled;
    var setTotalTime;
    var target;
    var timeline;
    var vars;
    var yoyo;

    function TweenMax(target, duration, vars)
    {
        super(target, duration, vars);
        if (com.greensock.TweenLite.version < 11.2) 
        {
            trace("TweenMax warning: Please update your TweenLite class or try deleting your ASO files. TweenMax requires a more recent version. Download updates at http://www.TweenMax.com.");
        }
        this._cyclesComplete = 0;
        this.yoyo = Boolean(this.vars.yoyo);
        this._repeat = this.vars.repeat || 0;
        this._repeatDelay = this.vars.repeatDelay || 0;
        this.cacheIsDirty = true;
        if (this.vars.timeScale != undefined && !(this.target instanceof com.greensock.core.TweenCore)) 
        {
            this.cachedTimeScale = this.vars.timeScale;
        }
    }

    function init()
    {
        if (this.vars.startAt) 
        {
            this.vars.startAt.overwrite = 0;
            this.vars.startAt.immediateRender = true;
            var __reg3 = new com.greensock.TweenMax(this.target, 0, this.vars.startAt);
        }
        super.init();
    }

    function invalidate()
    {
        this.yoyo = Boolean(this.vars.yoyo);
        this._repeat = this.vars.repeat || 0;
        this._repeatDelay = this.vars.repeatDelay || 0;
        this.setDirtyCache(true);
        super.invalidate();
    }

    function updateTo(vars, resetDuration)
    {
        var __reg7 = this.ratio;
        if (resetDuration && this.timeline != undefined && this.cachedStartTime < this.timeline.cachedTime) 
        {
            this.cachedStartTime = this.timeline.cachedTime;
            this.setDirtyCache(false);
            if (this.gc) 
            {
                this.setEnabled(true, false);
            }
            else 
            {
                this.timeline.insert(this, this.cachedStartTime - this._delay);
            }
        }
        for (var __reg6 in vars) 
        {
            this.vars[__reg6] = vars[__reg6];
        }
        if (this.initted) 
        {
            if (resetDuration) 
            {
                this.initted = false;
                return;
            }
            if (this._notifyPluginsOfEnabled && this.cachedPT1) 
            {
                com.greensock.TweenLite.onPluginEvent("onDisable", this);
            }
            if (this.cachedTime / this.cachedDuration > 0.998) 
            {
                var __reg8 = this.cachedTime;
                this.renderTime(0, true, false);
                this.initted = false;
                this.renderTime(__reg8, true, false);
                return;
            }
            if (this.cachedTime > 0) 
            {
                this.initted = false;
                this.init();
                var __reg5 = 1 / (1 - __reg7);
                var __reg2 = this.cachedPT1;
                var __reg3 = undefined;
                for (;;) 
                {
                    if (!__reg2) 
                    {
                        return;
                    }
                    __reg3 = __reg2.start + __reg2.change;
                    __reg2.change = __reg2.change * __reg5;
                    __reg2.start = __reg3 - __reg2.change;
                    __reg2 = __reg2.nextNode;
                }
            }
        }
    }

    function setDestination(property, value, adjustStartValues)
    {
        var __reg2 = {};
        __reg2[property] = value;
        this.updateTo(__reg2, Boolean(adjustStartValues != false));
    }

    function killProperties(names)
    {
        var __reg3 = {};
        var __reg2 = names.length;
        while (--__reg2 > -1) 
        {
            __reg3[names[__reg2]] = true;
        }
        this.killVars(__reg3);
    }

    function renderTime(time, suppressEvents, force)
    {
        var __reg9 = this.cacheIsDirty ? this.__get__totalDuration() : this.cachedTotalDuration;
        var __reg7 = this.cachedTotalTime;
        var __reg5 = undefined;
        var __reg11 = undefined;
        var __reg6 = undefined;
        if (time >= __reg9) 
        {
            this.cachedTotalTime = __reg9;
            this.cachedTime = this.cachedDuration;
            this.ratio = 1;
            __reg5 = true;
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
            if (time < 0) 
            {
                this.active = false;
                if (this.cachedDuration == 0) 
                {
                    if (this._rawPrevTime >= 0) 
                    {
                        force = true;
                        __reg5 = true;
                    }
                    this._rawPrevTime = time;
                }
            }
            else if (time == 0 && !this.initted) 
            {
                force = true;
            }
            this.cachedTotalTime = this.cachedTime = this.ratio = 0;
            if (this.cachedReversed && __reg7 != 0) 
            {
                __reg5 = true;
            }
        }
        else 
        {
            this.cachedTotalTime = this.cachedTime = time;
            __reg6 = true;
        }
        if (this._repeat != 0) 
        {
            var __reg4 = this.cachedDuration + this._repeatDelay;
            var __reg12 = this._cyclesComplete;
            this._cyclesComplete = this.cachedTotalTime / __reg4 >> 0;
            if (this._cyclesComplete == this.cachedTotalTime / __reg4) 
            {
                --this._cyclesComplete;
            }
            if (__reg12 != this._cyclesComplete) 
            {
                __reg11 = true;
            }
            if (__reg5) 
            {
                if (this.yoyo && this._repeat % 2) 
                {
                    this.cachedTime = this.ratio = 0;
                }
            }
            else if (time > 0) 
            {
                this.cachedTime = (this.cachedTotalTime / __reg4 - this._cyclesComplete) * __reg4;
                if (this.yoyo && this._cyclesComplete % 2) 
                {
                    this.cachedTime = this.cachedDuration - this.cachedTime;
                }
                else if (this.cachedTime >= this.cachedDuration) 
                {
                    this.cachedTime = this.cachedDuration;
                    this.ratio = 1;
                    __reg6 = false;
                }
                if (this.cachedTime <= 0) 
                {
                    this.cachedTime = this.ratio = 0;
                    __reg6 = false;
                }
            }
            else 
            {
                this._cyclesComplete = 0;
            }
        }
        if (__reg7 == this.cachedTotalTime && !force) 
        {
            return undefined;
        }
        else if (!this.initted) 
        {
            this.init();
        }
        if (!this.active && !this.cachedPaused) 
        {
            this.active = true;
        }
        if (__reg6) 
        {
            this.ratio = this._ease(this.cachedTime, 0, 1, this.cachedDuration);
        }
        if (__reg7 == 0 && this.vars.onStart && this.cachedTotalTime != 0 || this.cachedDuration == 0 && !suppressEvents) 
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
        if (__reg11 && !suppressEvents && !this.gc) 
        {
            if (this.vars.onRepeat) 
            {
                this.vars.onRepeat.apply(this.vars.onRepeatScope, this.vars.onRepeatParams);
            }
        }
        if (__reg5 && !this.gc) 
        {
            if (this._hasPlugins && this.cachedPT1) 
            {
                com.greensock.TweenLite.onPluginEvent("onComplete", this);
            }
            this.complete(true, suppressEvents);
        }
    }

    static function to(target, duration, vars)
    {
        return new com.greensock.TweenMax(target, duration, vars);
    }

    static function from(target, duration, vars)
    {
        vars.runBackwards = true;
        if (vars.immediateRender != false) 
        {
            vars.immediateRender = true;
        }
        return new com.greensock.TweenMax(target, duration, vars);
    }

    static function fromTo(target, duration, fromVars, toVars)
    {
        toVars.startAt = fromVars;
        if (fromVars.immediateRender) 
        {
            toVars.immediateRender = true;
        }
        return new com.greensock.TweenMax(target, duration, toVars);
    }

    static function allTo(targets, duration, vars, stagger, onCompleteAll, onCompleteAllParams, onCompleteAllScope)
    {
        var __reg2 = undefined;
        var __reg3 = undefined;
        var __reg1 = undefined;
        if (stagger == undefined) 
        {
            stagger = 0;
        }
        var __reg7 = targets.length;
        var __reg6 = [];
        var __reg5 = vars.delay || 0;
        var onCompleteProxy = vars.onComplete;
        var onCompleteParamsProxy = vars.onCompleteParams;
        var onCompleteScopeProxy = vars.onCompleteScope;
        var __reg9 = __reg7 - 1;
        __reg2 = 0;
        while (__reg2 < __reg7) 
        {
            __reg3 = {};
            for (__reg1 in vars) 
            {
                __reg3[__reg1] = vars[__reg1];
            }
            __reg3.delay = __reg5;
            if (__reg2 == __reg9 && onCompleteAll != undefined) 
            {
                __reg3.onComplete = function ()
                {
                    if (onCompleteProxy != undefined) 
                    {
                        onCompleteProxy.apply(onCompleteScopeProxy, onCompleteParamsProxy);
                    }
                    onCompleteAll.apply(onCompleteAllScope, onCompleteAllParams);
                }
                ;
            }
            __reg6[__reg2] = new com.greensock.TweenMax(targets[__reg2], duration, __reg3);
            __reg5 = __reg5 + stagger;
            ++__reg2;
        }
        return __reg6;
    }

    static function allFrom(targets, duration, vars, stagger, onCompleteAll, onCompleteAllParams, onCompleteAllScope)
    {
        vars.runBackwards = true;
        if (vars.immediateRender != false) 
        {
            vars.immediateRender = true;
        }
        return com.greensock.TweenMax.allTo(targets, duration, vars, stagger, onCompleteAll, onCompleteAllParams, onCompleteAllScope);
    }

    static function allFromTo(targets, duration, fromVars, toVars, stagger, onCompleteAll, onCompleteAllParams, onCompleteAllScope)
    {
        toVars.startAt = fromVars;
        if (fromVars.immediateRender) 
        {
            toVars.immediateRender = true;
        }
        return com.greensock.TweenMax.allTo(targets, duration, toVars, stagger, onCompleteAll, onCompleteAllParams, onCompleteAllScope);
    }

    static function delayedCall(delay, onComplete, onCompleteParams, onCompleteScope, useFrames)
    {
        return new com.greensock.TweenMax(onComplete, 0, {delay: delay, onComplete: onComplete, onCompleteParams: onCompleteParams, onCompleteScope: onCompleteScope, immediateRender: false, useFrames: useFrames, overwrite: 0});
    }

    static function getTweensOf(target)
    {
        var __reg2 = com.greensock.TweenLite.masterList[target].tweens;
        var __reg3 = [];
        if (__reg2) 
        {
            var __reg1 = __reg2.length;
            while (--__reg1 > -1) 
            {
                if (!__reg2[__reg1].gc) 
                {
                    __reg3[__reg3.length] = __reg2[__reg1];
                }
            }
        }
        return __reg3;
    }

    static function isTweening(target)
    {
        var __reg3 = com.greensock.TweenMax.getTweensOf(target);
        var __reg2 = __reg3.length;
        var __reg1 = undefined;
        while (--__reg2 > -1) 
        {
            __reg1 = __reg3[__reg2];
            if (__reg1.active || (__reg1.cachedStartTime == __reg1.timeline.cachedTime && __reg1.timeline.active)) 
            {
                return true;
            }
        }
        return false;
    }

    static function getAllTweens()
    {
        var __reg5 = com.greensock.TweenLite.masterList;
        var __reg4 = 0;
        var __reg3 = [];
        var __reg2 = undefined;
        var __reg1 = undefined;
        for (var __reg6 in __reg5) 
        {
            __reg2 = __reg5[__reg6].tweens;
            __reg1 = __reg2.length;
            while (--__reg1 > -1) 
            {
                if (!__reg2[__reg1].gc) 
                {
                    __reg3[__reg4++] = __reg2[__reg1];
                }
            }
        }
        return __reg3;
    }

    static function killAll(complete, tweens, delayedCalls)
    {
        if (tweens == undefined) 
        {
            tweens = true;
        }
        if (delayedCalls == undefined) 
        {
            delayedCalls = true;
        }
        var __reg2 = com.greensock.TweenMax.getAllTweens();
        var __reg3 = undefined;
        var __reg1 = __reg2.length;
        for (;;) 
        {
            if (--__reg1 <= -1) 
            {
                return;
            }
            __reg3 = __reg2[__reg1].target == __reg2[__reg1].vars.onComplete;
            if (__reg3 == delayedCalls || __reg3 != tweens) 
            {
                if (complete == true) 
                {
                    __reg2[__reg1].complete(false, false);
                }
                else 
                {
                    __reg2[__reg1].setEnabled(false, false);
                }
            }
        }
    }

    static function killChildTweensOf(parent, complete)
    {
        var __reg3 = com.greensock.TweenMax.getAllTweens();
        var __reg4 = undefined;
        var __reg1 = undefined;
        var __reg2 = __reg3.length;
        for (;;) 
        {
            if (--__reg2 <= -1) 
            {
                return;
            }
            __reg4 = __reg3[__reg2].target;
            if (__reg4 instanceof MovieClip) 
            {
                __reg1 = __reg4._parent;
                while (__reg1) 
                {
                    if (__reg1 == parent) 
                    {
                        if (complete == true) 
                        {
                            __reg3[__reg2].complete(false, false);
                        }
                        else 
                        {
                            __reg3[__reg2].setEnabled(false, false);
                        }
                    }
                    __reg1 = __reg1._parent;
                }
            }
        }
    }

    static function pauseAll(tweens, delayedCalls)
    {
        com.greensock.TweenMax.changePause(true, tweens, delayedCalls);
    }

    static function resumeAll(tweens, delayedCalls)
    {
        com.greensock.TweenMax.changePause(false, tweens, delayedCalls);
    }

    static function changePause(pause, tweens, delayedCalls)
    {
        if (tweens == undefined) 
        {
            tweens = true;
        }
        if (delayedCalls == undefined) 
        {
            delayedCalls = true;
        }
        var __reg2 = com.greensock.TweenMax.getAllTweens();
        var __reg3 = undefined;
        var __reg1 = __reg2.length;
        for (;;) 
        {
            if (--__reg1 <= -1) 
            {
                return;
            }
            __reg3 = Boolean(__reg2[__reg1].target == __reg2[__reg1].vars.onComplete);
            if (__reg3 == delayedCalls || __reg3 != tweens) 
            {
                __reg2[__reg1].paused = pause;
            }
        }
    }

    function get currentProgress()
    {
        return this.cachedTime / this.__get__duration();
    }

    function set currentProgress(n)
    {
        if (this._cyclesComplete == 0) 
        {
            this.setTotalTime(this.__get__duration() * n, false);
        }
        else 
        {
            this.setTotalTime(this.__get__duration() * n + this._cyclesComplete * this.cachedDuration, false);
        }
    }

    function get totalProgress()
    {
        return this.cachedTotalTime / this.__get__totalDuration();
    }

    function set totalProgress(n)
    {
        this.setTotalTime(this.__get__totalDuration() * n, false);
    }

    function get currentTime()
    {
        return this.cachedTime;
    }

    function set currentTime(n)
    {
        if (this._cyclesComplete != 0) 
        {
            if (this.yoyo && this._cyclesComplete % 2 == 1) 
            {
                n = this.__get__duration() - n + this._cyclesComplete * (this.cachedDuration + this._repeatDelay);
            }
            else 
            {
                n = n + this._cyclesComplete * (this.__get__duration() + this._repeatDelay);
            }
        }
        this.setTotalTime(n, false);
    }

    function get totalDuration()
    {
        if (this.cacheIsDirty) 
        {
            this.cachedTotalDuration = this._repeat == -1 ? 999999999999 : this.cachedDuration * (this._repeat + 1) + this._repeatDelay * this._repeat;
            this.cacheIsDirty = false;
        }
        return this.cachedTotalDuration;
    }

    function set totalDuration(n)
    {
        if (this._repeat != -1) 
        {
            this.__set__duration((n - this._repeat * this._repeatDelay) / (this._repeat + 1));
            return;
        }
    }

    function get timeScale()
    {
        return this.cachedTimeScale;
    }

    function set timeScale(n)
    {
        if (n == 0) 
        {
            n = 0.0001;
        }
        var __reg3 = this.cachedPauseTime || this.cachedPauseTime == 0 ? this.cachedPauseTime : this.timeline.cachedTotalTime;
        this.cachedStartTime = __reg3 - (__reg3 - this.cachedStartTime) * this.cachedTimeScale / n;
        this.cachedTimeScale = n;
        this.setDirtyCache(false);
    }

    function get repeat()
    {
        return this._repeat;
    }

    function set repeat(n)
    {
        this._repeat = n;
        this.setDirtyCache(true);
    }

    function get repeatDelay()
    {
        return this._repeatDelay;
    }

    function set repeatDelay(n)
    {
        this._repeatDelay = n;
        this.setDirtyCache(true);
    }

    static function get globalTimeScale()
    {
        return com.greensock.TweenLite.rootTimeline == undefined ? 1 : com.greensock.TweenLite.rootTimeline.cachedTimeScale;
    }

    static function set globalTimeScale(n)
    {
        if (n == 0) 
        {
            n = 0.0001;
        }
        if (com.greensock.TweenLite.rootTimeline == undefined) 
        {
            com.greensock.TweenLite.to({}, 0, {});
        }
        var __reg1 = com.greensock.TweenLite.rootTimeline;
        var __reg2 = getTimer() * 0.001;
        __reg1.cachedStartTime = __reg2 - (__reg2 - __reg1.cachedStartTime) * __reg1.cachedTimeScale / n;
        __reg1 = com.greensock.TweenLite.rootFramesTimeline;
        __reg2 = com.greensock.TweenLite.rootFrame;
        __reg1.cachedStartTime = __reg2 - (__reg2 - __reg1.cachedStartTime) * __reg1.cachedTimeScale / n;
        com.greensock.TweenLite.rootFramesTimeline.cachedTimeScale = com.greensock.TweenLite.rootTimeline.cachedTimeScale = n;
    }

}
