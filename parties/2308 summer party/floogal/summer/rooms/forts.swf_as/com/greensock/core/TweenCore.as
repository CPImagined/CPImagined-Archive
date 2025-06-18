dynamic class com.greensock.core.TweenCore
{
    static var version: Number = 1.691;
    var _delay;
    var _rawPrevTime;
    var active;
    var cacheIsDirty;
    var cachedDuration;
    var cachedOrphan;
    var cachedPauseTime;
    var cachedPaused;
    var cachedReversed;
    var cachedStartTime;
    var cachedTime;
    var cachedTimeScale;
    var cachedTotalDuration;
    var cachedTotalTime;
    var data;
    var gc;
    var initted;
    var timeline;
    var vars;

    function TweenCore(duration, vars)
    {
        this.vars = vars || {};
        this.cachedDuration = this.cachedTotalDuration = duration || 0;
        this._delay = Number(this.vars.delay) || 0;
        this.cachedTimeScale = this.vars.timeScale || 1;
        this.active = Boolean(duration == 0 && this._delay == 0 && this.vars.immediateRender != false);
        this.cachedTotalTime = this.cachedTime = 0;
        this.data = this.vars.data;
        this.gc = this.initted = this.cacheIsDirty = this.cachedPaused = this.cachedReversed = false;
        this._rawPrevTime = -1;
        if (!com.greensock.core.TweenCore._classInitted) 
        {
            if (com.greensock.TweenLite.rootFrame == undefined && com.greensock.TweenLite.initClass != undefined) 
            {
                com.greensock.TweenLite.initClass();
                com.greensock.core.TweenCore._classInitted = true;
            }
            else 
            {
                return;
            }
        }
        var __reg2 = this.vars.timeline instanceof com.greensock.core.SimpleTimeline ? this.vars.timeline : (this.vars.useFrames == true ? com.greensock.TweenLite.rootFramesTimeline : com.greensock.TweenLite.rootTimeline);
        __reg2.insert(this, __reg2.cachedTotalTime);
        if (this.vars.reversed) 
        {
            this.cachedReversed = true;
        }
        if (this.vars.paused) 
        {
            this.__set__paused(true);
        }
    }

    function play()
    {
        this.__set__reversed(false);
        this.__set__paused(false);
    }

    function pause()
    {
        this.__set__paused(true);
    }

    function resume()
    {
        this.__set__paused(false);
    }

    function restart(includeDelay, suppressEvents)
    {
        this.__set__reversed(false);
        this.__set__paused(false);
        this.setTotalTime(includeDelay ? 0 - this._delay : 0, Boolean(suppressEvents != false));
    }

    function reverse(forceResume)
    {
        this.__set__reversed(true);
        if (forceResume != false) 
        {
            this.__set__paused(false);
            return;
        }
        if (this.gc) 
        {
            this.setEnabled(true, false);
        }
    }

    function renderTime(time, suppressEvents, force)
    {
    }

    function complete(skipRender, suppressEvents)
    {
        if (!skipRender) 
        {
            this.renderTime(this.__get__totalDuration(), suppressEvents, false);
            return undefined;
        }
        if (this.timeline.autoRemoveChildren) 
        {
            this.setEnabled(false, false);
        }
        else 
        {
            this.active = false;
        }
        if (suppressEvents) 
        {
            return;
        }
        if (this.vars.onComplete && this.cachedTotalTime >= this.cachedTotalDuration && !this.cachedReversed) 
        {
            this.vars.onComplete.apply(this.vars.onCompleteScope, this.vars.onCompleteParams);
            return;
        }
        if (this.cachedReversed && this.cachedTotalTime == 0 && this.vars.onReverseComplete) 
        {
            this.vars.onReverseComplete.apply(this.vars.onReverseCompleteScope, this.vars.onReverseCompleteParams);
        }
    }

    function invalidate()
    {
    }

    function setEnabled(enabled, ignoreTimeline)
    {
        this.gc = !enabled;
        if (enabled) 
        {
            this.active = Boolean(!this.cachedPaused && this.cachedTotalTime > 0 && this.cachedTotalTime < this.cachedTotalDuration);
            if (ignoreTimeline != true && this.cachedOrphan) 
            {
                this.timeline.insert(this, this.cachedStartTime - this._delay);
            }
        }
        else 
        {
            this.active = false;
            if (ignoreTimeline != true && !this.cachedOrphan) 
            {
                this.timeline.remove(this, true);
            }
        }
        return false;
    }

    function kill()
    {
        this.setEnabled(false, false);
    }

    function setDirtyCache(includeSelf)
    {
        var __reg2 = includeSelf == false ? this.timeline : this;
        for (;;) 
        {
            if (!__reg2) 
            {
                return;
            }
            __reg2.cacheIsDirty = true;
            __reg2 = __reg2.timeline;
        }
    }

    function setTotalTime(time, suppressEvents)
    {
        if (this.timeline) 
        {
            var __reg3 = this.cachedPaused ? this.cachedPauseTime : this.timeline.cachedTotalTime;
            if (this.cachedReversed) 
            {
                var __reg4 = this.cacheIsDirty ? this.__get__totalDuration() : this.cachedTotalDuration;
                this.cachedStartTime = __reg3 - (__reg4 - time) / this.cachedTimeScale;
            }
            else 
            {
                this.cachedStartTime = __reg3 - time / this.cachedTimeScale;
            }
            if (!this.timeline.cacheIsDirty) 
            {
                this.setDirtyCache(false);
            }
            if (this.cachedTotalTime != time) 
            {
                this.renderTime(time, suppressEvents, false);
            }
        }
    }

    function get delay()
    {
        return this._delay;
    }

    function set delay(n)
    {
        this.startTime = this.startTime + (n - this._delay);
        this._delay = n;
    }

    function get duration()
    {
        return this.cachedDuration;
    }

    function set duration(n)
    {
        var __reg2 = n / this.cachedDuration;
        this.cachedDuration = this.cachedTotalDuration = n;
        if (this.active && !this.cachedPaused && n != 0) 
        {
            this.setTotalTime(this.cachedTotalTime * __reg2, true);
        }
        this.setDirtyCache(false);
    }

    function get totalDuration()
    {
        return this.cachedTotalDuration;
    }

    function set totalDuration(n)
    {
        this.__set__duration(n);
    }

    function get currentTime()
    {
        return this.cachedTime;
    }

    function set currentTime(n)
    {
        this.setTotalTime(n, false);
    }

    function get totalTime()
    {
        return this.cachedTotalTime;
    }

    function set totalTime(n)
    {
        this.setTotalTime(n, false);
    }

    function get startTime()
    {
        return this.cachedStartTime;
    }

    function set startTime(n)
    {
        if (this.timeline != undefined && (n != this.cachedStartTime || this.gc)) 
        {
            this.timeline.insert(this, n - this._delay);
        }
        else 
        {
            this.cachedStartTime = n;
        }
    }

    function get reversed()
    {
        return this.cachedReversed;
    }

    function set reversed(b)
    {
        if (b != this.cachedReversed) 
        {
            this.cachedReversed = b;
            this.setTotalTime(this.cachedTotalTime, true);
        }
    }

    function get paused()
    {
        return this.cachedPaused;
    }

    function set paused(b)
    {
        if (b != this.cachedPaused && this.timeline) 
        {
            if (b) 
            {
                this.cachedPauseTime = this.timeline.rawTime;
            }
            else 
            {
                this.cachedStartTime = this.cachedStartTime + (this.timeline.__get__rawTime() - this.cachedPauseTime);
                this.cachedPauseTime = NaN;
                this.setDirtyCache(false);
            }
            this.cachedPaused = b;
            this.active = Boolean(!this.cachedPaused && this.cachedTotalTime > 0 && this.cachedTotalTime < this.cachedTotalDuration);
        }
        if (!b && this.gc) 
        {
            this.setEnabled(true, false);
        }
    }

}
