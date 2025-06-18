//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.greensock.plugins.BevelFilterPlugin extends com.greensock.plugins.FilterPlugin
    {
        var propName, overwriteProps, _target, _type, initFilter;
        function BevelFilterPlugin () {
            super();
            propName = "bevelFilter";
            overwriteProps = ["bevelFilter"];
        }
        function onInitTween(target, value, tween) {
            _target = target;
            _type = flash.filters.BevelFilter;
            initFilter(value, new flash.filters.BevelFilter(0, 0, 16777215, 0.5, 0, 0.5, 2, 2, 0, value.quality || 2), _propNames);
            return(true);
        }
        static var API = 1;
        static var _propNames = ["distance", "angle", "highlightColor", "highlightAlpha", "shadowColor", "shadowAlpha", "blurX", "blurY", "strength", "quality"];
    }
