//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.engine.tweener.Equations
    {
        function Equations () {
        }
        static function init() {
            com.clubpenguin.engine.tweener.Tweener.registerTransition("easenone", easeNone);
            com.clubpenguin.engine.tweener.Tweener.registerTransition("linear", easeNone);
            com.clubpenguin.engine.tweener.Tweener.registerTransition("easeinquad", easeInQuad);
            com.clubpenguin.engine.tweener.Tweener.registerTransition("easeoutquad", easeOutQuad);
            com.clubpenguin.engine.tweener.Tweener.registerTransition("easeinoutquad", easeInOutQuad);
            com.clubpenguin.engine.tweener.Tweener.registerTransition("easeoutinquad", easeOutInQuad);
            com.clubpenguin.engine.tweener.Tweener.registerTransition("easeincubic", easeInCubic);
            com.clubpenguin.engine.tweener.Tweener.registerTransition("easeoutcubic", easeOutCubic);
            com.clubpenguin.engine.tweener.Tweener.registerTransition("easeinoutcubic", easeInOutCubic);
            com.clubpenguin.engine.tweener.Tweener.registerTransition("easeoutincubic", easeOutInCubic);
            com.clubpenguin.engine.tweener.Tweener.registerTransition("easeinquart", easeInQuart);
            com.clubpenguin.engine.tweener.Tweener.registerTransition("easeoutquart", easeOutQuart);
            com.clubpenguin.engine.tweener.Tweener.registerTransition("easeinoutquart", easeInOutQuart);
            com.clubpenguin.engine.tweener.Tweener.registerTransition("easeoutinquart", easeOutInQuart);
            com.clubpenguin.engine.tweener.Tweener.registerTransition("easeinquint", easeInQuint);
            com.clubpenguin.engine.tweener.Tweener.registerTransition("easeoutquint", easeOutQuint);
            com.clubpenguin.engine.tweener.Tweener.registerTransition("easeinoutquint", easeInOutQuint);
            com.clubpenguin.engine.tweener.Tweener.registerTransition("easeoutinquint", easeOutInQuint);
            com.clubpenguin.engine.tweener.Tweener.registerTransition("easeinsine", easeInSine);
            com.clubpenguin.engine.tweener.Tweener.registerTransition("easeoutsine", easeOutSine);
            com.clubpenguin.engine.tweener.Tweener.registerTransition("easeinoutsine", easeInOutSine);
            com.clubpenguin.engine.tweener.Tweener.registerTransition("easeoutinsine", easeOutInSine);
            com.clubpenguin.engine.tweener.Tweener.registerTransition("easeincirc", easeInCirc);
            com.clubpenguin.engine.tweener.Tweener.registerTransition("easeoutcirc", easeOutCirc);
            com.clubpenguin.engine.tweener.Tweener.registerTransition("easeinoutcirc", easeInOutCirc);
            com.clubpenguin.engine.tweener.Tweener.registerTransition("easeoutincirc", easeOutInCirc);
            com.clubpenguin.engine.tweener.Tweener.registerTransition("easeinexpo", easeInExpo);
            com.clubpenguin.engine.tweener.Tweener.registerTransition("easeoutexpo", easeOutExpo);
            com.clubpenguin.engine.tweener.Tweener.registerTransition("easeinoutexpo", easeInOutExpo);
            com.clubpenguin.engine.tweener.Tweener.registerTransition("easeoutinexpo", easeOutInExpo);
            com.clubpenguin.engine.tweener.Tweener.registerTransition("easeinelastic", easeInElastic);
            com.clubpenguin.engine.tweener.Tweener.registerTransition("easeoutelastic", easeOutElastic);
            com.clubpenguin.engine.tweener.Tweener.registerTransition("easeinoutelastic", easeInOutElastic);
            com.clubpenguin.engine.tweener.Tweener.registerTransition("easeoutinelastic", easeOutInElastic);
            com.clubpenguin.engine.tweener.Tweener.registerTransition("easeinback", easeInBack);
            com.clubpenguin.engine.tweener.Tweener.registerTransition("easeoutback", easeOutBack);
            com.clubpenguin.engine.tweener.Tweener.registerTransition("easeinoutback", easeInOutBack);
            com.clubpenguin.engine.tweener.Tweener.registerTransition("easeoutinback", easeOutInBack);
            com.clubpenguin.engine.tweener.Tweener.registerTransition("easeinbounce", easeInBounce);
            com.clubpenguin.engine.tweener.Tweener.registerTransition("easeoutbounce", easeOutBounce);
            com.clubpenguin.engine.tweener.Tweener.registerTransition("easeinoutbounce", easeInOutBounce);
            com.clubpenguin.engine.tweener.Tweener.registerTransition("easeoutinbounce", easeOutInBounce);
        }
        static function easeNone(_arg_2, _arg_4, _arg_3, _arg_1, p_params) {
            return(((_arg_3 * _arg_2) / _arg_1) + _arg_4);
        }
        static function easeInQuad(_arg_1, _arg_4, _arg_3, _arg_2, p_params) {
            _arg_1 = _arg_1 / _arg_2;
            return(((_arg_3 * _arg_1) * _arg_1) + _arg_4);
        }
        static function easeOutQuad(_arg_1, _arg_4, _arg_3, _arg_2, p_params) {
            _arg_1 = _arg_1 / _arg_2;
            return((((-_arg_3) * _arg_1) * (_arg_1 - 2)) + _arg_4);
        }
        static function easeInOutQuad(_arg_1, _arg_3, _arg_2, _arg_4, p_params) {
            _arg_1 = _arg_1 / (_arg_4 / 2);
            if (_arg_1 < 1) {
                return((((_arg_2 / 2) * _arg_1) * _arg_1) + _arg_3);
            }
            _arg_1--;
            return((((-_arg_2) / 2) * ((_arg_1 * (_arg_1 - 2)) - 1)) + _arg_3);
        }
        static function easeOutInQuad(_arg_2, _arg_4, _arg_3, _arg_1, _arg_5) {
            if (_arg_2 < (_arg_1 / 2)) {
                return(easeOutQuad(_arg_2 * 2, _arg_4, _arg_3 / 2, _arg_1, _arg_5));
            }
            return(easeInQuad((_arg_2 * 2) - _arg_1, _arg_4 + (_arg_3 / 2), _arg_3 / 2, _arg_1, _arg_5));
        }
        static function easeInCubic(_arg_1, _arg_4, _arg_3, _arg_2, p_params) {
            _arg_1 = _arg_1 / _arg_2;
            return((((_arg_3 * _arg_1) * _arg_1) * _arg_1) + _arg_4);
        }
        static function easeOutCubic(_arg_1, _arg_4, _arg_3, _arg_2, p_params) {
            _arg_1 = (_arg_1 / _arg_2) - 1;
            return((_arg_3 * (((_arg_1 * _arg_1) * _arg_1) + 1)) + _arg_4);
        }
        static function easeInOutCubic(_arg_1, _arg_3, _arg_2, _arg_4, p_params) {
            _arg_1 = _arg_1 / (_arg_4 / 2);
            if (_arg_1 < 1) {
                return(((((_arg_2 / 2) * _arg_1) * _arg_1) * _arg_1) + _arg_3);
            }
            _arg_1 = _arg_1 - 2;
            return(((_arg_2 / 2) * (((_arg_1 * _arg_1) * _arg_1) + 2)) + _arg_3);
        }
        static function easeOutInCubic(_arg_2, _arg_4, _arg_3, _arg_1, _arg_5) {
            if (_arg_2 < (_arg_1 / 2)) {
                return(easeOutCubic(_arg_2 * 2, _arg_4, _arg_3 / 2, _arg_1, _arg_5));
            }
            return(easeInCubic((_arg_2 * 2) - _arg_1, _arg_4 + (_arg_3 / 2), _arg_3 / 2, _arg_1, _arg_5));
        }
        static function easeInQuart(_arg_1, _arg_4, _arg_3, _arg_2, p_params) {
            _arg_1 = _arg_1 / _arg_2;
            return(((((_arg_3 * _arg_1) * _arg_1) * _arg_1) * _arg_1) + _arg_4);
        }
        static function easeOutQuart(_arg_1, _arg_4, _arg_3, _arg_2, p_params) {
            _arg_1 = (_arg_1 / _arg_2) - 1;
            return(((-_arg_3) * ((((_arg_1 * _arg_1) * _arg_1) * _arg_1) - 1)) + _arg_4);
        }
        static function easeInOutQuart(_arg_1, _arg_3, _arg_2, _arg_4, p_params) {
            _arg_1 = _arg_1 / (_arg_4 / 2);
            if (_arg_1 < 1) {
                return((((((_arg_2 / 2) * _arg_1) * _arg_1) * _arg_1) * _arg_1) + _arg_3);
            }
            _arg_1 = _arg_1 - 2;
            return((((-_arg_2) / 2) * ((((_arg_1 * _arg_1) * _arg_1) * _arg_1) - 2)) + _arg_3);
        }
        static function easeOutInQuart(_arg_2, _arg_4, _arg_3, _arg_1, _arg_5) {
            if (_arg_2 < (_arg_1 / 2)) {
                return(easeOutQuart(_arg_2 * 2, _arg_4, _arg_3 / 2, _arg_1, _arg_5));
            }
            return(easeInQuart((_arg_2 * 2) - _arg_1, _arg_4 + (_arg_3 / 2), _arg_3 / 2, _arg_1, _arg_5));
        }
        static function easeInQuint(_arg_1, _arg_4, _arg_3, _arg_2, p_params) {
            _arg_1 = _arg_1 / _arg_2;
            return((((((_arg_3 * _arg_1) * _arg_1) * _arg_1) * _arg_1) * _arg_1) + _arg_4);
        }
        static function easeOutQuint(_arg_1, _arg_4, _arg_3, _arg_2, p_params) {
            _arg_1 = (_arg_1 / _arg_2) - 1;
            return((_arg_3 * (((((_arg_1 * _arg_1) * _arg_1) * _arg_1) * _arg_1) + 1)) + _arg_4);
        }
        static function easeInOutQuint(_arg_1, _arg_3, _arg_2, _arg_4, p_params) {
            _arg_1 = _arg_1 / (_arg_4 / 2);
            if (_arg_1 < 1) {
                return(((((((_arg_2 / 2) * _arg_1) * _arg_1) * _arg_1) * _arg_1) * _arg_1) + _arg_3);
            }
            _arg_1 = _arg_1 - 2;
            return(((_arg_2 / 2) * (((((_arg_1 * _arg_1) * _arg_1) * _arg_1) * _arg_1) + 2)) + _arg_3);
        }
        static function easeOutInQuint(_arg_2, _arg_4, _arg_3, _arg_1, _arg_5) {
            if (_arg_2 < (_arg_1 / 2)) {
                return(easeOutQuint(_arg_2 * 2, _arg_4, _arg_3 / 2, _arg_1, _arg_5));
            }
            return(easeInQuint((_arg_2 * 2) - _arg_1, _arg_4 + (_arg_3 / 2), _arg_3 / 2, _arg_1, _arg_5));
        }
        static function easeInSine(_arg_3, _arg_4, _arg_1, _arg_2, p_params) {
            return((((-_arg_1) * Math.cos((_arg_3 / _arg_2) * (Math.PI/2))) + _arg_1) + _arg_4);
        }
        static function easeOutSine(_arg_2, _arg_4, _arg_3, _arg_1, p_params) {
            return((_arg_3 * Math.sin((_arg_2 / _arg_1) * (Math.PI/2))) + _arg_4);
        }
        static function easeInOutSine(_arg_2, _arg_4, _arg_3, _arg_1, p_params) {
            return((((-_arg_3) / 2) * (Math.cos((Math.PI * _arg_2) / _arg_1) - 1)) + _arg_4);
        }
        static function easeOutInSine(_arg_2, _arg_4, _arg_3, _arg_1, _arg_5) {
            if (_arg_2 < (_arg_1 / 2)) {
                return(easeOutSine(_arg_2 * 2, _arg_4, _arg_3 / 2, _arg_1, _arg_5));
            }
            return(easeInSine((_arg_2 * 2) - _arg_1, _arg_4 + (_arg_3 / 2), _arg_3 / 2, _arg_1, _arg_5));
        }
        static function easeInExpo(_arg_1, _arg_3, _arg_2, _arg_4, p_params) {
            return(((_arg_1 == 0) ? (_arg_3) : (((_arg_2 * Math.pow(2, 10 * ((_arg_1 / _arg_4) - 1))) + _arg_3) - (_arg_2 * 0.001))));
        }
        static function easeOutExpo(_arg_2, _arg_4, _arg_3, _arg_1, p_params) {
            return(((_arg_2 == _arg_1) ? (_arg_4 + _arg_3) : (((_arg_3 * 1.001) * ((-Math.pow(2, (-10 * _arg_2) / _arg_1)) + 1)) + _arg_4)));
        }
        static function easeInOutExpo(_arg_1, _arg_3, _arg_2, _arg_4, p_params) {
            if (_arg_1 == 0) {
                return(_arg_3);
            }
            if (_arg_1 == _arg_4) {
                return(_arg_3 + _arg_2);
            }
            _arg_1 = _arg_1 / (_arg_4 / 2);
            if (_arg_1 < 1) {
                return((((_arg_2 / 2) * Math.pow(2, 10 * (_arg_1 - 1))) + _arg_3) - (_arg_2 * 0.0005));
            }
            _arg_1--;
            return((((_arg_2 / 2) * 1.0005) * ((-Math.pow(2, -10 * _arg_1)) + 2)) + _arg_3);
        }
        static function easeOutInExpo(_arg_2, _arg_4, _arg_3, _arg_1, _arg_5) {
            if (_arg_2 < (_arg_1 / 2)) {
                return(easeOutExpo(_arg_2 * 2, _arg_4, _arg_3 / 2, _arg_1, _arg_5));
            }
            return(easeInExpo((_arg_2 * 2) - _arg_1, _arg_4 + (_arg_3 / 2), _arg_3 / 2, _arg_1, _arg_5));
        }
        static function easeInCirc(_arg_1, _arg_4, _arg_3, _arg_2, p_params) {
            _arg_1 = _arg_1 / _arg_2;
            return(((-_arg_3) * (Math.sqrt(1 - (_arg_1 * _arg_1)) - 1)) + _arg_4);
        }
        static function easeOutCirc(_arg_1, _arg_4, _arg_3, _arg_2, p_params) {
            _arg_1 = (_arg_1 / _arg_2) - 1;
            return((_arg_3 * Math.sqrt(1 - (_arg_1 * _arg_1))) + _arg_4);
        }
        static function easeInOutCirc(_arg_1, _arg_3, _arg_2, _arg_4, p_params) {
            _arg_1 = _arg_1 / (_arg_4 / 2);
            if (_arg_1 < 1) {
                return((((-_arg_2) / 2) * (Math.sqrt(1 - (_arg_1 * _arg_1)) - 1)) + _arg_3);
            }
            _arg_1 = _arg_1 - 2;
            return(((_arg_2 / 2) * (Math.sqrt(1 - (_arg_1 * _arg_1)) + 1)) + _arg_3);
        }
        static function easeOutInCirc(_arg_2, _arg_4, _arg_3, _arg_1, _arg_5) {
            if (_arg_2 < (_arg_1 / 2)) {
                return(easeOutCirc(_arg_2 * 2, _arg_4, _arg_3 / 2, _arg_1, _arg_5));
            }
            return(easeInCirc((_arg_2 * 2) - _arg_1, _arg_4 + (_arg_3 / 2), _arg_3 / 2, _arg_1, _arg_5));
        }
        static function easeInElastic(_arg_3, _arg_7, _arg_4, _arg_6, _arg_8) {
            if (_arg_3 == 0) {
                return(_arg_7);
            }
            _arg_3 = _arg_3 / _arg_6;
            if (_arg_3 == 1) {
                return(_arg_7 + _arg_4);
            }
            var _local_2 = ((_arg_8.period == undefined) ? (_arg_6 * 0.3) : (_arg_8.period));
            var _local_5;
            var _local_1 = _arg_8.amplitude;
            if ((!_local_1) || (_local_1 < Math.abs(_arg_4))) {
                _local_1 = _arg_4;
                _local_5 = _local_2 / 4;
            } else {
                _local_5 = (_local_2 / (Math.PI*2)) * Math.asin(_arg_4 / _local_1);
            }
            _arg_3 = _arg_3 - 1;
            return((-((_local_1 * Math.pow(2, 10 * _arg_3)) * Math.sin((((_arg_3 * _arg_6) - _local_5) * (Math.PI*2)) / _local_2))) + _arg_7);
        }
        static function easeOutElastic(_arg_4, _arg_7, _arg_2, _arg_6, _arg_8) {
            if (_arg_4 == 0) {
                return(_arg_7);
            }
            _arg_4 = _arg_4 / _arg_6;
            if (_arg_4 == 1) {
                return(_arg_7 + _arg_2);
            }
            var _local_3 = ((_arg_8.period == undefined) ? (_arg_6 * 0.3) : (_arg_8.period));
            var _local_5;
            var _local_1 = _arg_8.amplitude;
            if ((!_local_1) || (_local_1 < Math.abs(_arg_2))) {
                _local_1 = _arg_2;
                _local_5 = _local_3 / 4;
            } else {
                _local_5 = (_local_3 / (Math.PI*2)) * Math.asin(_arg_2 / _local_1);
            }
            return((((_local_1 * Math.pow(2, -10 * _arg_4)) * Math.sin((((_arg_4 * _arg_6) - _local_5) * (Math.PI*2)) / _local_3)) + _arg_2) + _arg_7);
        }
        static function easeInOutElastic(_arg_2, _arg_7, _arg_4, _arg_6, _arg_8) {
            if (_arg_2 == 0) {
                return(_arg_7);
            }
            _arg_2 = _arg_2 / (_arg_6 / 2);
            if (_arg_2 == 2) {
                return(_arg_7 + _arg_4);
            }
            var _local_3 = ((_arg_8.period == undefined) ? (_arg_6 * 0.45) : (_arg_8.period));
            var _local_5;
            var _local_1 = _arg_8.amplitude;
            if ((!_local_1) || (_local_1 < Math.abs(_arg_4))) {
                _local_1 = _arg_4;
                _local_5 = _local_3 / 4;
            } else {
                _local_5 = (_local_3 / (Math.PI*2)) * Math.asin(_arg_4 / _local_1);
            }
            if (_arg_2 < 1) {
                _arg_2 = _arg_2 - 1;
                return((-0.5 * ((_local_1 * Math.pow(2, 10 * _arg_2)) * Math.sin((((_arg_2 * _arg_6) - _local_5) * (Math.PI*2)) / _local_3))) + _arg_7);
            }
            _arg_2 = _arg_2 - 1;
            return(((((_local_1 * Math.pow(2, -10 * _arg_2)) * Math.sin((((_arg_2 * _arg_6) - _local_5) * (Math.PI*2)) / _local_3)) * 0.5) + _arg_4) + _arg_7);
        }
        static function easeOutInElastic(_arg_2, _arg_4, _arg_3, _arg_1, _arg_5) {
            if (_arg_2 < (_arg_1 / 2)) {
                return(easeOutElastic(_arg_2 * 2, _arg_4, _arg_3 / 2, _arg_1, _arg_5));
            }
            return(easeInElastic((_arg_2 * 2) - _arg_1, _arg_4 + (_arg_3 / 2), _arg_3 / 2, _arg_1, _arg_5));
        }
        static function easeInBack(_arg_2, _arg_6, _arg_5, _arg_4, _arg_3) {
            var _local_1 = ((_arg_3.overshoot == undefined) ? 1.70158 : (_arg_3.overshoot));
            _arg_2 = _arg_2 / _arg_4;
            return((((_arg_5 * _arg_2) * _arg_2) * (((_local_1 + 1) * _arg_2) - _local_1)) + _arg_6);
        }
        static function easeOutBack(_arg_1, _arg_6, _arg_5, _arg_4, _arg_3) {
            var _local_2 = ((_arg_3.overshoot == undefined) ? 1.70158 : (_arg_3.overshoot));
            _arg_1 = (_arg_1 / _arg_4) - 1;
            return((_arg_5 * (((_arg_1 * _arg_1) * (((_local_2 + 1) * _arg_1) + _local_2)) + 1)) + _arg_6);
        }
        static function easeInOutBack(_arg_1, _arg_4, _arg_3, _arg_6, _arg_5) {
            var _local_2 = ((_arg_5.overshoot == undefined) ? 1.70158 : (_arg_5.overshoot));
            _arg_1 = _arg_1 / (_arg_6 / 2);
            if (_arg_1 < 1) {
                _local_2 = _local_2 * 1.525;
                return(((_arg_3 / 2) * ((_arg_1 * _arg_1) * (((_local_2 + 1) * _arg_1) - _local_2))) + _arg_4);
            }
            _arg_1 = _arg_1 - 2;
            _local_2 = _local_2 * 1.525;
            return(((_arg_3 / 2) * (((_arg_1 * _arg_1) * (((_local_2 + 1) * _arg_1) + _local_2)) + 2)) + _arg_4);
        }
        static function easeOutInBack(_arg_2, _arg_4, _arg_3, _arg_1, _arg_5) {
            if (_arg_2 < (_arg_1 / 2)) {
                return(easeOutBack(_arg_2 * 2, _arg_4, _arg_3 / 2, _arg_1, _arg_5));
            }
            return(easeInBack((_arg_2 * 2) - _arg_1, _arg_4 + (_arg_3 / 2), _arg_3 / 2, _arg_1, _arg_5));
        }
        static function easeInBounce(_arg_3, _arg_4, _arg_2, _arg_1, p_params) {
            return((_arg_2 - easeOutBounce(_arg_1 - _arg_3, 0, _arg_2, _arg_1)) + _arg_4);
        }
        static function easeOutBounce(_arg_1, _arg_3, _arg_2, _arg_4, p_params) {
            _arg_1 = _arg_1 / _arg_4;
            if (_arg_1 < 0.363636363636364) {
                return((_arg_2 * ((7.5625 * _arg_1) * _arg_1)) + _arg_3);
            }
            if (_arg_1 < 0.727272727272727) {
                _arg_1 = _arg_1 - 0.545454545454545;
                return((_arg_2 * (((7.5625 * _arg_1) * _arg_1) + 0.75)) + _arg_3);
            }
            if (_arg_1 < 0.909090909090909) {
                _arg_1 = _arg_1 - 0.818181818181818;
                return((_arg_2 * (((7.5625 * _arg_1) * _arg_1) + 0.9375)) + _arg_3);
            }
            _arg_1 = _arg_1 - 0.954545454545455;
            return((_arg_2 * (((7.5625 * _arg_1) * _arg_1) + 0.984375)) + _arg_3);
        }
        static function easeInOutBounce(_arg_2, _arg_4, _arg_3, _arg_1, p_params) {
            if (_arg_2 < (_arg_1 / 2)) {
                return((easeInBounce(_arg_2 * 2, 0, _arg_3, _arg_1) * 0.5) + _arg_4);
            }
            return(((easeOutBounce((_arg_2 * 2) - _arg_1, 0, _arg_3, _arg_1) * 0.5) + (_arg_3 * 0.5)) + _arg_4);
        }
        static function easeOutInBounce(_arg_2, _arg_4, _arg_3, _arg_1, _arg_5) {
            if (_arg_2 < (_arg_1 / 2)) {
                return(easeOutBounce(_arg_2 * 2, _arg_4, _arg_3 / 2, _arg_1, _arg_5));
            }
            return(easeInBounce((_arg_2 * 2) - _arg_1, _arg_4 + (_arg_3 / 2), _arg_3 / 2, _arg_1, _arg_5));
        }
    }
