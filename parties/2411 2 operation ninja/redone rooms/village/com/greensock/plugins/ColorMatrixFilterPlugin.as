    class com.greensock.plugins.ColorMatrixFilterPlugin extends com.greensock.plugins.FilterPlugin
    {
        var propName, overwriteProps, _target, _type, initFilter, _matrix, _filter, _matrixTween, __get__changeFactor;
        function ColorMatrixFilterPlugin () {
            super();
            propName = "colorMatrixFilter";
            overwriteProps = ["colorMatrixFilter"];
        }
        function onInitTween(target, value, tween) {
            _target = target;
            _type = flash.filters.ColorMatrixFilter;
            var _local_3 = value;
            initFilter({remove:value.remove, index:value.index, addFilter:value.addFilter}, new flash.filters.ColorMatrixFilter(_idMatrix.slice()), _propNames);
            _matrix = flash.filters.ColorMatrixFilter(_filter).matrix;
            var _local_2 = [];
            if ((_local_3.matrix != undefined) && (_local_3.matrix instanceof Array)) {
                _local_2 = _local_3.matrix;
            } else {
                if (_local_3.relative == true) {
                    _local_2 = _matrix.slice();
                } else {
                    _local_2 = _idMatrix.slice();
                }
                _local_2 = setBrightness(_local_2, _local_3.brightness);
                _local_2 = setContrast(_local_2, _local_3.contrast);
                _local_2 = setHue(_local_2, _local_3.hue);
                _local_2 = setSaturation(_local_2, _local_3.saturation);
                _local_2 = setThreshold(_local_2, _local_3.threshold);
                if (!isNaN(_local_3.colorize)) {
                    _local_2 = colorize(_local_2, _local_3.colorize, _local_3.amount);
                }
            }
            _matrixTween = new com.greensock.plugins.EndArrayPlugin();
            _matrixTween.init(_matrix, _local_2);
            return(true);
        }
        function set changeFactor(n) {
            _matrixTween.changeFactor = n;
            flash.filters.ColorMatrixFilter(_filter).matrix = _matrix;
            super.changeFactor = n;
            //return(__get__changeFactor());
        }
        static function colorize(m, color, amount) {
            if (isNaN(color)) {
                return(m);
            }
            if (isNaN(amount)) {
                amount = 1;
            }
            var _local_3 = ((color >> 16) & 255) / 255;
            var _local_5 = ((color >> 8) & 255) / 255;
            var _local_2 = (color & 255) / 255;
            var _local_4 = 1 - amount;
            var _local_7 = [_local_4 + ((amount * _local_3) * _lumR), (amount * _local_3) * _lumG, (amount * _local_3) * _lumB, 0, 0, (amount * _local_5) * _lumR, _local_4 + ((amount * _local_5) * _lumG), (amount * _local_5) * _lumB, 0, 0, (amount * _local_2) * _lumR, (amount * _local_2) * _lumG, _local_4 + ((amount * _local_2) * _lumB), 0, 0, 0, 0, 0, 1, 0];
            return(applyMatrix(_local_7, m));
        }
        static function setThreshold(m, n) {
            if (isNaN(n)) {
                return(m);
            }
            var _local_2 = [_lumR * 256, _lumG * 256, _lumB * 256, 0, -256 * n, _lumR * 256, _lumG * 256, _lumB * 256, 0, -256 * n, _lumR * 256, _lumG * 256, _lumB * 256, 0, -256 * n, 0, 0, 0, 1, 0];
            return(applyMatrix(_local_2, m));
        }
        static function setHue(m, n) {
            if (isNaN(n)) {
                return(m);
            }
            n = n * (Math.PI/180);
            var _local_1 = Math.cos(n);
            var _local_2 = Math.sin(n);
            var _local_4 = [(_lumR + (_local_1 * (1 - _lumR))) + (_local_2 * (-_lumR)), (_lumG + (_local_1 * (-_lumG))) + (_local_2 * (-_lumG)), (_lumB + (_local_1 * (-_lumB))) + (_local_2 * (1 - _lumB)), 0, 0, (_lumR + (_local_1 * (-_lumR))) + (_local_2 * 0.143), (_lumG + (_local_1 * (1 - _lumG))) + (_local_2 * 0.14), (_lumB + (_local_1 * (-_lumB))) + (_local_2 * -0.283), 0, 0, (_lumR + (_local_1 * (-_lumR))) + (_local_2 * (-(1 - _lumR))), (_lumG + (_local_1 * (-_lumG))) + (_local_2 * _lumG), (_lumB + (_local_1 * (1 - _lumB))) + (_local_2 * _lumB), 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1];
            return(applyMatrix(_local_4, m));
        }
        static function setBrightness(m, n) {
            if (isNaN(n)) {
                return(m);
            }
            n = (n * 100) - 100;
            return(applyMatrix([1, 0, 0, 0, n, 0, 1, 0, 0, n, 0, 0, 1, 0, n, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1], m));
        }
        static function setSaturation(m, n) {
            if (isNaN(n)) {
                return(m);
            }
            var _local_4 = 1 - n;
            var _local_2 = _local_4 * _lumR;
            var _local_5 = _local_4 * _lumG;
            var _local_1 = _local_4 * _lumB;
            var _local_6 = [_local_2 + n, _local_5, _local_1, 0, 0, _local_2, _local_5 + n, _local_1, 0, 0, _local_2, _local_5, _local_1 + n, 0, 0, 0, 0, 0, 1, 0];
            return(applyMatrix(_local_6, m));
        }
        static function setContrast(m, n) {
            if (isNaN(n)) {
                return(m);
            }
            n = n + 0.01;
            var _local_2 = [n, 0, 0, 0, 128 * (1 - n), 0, n, 0, 0, 128 * (1 - n), 0, 0, n, 0, 128 * (1 - n), 0, 0, 0, 1, 0];
            return(applyMatrix(_local_2, m));
        }
        static function applyMatrix(m, m2) {
            if ((!(m instanceof Array)) || (!(m2 instanceof Array))) {
                return(m2);
            }
            var _local_7 = [];
            var _local_2 = 0;
            var _local_5 = 0;
            var _local_6;
            var _local_1;
            _local_6 = 0;
            while (_local_6 < 4) {
                _local_1 = 0;
                while (_local_1 < 5) {
                    if (_local_1 == 4) {
                        _local_5 = m[_local_2 + 4];
                    } else {
                        _local_5 = 0;
                    }
                    _local_7[_local_2 + _local_1] = ((((m[_local_2] * m2[_local_1]) + (m[_local_2 + 1] * m2[_local_1 + 5])) + (m[_local_2 + 2] * m2[_local_1 + 10])) + (m[_local_2 + 3] * m2[_local_1 + 15])) + _local_5;
                    _local_1++;
                }
                _local_2 = _local_2 + 5;
                _local_6++;
            }
            return(_local_7);
        }
        static var API = 1;
        static var _propNames = [];
        static var _idMatrix = [1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0];
        static var _lumR = 0.212671;
        static var _lumG = 0.71516;
        static var _lumB = 0.072169;
    }
