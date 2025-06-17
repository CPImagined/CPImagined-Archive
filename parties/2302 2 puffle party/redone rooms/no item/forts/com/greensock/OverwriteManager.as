//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.greensock.OverwriteManager
    {
        static var mode, enabled;
        function OverwriteManager () {
        }
        static function init(defaultMode) {
            if (com.greensock.TweenLite.version < 11.6) {
                trace("Warning: Your TweenLite class needs to be updated to work with OverwriteManager (or you may need to clear your ASO files). Please download and install the latest version from http://www.tweenlite.com.");
            }
            com.greensock.TweenLite.overwriteManager = com.greensock.OverwriteManager;
            mode = ((defaultMode == undefined) ? 2 : (defaultMode));
            enabled = true;
            return(mode);
        }
        static function manageOverwrites(tween, props, targetTweens, mode) {
            var _local_3;
            var _local_10;
            var _local_1;
            if (mode >= 4) {
                var _local_17 = targetTweens.length;
                _local_3 = 0;
                while (_local_3 < _local_17) {
                    _local_1 = targetTweens[_local_3];
                    if (_local_1 != tween) {
                        if (_local_1.setEnabled(false, false)) {
                            _local_10 = true;
                        }
                    } else if (mode == 5) {
                        break;
                    }
                    _local_3++;
                }
                return(_local_10);
            }
            var _local_5 = tween.cachedStartTime + 1E-10;
            var _local_9 = [];
            var _local_13 = [];
            var _local_15 = 0;
            var _local_12 = 0;
            _local_3 = targetTweens.length;
            while (_local_3-- , _local_3 > -1) {
                _local_1 = targetTweens[_local_3];
                if (((_local_1 == tween) || (_local_1.gc)) || ((!_local_1.initted) && ((_local_5 - _local_1.cachedStartTime) <= 2E-10))) {
                } else if (_local_1.timeline != tween.timeline) {
                    if (!getGlobalPaused(_local_1)) {
                        _local_13[_local_15++] = _local_1;
                    }
                } else if ((((_local_1.cachedStartTime <= _local_5) && (((_local_1.cachedStartTime + _local_1.totalDuration) + 1E-10) > _local_5)) && (!_local_1.cachedPaused)) && (!((tween.cachedDuration == 0) && ((_local_5 - _local_1.cachedStartTime) <= 2E-10)))) {
                    _local_9[_local_12++] = _local_1;
                }
            }
            if (_local_15 != 0) {
                var _local_6 = tween.cachedTimeScale;
                var _local_7 = _local_5;
                var _local_4;
                var _local_11;
                var _local_2;
                _local_2 = tween.timeline;
                while (_local_2) {
                    _local_6 = _local_6 * _local_2.cachedTimeScale;
                    _local_7 = _local_7 + _local_2.cachedStartTime;
                    _local_2 = _local_2.timeline;
                }
                _local_5 = _local_6 * _local_7;
                _local_3 = _local_15;
                while (_local_3-- , _local_3 > -1) {
                    _local_4 = _local_13[_local_3];
                    _local_6 = _local_4.cachedTimeScale;
                    _local_7 = _local_4.cachedStartTime;
                    _local_2 = _local_4.timeline;
                    while (_local_2) {
                        _local_6 = _local_6 * _local_2.cachedTimeScale;
                        _local_7 = _local_7 + _local_2.cachedStartTime;
                        _local_2 = _local_2.timeline;
                    }
                    _local_11 = _local_6 * _local_7;
                    if ((_local_11 <= _local_5) && ((((_local_11 + (_local_4.totalDuration * _local_6)) + 1E-10) > _local_5) || (_local_4.cachedDuration == 0))) {
                        _local_9[_local_12++] = _local_4;
                    }
                }
            }
            if (_local_12 == 0) {
                return(_local_10);
            }
            _local_3 = _local_12;
            if (mode == 2) {
                while (_local_3-- , _local_3 > -1) {
                    _local_1 = _local_9[_local_3];
                    if (_local_1.killVars(props)) {
                        _local_10 = true;
                    }
                    if ((_local_1.cachedPT1 == undefined) && (_local_1.initted)) {
                        _local_1.setEnabled(false, false);
                    }
                }
            } else {
                while (_local_3-- , _local_3 > -1) {
                    if (_local_9[_local_3].setEnabled(false, false)) {
                        _local_10 = true;
                    }
                }
            }
            return(_local_10);
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
