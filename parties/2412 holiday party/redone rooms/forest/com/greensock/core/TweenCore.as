//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.greensock.core.TweenCore
    {
        static var _classInitted;
        var vars, cachedDuration, cachedTotalDuration, _delay, cachedTimeScale, active, cachedTotalTime, cachedTime, data, gc, initted, cacheIsDirty, cachedPaused, cachedReversed, _rawPrevTime, timeline, cachedOrphan, cachedStartTime, cachedPauseTime;
        function TweenCore (duration, vars) {
            this.vars = vars || ({});
            cachedDuration = (cachedTotalDuration = duration || 0);
            _delay = Number(this.vars.delay) || 0;
            cachedTimeScale = this.vars.timeScale || 1;
            active = Boolean(((duration == 0) && (_delay == 0)) && (this.vars.immediateRender != false));
            cachedTotalTime = (cachedTime = 0);
            data = this.vars.data;
            gc = (initted = (cacheIsDirty = (cachedPaused = (cachedReversed = false))));
            _rawPrevTime = -1;
            if (!_classInitted) {
                if ((com.greensock.TweenLite.rootFrame == undefined) && (com.greensock.TweenLite.initClass != undefined)) {
                    com.greensock.TweenLite.initClass();
                    _classInitted = true;
                } else {
                    return;
                }
            }
            var tl = ((this.vars.timeline instanceof com.greensock.core.SimpleTimeline) ? (this.vars.timeline) : (((this.vars.useFrames == true) ? (com.greensock.TweenLite.rootFramesTimeline) : (com.greensock.TweenLite.rootTimeline))));
            tl.insert(this, tl.cachedTotalTime);
            if (this.vars.reversed) {
                cachedReversed = true;
            }
            if (this.vars.paused) {
                paused = (true);
            }
        }
        function play() {
            reversed = (false);
            paused = (false);
        }
        function pause() {
            paused = (true);
        }
        function resume() {
            paused = (false);
        }
        function restart(includeDelay, suppressEvents) {
            reversed = (false);
            paused = (false);
            setTotalTime((includeDelay ? (-_delay) : 0), Boolean(suppressEvents != false));
        }
        function reverse(forceResume) {
            reversed = (true);
            if (forceResume != false) {
                paused = (false);
            } else if (gc) {
                setEnabled(true, false);
            }
        }
        function renderTime(time, suppressEvents, force) {
        }
        function complete(skipRender, suppressEvents) {
            if (!skipRender) {
                renderTime(totalDuration, suppressEvents, false);
                return(undefined);
            }
            if (timeline.autoRemoveChildren) {
                setEnabled(false, false);
            } else {
                active = false;
            }
            if (!suppressEvents) {
                if ((vars.onComplete && (cachedTotalTime >= cachedTotalDuration)) && (!cachedReversed)) {
                    vars.onComplete.apply(vars.onCompleteScope, vars.onCompleteParams);
                } else if ((cachedReversed && (cachedTotalTime == 0)) && (vars.onReverseComplete)) {
                    vars.onReverseComplete.apply(vars.onReverseCompleteScope, vars.onReverseCompleteParams);
                }
            }
        }
        function invalidate() {
        }
        function setEnabled(enabled, ignoreTimeline) {
            gc = !enabled;
            if (enabled) {
                active = Boolean(((!cachedPaused) && (cachedTotalTime > 0)) && (cachedTotalTime < cachedTotalDuration));
                if ((ignoreTimeline != true) && (cachedOrphan)) {
                    timeline.insert(this, cachedStartTime - _delay);
                }
            } else {
                active = false;
                if ((ignoreTimeline != true) && (!cachedOrphan)) {
                    timeline.remove(this, true);
                }
            }
            return(false);
        }
        function kill() {
            setEnabled(false, false);
        }
        function setDirtyCache(includeSelf) {
            var tween = ((includeSelf != false) ? (this) : (timeline));
            while (tween) {
                tween.cacheIsDirty = true;
                tween = tween.timeline;
            }
        }
        function setTotalTime(time, suppressEvents) {
            if (timeline) {
                var tlTime = (cachedPaused ? (cachedPauseTime) : (timeline.cachedTotalTime));
                if (cachedReversed) {
                    var dur = (cacheIsDirty ? (totalDuration) : (cachedTotalDuration));
                    cachedStartTime = tlTime - ((dur - time) / cachedTimeScale);
                } else {
                    cachedStartTime = tlTime - (time / cachedTimeScale);
                }
                if (!timeline.cacheIsDirty) {
                    setDirtyCache(false);
                }
                if (cachedTotalTime != time) {
                    renderTime(time, suppressEvents, false);
                }
            }
        }
        function get delay() {
            return(_delay);
        }
        function set delay(n) {
            startTime = startTime + (n - _delay);
            _delay = n;
            //return(delay);
        }
        function get duration() {
            return(cachedDuration);
        }
        function set duration(n) {
            var ratio = (n / cachedDuration);
            cachedDuration = (cachedTotalDuration = n);
            if ((active && (!cachedPaused)) && (n != 0)) {
                setTotalTime(cachedTotalTime * ratio, true);
            }
            setDirtyCache(false);
            //return(duration);
        }
        function get totalDuration() {
            return(cachedTotalDuration);
        }
        function set totalDuration(n) {
            duration = (n);
            //return(totalDuration);
        }
        function get currentTime() {
            return(cachedTime);
        }
        function set currentTime(n) {
            setTotalTime(n, false);
            //return(currentTime);
        }
        function get totalTime() {
            return(cachedTotalTime);
        }
        function set totalTime(n) {
            setTotalTime(n, false);
            //return(totalTime);
        }
        function get startTime() {
            return(cachedStartTime);
        }
        function set startTime(n) {
            if ((timeline != undefined) && ((n != cachedStartTime) || (gc))) {
                timeline.insert(this, n - _delay);
            } else {
                cachedStartTime = n;
            }
            //return(startTime);
        }
        function get reversed() {
            return(cachedReversed);
        }
        function set reversed(b) {
            if (b != cachedReversed) {
                cachedReversed = b;
                setTotalTime(cachedTotalTime, true);
            }
            //return(reversed);
        }
        function get paused() {
            return(cachedPaused);
        }
        function set paused(b) {
            if ((b != cachedPaused) && (timeline)) {
                if (b) {
                    cachedPauseTime = timeline.rawTime;
                } else {
                    cachedStartTime = cachedStartTime + (timeline.rawTime - cachedPauseTime);
                    cachedPauseTime = NaN;
                    setDirtyCache(false);
                }
                cachedPaused = b;
                active = Boolean(((!cachedPaused) && (cachedTotalTime > 0)) && (cachedTotalTime < cachedTotalDuration));
            }
            if ((!b) && (gc)) {
                setEnabled(true, false);
            }
            //return(paused);
        }
        static var version = 1.691;
    }
