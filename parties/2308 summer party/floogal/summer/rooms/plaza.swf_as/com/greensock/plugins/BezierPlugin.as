dynamic class com.greensock.plugins.BezierPlugin extends com.greensock.plugins.TweenPlugin
{
    static var API: Number = 1;
    static var _RAD2DEG: Number = 57.2957795131;
    var _beziers;
    var _future;
    var _orient;
    var _orientData;
    var _target;
    var overwriteProps;
    var propName;
    var round;

    function BezierPlugin()
    {
        super();
        this.propName = "bezier";
        this.overwriteProps = [];
        this._future = {};
    }

    function onInitTween(target, value, tween)
    {
        if (!(value instanceof Array)) 
        {
            return false;
        }
        this.init(tween, [value][0], false);
        return true;
    }

    function init(tween, beziers, through)
    {
        this._target = tween.target;
        var __reg7 = tween.vars;
        if (__reg7.orientToBezier == true) 
        {
            this._orientData = [["_x", "_y", "_rotation", 0, 0.01]];
            this._orient = true;
        }
        else if (__reg7.orientToBezier instanceof Array) 
        {
            this._orientData = __reg7.orientToBezier;
            this._orient = true;
        }
        var __reg3 = {};
        var __reg4 = undefined;
        var __reg2 = undefined;
        var __reg8 = undefined;
        __reg4 = 0;
        while (__reg4 < beziers.length) 
        {
            for (__reg2 in beziers[__reg4]) 
            {
                if (__reg3[__reg2] == undefined) 
                {
                    __reg3[__reg2] = [tween.target[__reg2]];
                }
                if (typeof beziers[__reg4][__reg2] == "number") 
                {
                    __reg3[__reg2].push(beziers[__reg4][__reg2]);
                }
                else 
                {
                    __reg3[__reg2].push(tween.target[__reg2] + Number(beziers[__reg4][__reg2]));
                }
            }
            ++__reg4;
        }
        for (__reg2 in __reg3) 
        {
            this.overwriteProps[this.overwriteProps.length] = __reg2;
            if (__reg7[__reg2] != undefined) 
            {
                if (typeof __reg7[__reg2] == "number") 
                {
                    __reg3[__reg2].push(__reg7[__reg2]);
                }
                else 
                {
                    __reg3[__reg2].push(tween.target[__reg2] + Number(__reg7[__reg2]));
                }
                __reg8 = {};
                __reg8[__reg2] = true;
                tween.killVars(__reg8, false);
                delete __reg7[__reg2];
            }
        }
        this._beziers = com.greensock.plugins.BezierPlugin.parseBeziers(__reg3, through);
    }

    static function parseBeziers(props, through)
    {
        var __reg2 = undefined;
        var __reg1 = undefined;
        var __reg3 = undefined;
        var __reg4 = undefined;
        var __reg6 = {};
        if (through == true) 
        {
            for (__reg4 in props) 
            {
                __reg1 = props[__reg4];
                __reg6[__reg4] = __reg3 = [];
                if (__reg1.length > 2) 
                {
                    __reg3[__reg3.length] = [__reg1[0], __reg1[1] - (__reg1[2] - __reg1[0]) / 4, __reg1[1]];
                    __reg2 = 1;
                    while (__reg2 < __reg1.length - 1) 
                    {
                        __reg3[__reg3.length] = [__reg1[__reg2], __reg1[__reg2] + (__reg1[__reg2] - __reg3[__reg2 - 1][1]), __reg1[__reg2 + 1]];
                        ++__reg2;
                    }
                }
                else 
                {
                    __reg3[__reg3.length] = [__reg1[0], (__reg1[0] + __reg1[1]) / 2, __reg1[1]];
                }
            }
        }
        else 
        {
            for (__reg4 in props) 
            {
                __reg1 = props[__reg4];
                __reg6[__reg4] = __reg3 = [];
                if (__reg1.length > 3) 
                {
                    __reg3[__reg3.length] = [__reg1[0], __reg1[1], (__reg1[1] + __reg1[2]) / 2];
                    __reg2 = 2;
                    while (__reg2 < __reg1.length - 2) 
                    {
                        __reg3[__reg3.length] = [__reg3[__reg2 - 2][2], __reg1[__reg2], (__reg1[__reg2] + __reg1[__reg2 + 1]) / 2];
                        ++__reg2;
                    }
                    __reg3[__reg3.length] = [__reg3[__reg3.length - 1][2], __reg1[__reg1.length - 2], __reg1[__reg1.length - 1]];
                }
                else if (__reg1.length == 3) 
                {
                    __reg3[__reg3.length] = [__reg1[0], __reg1[1], __reg1[2]];
                }
                else if (__reg1.length == 2) 
                {
                    __reg3[__reg3.length] = [__reg1[0], (__reg1[0] + __reg1[1]) / 2, __reg1[1]];
                }
            }
        }
        return __reg6;
    }

    function killProps(lookup)
    {
        for (var __reg4 in this._beziers) 
        {
            if (lookup[__reg4] != undefined) 
            {
                delete this._beziers[__reg4];
            }
        }
        super.killProps(lookup);
    }

    function set changeFactor(n)
    {
        var __reg3 = undefined;
        var __reg5 = undefined;
        var __reg4 = undefined;
        var __reg6 = undefined;
        var __reg7 = undefined;
        var __reg15 = undefined;
        var __reg16 = undefined;
        if (n == 1) 
        {
            for (__reg5 in this._beziers) 
            {
                __reg3 = this._beziers[__reg5].length - 1;
                this._target[__reg5] = this._beziers[__reg5][__reg3][2];
            }
        }
        else 
        {
            for (__reg5 in this._beziers) 
            {
                __reg7 = this._beziers[__reg5].length;
                if (n < 0) 
                {
                    __reg3 = 0;
                }
                else if (n >= 1) 
                {
                    __reg3 = __reg7 - 1;
                }
                else 
                {
                    __reg3 = __reg7 * n >> 0;
                }
                __reg6 = (n - __reg3 * (1 / __reg7)) * __reg7;
                __reg4 = this._beziers[__reg5][__reg3];
                if (this.round) 
                {
                    this._target[__reg5] = Math.round(__reg4[0] + __reg6 * (2 * (1 - __reg6) * (__reg4[1] - __reg4[0]) + __reg6 * (__reg4[2] - __reg4[0])));
                }
                else 
                {
                    this._target[__reg5] = __reg4[0] + __reg6 * (2 * (1 - __reg6) * (__reg4[1] - __reg4[0]) + __reg6 * (__reg4[2] - __reg4[0]));
                }
            }
        }
        if (this._orient == true) 
        {
            __reg3 = this._orientData.length;
            var __reg9 = {};
            var __reg11 = undefined;
            var __reg10 = undefined;
            var __reg2 = undefined;
            var __reg12 = undefined;
            while (__reg3-- > 0) 
            {
                __reg2 = this._orientData[__reg3];
                __reg9[__reg2[0]] = this._target[__reg2[0]];
                __reg9[__reg2[1]] = this._target[__reg2[1]];
            }
            var __reg13 = this._target;
            var __reg14 = this.round;
            this._target = this._future;
            this.round = false;
            this._orient = false;
            __reg3 = this._orientData.length;
            while (__reg3-- > 0) 
            {
                __reg2 = this._orientData[__reg3];
                this.__set__changeFactor(n + (__reg2[4] || 0.01));
                __reg12 = __reg2[3] || 0;
                __reg11 = this._future[__reg2[0]] - __reg9[__reg2[0]];
                __reg10 = this._future[__reg2[1]] - __reg9[__reg2[1]];
                __reg13[__reg2[2]] = Math.atan2(__reg10, __reg11) * com.greensock.plugins.BezierPlugin._RAD2DEG + __reg12;
            }
            this._target = __reg13;
            this.round = __reg14;
            this._orient = true;
        }
    }

}
