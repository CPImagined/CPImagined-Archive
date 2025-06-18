dynamic class com.greensock.plugins.BezierThroughPlugin extends com.greensock.plugins.BezierPlugin
{
    static var API: Number = 1;
    var init;
    var propName;

    function BezierThroughPlugin()
    {
        super();
        this.propName = "bezierThrough";
    }

    function onInitTween(target, value, tween)
    {
        if (!(value instanceof Array)) 
        {
            return false;
        }
        this.init(tween, [value][0], true);
        return true;
    }

}
