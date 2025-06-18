//Created by Action Script Viewer - https://www.buraks.com/asv
    class gs.TweenFilterLite extends gs.TweenLite
    {
        var _clrsa, _filters, _matrix, target, vars, _cmf, _endMatrix, tweens, startTime, duration, _hst, _subTweens;
        function TweenFilterLite ($target, $duration, $vars) {
            super($target, $duration, $vars);
            if ((gs.TweenLite.version < 7) || (gs.TweenLite.version == undefined)) {
                trace("TweenFilterLite error: Please update your TweenLite class or try clearing your ASO files. TweenFilterLite requires a more recent version. Download updates at http://www.TweenLite.com.");
            }
            if ($vars.type != undefined) {
                trace(("TweenFilterLite warning: " + $target) + " appears to be using deprecated syntax. Please update to the new syntax. See http://www.TweenFilterLite.com for details.");
            }
        }
        static function to($target, $duration, $vars) {
            return(new gs.TweenFilterLite($target, $duration, $vars));
        }
        static function from($target, $duration, $vars) {
            $vars.runBackwards = true;
            return(new gs.TweenFilterLite($target, $duration, $vars));
        }
        function initTweenVals($hrp, $reservedProps) {
            _clrsa = [];
            _filters = [];
            _matrix = _idMatrix.slice();
            $reservedProps = $reservedProps || "";
            $reservedProps = $reservedProps + " blurFilter glowFilter colorMatrixFilter dropShadowFilter bevelFilter ";
            if ((typeof(target) == "movieclip") || (target instanceof TextField)) {
                var _local_4;
                var _local_5;
                if (vars.blurFilter != undefined) {
                    _local_5 = vars.blurFilter;
                    addFilter("blur", _local_5, flash.filters.BlurFilter, ["blurX", "blurY", "quality"], new flash.filters.BlurFilter(0, 0, _local_5.quality || 2));
                }
                if (vars.glowFilter != undefined) {
                    _local_5 = vars.glowFilter;
                    addFilter("glow", _local_5, flash.filters.GlowFilter, ["alpha", "blurX", "blurY", "color", "quality", "strength", "inner", "knockout"], new flash.filters.GlowFilter(16777215, 0, 0, 0, _local_5.strength || 1, _local_5.quality || 2, _local_5.inner, _local_5.knockout));
                }
                if (vars.colorMatrixFilter != undefined) {
                    _local_5 = vars.colorMatrixFilter;
                    var _local_11 = addFilter("colorMatrix", _local_5, flash.filters.ColorMatrixFilter, [], new flash.filters.ColorMatrixFilter(_matrix));
                    _cmf = _local_11.filter;
                    _matrix = _cmf.matrix;
                    if ((_local_5.matrix != undefined) && (_local_5.matrix instanceof Array)) {
                        _endMatrix = _local_5.matrix;
                    } else {
                        if (_local_5.relative == true) {
                            _endMatrix = _matrix.slice();
                        } else {
                            _endMatrix = _idMatrix.slice();
                        }
                        _endMatrix = setBrightness(_endMatrix, _local_5.brightness);
                        _endMatrix = setContrast(_endMatrix, _local_5.contrast);
                        _endMatrix = setHue(_endMatrix, _local_5.hue);
                        _endMatrix = setSaturation(_endMatrix, _local_5.saturation);
                        _endMatrix = setThreshold(_endMatrix, _local_5.threshold);
                        if (!isNaN(_local_5.colorize)) {
                            _endMatrix = colorize(_endMatrix, _local_5.colorize, _local_5.amount);
                        } else if (!isNaN(_local_5["color"])) {
                            _endMatrix = colorize(_endMatrix, _local_5["color"], _local_5.amount);
                        }
                    }
                    _local_4 = 0;
                    while (_local_4 < _endMatrix.length) {
                        if ((_matrix[_local_4] != _endMatrix[_local_4]) && (_matrix[_local_4] != undefined)) {
                            tweens.push({o:_matrix, p:_local_4.toString(), s:_matrix[_local_4], c:_endMatrix[_local_4] - _matrix[_local_4]});
                        }
                        _local_4++;
                    }
                }
                if (vars.dropShadowFilter != undefined) {
                    _local_5 = vars.dropShadowFilter;
                    addFilter("dropShadow", _local_5, flash.filters.DropShadowFilter, ["alpha", "angle", "blurX", "blurY", "color", "distance", "quality", "strength", "inner", "knockout", "hideObject"], new flash.filters.DropShadowFilter(0, 45, 0, 0, 0, 0, 1, _local_5.quality || 2, _local_5.inner, _local_5.knockout, _local_5.hideObject));
                }
                if (vars.bevelFilter != undefined) {
                    _local_5 = vars.bevelFilter;
                    addFilter("bevel", _local_5, flash.filters.BevelFilter, ["angle", "blurX", "blurY", "distance", "highlightAlpha", "highlightColor", "quality", "shadowAlpha", "shadowColor", "strength"], new flash.filters.BevelFilter(0, 0, 16777215, 0.5, 0, 0.5, 2, 2, 0, _local_5.quality || 2));
                }
                if (vars.runBackwards == true) {
                    var _local_3;
                    _local_4 = 0;
                    while (_local_4 < _clrsa.length) {
                        _local_3 = _clrsa[_local_4];
                        _local_3.sr = _local_3.sr + _local_3.cr;
                        _local_3.cr = _local_3.cr * -1;
                        _local_3.sg = _local_3.sg + _local_3.cg;
                        _local_3.cg = _local_3.cg * -1;
                        _local_3.sb = _local_3.sb + _local_3.cb;
                        _local_3.cb = _local_3.cb * -1;
                        _local_3.f[_local_3.p] = ((_local_3.sr << 16) | (_local_3.sg << 8)) | _local_3.sb;
                        _local_4++;
                    }
                }
                super.initTweenVals(true, $reservedProps);
            } else {
                super.initTweenVals($hrp, $reservedProps);
            }
        }
        function addFilter($name, $fv, $filterType, $props, $defaultFilter) {
            var _local_5 = {type:$filterType};
            var _local_8 = target.filters;
            var _local_3;
            var _local_2;
            var _local_9;
            var _local_4;
            var _local_7;
            _local_3 = 0;
            while (_local_3 < _local_8.length) {
                if (_local_8[_local_3] instanceof $filterType) {
                    _local_5.filter = _local_8[_local_3];
                    break;
                }
                _local_3++;
            }
            if (_local_5.filter == undefined) {
                _local_5.filter = $defaultFilter;
                _local_8.push(_local_5.filter);
                target.filters = _local_8;
            }
            _local_3 = 0;
            while (_local_3 < $props.length) {
                _local_2 = $props[_local_3];
                if ($fv[_local_2] != undefined) {
                    if (((_local_2 == "color") || (_local_2 == "highlightColor")) || (_local_2 == "shadowColor")) {
                        _local_4 = HEXtoRGB(_local_5.filter[_local_2]);
                        _local_7 = HEXtoRGB($fv[_local_2]);
                        _clrsa.push({f:_local_5.filter, p:_local_2, sr:_local_4.rb, cr:_local_7.rb - _local_4.rb, sg:_local_4.gb, cg:_local_7.gb - _local_4.gb, sb:_local_4.bb, cb:_local_7.bb - _local_4.bb});
                    } else if ((((_local_2 == "quality") || (_local_2 == "inner")) || (_local_2 == "knockout")) || (_local_2 == "hideObject")) {
                        _local_5.filter[_local_2] = $fv[_local_2];
                    } else {
                        if (typeof($fv[_local_2]) == "number") {
                            _local_9 = $fv[_local_2] - _local_5.filter[_local_2];
                        } else {
                            _local_9 = Number($fv[_local_2]);
                        }
                        tweens.push({o:_local_5.filter, p:_local_2, s:_local_5.filter[_local_2], c:_local_9});
                    }
                }
                _local_3++;
            }
            _filters.push(_local_5);
            _hf = true;
            return(_local_5);
        }
        function render($t) {
            var _local_11 = ($t - startTime) / 1000;
            var _local_7;
            var _local_4;
            var _local_3;
            if (_local_11 >= duration) {
                _local_11 = duration;
                _local_7 = 1;
            } else {
                _local_7 = vars.ease(_local_11, 0, 1, duration);
            }
            _local_3 = tweens.length - 1;
            while (_local_3 > -1) {
                _local_4 = tweens[_local_3];
                _local_4.o[_local_4.p] = _local_4.s + (_local_7 * _local_4.c);
                _local_3--;
            }
            if (_hf) {
                var _local_5;
                var _local_9;
                var _local_10;
                var _local_8;
                _local_3 = _clrsa.length - 1;
                while (_local_3 > -1) {
                    _local_4 = _clrsa[_local_3];
                    _local_9 = _local_4.sr + (_local_7 * _local_4.cr);
                    _local_10 = _local_4.sg + (_local_7 * _local_4.cg);
                    _local_8 = _local_4.sb + (_local_7 * _local_4.cb);
                    _local_4.f[_local_4.p] = ((_local_9 << 16) | (_local_10 << 8)) | _local_8;
                    _local_3--;
                }
                if (_cmf) {
                    _cmf.matrix = _matrix;
                }
                var _local_6 = target.filters;
                _local_3 = 0;
                while (_local_3 < _filters.length) {
                    _local_5 = _local_6.length - 1;
                    while (_local_5 > -1) {
                        if (_local_6[_local_5] instanceof _filters[_local_3].type) {
                            _local_6.splice(_local_5, 1, _filters[_local_3].filter);
                            break;
                        }
                        _local_5--;
                    }
                    _local_3++;
                }
                target.filters = _local_6;
            }
            if (_hst) {
                _local_3 = _subTweens.length - 1;
                while (_local_3 > -1) {
                    _subTweens[_local_3].proxy(_subTweens[_local_3]);
                    _local_3--;
                }
            }
            if (vars.onUpdate != undefined) {
                vars.onUpdate.apply(vars.onUpdateScope, vars.onUpdateParams);
            }
            if (_local_11 == duration) {
                super.complete(true);
            }
        }
        function HEXtoRGB($n) {
            return({rb:$n >> 16, gb:($n >> 8) & 255, bb:$n & 255});
        }
        static function colorize($m, $color, $amount) {
            if (($color == undefined) || (isNaN($color))) {
                return($m);
            }
            if ($amount == undefined) {
                $amount = 1;
            }
            var _local_3 = (($color >> 16) & 255) / 255;
            var _local_5 = (($color >> 8) & 255) / 255;
            var _local_2 = ($color & 255) / 255;
            var _local_4 = 1 - $amount;
            var _local_7 = [_local_4 + (($amount * _local_3) * _lumR), ($amount * _local_3) * _lumG, ($amount * _local_3) * _lumB, 0, 0, ($amount * _local_5) * _lumR, _local_4 + (($amount * _local_5) * _lumG), ($amount * _local_5) * _lumB, 0, 0, ($amount * _local_2) * _lumR, ($amount * _local_2) * _lumG, _local_4 + (($amount * _local_2) * _lumB), 0, 0, 0, 0, 0, 1, 0];
            return(applyMatrix(_local_7, $m));
        }
        static function setThreshold($m, $n) {
            if (($n == undefined) || (isNaN($n))) {
                return($m);
            }
            var _local_2 = [_lumR * 256, _lumG * 256, _lumB * 256, 0, -256 * $n, _lumR * 256, _lumG * 256, _lumB * 256, 0, -256 * $n, _lumR * 256, _lumG * 256, _lumB * 256, 0, -256 * $n, 0, 0, 0, 1, 0];
            return(applyMatrix(_local_2, $m));
        }
        static function setHue($m, $n) {
            if (($n == undefined) || (isNaN($n))) {
                return($m);
            }
            $n = $n * (Math.PI/180);
            var _local_1 = Math.cos($n);
            var _local_2 = Math.sin($n);
            var _local_4 = [(_lumR + (_local_1 * (1 - _lumR))) + (_local_2 * (-_lumR)), (_lumG + (_local_1 * (-_lumG))) + (_local_2 * (-_lumG)), (_lumB + (_local_1 * (-_lumB))) + (_local_2 * (1 - _lumB)), 0, 0, (_lumR + (_local_1 * (-_lumR))) + (_local_2 * 0.143), (_lumG + (_local_1 * (1 - _lumG))) + (_local_2 * 0.14), (_lumB + (_local_1 * (-_lumB))) + (_local_2 * -0.283), 0, 0, (_lumR + (_local_1 * (-_lumR))) + (_local_2 * (-(1 - _lumR))), (_lumG + (_local_1 * (-_lumG))) + (_local_2 * _lumG), (_lumB + (_local_1 * (1 - _lumB))) + (_local_2 * _lumB), 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1];
            return(applyMatrix(_local_4, $m));
        }
        static function setBrightness($m, $n) {
            if (($n == undefined) || (isNaN($n))) {
                return($m);
            }
            $n = ($n * 100) - 100;
            return(applyMatrix([1, 0, 0, 0, $n, 0, 1, 0, 0, $n, 0, 0, 1, 0, $n, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1], $m));
        }
        static function setSaturation($m, $n) {
            if (($n == undefined) || (isNaN($n))) {
                return($m);
            }
            var _local_4 = 1 - $n;
            var _local_3 = _local_4 * _lumR;
            var _local_5 = _local_4 * _lumG;
            var _local_2 = _local_4 * _lumB;
            var _local_6 = [_local_3 + $n, _local_5, _local_2, 0, 0, _local_3, _local_5 + $n, _local_2, 0, 0, _local_3, _local_5, _local_2 + $n, 0, 0, 0, 0, 0, 1, 0];
            return(applyMatrix(_local_6, $m));
        }
        static function setContrast($m, $n) {
            if (($n == undefined) || (isNaN($n))) {
                return($m);
            }
            $n = $n + 0.01;
            var _local_2 = [$n, 0, 0, 0, 128 * (1 - $n), 0, $n, 0, 0, 128 * (1 - $n), 0, 0, $n, 0, 128 * (1 - $n), 0, 0, 0, 1, 0];
            return(applyMatrix(_local_2, $m));
        }
        static function applyMatrix($m, $m2) {
            if (((($m == undefined) || (!($m instanceof Array))) || ($m2 == undefined)) || (!($m2 instanceof Array))) {
                return($m2);
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
                        _local_5 = $m[_local_2 + 4];
                    } else {
                        _local_5 = 0;
                    }
                    _local_7[_local_2 + _local_1] = (((($m[_local_2] * $m2[_local_1]) + ($m[_local_2 + 1] * $m2[_local_1 + 5])) + ($m[_local_2 + 2] * $m2[_local_1 + 10])) + ($m[_local_2 + 3] * $m2[_local_1 + 15])) + _local_5;
                    _local_1++;
                }
                _local_2 = _local_2 + 5;
                _local_6++;
            }
            return(_local_7);
        }
        static var version = 7.3;
        static var delayedCall = gs.TweenLite.delayedCall;
        static var killTweensOf = gs.TweenLite.killTweensOf;
        static var killDelayedCallsTo = gs.TweenLite.killDelayedCallsTo;
        static var _idMatrix = [1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0];
        static var _lumR = 0.212671;
        static var _lumG = 0.71516;
        static var _lumB = 0.072169;
        var _hf = false;
    }
