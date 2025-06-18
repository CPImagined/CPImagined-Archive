//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.greensock.core.SimpleTimeline extends com.greensock.core.TweenCore
    {
        var _lastChild, _firstChild, cachedTotalTime, cachedTime;
        function SimpleTimeline (vars) {
            super(0, vars);
        }
        function insert(tween, time) {
            if (time == undefined) {
                time = 0;
            }
            var prevTimeline = tween.timeline;
            if ((!tween.cachedOrphan) && (prevTimeline)) {
                prevTimeline.remove(tween, true);
            }
            tween.timeline = this;
            tween.cachedStartTime = Number(time) + tween.delay;
            if (tween.gc) {
                tween.setEnabled(true, true);
            }
            if (tween.cachedPaused && (prevTimeline != this)) {
                tween.cachedPauseTime = tween.cachedStartTime + ((rawTime - tween.cachedStartTime) / tween.cachedTimeScale);
            }
            if (_lastChild) {
                _lastChild.nextNode = tween;
            } else {
                _firstChild = tween;
            }
            tween.prevNode = _lastChild;
            _lastChild = tween;
            tween.nextNode = undefined;
            tween.cachedOrphan = false;
            return(tween);
        }
        function remove(tween, skipDisable) {
            if (tween.cachedOrphan) {
                return(undefined);
            } else if (skipDisable != true) {
                tween.setEnabled(false, true);
            }
            if (tween.nextNode) {
                tween.nextNode.prevNode = tween.prevNode;
            } else if (_lastChild == tween) {
                _lastChild = tween.prevNode;
            }
            if (tween.prevNode) {
                tween.prevNode.nextNode = tween.nextNode;
            } else if (_firstChild == tween) {
                _firstChild = tween.nextNode;
            }
            tween.cachedOrphan = true;
        }
        function renderTime(time, suppressEvents, force) {
            var tween = _firstChild;
            var dur;
            var next;
            cachedTotalTime = time;
            cachedTime = time;
            while (tween) {
                next = tween.nextNode;
                if (tween.active || (((time >= tween.cachedStartTime) && (!tween.cachedPaused)) && (!tween.gc))) {
                    if (!tween.cachedReversed) {
                        tween.renderTime((time - tween.cachedStartTime) * tween.cachedTimeScale, suppressEvents, false);
                    } else {
                        dur = (tween.cacheIsDirty ? (tween.totalDuration) : (tween.cachedTotalDuration));
                        tween.renderTime(dur - ((time - tween.cachedStartTime) * tween.cachedTimeScale), suppressEvents, false);
                    }
                }
                tween = next;
            }
        }
        function get rawTime() {
            return(cachedTotalTime);
        }
    }
