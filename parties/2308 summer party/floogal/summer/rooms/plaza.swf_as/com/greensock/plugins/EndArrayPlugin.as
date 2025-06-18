dynamic class com.greensock.plugins.EndArrayPlugin extends com.greensock.plugins.TweenPlugin
{
    static var API: Number = 1;
    var _a;
    var _info;
    var overwriteProps;
    var propName;
    var round;

    function EndArrayPlugin()
    {
        super();
        this.propName = "endArray";
        this.overwriteProps = ["endArray"];
        this._info = [];
    }

    function onInitTween(target, value, tween)
    {
        if (!(target instanceof Array) || !(value instanceof Array)) 
        {
            return false;
        }
        this.init([target][0], [value][0]);
        return true;
    }

    function init(start, end)
    {
        this._a = start;
        var __reg2 = end.length;
        for (;;) 
        {
            if (!(__reg2--)) 
            {
                return;
            }
            if (start[__reg2] != end[__reg2] && start[__reg2] != undefined) 
            {
                this._info[this._info.length] = new com.greensock.plugins.helpers.ArrayTweenInfo(__reg2, this._a[__reg2], end[__reg2] - this._a[__reg2]);
            }
        }
    }

    function set changeFactor(n)
    {
        var __reg3 = this._info.length;
        var __reg2 = undefined;
        if (this.round) 
        {
            while (__reg3--) 
            {
                __reg2 = this._info[__reg3];
                this._a[__reg2.index] = Math.round(__reg2.start + __reg2.change * n);
            }
        }
        else 
        {
            while (__reg3--) 
            {
                __reg2 = this._info[__reg3];
                this._a[__reg2.index] = __reg2.start + __reg2.change * n;
            }
        }
    }

}
