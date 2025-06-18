//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.greensock.OverwriteManager
    {
        static var mode, enabled;
        function OverwriteManager () {
        }
        static function init(defaultMode) {
            if (com.greensock.TweenLite.version < 11.6) {
            }
            com.greensock.TweenLite.overwriteManager = com.greensock.OverwriteManager;
            mode = ((defaultMode == undefined) ? 2 : (defaultMode));
            enabled = true;
            return(mode);
        }
        static function manageOverwrites(tween, props, targetTweens, mode) {
            var i;
            var changed;
            var curTween;
            if (mode >= 4) {
                var l = targetTweens.length;
                i = 0;
                while (i < l) {
                    curTween = targetTweens[i];
                    if (curTween != tween) {
                        if (curTween.setEnabled(false, false)) {
                            changed = true;
                        }
                    } else if (mode == 5) {
                        break;
                    }
                    i++;
                }
                return(changed);
            }
            var startTime = (tween.cachedStartTime + 1E-10);
            var overlaps = [];
            var cousins = [];
            var cCount = 0;
            var oCount = 0;
            i = targetTweens.length;
            while ((--i) > -1) {
                curTween = targetTweens[i];
                if (((curTween == tween) || (curTween.gc)) || ((!curTween.initted) && ((startTime - curTween.cachedStartTime) <= 2E-10))) {
                } else if (curTween.timeline != tween.timeline) {
                    if (!getGlobalPaused(curTween)) {
                        cousins[cCount++] = curTween;
                    }
                } else if ((((curTween.cachedStartTime <= startTime) && (((curTween.cachedStartTime + curTween.totalDuration) + 1E-10) > startTime)) && (!curTween.cachedPaused)) && (!((tween.cachedDuration == 0) && ((startTime - curTween.cachedStartTime) <= 2E-10)))) {
                    overlaps[oCount++] = curTween;
                }
            }
            if (cCount != 0) {
                var combinedTimeScale = tween.cachedTimeScale;
                var combinedStartTime = startTime;
                var cousin;
                var cousinStartTime;
                var timeline;
                timeline = tween.timeline;
                while (timeline) {
                    combinedTimeScale = combinedTimeScale * timeline.cachedTimeScale;
                    combinedStartTime = combinedStartTime + timeline.cachedStartTime;
                    timeline = timeline.timeline;
                }
                startTime = combinedTimeScale * combinedStartTime;
                i = cCount;
                while ((--i) > -1) {
                    cousin = cousins[i];
                    combinedTimeScale = cousin.cachedTimeScale;
                    combinedStartTime = cousin.cachedStartTime;
                    timeline = cousin.timeline;
                    while (timeline) {
                        combinedTimeScale = combinedTimeScale * timeline.cachedTimeScale;
                        combinedStartTime = combinedStartTime + timeline.cachedStartTime;
                        timeline = timeline.timeline;
                    }
                    cousinStartTime = combinedTimeScale * combinedStartTime;
                    if ((cousinStartTime <= startTime) && ((((cousinStartTime + (cousin.totalDuration * combinedTimeScale)) + 1E-10) > startTime) || (cousin.cachedDuration == 0))) {
                        overlaps[oCount++] = cousin;
                    }
                }
            }
            if (oCount == 0) {
                return(changed);
            }
            i = oCount;
            if (mode == 2) {
                while ((--i) > -1) {
                    curTween = overlaps[i];
                    if (curTween.killVars(props)) {
                        changed = true;
                    }
                    if ((curTween.cachedPT1 == undefined) && (curTween.initted)) {
                        curTween.setEnabled(false, false);
                    }
                }
            } else {
                while ((--i) > -1) {
                    if (overlaps[i].setEnabled(false, false)) {
                        changed = true;
                    }
                }
            }
            return(changed);
        }
        static function getGlobalPaused(tween) {
            while (tween) {
                if (tween.cachedPaused) {
                    return(true);
                }
                tween = tween.timeline;
            }
            return(false);
        }
        static var version = 6.1;
        static var NONE = 0;
        static var ALL_IMMEDIATE = 1;
        static var AUTO = 2;
        static var CONCURRENT = 3;
        static var ALL_ONSTART = 4;
        static var PREEXISTING = 5;
    }
