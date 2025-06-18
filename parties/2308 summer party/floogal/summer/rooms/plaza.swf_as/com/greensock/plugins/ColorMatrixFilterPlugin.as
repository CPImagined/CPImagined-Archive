dynamic class com.greensock.plugins.ColorMatrixFilterPlugin extends com.greensock.plugins.FilterPlugin
{
    static var API: Number = 1;
    static var _propNames = [];
    static var _idMatrix = [1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0];
    static var _lumR: Number = 0.212671;
    static var _lumG: Number = 0.71516;
    static var _lumB: Number = 0.072169;
    var _filter;
    var _matrix;
    var _matrixTween;
    var _target;
    var _type;
    var initFilter;
    var overwriteProps;
    var propName;

    function ColorMatrixFilterPlugin()
    {
        super();
        this.propName = "colorMatrixFilter";
        this.overwriteProps = ["colorMatrixFilter"];
    }

    function onInitTween(target, value, tween)
    {
        this._target = target;
        this._type = flash.filters.ColorMatrixFilter;
        var __reg3 = value;
        this.initFilter({remove: value.remove, index: value.index, addFilter: value.addFilter}, new flash.filters.ColorMatrixFilter(com.greensock.plugins.ColorMatrixFilterPlugin._idMatrix.slice()), com.greensock.plugins.ColorMatrixFilterPlugin._propNames);
        this._matrix = flash.filters.ColorMatrixFilter(this._filter).matrix;
        var __reg2 = [];
        if (__reg3.matrix != undefined && __reg3.matrix instanceof Array) 
        {
            __reg2 = __reg3.matrix;
        }
        else 
        {
            if (__reg3.relative == true) 
            {
                __reg2 = this._matrix.slice();
            }
            else 
            {
                __reg2 = com.greensock.plugins.ColorMatrixFilterPlugin._idMatrix.slice();
            }
            __reg2 = com.greensock.plugins.ColorMatrixFilterPlugin.setBrightness(__reg2, __reg3.brightness);
            __reg2 = com.greensock.plugins.ColorMatrixFilterPlugin.setContrast(__reg2, __reg3.contrast);
            __reg2 = com.greensock.plugins.ColorMatrixFilterPlugin.setHue(__reg2, __reg3.hue);
            __reg2 = com.greensock.plugins.ColorMatrixFilterPlugin.setSaturation(__reg2, __reg3.saturation);
            __reg2 = com.greensock.plugins.ColorMatrixFilterPlugin.setThreshold(__reg2, __reg3.threshold);
            if (!isNaN(__reg3.colorize)) 
            {
                __reg2 = com.greensock.plugins.ColorMatrixFilterPlugin.colorize(__reg2, __reg3.colorize, __reg3.amount);
            }
        }
        this._matrixTween = new com.greensock.plugins.EndArrayPlugin();
        this._matrixTween.init(this._matrix, __reg2);
        return true;
    }

    function set changeFactor(n)
    {
        this._matrixTween.__set__changeFactor(n);
        flash.filters.ColorMatrixFilter(this._filter).matrix = this._matrix;
        super.__set__changeFactor(n);
    }

    static function colorize(m, color, amount)
    {
        if (isNaN(color)) 
        {
            return m;
        }
        else if (isNaN(amount)) 
        {
            amount = 1;
        }
        var __reg3 = (color >> 16 & 255) / 255;
        var __reg5 = (color >> 8 & 255) / 255;
        var __reg2 = (color & 255) / 255;
        var __reg4 = 1 - amount;
        var __reg7 = [__reg4 + amount * __reg3 * com.greensock.plugins.ColorMatrixFilterPlugin._lumR, amount * __reg3 * com.greensock.plugins.ColorMatrixFilterPlugin._lumG, amount * __reg3 * com.greensock.plugins.ColorMatrixFilterPlugin._lumB, 0, 0, amount * __reg5 * com.greensock.plugins.ColorMatrixFilterPlugin._lumR, __reg4 + amount * __reg5 * com.greensock.plugins.ColorMatrixFilterPlugin._lumG, amount * __reg5 * com.greensock.plugins.ColorMatrixFilterPlugin._lumB, 0, 0, amount * __reg2 * com.greensock.plugins.ColorMatrixFilterPlugin._lumR, amount * __reg2 * com.greensock.plugins.ColorMatrixFilterPlugin._lumG, __reg4 + amount * __reg2 * com.greensock.plugins.ColorMatrixFilterPlugin._lumB, 0, 0, 0, 0, 0, 1, 0];
        return com.greensock.plugins.ColorMatrixFilterPlugin.applyMatrix(__reg7, m);
    }

    static function setThreshold(m, n)
    {
        if (isNaN(n)) 
        {
            return m;
        }
        var __reg2 = [com.greensock.plugins.ColorMatrixFilterPlugin._lumR * 256, com.greensock.plugins.ColorMatrixFilterPlugin._lumG * 256, com.greensock.plugins.ColorMatrixFilterPlugin._lumB * 256, 0, -256 * n, com.greensock.plugins.ColorMatrixFilterPlugin._lumR * 256, com.greensock.plugins.ColorMatrixFilterPlugin._lumG * 256, com.greensock.plugins.ColorMatrixFilterPlugin._lumB * 256, 0, -256 * n, com.greensock.plugins.ColorMatrixFilterPlugin._lumR * 256, com.greensock.plugins.ColorMatrixFilterPlugin._lumG * 256, com.greensock.plugins.ColorMatrixFilterPlugin._lumB * 256, 0, -256 * n, 0, 0, 0, 1, 0];
        return com.greensock.plugins.ColorMatrixFilterPlugin.applyMatrix(__reg2, m);
    }

    static function setHue(m, n)
    {
        if (isNaN(n)) 
        {
            return m;
        }
        n = n * 0.0174532925199;
        var __reg1 = Math.cos(n);
        var __reg2 = Math.sin(n);
        var __reg4 = [com.greensock.plugins.ColorMatrixFilterPlugin._lumR + __reg1 * (1 - com.greensock.plugins.ColorMatrixFilterPlugin._lumR) + __reg2 * (0 - com.greensock.plugins.ColorMatrixFilterPlugin._lumR), com.greensock.plugins.ColorMatrixFilterPlugin._lumG + __reg1 * (0 - com.greensock.plugins.ColorMatrixFilterPlugin._lumG) + __reg2 * (0 - com.greensock.plugins.ColorMatrixFilterPlugin._lumG), com.greensock.plugins.ColorMatrixFilterPlugin._lumB + __reg1 * (0 - com.greensock.plugins.ColorMatrixFilterPlugin._lumB) + __reg2 * (1 - com.greensock.plugins.ColorMatrixFilterPlugin._lumB), 0, 0, com.greensock.plugins.ColorMatrixFilterPlugin._lumR + __reg1 * (0 - com.greensock.plugins.ColorMatrixFilterPlugin._lumR) + __reg2 * 0.143, com.greensock.plugins.ColorMatrixFilterPlugin._lumG + __reg1 * (1 - com.greensock.plugins.ColorMatrixFilterPlugin._lumG) + __reg2 * 0.14, com.greensock.plugins.ColorMatrixFilterPlugin._lumB + __reg1 * (0 - com.greensock.plugins.ColorMatrixFilterPlugin._lumB) + __reg2 * -0.283, 0, 0, com.greensock.plugins.ColorMatrixFilterPlugin._lumR + __reg1 * (0 - com.greensock.plugins.ColorMatrixFilterPlugin._lumR) + __reg2 * (0 - (1 - com.greensock.plugins.ColorMatrixFilterPlugin._lumR)), com.greensock.plugins.ColorMatrixFilterPlugin._lumG + __reg1 * (0 - com.greensock.plugins.ColorMatrixFilterPlugin._lumG) + __reg2 * com.greensock.plugins.ColorMatrixFilterPlugin._lumG, com.greensock.plugins.ColorMatrixFilterPlugin._lumB + __reg1 * (1 - com.greensock.plugins.ColorMatrixFilterPlugin._lumB) + __reg2 * com.greensock.plugins.ColorMatrixFilterPlugin._lumB, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1];
        return com.greensock.plugins.ColorMatrixFilterPlugin.applyMatrix(__reg4, m);
    }

    static function setBrightness(m, n)
    {
        if (isNaN(n)) 
        {
            return m;
        }
        n = n * 100 - 100;
        return com.greensock.plugins.ColorMatrixFilterPlugin.applyMatrix([1, 0, 0, 0, n, 0, 1, 0, 0, n, 0, 0, 1, 0, n, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1], m);
    }

    static function setSaturation(m, n)
    {
        if (isNaN(n)) 
        {
            return m;
        }
        var __reg4 = 1 - n;
        var __reg2 = __reg4 * com.greensock.plugins.ColorMatrixFilterPlugin._lumR;
        var __reg5 = __reg4 * com.greensock.plugins.ColorMatrixFilterPlugin._lumG;
        var __reg1 = __reg4 * com.greensock.plugins.ColorMatrixFilterPlugin._lumB;
        var __reg6 = [__reg2 + n, __reg5, __reg1, 0, 0, __reg2, __reg5 + n, __reg1, 0, 0, __reg2, __reg5, __reg1 + n, 0, 0, 0, 0, 0, 1, 0];
        return com.greensock.plugins.ColorMatrixFilterPlugin.applyMatrix(__reg6, m);
    }

    static function setContrast(m, n)
    {
        if (isNaN(n)) 
        {
            return m;
        }
        n = n + 0.01;
        var __reg2 = [n, 0, 0, 0, 128 * (1 - n), 0, n, 0, 0, 128 * (1 - n), 0, 0, n, 0, 128 * (1 - n), 0, 0, 0, 1, 0];
        return com.greensock.plugins.ColorMatrixFilterPlugin.applyMatrix(__reg2, m);
    }

    static function applyMatrix(m, m2)
    {
        if (!(m instanceof Array) || !(m2 instanceof Array)) 
        {
            return m2;
        }
        var __reg7 = [];
        var __reg2 = 0;
        var __reg5 = 0;
        var __reg6 = undefined;
        var __reg1 = undefined;
        __reg6 = 0;
        while (__reg6 < 4) 
        {
            __reg1 = 0;
            while (__reg1 < 5) 
            {
                if (__reg1 == 4) 
                {
                    __reg5 = m[__reg2 + 4];
                }
                else 
                {
                    __reg5 = 0;
                }
                __reg7[__reg2 + __reg1] = m[__reg2] * m2[__reg1] + m[__reg2 + 1] * m2[__reg1 + 5] + m[__reg2 + 2] * m2[__reg1 + 10] + m[__reg2 + 3] * m2[__reg1 + 15] + __reg5;
                ++__reg1;
            }
            __reg2 = __reg2 + 5;
            ++__reg6;
        }
        return __reg7;
    }

}
