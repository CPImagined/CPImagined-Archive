//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.greensock.plugins.BezierPlugin extends com.greensock.plugins.TweenPlugin
    {
        var propName, overwriteProps, _future, _target, _orientData, _orient, _beziers, round, __get__changeFactor;
        function BezierPlugin () {
            super();
            propName = "bezier";
            overwriteProps = [];
            _future = {};
        }
        function onInitTween(target, value, tween) {
            if (!(value instanceof Array)) {
                return(false);
            }
            init(tween, [value][0], false);
            return(true);
        }
        function init(tween, beziers, through) {
            _target = tween.target;
            var enumerables = tween.vars;
            if (enumerables.orientToBezier == true) {
                _orientData = [["_x", "_y", "_rotation", 0, 0.01]];
                _orient = true;
            } else if (enumerables.orientToBezier instanceof Array) {
                _orientData = enumerables.orientToBezier;
                _orient = true;
            }
            var props = {};
            var i;
            var p;
            var killVarsLookup;
            i = 0;
            while (i < beziers.length) {
                for (p in beziers[i]) {
                    if (props[p] == undefined) {
                        props[p] = [tween.target[p]];
                    }
                    if (typeof(beziers[i][p]) == "number") {
                        props[p].push(beziers[i][p]);
                    } else {
                        props[p].push(tween.target[p] + Number(beziers[i][p]));
                    }
                }
                i++;
            }
            for (p in props) {
                overwriteProps[overwriteProps.length] = p;
                if (enumerables[p] != undefined) {
                    if (typeof(enumerables[p]) == "number") {
                        props[p].push(enumerables[p]);
                    } else {
                        props[p].push(tween.target[p] + Number(enumerables[p]));
                    }
                    killVarsLookup = {};
                    killVarsLookup[p] = true;
                    tween.killVars(killVarsLookup, false);
                    delete enumerables[p];
                }
            }
            _beziers = parseBeziers(props, through);
        }
        static function parseBeziers(props, through) {
            var i;
            var a;
            var b;
            var p;
            var all = {};
            if (through == true) {
                for (p in props) {
                    a = props[p];
                    all[p] = (b = []);
                    if (a.length > 2) {
                        b[b.length] = [a[0], a[1] - ((a[2] - a[0]) / 4), a[1]];
                        i = 1;
                        while (i < (a.length - 1)) {
                            b[b.length] = [a[i], a[i] + (a[i] - b[i - 1][1]), a[i + 1]];
                            i++;
                        }
                    } else {
                        b[b.length] = [a[0], (a[0] + a[1]) / 2, a[1]];
                    }
                }
            } else {
                for (p in props) {
                    a = props[p];
                    all[p] = (b = []);
                    if (a.length > 3) {
                        b[b.length] = [a[0], a[1], (a[1] + a[2]) / 2];
                        i = 2;
                        while (i < (a.length - 2)) {
                            b[b.length] = [b[i - 2][2], a[i], (a[i] + a[i + 1]) / 2];
                            i++;
                        }
                        b[b.length] = [b[b.length - 1][2], a[a.length - 2], a[a.length - 1]];
                    } else if (a.length == 3) {
                        b[b.length] = [a[0], a[1], a[2]];
                    } else if (a.length == 2) {
                        b[b.length] = [a[0], (a[0] + a[1]) / 2, a[1]];
                    }
                }
            }
            return(all);
        }
        function killProps(lookup) {
            for (var p in _beziers) {
                if (lookup[p] != undefined) {
                    delete _beziers[p];
                }
            }
            super.killProps(lookup);
        }
        function set changeFactor(n) {
            var i;
            var p;
            var b;
            var t;
            var segments;
            var val;
            var neg;
            if (n == 1) {
                for (p in _beziers) {
                    i = _beziers[p].length - 1;
                    _target[p] = _beziers[p][i][2];
                }
            } else {
                for (p in _beziers) {
                    segments = _beziers[p].length;
                    if (n < 0) {
                        i = 0;
                    } else if (n >= 1) {
                        i = segments - 1;
                    } else {
                        i = (segments * n) >> 0;
                    }
                    t = (n - (i * (1 / segments))) * segments;
                    b = _beziers[p][i];
                    if (round) {
                        _target[p] = Math.round(b[0] + (t * (((2 * (1 - t)) * (b[1] - b[0])) + (t * (b[2] - b[0])))));
                    } else {
                        _target[p] = b[0] + (t * (((2 * (1 - t)) * (b[1] - b[0])) + (t * (b[2] - b[0]))));
                    }
                }
            }
            if (_orient == true) {
                i = _orientData.length;
                var curVals = {};
                var dx;
                var dy;
                var cotb;
                var toAdd;
                while ((i--) > 0) {
                    cotb = _orientData[i];
                    curVals[cotb[0]] = _target[cotb[0]];
                    curVals[cotb[1]] = _target[cotb[1]];
                }
                var oldTarget = _target;
                var oldRound = round;
                _target = _future;
                round = false;
                _orient = false;
                i = _orientData.length;
                while ((i--) > 0) {
                    cotb = _orientData[i];
                    changeFactor = (n + (cotb[4] || 0.01));
                    toAdd = cotb[3] || 0;
                    dx = _future[cotb[0]] - curVals[cotb[0]];
                    dy = _future[cotb[1]] - curVals[cotb[1]];
                    oldTarget[cotb[2]] = (Math.atan2(dy, dx) * _RAD2DEG) + toAdd;
                }
                _target = oldTarget;
                round = oldRound;
                _orient = true;
            }
            //return(__get__changeFactor());
        }
        static var API = 1;
        static var _RAD2DEG = 57.2957795130823;
    }
