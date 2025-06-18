//Created by Action Script Viewer - https://www.buraks.com/asv
    class gs.TweenLite
    {
        static var _e, _classInitted, _curTime, _gc, _listening;
        var tweenID, endTargetID, vars, duration, delay, _active, target, tweens, _subTweens, _hst, _initted, initTime, startTime;
        function TweenLite ($target, $duration, $vars) {
            _cnt++;
            tweenID = "tw" + _cnt;
            endTargetID = getID($target, true);
            if (($vars.overwrite != false) && ($target != undefined)) {
                delete _all[endTargetID];
                _all[endTargetID] = {info:[$target, endTargetID]};
            }
            _all[endTargetID][tweenID] = this;
            vars = $vars;
            duration = $duration || 0.001;
            delay = $vars.delay || 0;
            _active = ($duration == 0) && (delay == 0);
            target = $target;
            if (typeof(vars.ease) != "function") {
                vars.ease = defaultEase;
            }
            if (vars.easeParams != undefined) {
                vars.proxiedEase = vars.ease;
                vars.ease = easeProxy;
            }
            if (typeof(vars.autoAlpha) == "number") {
                vars._alpha = vars.autoAlpha;
                vars._visible = vars._alpha > 0;
            }
            tweens = [];
            _subTweens = [];
            _hst = (_initted = false);
            if ((_e._visible != false) || (!_classInitted)) {
                _curTime = getTimer();
                var _local_3 = 999;
                while (_root.getInstanceAtDepth(_local_3) != undefined) {
                    _local_3++;
                }
                _e = _root.createEmptyMovieClip("__tweenLite_mc", _local_3);
                _e._visible = false;
                clearInterval(_gc);
                _gc = setInterval(killGarbage, 2000);
                _e.onEnterFrame = executeAll;
                _classInitted = true;
            }
            initTime = _curTime;
            if (_active || ((vars.runBackwards == true) && (vars.renderOnStart != true))) {
                initTweenVals();
                startTime = _curTime;
                if (_active) {
                    render(startTime + 1);
                } else {
                    render(startTime);
                }
                if ((vars._visible != undefined) && (vars.runBackwards == true)) {
                    target._visible = vars._visible;
                }
            }
            if ((!_active) && (!_listening)) {
                _listening = true;
            }
        }
        function initTweenVals($hrp, $reservedProps) {
            var _local_8 = typeof(target) == "movieclip";
            var _local_4;
            var _local_2;
            if (target instanceof Array) {
                var _local_5 = vars.endArray || ([]);
                _local_2 = 0;
                while (_local_2 < _local_5.length) {
                    if ((target[_local_2] != _local_5[_local_2]) && (target[_local_2] != undefined)) {
                        tweens.push({o:target, p:_local_2.toString(), s:target[_local_2], c:_local_5[_local_2] - target[_local_2]});
                    }
                    _local_2++;
                }
            } else {
                if (((vars.tint != undefined) || (vars.removeTint == true)) && (_local_8 || (target instanceof TextField))) {
                    var _local_13 = new Color(target);
                    var _local_10 = vars._alpha;
                    if (_local_10 != undefined) {
                        delete vars._alpha;
                    } else {
                        _local_10 = target._alpha;
                    }
                    if (((vars.removeTint == true) || (vars.tint == null)) || (vars.tint == "")) {
                        addSubTween(tintProxy, _local_13.getTransform(), {rb:0, gb:0, bb:0, ab:0, ra:_local_10, ga:_local_10, ba:_local_10, aa:_local_10}, {color:_local_13});
                    } else {
                        addSubTween(tintProxy, _local_13.getTransform(), {rb:vars.tint >> 16, gb:(vars.tint >> 8) & 255, bb:vars.tint & 255, ra:0, ga:0, ba:0, aa:_local_10}, {color:_local_13});
                    }
                }
                if ((vars.frame != undefined) && (_local_8)) {
                    addSubTween(frameProxy, {frame:target._currentframe}, {frame:vars.frame}, {mc:target});
                }
                if ((vars.volume != undefined) && (_local_8 || (target instanceof Sound))) {
                    var _local_14;
                    if (_local_8) {
                        _local_14 = new Sound(target);
                    } else {
                        _local_14 = Sound(target);
                    }
                    addSubTween(volumeProxy, {volume:_local_14.getVolume()}, {volume:vars.volume}, {sound:_local_14});
                }
                for (_local_4 in vars) {
                    if (((((((((((((((((((_local_4 == "ease") || (_local_4 == "delay")) || (_local_4 == "overwrite")) || (_local_4 == "onComplete")) || (_local_4 == "onCompleteParams")) || (_local_4 == "onCompleteScope")) || (_local_4 == "runBackwards")) || (_local_4 == "onUpdate")) || (_local_4 == "onUpdateParams")) || (_local_4 == "onUpdateScope")) || (_local_4 == "persist")) || (_local_4 == "volume")) || (_local_4 == "onStart")) || (_local_4 == "onStartParams")) || (_local_4 == "onStartScope")) || (_local_4 == "renderOnStart")) || (_local_4 == "proxiedEase")) || (_local_4 == "easeParams")) || ($hrp && ($reservedProps.indexOf((" " + _local_4) + " ") != -1))) {
                    } else if ((!(_local_8 && (((((_local_4 == "_visible") || (_local_4 == "autoAlpha")) || (_local_4 == "tint")) || (_local_4 == "removeTint")) || (_local_4 == "frame")))) && (target[_local_4] != undefined)) {
                        if (typeof(vars[_local_4]) == "number") {
                            tweens.push({o:target, p:_local_4, s:target[_local_4], c:vars[_local_4] - target[_local_4]});
                        } else {
                            tweens.push({o:target, p:_local_4, s:target[_local_4], c:Number(vars[_local_4])});
                        }
                    }
                }
            }
            if (vars.runBackwards == true) {
                var _local_3;
                _local_2 = tweens.length - 1;
                while (_local_2 > -1) {
                    _local_3 = tweens[_local_2];
                    _local_3.s = _local_3.s + _local_3.c;
                    _local_3.c = _local_3.c * -1;
                    _local_2--;
                }
            }
            if (vars._visible == true) {
                target._visible = true;
            }
            _initted = true;
        }
        function addSubTween($proxy, $target, $props, $info) {
            var _local_5 = {proxy:$proxy, target:$target, info:$info};
            _subTweens.push(_local_5);
            for (var _local_8 in $props) {
                if (typeof($props[_local_8]) == "number") {
                    tweens.push({o:$target, p:_local_8, s:$target[_local_8], c:$props[_local_8] - $target[_local_8], sub:_local_5});
                } else {
                    tweens.push({o:$target, p:_local_8, s:$target[_local_8], c:Number($props[_local_8]), sub:_local_5});
                }
            }
            _hst = true;
        }
        static function to($target, $duration, $vars) {
            return(new gs.TweenLite($target, $duration, $vars));
        }
        static function from($target, $duration, $vars) {
            $vars.runBackwards = true;
            return(new gs.TweenLite($target, $duration, $vars));
        }
        static function delayedCall($delay, $onComplete, $onCompleteParams, $onCompleteScope) {
            return(new gs.TweenLite($onComplete, 0, {delay:$delay, onComplete:$onComplete, onCompleteParams:$onCompleteParams, onCompleteScope:$onCompleteScope, overwrite:false}));
        }
        function render($t) {
            var _local_5 = ($t - startTime) / 1000;
            var _local_4;
            var _local_3;
            var _local_2;
            if (_local_5 >= duration) {
                _local_5 = duration;
                _local_4 = 1;
            } else {
                _local_4 = vars.ease(_local_5, 0, 1, duration);
            }
            _local_2 = tweens.length - 1;
            while (_local_2 > -1) {
                _local_3 = tweens[_local_2];
                _local_3.o[_local_3.p] = _local_3.s + (_local_4 * _local_3.c);
                _local_2--;
            }
            if (_hst) {
                _local_2 = _subTweens.length - 1;
                while (_local_2 > -1) {
                    _subTweens[_local_2].proxy(_subTweens[_local_2]);
                    _local_2--;
                }
            }
            if (vars.onUpdate != undefined) {
                vars.onUpdate.apply(vars.onUpdateScope, vars.onUpdateParams);
            }
            if (_local_5 == duration) {
                complete(true);
            }
        }
        static function executeAll() {
            var _local_5 = (_curTime = getTimer());
            if (_listening) {
                var _local_2 = _all;
                var _local_1;
                var _local_4;
                var _local_3;
                for (_local_3 in _local_2) {
                    for (_local_4 in _local_2[_local_3]) {
                        _local_1 = _local_2[_local_3][_local_4];
                        if (_local_1.active) {
                            _local_1.render(_local_5);
                        }
                    }
                }
            }
        }
        static function removeTween($t) {
            _all[$t.endTargetID][$t.tweenID] = {active:false};
            delete _all[$t.endTargetID][$t.tweenID];
        }
        static function killTweensOf($tg, $complete) {
            var _local_3 = getID($tg, true);
            if ($complete) {
                var _local_1 = _all[_local_3];
                for (var _local_2 in _local_1) {
                    _local_1[_local_2].complete(false);
                }
            }
            delete _all[_local_3];
        }
        function complete($skipRender) {
            if ($skipRender != true) {
                if (!_initted) {
                    initTweenVals();
                }
                startTime = _curTime - (duration * 1000);
                render(_curTime);
                return(undefined);
            }
            if (vars._visible != undefined) {
                if ((vars.autoAlpha != undefined) && (target._alpha == 0)) {
                    target._visible = false;
                } else if (vars.runBackwards != true) {
                    target._visible = vars._visible;
                }
            }
            if (vars.onComplete) {
                vars.onComplete.apply(vars.onCompleteScope, vars.onCompleteParams);
            }
            if (vars.persist != true) {
                removeTween(this);
            }
        }
        static function getID($tg, $lookup) {
            var _local_3;
            if ($lookup) {
                var _local_1 = _all;
                if (typeof($tg) == "movieclip") {
                    if (_local_1[String($tg)] != undefined) {
                        return(String($tg));
                    } else {
                        _local_3 = String($tg);
                        _all[_local_3] = {info:[$tg, _local_3]};
                        return(_local_3);
                    }
                } else {
                    for (var _local_4 in _local_1) {
                        if (_local_1[_local_4].info[0] == $tg) {
                            return(_local_4);
                        }
                    }
                }
            }
            _cnt++;
            _local_3 = "t" + _cnt;
            _all[_local_3] = {info:[$tg, _local_3]};
            return(_local_3);
        }
        static function killGarbage() {
            if (_listening) {
                var _local_1 = _all;
                var _local_2;
                var _local_3;
                var _local_5;
                var _local_6 = 0;
                var _local_4 = 0;
                for (_local_3 in _local_1) {
                    _local_4 = 0;
                    for (_local_5 in _local_1[_local_3]) {
                        _local_2 = _local_1[_local_3][_local_5];
                        if (_local_2.tweens == undefined) {
                        } else {
                            _local_4++;
                        }
                    }
                    if (_local_4 == 0) {
                        delete _local_1[_local_3];
                    } else {
                        _local_6++;
                    }
                }
                if (_local_6 == 0) {
                    _listening = false;
                }
            }
        }
        static function defaultEase($t, $b, $c, $d) {
            $t = $t / $d;
            return((((-$c) * $t) * ($t - 2)) + $b);
        }
        function easeProxy($t, $b, $c, $d) {
            var _local_3 = this;
            return(_local_3.proxiedEase.apply(null, arguments.concat(_local_3.easeParams)));
        }
        static function tintProxy($o) {
            $o.info["color"].setTransform($o.target);
        }
        static function frameProxy($o) {
            $o.info.mc.gotoAndStop(Math.round($o.target.frame));
        }
        static function volumeProxy($o) {
            $o.info["sound"].setVolume($o.target.volume);
        }
        function get active() {
            if (_active) {
                return(true);
            } else if (((_curTime - initTime) / 1000) > delay) {
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
                    vars.onStart.apply(vars.onStartScope, vars.onStartParams);
                }
                return(true);
            } else {
                return(false);
            }
        }
        static var version = 7;
        static var killDelayedCallsTo = killTweensOf;
        static var _all = new Object();
        static var _cnt = -16000;
        static var _hrp = false;
    }
