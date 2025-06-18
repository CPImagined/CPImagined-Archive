dynamic class com.greensock.plugins.ColorTransformPlugin extends com.greensock.plugins.TintPlugin
{
    static var API: Number = 1;
    var init;
    var propName;

    function ColorTransformPlugin()
    {
        super();
        this.propName = "colorTransform";
    }

    function onInitTween(target, value, tween)
    {
        if (typeof target != "movieclip" && !(target instanceof TextField)) 
        {
            return false;
        }
        var __reg7 = new Color(target);
        var __reg2 = __reg7.getTransform();
        if (value.redMultiplier != undefined) 
        {
            __reg2.ra = value.redMultiplier * 100;
        }
        if (value.greenMultiplier != undefined) 
        {
            __reg2.ga = value.greenMultiplier * 100;
        }
        if (value.blueMultiplier != undefined) 
        {
            __reg2.ba = value.blueMultiplier * 100;
        }
        if (value.alphaMultiplier != undefined) 
        {
            __reg2.aa = value.alphaMultiplier * 100;
        }
        if (value.redOffset != undefined) 
        {
            __reg2.rb = value.redOffset;
        }
        if (value.greenOffset != undefined) 
        {
            __reg2.gb = value.greenOffset;
        }
        if (value.blueOffset != undefined) 
        {
            __reg2.bb = value.blueOffset;
        }
        if (value.alphaOffset != undefined) 
        {
            __reg2.ab = value.alphaOffset;
        }
        if (!isNaN(value.tint) || !isNaN(value.color)) 
        {
            var __reg4 = isNaN(value.tint) ? value.color : value.tint;
            if (__reg4 != null) 
            {
                __reg2.rb = Number(__reg4) >> 16;
                __reg2.gb = Number(__reg4) >> 8 & 255;
                __reg2.bb = Number(__reg4) & 255;
                __reg2.ra = 0;
                __reg2.ga = 0;
                __reg2.ba = 0;
            }
        }
        if (isNaN(value.tintAmount)) 
        {
            if (isNaN(value.exposure)) 
            {
                if (!isNaN(value.brightness)) 
                {
                    __reg2.rb = __reg2.gb = __reg2.bb = Math.max(0, (value.brightness - 1) * 255);
                    __reg2.ra = __reg2.ga = __reg2.ba = (1 - Math.abs(value.brightness - 1)) * 100;
                }
            }
            else 
            {
                __reg2.rb = __reg2.gb = __reg2.bb = 255 * (value.exposure - 1);
                __reg2.ra = __reg2.ga = __reg2.ba = 100;
            }
        }
        else 
        {
            var __reg5 = value.tintAmount / (1 - (__reg2.ra + __reg2.ga + __reg2.ba) / 300);
            __reg2.rb = __reg2.rb * __reg5;
            __reg2.gb = __reg2.gb * __reg5;
            __reg2.bb = __reg2.bb * __reg5;
            __reg2.ra = __reg2.ga = __reg2.ba = (1 - value.tintAmount) * 100;
        }
        if (tween.vars._alpha != undefined && value.alphaMultiplier == undefined) 
        {
            __reg2.aa = tween.vars._alpha;
            tween.killVars({_alpha: 1});
        }
        this.init(target, __reg2);
        return true;
    }

}
