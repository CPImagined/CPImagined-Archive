//Created by Action Script Viewer - https://www.buraks.com/asv
    class gs.TweenMax extends gs.TweenFilterLite
    {
        var _pauseTime, vars, target, addSubTween, _active, initTime, startTime, delay, _initted, duration, render;
        function TweenMax ($target, $duration, $vars) {
            super($target, $duration, $vars);
            _pauseTime = null;
            if ((gs.TweenFilterLite.version < 7.3) || (isNaN(gs.TweenFilterLite.version))) {
                trace("TweenMax error! Please update your TweenFilterLite class or try deleting your ASO files. TweenMax requires a more recent version. Download updates at http://www.TweenMax.com.");
            }
        }
        static function to($target, $duration, $vars) {
            return(new gs.TweenMax($target, $duration, $vars));
        }
        static function from($target, $duration, $vars) {
            $vars.runBackwards = true;
            return(new gs.TweenMax($target, $duration, $vars));
        }
        static function allTo($targets, $duration, $vars) {
            if ($targets.length == 0) {
                return([]);
            }
            var _local_4;
            var _local_3;
            var _local_1;
            var _local_10;
            var _local_7;
            var _local_6 = [];
            var _local_9 = $vars.delayIncrement || 0;
            delete $vars.delayIncrement;
            if ($vars.onCompleteAll == undefined) {
                _local_7 = $vars;
            } else {
                _local_7 = {};
                for (_local_1 in $vars) {
                    _local_7[_local_1] = $vars[_local_1];
                }
                _local_7.onCompleteParams = [[$vars.onComplete, $vars.onCompleteAll], [$vars.onCompleteParams, $vars.onCompleteAllParams], [$vars.onCompleteScope, $vars.onCompleteAllScope]];
                _local_7.onComplete = callbackProxy;
                delete $vars.onCompleteAll;
            }
            delete $vars.onCompleteAllParams;
            delete $vars.onCompleteAllScope;
            if (_local_9 == 0) {
                _local_6.push(new gs.TweenMax($targets[0], $duration, _local_7));
                _local_4 = 1;
                while (_local_4 < $targets.length) {
                    _local_3 = {};
                    for (_local_1 in $vars) {
                        _local_3[_local_1] = $vars[_local_1];
                    }
                    _local_6.push(new gs.TweenMax($targets[_local_4], $duration, _local_3));
                    _local_4++;
                }
            } else {
                _local_10 = $vars.delay || 0;
                _local_4 = 0;
                while (_local_4 < ($targets.length - 1)) {
                    _local_3 = {};
                    for (_local_1 in $vars) {
                        _local_3[_local_1] = $vars[_local_1];
                    }
                    _local_3.delay = _local_10 + (_local_4 * _local_9);
                    _local_6.push(new gs.TweenMax($targets[_local_4], $duration, _local_3));
                    _local_4++;
                }
                _local_7.delay = _local_10 + (($targets.length - 1) * _local_9);
                _local_6.push(new gs.TweenMax($targets[$targets.length - 1], $duration, _local_7));
            }
            return(_local_6);
        }
        static function allFrom($targets, $duration, $vars) {
            $vars.runBackwards = true;
            return(allTo($targets, $duration, $vars));
        }
        static function callbackProxy($functions, $params, $scopes) {
            var _local_1 = 0;
            while (_local_1 < $functions.length) {
                if ($functions[_local_1] != undefined) {
                    $functions[_local_1].apply($scopes[_local_1], $params[_local_1]);
                }
                _local_1++;
            }
        }
        static function sequence($target, $tweens) {
            var _local_1 = 0;
            while (_local_1 < $tweens.length) {
                $tweens[_local_1].target = $target;
                _local_1++;
            }
            return(multiSequence($tweens));
        }
        static function multiSequence($tweens) {
            var _local_5 = [];
            var _local_13 = [];
            var _local_11 = 0;
            var _local_3;
            var _local_6;
            var _local_9;
            var _local_10;
            var _local_7;
            var _local_1;
            var _local_4;
            var _local_8;
            var _local_2;
            _local_7 = 0;
            while (_local_7 < $tweens.length) {
                _local_3 = $tweens[_local_7];
                _local_10 = _local_3.time || 0;
                _local_1 = {};
                for (_local_4 in _local_3) {
                    _local_1[_local_4] = _local_3[_local_4];
                }
                delete _local_1.time;
                _local_9 = _local_1.delay || 0;
                _local_1.delay = _local_11 + _local_9;
                _local_6 = _local_1.target;
                delete _local_1.target;
                _local_8 = false;
                _local_2 = 0;
                while (_local_2 < _local_5.length) {
                    if (_local_5[_local_2] == _local_6) {
                        _local_8 = true;
                    }
                    _local_2++;
                }
                if (!_local_8) {
                    if (_local_1.overwrite == undefined) {
                        _local_1.overwrite = true;
                    }
                    _local_5.push(_local_6);
                } else {
                    _local_1.overwrite = false;
                }
                _local_13.push(new gs.TweenMax(_local_6, _local_10, _local_1));
                _local_11 = _local_11 + (_local_10 + _local_9);
                _local_7++;
            }
            return(_local_13);
        }
        static function delayedCall($delay, $onComplete, $onCompleteParams, $onCompleteScope) {
            return(new gs.TweenMax($onComplete, 0, {delay:$delay, onComplete:$onComplete, onCompleteParams:$onCompleteParams, onCompleteScope:$onCompleteScope, overwrite:false}));
        }
        function initTweenVals($hrp, $reservedProps) {
            $reservedProps = $reservedProps || "";
            $reservedProps = $reservedProps + " hexColors bezier bezierThrough orientToBezier quaternions onCompleteAll onCompleteAllParams ";
            var _local_3;
            var _local_4;
            var _local_14;
            var _local_13;
            var _local_5;
            var _local_9 = bezierProxy;
            if (vars.orientToBezier == true) {
                vars.orientToBezier = [["_x", "_y", "_rotation", 0]];
                _local_9 = bezierProxy2;
            } else if (vars.orientToBezier instanceof Array) {
                _local_9 = bezierProxy2;
            }
            if (vars.bezier != undefined) {
                _local_13 = {};
                _local_5 = vars.bezier;
                _local_4 = 0;
                while (_local_4 < _local_5.length) {
                    for (_local_3 in _local_5[_local_4]) {
                        if (_local_13[_local_3] == undefined) {
                            _local_13[_local_3] = [target[_local_3]];
                        }
                        if (typeof(_local_5[_local_4][_local_3]) == "number") {
                            _local_13[_local_3].push(_local_5[_local_4][_local_3]);
                        } else {
                            _local_13[_local_3].push(target[_local_3] + Number(_local_5[_local_4][_local_3]));
                        }
                    }
                    _local_4++;
                }
                for (_local_3 in _local_13) {
                    if (typeof(vars[_local_3]) == "number") {
                        _local_13[_local_3].push(vars[_local_3]);
                    } else {
                        _local_13[_local_3].push(target[_local_3] + Number(vars[_local_3]));
                    }
                    delete vars[_local_3];
                }
                addSubTween(_local_9, {t:0}, {t:1}, {props:parseBeziers(_local_13, false), target:target, orientToBezier:vars.orientToBezier});
            }
            if (vars.bezierThrough != undefined) {
                _local_13 = {};
                _local_5 = vars.bezierThrough;
                _local_4 = 0;
                while (_local_4 < _local_5.length) {
                    for (_local_3 in _local_5[_local_4]) {
                        if (_local_13[_local_3] == undefined) {
                            _local_13[_local_3] = [target[_local_3]];
                        }
                        if (typeof(_local_5[_local_4][_local_3]) == "number") {
                            _local_13[_local_3].push(_local_5[_local_4][_local_3]);
                        } else {
                            _local_13[_local_3].push(target[_local_3] + Number(_local_5[_local_4][_local_3]));
                        }
                    }
                    _local_4++;
                }
                for (_local_3 in _local_13) {
                    if (typeof(vars[_local_3]) == "number") {
                        _local_13[_local_3].push(vars[_local_3]);
                    } else {
                        _local_13[_local_3].push(target[_local_3] + Number(vars[_local_3]));
                    }
                    delete vars[_local_3];
                }
                addSubTween(_local_9, {t:0}, {t:1}, {props:parseBeziers(_local_13, true), target:target, orientToBezier:vars.orientToBezier});
            }
            if ((vars.hexColors != undefined) && (typeof(vars.hexColors) == "object")) {
                for (_local_3 in vars.hexColors) {
                    addSubTween(hexColorsProxy, {r:target[_local_3] >> 16, g:(target[_local_3] >> 8) & 255, b:target[_local_3] & 255}, {r:vars.hexColors[_local_3] >> 16, g:(vars.hexColors[_local_3] >> 8) & 255, b:vars.hexColors[_local_3] & 255}, {prop:_local_3, target:target});
                }
            }
            super.initTweenVals(true, $reservedProps);
        }
        static function parseBeziers($props, $through) {
            var _local_2;
            var _local_1;
            var _local_3;
            var _local_4;
            var _local_6 = {};
            if ($through) {
                for (_local_4 in $props) {
                    _local_1 = $props[_local_4];
                    _local_3 = [];
                    _local_6[_local_4] = _local_3;
                    if (_local_1.length > 2) {
                        _local_3.push({s:_local_1[0], cp:_local_1[1] - ((_local_1[2] - _local_1[0]) / 4), e:_local_1[1]});
                        _local_2 = 1;
                        while (_local_2 < (_local_1.length - 1)) {
                            _local_3.push({s:_local_1[_local_2], cp:_local_1[_local_2] + (_local_1[_local_2] - _local_3[_local_2 - 1].cp), e:_local_1[_local_2 + 1]});
                            _local_2++;
                        }
                    } else {
                        _local_3.push({s:_local_1[0], cp:(_local_1[0] + _local_1[1]) / 2, e:_local_1[1]});
                    }
                }
            } else {
                for (_local_4 in $props) {
                    _local_1 = $props[_local_4];
                    _local_3 = [];
                    _local_6[_local_4] = _local_3;
                    if (_local_1.length > 3) {
                        _local_3.push({s:_local_1[0], cp:_local_1[1], e:(_local_1[1] + _local_1[2]) / 2});
                        _local_2 = 2;
                        while (_local_2 < (_local_1.length - 2)) {
                            _local_3.push({s:_local_3[_local_2 - 2].e, cp:_local_1[_local_2], e:(_local_1[_local_2] + _local_1[_local_2 + 1]) / 2});
                            _local_2++;
                        }
                        _local_3.push({s:_local_3[_local_3.length - 1].e, cp:_local_1[_local_1.length - 2], e:_local_1[_local_1.length - 1]});
                    } else if (_local_1.length == 3) {
                        _local_3.push({s:_local_1[0], cp:_local_1[1], e:_local_1[2]});
                    } else if (_local_1.length == 2) {
                        _local_3.push({s:_local_1[0], cp:(_local_1[0] + _local_1[1]) / 2, e:_local_1[1]});
                    }
                }
            }
            return(_local_6);
        }
        static function getTweensOf($target) {
            var _local_1 = gs.TweenLite._all[gs.TweenLite.getID($target, true)];
            var _local_2 = [];
            if (_local_1 != null) {
                for (var _local_3 in _local_1) {
                    if (_local_1[_local_3].tweens != undefined) {
                        _local_2.push(_local_1[_local_3]);
                    }
                }
            }
            return(_local_2);
        }
        static function isTweening($target) {
            var _local_2 = getTweensOf($target);
            var _local_1 = 0;
            while (_local_1 < _local_2.length) {
                if (_local_2[_local_1].active) {
                    return(true);
                }
                _local_1++;
            }
            return(false);
        }
        function pause() {
            if (_pauseTime == null) {
                _pauseTime = gs.TweenLite._curTime;
                _active = false;
            }
        }
        function resume() {
            if (_pauseTime != null) {
                var _local_2 = gs.TweenLite._curTime - _pauseTime;
                initTime = initTime + _local_2;
                if (startTime != undefined) {
                    startTime = startTime + _local_2;
                }
                _pauseTime = null;
                if (((gs.TweenLite._curTime - initTime) / 1000) > delay) {
                    _active = true;
                }
            }
        }
        static function getAllTweens() {
            var _local_1 = gs.TweenLite._all;
            var _local_5 = [];
            var _local_4;
            var _local_3;
            var _local_2;
            for (_local_2 in _local_1) {
                for (_local_3 in _local_1[_local_2]) {
                    _local_4 = _local_1[_local_2][_local_3];
                    if (_local_4.tweens != undefined) {
                        _local_5.push(_local_1[_local_2][_local_3]);
                    }
                }
            }
            return(_local_5);
        }
        static function killAllTweens($complete) {
            killAll($complete, true, false);
        }
        static function killAllDelayedCalls($complete) {
            killAll($complete, false, true);
        }
        static function killAll($complete, $tweens, $delayedCalls) {
            if ($tweens == undefined) {
                $tweens = true;
            }
            if ($delayedCalls == undefined) {
                $delayedCalls = false;
            }
            var _local_2 = getAllTweens();
            var _local_1 = _local_2.length - 1;
            while (_local_1 > -1) {
                if (((typeof(_local_2[_local_1].target) == "function") == $delayedCalls) || ((typeof(_local_2[_local_1].target) == "function") != $tweens)) {
                    if ($complete) {
                        _local_2[_local_1].complete();
                    } else {
                        gs.TweenLite.removeTween(_local_2[_local_1]);
                    }
                }
                _local_1--;
            }
        }
        static function pauseAll($tweens, $delayedCalls) {
            changePause(true, $tweens, $delayedCalls);
        }
        static function resumeAll($tweens, $delayedCalls) {
            changePause(false, $tweens, $delayedCalls);
        }
        static function changePause($pause, $tweens, $delayedCalls) {
            if ($pause == undefined) {
                $pause = true;
            }
            if ($tweens == undefined) {
                $tweens = true;
            }
            if ($delayedCalls == undefined) {
                $delayedCalls = false;
            }
            var _local_2 = getAllTweens();
            var _local_1 = _local_2.length - 1;
            while (_local_1 > -1) {
                if (((typeof(_local_2[_local_1].target) == "function") == $delayedCalls) || ((typeof(_local_2[_local_1].target) == "function") != $tweens)) {
                    _local_2[_local_1].paused = $pause;
                }
                _local_1--;
            }
        }
        static function hexColorsProxy($o) {
            $o.info.target[$o.info.prop] = (($o.target.r << 16) | ($o.target.g << 8)) | $o.target.b;
        }
        static function bezierProxy($o) {
            var _local_4 = $o.target.t;
            var _local_7 = $o.info.props;
            var _local_8 = $o.info.target;
            var _local_3;
            var _local_6;
            var _local_1;
            var _local_5;
            var _local_2;
            for (_local_6 in _local_7) {
                _local_2 = _local_7[_local_6].length;
                if (_local_4 < 0) {
                    _local_3 = 0;
                } else if (_local_4 >= 1) {
                    _local_3 = _local_2 - 1;
                } else {
                    _local_3 = (_local_2 * _local_4) >> 0;
                }
                _local_5 = (_local_4 - (_local_3 * (1 / _local_2))) * _local_2;
                _local_1 = _local_7[_local_6][_local_3];
                _local_8[_local_6] = _local_1.s + (_local_5 * (((2 * (1 - _local_5)) * (_local_1.cp - _local_1.s)) + (_local_5 * (_local_1.e - _local_1.s))));
            }
        }
        static function bezierProxy2($o) {
            bezierProxy($o);
            var _local_4 = {};
            var _local_3 = $o.info.target;
            $o.info.target = _local_4;
            $o.target.t = $o.target.t + 0.01;
            bezierProxy($o);
            var _local_5 = $o.info.orientToBezier;
            var _local_10;
            var _local_7;
            var _local_6;
            var _local_1;
            var _local_8;
            var _local_2;
            _local_2 = 0;
            while (_local_2 < _local_5.length) {
                _local_1 = _local_5[_local_2];
                _local_8 = _local_1[3] || 0;
                _local_7 = _local_4[_local_1[0]] - _local_3[_local_1[0]];
                _local_6 = _local_4[_local_1[1]] - _local_3[_local_1[1]];
                _local_3[_local_1[2]] = (Math.atan2(_local_6, _local_7) * RAD2DEG) + _local_8;
                _local_2++;
            }
            $o.info.target = _local_3;
            $o.target.t = $o.target.t - 0.01;
        }
        function get active() {
            if (_active) {
                return(true);
            } else if (_pauseTime != null) {
                return(false);
            } else if (((gs.TweenLite._curTime - initTime) / 1000) > delay) {
                _active = true;
                startTime = initTime + (delay * 1000);
                if (!_initted) {
                    initTweenVals();
                } else if (vars._visible != undefined) {
                    target._visible = true;
                }
                if (duration == 0.001) {
                    startTime = startTime - 1;
                }
                if (vars.onStart != undefined) {
                    vars.onStart.apply(null, vars.onStartParams);
                }
                return(true);
            } else {
                return(false);
            }
        }
        function get paused() {
            if (_pauseTime != null) {
                return(true);
            }
            return(false);
        }
        function set paused($b) {
            if ($b) {
                this.pause();
            } else {
                resume();
            }
            //return(paused);
        }
        function get progress() {
            var _local_2 = (((gs.TweenLite._curTime - startTime) / 1000) / duration) || 0;
            if (_local_2 > 1) {
                return(1);
            } else {
                return(_local_2);
            }
        }
        function set progress($n) {
            var _local_2 = gs.TweenLite._curTime - ((duration * $n) * 1000);
            initTime = _local_2 - (delay * 1000);
            var _local_3 = active;
            startTime = _local_2;
            render(gs.TweenLite._curTime);
            //return(progress);
        }
        static var version = 1.4;
        static var RAD2DEG = 57.2957795130823;
        static var killTweensOf = gs.TweenLite.killTweensOf;
        static var killDelayedCallsTo = gs.TweenLite.killDelayedCallsTo;
        static var removeTween = gs.TweenLite.removeTween;
        static var defaultEase = gs.TweenLite.defaultEase;
    }
