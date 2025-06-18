dynamic class com.greensock.plugins.TintPlugin extends com.greensock.plugins.TweenPlugin
{
    static var API: Number = 1;
    var _color;
    var _tweens;
    var overwriteProps;
    var propName;

    function TintPlugin()
    {
        super();
        this.propName = "tint";
        this.overwriteProps = ["tint"];
    }

    function onInitTween(target, value, tween)
    {
        if (typeof target != "movieclip" && !(target instanceof TextField)) 
        {
            return false;
        }
        var __reg2 = tween.vars._alpha == undefined ? (tween.vars.autoAlpha == undefined ? target._alpha : tween.vars.autoAlpha) : tween.vars._alpha;
        var __reg4 = Number(value);
        var __reg6 = value == null || tween.vars.removeTint == true ? {rb: 0, gb: 0, bb: 0, ab: 0, ra: __reg2, ga: __reg2, ba: __reg2, aa: __reg2} : {rb: __reg4 >> 16, gb: __reg4 >> 8 & 255, bb: __reg4 & 255, ra: 0, ga: 0, ba: 0, aa: __reg2};
        this.init(target, __reg6);
        return true;
    }

    function init(target, end)
    {
        this._color = new Color(target);
        var __reg3 = this._color.getTransform();
        var __reg6 = undefined;
        var __reg2 = undefined;
        for (__reg2 in end) 
        {
            if (__reg3[__reg2] != end[__reg2]) 
            {
                this._tweens[this._tweens.length] = new com.greensock.core.PropTween(__reg3, __reg2, __reg3[__reg2], end[__reg2] - __reg3[__reg2], "tint", false);
            }
        }
    }

    function set changeFactor(n)
    {
        var __reg4 = this._color.getTransform();
        var __reg3 = this._tweens.length;
        var __reg2 = undefined;
        while (__reg3--) 
        {
            __reg2 = this._tweens[__reg3];
            __reg4[__reg2.property] = __reg2.start + __reg2.change * n;
        }
        this._color.setTransform(__reg4);
    }

}
