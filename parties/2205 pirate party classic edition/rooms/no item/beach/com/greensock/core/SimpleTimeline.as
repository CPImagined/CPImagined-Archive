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
            var _local_3 = tween.timeline;
            if ((!tween.cachedOrphan) && (_local_3)) {
                _local_3.remove(tween, true);
            }
            tween.timeline = this;
            tween.cachedStartTime = Number(time) + tween.delay;
            if (tween.gc) {
                tween.setEnabled(true, true);
            }
            if (tween.cachedPaused && (_local_3 != this)) {
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
            var _local_2 = _firstChild;
            var _local_4;
            var _local_5;
            cachedTotalTime = time;
            cachedTime = time;
            while (_local_2) {
                _local_5 = _local_2.nextNode;
                if (_local_2.active || (((time >= _local_2.cachedStartTime) && (!_local_2.cachedPaused)) && (!_local_2.gc))) {
                    if (!_local_2.cachedReversed) {
                        _local_2.renderTime((time - _local_2.cachedStartTime) * _local_2.cachedTimeScale, suppressEvents, false);
                    } else {
                        _local_4 = (_local_2.cacheIsDirty ? (_local_2.totalDuration) : (_local_2.cachedTotalDuration));
                        _local_2.renderTime(_local_4 - ((time - _local_2.cachedStartTime) * _local_2.cachedTimeScale), suppressEvents, false);
                    }
                }
                _local_2 = _local_5;
            }
        }
        function get rawTime() {
            return(cachedTotalTime);
        }
    }
