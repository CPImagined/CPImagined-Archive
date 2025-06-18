//Created by Action Script Viewer - https://www.buraks.com/asv
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
            var cmf = value;
            initFilter({remove:value.remove, index:value.index, addFilter:value.addFilter}, new flash.filters.ColorMatrixFilter(_idMatrix.slice()), _propNames);
            _matrix = flash.filters.ColorMatrixFilter(_filter).matrix;
            var endMatrix = [];
            if ((cmf.matrix != undefined) && (cmf.matrix instanceof Array)) {
                endMatrix = cmf.matrix;
            } else {
                if (cmf.relative == true) {
                    endMatrix = _matrix.slice();
                } else {
                    endMatrix = _idMatrix.slice();
                }
                endMatrix = setBrightness(endMatrix, cmf.brightness);
                endMatrix = setContrast(endMatrix, cmf.contrast);
                endMatrix = setHue(endMatrix, cmf.hue);
                endMatrix = setSaturation(endMatrix, cmf.saturation);
                endMatrix = setThreshold(endMatrix, cmf.threshold);
                if (!isNaN(cmf.colorize)) {
                    endMatrix = colorize(endMatrix, cmf.colorize, cmf.amount);
                }
            }
            _matrixTween = new com.greensock.plugins.EndArrayPlugin();
            _matrixTween.init(_matrix, endMatrix);
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
            } else if (isNaN(amount)) {
                amount = 1;
            }
            var r = (((color >> 16) & 255) / 255);
            var g = (((color >> 8) & 255) / 255);
            var b = ((color & 255) / 255);
            var inv = (1 - amount);
            var temp = [inv + ((amount * r) * _lumR), (amount * r) * _lumG, (amount * r) * _lumB, 0, 0, (amount * g) * _lumR, inv + ((amount * g) * _lumG), (amount * g) * _lumB, 0, 0, (amount * b) * _lumR, (amount * b) * _lumG, inv + ((amount * b) * _lumB), 0, 0, 0, 0, 0, 1, 0];
            return(applyMatrix(temp, m));
        }
        static function setThreshold(m, n) {
            if (isNaN(n)) {
                return(m);
            }
            var temp = [_lumR * 256, _lumG * 256, _lumB * 256, 0, -256 * n, _lumR * 256, _lumG * 256, _lumB * 256, 0, -256 * n, _lumR * 256, _lumG * 256, _lumB * 256, 0, -256 * n, 0, 0, 0, 1, 0];
            return(applyMatrix(temp, m));
        }
        static function setHue(m, n) {
            if (isNaN(n)) {
                return(m);
            }
            n = n * (Math.PI/180);
            var c = Math.cos(n);
            var s = Math.sin(n);
            var temp = [(_lumR + (c * (1 - _lumR))) + (s * (-_lumR)), (_lumG + (c * (-_lumG))) + (s * (-_lumG)), (_lumB + (c * (-_lumB))) + (s * (1 - _lumB)), 0, 0, (_lumR + (c * (-_lumR))) + (s * 0.143), (_lumG + (c * (1 - _lumG))) + (s * 0.14), (_lumB + (c * (-_lumB))) + (s * -0.283), 0, 0, (_lumR + (c * (-_lumR))) + (s * (-(1 - _lumR))), (_lumG + (c * (-_lumG))) + (s * _lumG), (_lumB + (c * (1 - _lumB))) + (s * _lumB), 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1];
            return(applyMatrix(temp, m));
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
            var inv = (1 - n);
            var r = (inv * _lumR);
            var g = (inv * _lumG);
            var b = (inv * _lumB);
            var temp = [r + n, g, b, 0, 0, r, g + n, b, 0, 0, r, g, b + n, 0, 0, 0, 0, 0, 1, 0];
            return(applyMatrix(temp, m));
        }
        static function setContrast(m, n) {
            if (isNaN(n)) {
                return(m);
            }
            n = n + 0.01;
            var temp = [n, 0, 0, 0, 128 * (1 - n), 0, n, 0, 0, 128 * (1 - n), 0, 0, n, 0, 128 * (1 - n), 0, 0, 0, 1, 0];
            return(applyMatrix(temp, m));
        }
        static function applyMatrix(m, m2) {
            if ((!(m instanceof Array)) || (!(m2 instanceof Array))) {
                return(m2);
            }
            var temp = [];
            var i = 0;
            var z = 0;
            var y;
            var x;
            y = 0;
            while (y < 4) {
                x = 0;
                while (x < 5) {
                    if (x == 4) {
                        z = m[i + 4];
                    } else {
                        z = 0;
                    }
                    temp[i + x] = ((((m[i] * m2[x]) + (m[i + 1] * m2[x + 5])) + (m[i + 2] * m2[x + 10])) + (m[i + 3] * m2[x + 15])) + z;
                    x++;
                }
                i = i + 5;
                y++;
            }
            return(temp);
        }
        static var API = 1;
        static var _propNames = [];
        static var _idMatrix = [1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0];
        static var _lumR = 0.212671;
        static var _lumG = 0.71516;
        static var _lumB = 0.072169;
    }
