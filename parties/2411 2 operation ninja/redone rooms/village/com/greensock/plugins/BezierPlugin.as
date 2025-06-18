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
            var _local_7 = tween.vars;
            if (_local_7.orientToBezier == true) {
                _orientData = [["_x", "_y", "_rotation", 0, 0.01]];
                _orient = true;
            } else if (_local_7.orientToBezier instanceof Array) {
                _orientData = _local_7.orientToBezier;
                _orient = true;
            }
            var _local_3 = {};
            var _local_4;
            var _local_2;
            var _local_8;
            _local_4 = 0;
            while (_local_4 < beziers.length) {
                for (_local_2 in beziers[_local_4]) {
                    if (_local_3[_local_2] == undefined) {
                        _local_3[_local_2] = [tween.target[_local_2]];
                    }
                    if (typeof(beziers[_local_4][_local_2]) == "number") {
                        _local_3[_local_2].push(beziers[_local_4][_local_2]);
                    } else {
                        _local_3[_local_2].push(tween.target[_local_2] + Number(beziers[_local_4][_local_2]));
                    }
                }
                _local_4++;
            }
            for (_local_2 in _local_3) {
                overwriteProps[overwriteProps.length] = _local_2;
                if (_local_7[_local_2] != undefined) {
                    if (typeof(_local_7[_local_2]) == "number") {
                        _local_3[_local_2].push(_local_7[_local_2]);
                    } else {
                        _local_3[_local_2].push(tween.target[_local_2] + Number(_local_7[_local_2]));
                    }
                    _local_8 = {};
                    _local_8[_local_2] = true;
                    tween.killVars(_local_8, false);
                    delete _local_7[_local_2];
                }
            }
            _beziers = parseBeziers(_local_3, through);
        }
        static function parseBeziers(props, through) {
            var _local_2;
            var _local_1;
            var _local_3;
            var _local_4;
            var _local_6 = {};
            if (through == true) {
                for (_local_4 in props) {
                    _local_1 = props[_local_4];
                    _local_3 = [];
                    _local_6[_local_4] = _local_3;
                    if (_local_1.length > 2) {
                        _local_3[_local_3.length] = [_local_1[0], _local_1[1] - ((_local_1[2] - _local_1[0]) / 4), _local_1[1]];
                        _local_2 = 1;
                        while (_local_2 < (_local_1.length - 1)) {
                            _local_3[_local_3.length] = [_local_1[_local_2], _local_1[_local_2] + (_local_1[_local_2] - _local_3[_local_2 - 1][1]), _local_1[_local_2 + 1]];
                            _local_2++;
                        }
                    } else {
                        _local_3[_local_3.length] = [_local_1[0], (_local_1[0] + _local_1[1]) / 2, _local_1[1]];
                    }
                }
            } else {
                for (_local_4 in props) {
                    _local_1 = props[_local_4];
                    _local_3 = [];
                    _local_6[_local_4] = _local_3;
                    if (_local_1.length > 3) {
                        _local_3[_local_3.length] = [_local_1[0], _local_1[1], (_local_1[1] + _local_1[2]) / 2];
                        _local_2 = 2;
                        while (_local_2 < (_local_1.length - 2)) {
                            _local_3[_local_3.length] = [_local_3[_local_2 - 2][2], _local_1[_local_2], (_local_1[_local_2] + _local_1[_local_2 + 1]) / 2];
                            _local_2++;
                        }
                        _local_3[_local_3.length] = [_local_3[_local_3.length - 1][2], _local_1[_local_1.length - 2], _local_1[_local_1.length - 1]];
                    } else if (_local_1.length == 3) {
                        _local_3[_local_3.length] = [_local_1[0], _local_1[1], _local_1[2]];
                    } else if (_local_1.length == 2) {
                        _local_3[_local_3.length] = [_local_1[0], (_local_1[0] + _local_1[1]) / 2, _local_1[1]];
                    }
                }
            }
            return(_local_6);
        }
        function killProps(lookup) {
            for (var _local_4 in _beziers) {
                if (lookup[_local_4] != undefined) {
                    delete _beziers[_local_4];
                }
            }
            super.killProps(lookup);
        }
        function set changeFactor(n) {
            var _local_3;
            var _local_5;
            var _local_4;
            var _local_6;
            var _local_7;
            var _local_15;
            var _local_16;
            if (n == 1) {
                for (_local_5 in _beziers) {
                    _local_3 = _beziers[_local_5].length - 1;
                    _target[_local_5] = _beziers[_local_5][_local_3][2];
                }
            } else {
                for (_local_5 in _beziers) {
                    _local_7 = _beziers[_local_5].length;
                    if (n < 0) {
                        _local_3 = 0;
                    } else if (n >= 1) {
                        _local_3 = _local_7 - 1;
                    } else {
                        _local_3 = (_local_7 * n) >> 0;
                    }
                    _local_6 = (n - (_local_3 * (1 / _local_7))) * _local_7;
                    _local_4 = _beziers[_local_5][_local_3];
                    if (round) {
                        _target[_local_5] = Math.round(_local_4[0] + (_local_6 * (((2 * (1 - _local_6)) * (_local_4[1] - _local_4[0])) + (_local_6 * (_local_4[2] - _local_4[0])))));
                    } else {
                        _target[_local_5] = _local_4[0] + (_local_6 * (((2 * (1 - _local_6)) * (_local_4[1] - _local_4[0])) + (_local_6 * (_local_4[2] - _local_4[0]))));
                    }
                }
            }
            if (_orient == true) {
                _local_3 = _orientData.length;
                var _local_9 = {};
                var _local_11;
                var _local_10;
                var _local_2;
                var _local_12;
                while ((_local_3--) > 0) {
                    _local_2 = _orientData[_local_3];
                    _local_9[_local_2[0]] = _target[_local_2[0]];
                    _local_9[_local_2[1]] = _target[_local_2[1]];
                }
                var _local_13 = _target;
                var _local_14 = round;
                _target = _future;
                round = false;
                _orient = false;
                _local_3 = _orientData.length;
                while ((_local_3--) > 0) {
                    _local_2 = _orientData[_local_3];
                    changeFactor = (n + (_local_2[4] || 0.01));
                    _local_12 = _local_2[3] || 0;
                    _local_11 = _future[_local_2[0]] - _local_9[_local_2[0]];
                    _local_10 = _future[_local_2[1]] - _local_9[_local_2[1]];
                    _local_13[_local_2[2]] = (Math.atan2(_local_10, _local_11) * _RAD2DEG) + _local_12;
                }
                _target = _local_13;
                round = _local_14;
                _orient = true;
            }
            //return(__get__changeFactor());
        }
        static var API = 1;
        static var _RAD2DEG = 57.2957795130823;
    }
