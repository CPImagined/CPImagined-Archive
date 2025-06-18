dynamic class com.greensock.core.SimpleTimeline extends com.greensock.core.TweenCore
{
    var _firstChild;
    var _lastChild;
    var cachedTime;
    var cachedTotalTime;

    function SimpleTimeline(vars)
    {
        super(0, vars);
    }

    function insert(tween, time)
    {
        if (time == undefined) 
        {
            time = 0;
        }
        var __reg3 = tween.timeline;
        if (!tween.cachedOrphan && __reg3) 
        {
            __reg3.remove(tween, true);
        }
        tween.timeline = this;
        tween.cachedStartTime = Number(time) + tween.__get__delay();
        if (tween.gc) 
        {
            tween.setEnabled(true, true);
        }
        if (tween.cachedPaused && __reg3 != this) 
        {
            tween.cachedPauseTime = tween.cachedStartTime + (this.__get__rawTime() - tween.cachedStartTime) / tween.cachedTimeScale;
        }
        if (this._lastChild) 
        {
            this._lastChild.nextNode = tween;
        }
        else 
        {
            this._firstChild = tween;
        }
        tween.prevNode = this._lastChild;
        this._lastChild = tween;
        tween.nextNode = undefined;
        tween.cachedOrphan = false;
        return tween;
    }

    function remove(tween, skipDisable)
    {
        if (tween.cachedOrphan) 
        {
            return undefined;
        }
        else if (skipDisable != true) 
        {
            tween.setEnabled(false, true);
        }
        if (tween.nextNode) 
        {
            tween.nextNode.prevNode = tween.prevNode;
        }
        else if (this._lastChild == tween) 
        {
            this._lastChild = tween.prevNode;
        }
        if (tween.prevNode) 
        {
            tween.prevNode.nextNode = tween.nextNode;
        }
        else if (this._firstChild == tween) 
        {
            this._firstChild = tween.nextNode;
        }
        tween.cachedOrphan = true;
    }

    function renderTime(time, suppressEvents, force)
    {
        var __reg2 = this._firstChild;
        var __reg4 = undefined;
        var __reg5 = undefined;
        this.cachedTotalTime = time;
        this.cachedTime = time;
        for (;;) 
        {
            if (!__reg2) 
            {
                return;
            }
            __reg5 = __reg2.nextNode;
            if (__reg2.active || (time >= __reg2.cachedStartTime && !__reg2.cachedPaused && !__reg2.gc)) 
            {
                if (__reg2.cachedReversed) 
                {
                    __reg4 = __reg2.cacheIsDirty ? __reg2.__get__totalDuration() : __reg2.cachedTotalDuration;
                    __reg2.renderTime(__reg4 - (time - __reg2.cachedStartTime) * __reg2.cachedTimeScale, suppressEvents, false);
                }
                else 
                {
                    __reg2.renderTime((time - __reg2.cachedStartTime) * __reg2.cachedTimeScale, suppressEvents, false);
                }
            }
            __reg2 = __reg5;
        }
    }

    function get rawTime()
    {
        return this.cachedTotalTime;
    }

}
