
//Created by Action Script Viewer - http://www.buraks.com/asv
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
        static function easeNone(t, b, c, d, p_params) {
            return(((c * t) / d) + b);
        }
        static function easeInQuad(t, b, c, d, p_params) {
            t = t / d;
            return(((c * t) * t) + b);
        }
        static function easeOutQuad(t, b, c, d, p_params) {
            t = t / d;
            return((((-c) * t) * (t - 2)) + b);
        }
        static function easeInOutQuad(t, b, c, d, p_params) {
            t = t / (d / 2);
            if (t < 1) {
                return((((c / 2) * t) * t) + b);
            }
            t--;
            return((((-c) / 2) * ((t * (t - 2)) - 1)) + b);
        }
        static function easeOutInQuad(t, b, c, d, p_params) {
            if (t < (d / 2)) {
                return(easeOutQuad(t * 2, b, c / 2, d, p_params));
            }
            return(easeInQuad((t * 2) - d, b + (c / 2), c / 2, d, p_params));
        }
        static function easeInCubic(t, b, c, d, p_params) {
            t = t / d;
            return((((c * t) * t) * t) + b);
        }
        static function easeOutCubic(t, b, c, d, p_params) {
            t = (t / d) - 1;
            return((c * (((t * t) * t) + 1)) + b);
        }
        static function easeInOutCubic(t, b, c, d, p_params) {
            t = t / (d / 2);
            if (t < 1) {
                return(((((c / 2) * t) * t) * t) + b);
            }
            t = t - 2;
            return(((c / 2) * (((t * t) * t) + 2)) + b);
        }
        static function easeOutInCubic(t, b, c, d, p_params) {
            if (t < (d / 2)) {
                return(easeOutCubic(t * 2, b, c / 2, d, p_params));
            }
            return(easeInCubic((t * 2) - d, b + (c / 2), c / 2, d, p_params));
        }
        static function easeInQuart(t, b, c, d, p_params) {
            t = t / d;
            return(((((c * t) * t) * t) * t) + b);
        }
        static function easeOutQuart(t, b, c, d, p_params) {
            t = (t / d) - 1;
            return(((-c) * ((((t * t) * t) * t) - 1)) + b);
        }
        static function easeInOutQuart(t, b, c, d, p_params) {
            t = t / (d / 2);
            if (t < 1) {
                return((((((c / 2) * t) * t) * t) * t) + b);
            }
            t = t - 2;
            return((((-c) / 2) * ((((t * t) * t) * t) - 2)) + b);
        }
        static function easeOutInQuart(t, b, c, d, p_params) {
            if (t < (d / 2)) {
                return(easeOutQuart(t * 2, b, c / 2, d, p_params));
            }
            return(easeInQuart((t * 2) - d, b + (c / 2), c / 2, d, p_params));
        }
        static function easeInQuint(t, b, c, d, p_params) {
            t = t / d;
            return((((((c * t) * t) * t) * t) * t) + b);
        }
        static function easeOutQuint(t, b, c, d, p_params) {
            t = (t / d) - 1;
            return((c * (((((t * t) * t) * t) * t) + 1)) + b);
        }
        static function easeInOutQuint(t, b, c, d, p_params) {
            t = t / (d / 2);
            if (t < 1) {
                return(((((((c / 2) * t) * t) * t) * t) * t) + b);
            }
            t = t - 2;
            return(((c / 2) * (((((t * t) * t) * t) * t) + 2)) + b);
        }
        static function easeOutInQuint(t, b, c, d, p_params) {
            if (t < (d / 2)) {
                return(easeOutQuint(t * 2, b, c / 2, d, p_params));
            }
            return(easeInQuint((t * 2) - d, b + (c / 2), c / 2, d, p_params));
        }
        static function easeInSine(t, b, c, d, p_params) {
            return((((-c) * Math.cos((t / d) * (Math.PI/2))) + c) + b);
        }
        static function easeOutSine(t, b, c, d, p_params) {
            return((c * Math.sin((t / d) * (Math.PI/2))) + b);
        }
        static function easeInOutSine(t, b, c, d, p_params) {
            return((((-c) / 2) * (Math.cos((Math.PI * t) / d) - 1)) + b);
        }
        static function easeOutInSine(t, b, c, d, p_params) {
            if (t < (d / 2)) {
                return(easeOutSine(t * 2, b, c / 2, d, p_params));
            }
            return(easeInSine((t * 2) - d, b + (c / 2), c / 2, d, p_params));
        }
        static function easeInExpo(t, b, c, d, p_params) {
            return(((t == 0) ? (b) : (((c * Math.pow(2, 10 * ((t / d) - 1))) + b) - (c * 0.001))));
        }
        static function easeOutExpo(t, b, c, d, p_params) {
            return(((t == d) ? (b + c) : (((c * 1.001) * ((-Math.pow(2, (-10 * t) / d)) + 1)) + b)));
        }
        static function easeInOutExpo(t, b, c, d, p_params) {
            if (t == 0) {
                return(b);
            }
            if (t == d) {
                return(b + c);
            }
            t = t / (d / 2);
            if (t < 1) {
                return((((c / 2) * Math.pow(2, 10 * (t - 1))) + b) - (c * 0.0005));
            }
            t--;
            return((((c / 2) * 1.0005) * ((-Math.pow(2, -10 * t)) + 2)) + b);
        }
        static function easeOutInExpo(t, b, c, d, p_params) {
            if (t < (d / 2)) {
                return(easeOutExpo(t * 2, b, c / 2, d, p_params));
            }
            return(easeInExpo((t * 2) - d, b + (c / 2), c / 2, d, p_params));
        }
        static function easeInCirc(t, b, c, d, p_params) {
            t = t / d;
            return(((-c) * (Math.sqrt(1 - (t * t)) - 1)) + b);
        }
        static function easeOutCirc(t, b, c, d, p_params) {
            t = (t / d) - 1;
            return((c * Math.sqrt(1 - (t * t))) + b);
        }
        static function easeInOutCirc(t, b, c, d, p_params) {
            t = t / (d / 2);
            if (t < 1) {
                return((((-c) / 2) * (Math.sqrt(1 - (t * t)) - 1)) + b);
            }
            t = t - 2;
            return(((c / 2) * (Math.sqrt(1 - (t * t)) + 1)) + b);
        }
        static function easeOutInCirc(t, b, c, d, p_params) {
            if (t < (d / 2)) {
                return(easeOutCirc(t * 2, b, c / 2, d, p_params));
            }
            return(easeInCirc((t * 2) - d, b + (c / 2), c / 2, d, p_params));
        }
        static function easeInElastic(t, b, c, d, p_params) {
            if (t == 0) {
                return(b);
            }
            t = t / d;
            if (t == 1) {
                return(b + c);
            }
            var _local2 = ((p_params.period == undefined) ? (d * 0.3) : (p_params.period));
            var _local5;
            var _local1 = p_params.amplitude;
            if ((!_local1) || (_local1 < Math.abs(c))) {
                _local1 = c;
                _local5 = _local2 / 4;
            } else {
                _local5 = (_local2 / (Math.PI*2)) * Math.asin(c / _local1);
            }
            t = t - 1;
            return((-((_local1 * Math.pow(2, 10 * t)) * Math.sin((((t * d) - _local5) * (Math.PI*2)) / _local2))) + b);
        }
        static function easeOutElastic(t, b, c, d, p_params) {
            if (t == 0) {
                return(b);
            }
            t = t / d;
            if (t == 1) {
                return(b + c);
            }
            var _local3 = ((p_params.period == undefined) ? (d * 0.3) : (p_params.period));
            var _local5;
            var _local1 = p_params.amplitude;
            if ((!_local1) || (_local1 < Math.abs(c))) {
                _local1 = c;
                _local5 = _local3 / 4;
            } else {
                _local5 = (_local3 / (Math.PI*2)) * Math.asin(c / _local1);
            }
            return((((_local1 * Math.pow(2, -10 * t)) * Math.sin((((t * d) - _local5) * (Math.PI*2)) / _local3)) + c) + b);
        }
        static function easeInOutElastic(t, b, c, d, p_params) {
            if (t == 0) {
                return(b);
            }
            t = t / (d / 2);
            if (t == 2) {
                return(b + c);
            }
            var _local3 = ((p_params.period == undefined) ? (d * 0.45) : (p_params.period));
            var _local5;
            var _local1 = p_params.amplitude;
            if ((!_local1) || (_local1 < Math.abs(c))) {
                _local1 = c;
                _local5 = _local3 / 4;
            } else {
                _local5 = (_local3 / (Math.PI*2)) * Math.asin(c / _local1);
            }
            if (t < 1) {
                t = t - 1;
                return((-0.5 * ((_local1 * Math.pow(2, 10 * t)) * Math.sin((((t * d) - _local5) * (Math.PI*2)) / _local3))) + b);
            }
            t = t - 1;
            return(((((_local1 * Math.pow(2, -10 * t)) * Math.sin((((t * d) - _local5) * (Math.PI*2)) / _local3)) * 0.5) + c) + b);
        }
        static function easeOutInElastic(t, b, c, d, p_params) {
            if (t < (d / 2)) {
                return(easeOutElastic(t * 2, b, c / 2, d, p_params));
            }
            return(easeInElastic((t * 2) - d, b + (c / 2), c / 2, d, p_params));
        }
        static function easeInBack(t, b, c, d, p_params) {
            var _local1 = ((p_params.overshoot == undefined) ? 1.70158 : (p_params.overshoot));
            t = t / d;
            return((((c * t) * t) * (((_local1 + 1) * t) - _local1)) + b);
        }
        static function easeOutBack(t, b, c, d, p_params) {
            var _local2 = ((p_params.overshoot == undefined) ? 1.70158 : (p_params.overshoot));
            t = (t / d) - 1;
            return((c * (((t * t) * (((_local2 + 1) * t) + _local2)) + 1)) + b);
        }
        static function easeInOutBack(t, b, c, d, p_params) {
            var _local2 = ((p_params.overshoot == undefined) ? 1.70158 : (p_params.overshoot));
            t = t / (d / 2);
            if (t < 1) {
                _local2 = _local2 * 1.525;
                return(((c / 2) * ((t * t) * (((_local2 + 1) * t) - _local2))) + b);
            }
            t = t - 2;
            _local2 = _local2 * 1.525;
            return(((c / 2) * (((t * t) * (((_local2 + 1) * t) + _local2)) + 2)) + b);
        }
        static function easeOutInBack(t, b, c, d, p_params) {
            if (t < (d / 2)) {
                return(easeOutBack(t * 2, b, c / 2, d, p_params));
            }
            return(easeInBack((t * 2) - d, b + (c / 2), c / 2, d, p_params));
        }
        static function easeInBounce(t, b, c, d, p_params) {
            return((c - easeOutBounce(d - t, 0, c, d)) + b);
        }
        static function easeOutBounce(t, b, c, d, p_params) {
            t = t / d;
            if (t < 0.363636363636364) {
                return((c * ((7.5625 * t) * t)) + b);
            } else if (t < 0.727272727272727) {
                t = t - 0.545454545454545;
                return((c * (((7.5625 * t) * t) + 0.75)) + b);
            } else if (t < 0.909090909090909) {
                t = t - 0.818181818181818;
                return((c * (((7.5625 * t) * t) + 0.9375)) + b);
            } else {
                t = t - 0.954545454545455;
                return((c * (((7.5625 * t) * t) + 0.984375)) + b);
            }
        }
        static function easeInOutBounce(t, b, c, d, p_params) {
            if (t < (d / 2)) {
                return((easeInBounce(t * 2, 0, c, d) * 0.5) + b);
            } else {
                return(((easeOutBounce((t * 2) - d, 0, c, d) * 0.5) + (c * 0.5)) + b);
            }
        }
        static function easeOutInBounce(t, b, c, d, p_params) {
            if (t < (d / 2)) {
                return(easeOutBounce(t * 2, b, c / 2, d, p_params));
            }
            return(easeInBounce((t * 2) - d, b + (c / 2), c / 2, d, p_params));
        }
    }
