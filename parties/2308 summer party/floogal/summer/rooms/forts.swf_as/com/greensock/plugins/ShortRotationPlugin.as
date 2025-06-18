dynamic class com.greensock.plugins.ShortRotationPlugin extends com.greensock.plugins.TweenPlugin
{
    static var API: Number = 1;
    var addTween;
    var overwriteProps;
    var propName;

    function ShortRotationPlugin()
    {
        super();
        this.propName = "shortRotation";
        this.overwriteProps = [];
    }

    function onInitTween(target, value, tween)
    {
        if (typeof value == "number") 
        {
            return false;
        }
        var __reg4 = Boolean(value.useRadians == true);
        for (var __reg5 in value) 
        {
            if (__reg5 != "useRadians") 
            {
                this.initRotation(target, __reg5, target[__reg5], typeof value[__reg5] == "number" ? Number(value[__reg5]) : target[__reg5] + Number(value[__reg5]), __reg4);
            }
        }
        return true;
    }

    function initRotation(target, propName, start, end, useRadians)
    {
        var __reg3 = useRadians ? 6.28318530718 : 360;
        var __reg2 = (end - start) % __reg3;
        if (__reg2 != __reg2 % (__reg3 / 2)) 
        {
            __reg2 = __reg2 >= 0 ? __reg2 - __reg3 : __reg2 + __reg3;
        }
        this.addTween(target, propName, start, start + __reg2, propName);
        this.overwriteProps[this.overwriteProps.length] = propName;
    }

}
