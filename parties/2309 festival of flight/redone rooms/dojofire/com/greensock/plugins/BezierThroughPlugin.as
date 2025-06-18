//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.greensock.plugins.BezierThroughPlugin extends com.greensock.plugins.BezierPlugin
    {
        var propName, init;
        function BezierThroughPlugin () {
            super();
            propName = "bezierThrough";
        }
        function onInitTween(target, value, tween) {
            if (!(value instanceof Array)) {
                return(false);
            }
            init(tween, [value][0], true);
            return(true);
        }
        static var API = 1;
    }
