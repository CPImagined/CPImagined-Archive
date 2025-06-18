dynamic class com.greensock.plugins.HexColorsPlugin extends com.greensock.plugins.TweenPlugin
{
    static var API: Number = 1;
    var _colors;
    var overwriteProps;
    var propName;

    function HexColorsPlugin()
    {
        super();
        this.propName = "hexColors";
        this.overwriteProps = [];
        this._colors = [];
    }

    function onInitTween(target, value, tween)
    {
        for (var __reg4 in value) 
        {
            this.initColor(target, __reg4, Number(target[__reg4]), Number(value[__reg4]));
        }
        return true;
    }

    function initColor(target, propName, start, end)
    {
        if (start != end) 
        {
            var __reg3 = start >> 16;
            var __reg5 = start >> 8 & 255;
            var __reg2 = start & 255;
            this._colors[this._colors.length] = [target, propName, __reg3, (end >> 16) - __reg3, __reg5, (end >> 8 & 255) - __reg5, __reg2, (end & 255) - __reg2];
            this.overwriteProps[this.overwriteProps.length] = propName;
        }
    }

    function killProps(lookup)
    {
        var __reg3 = this._colors.length;
        while (__reg3--) 
        {
            if (lookup[this._colors[__reg3][1]] != undefined) 
            {
                this._colors.splice(__reg3, 1);
            }
        }
        super.killProps(lookup);
    }

    function set changeFactor(n)
    {
        var __reg4 = this._colors.length;
        var __reg2 = undefined;
        while (__reg4--) 
        {
            __reg2 = this._colors[__reg4];
            __reg2[0][__reg2[1]] = __reg2[2] + n * __reg2[3] << 16 | __reg2[4] + n * __reg2[5] << 8 | __reg2[6] + n * __reg2[7];
        }
    }

}
