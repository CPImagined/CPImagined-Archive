//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.greensock.plugins.GlowFilterPlugin extends com.greensock.plugins.FilterPlugin
    {
        var propName, overwriteProps, _target, _type, initFilter;
        function GlowFilterPlugin () {
            super();
            propName = "glowFilter";
            overwriteProps = ["glowFilter"];
        }
        function onInitTween(target, value, tween) {
            _target = target;
            _type = flash.filters.GlowFilter;
            initFilter(value, new flash.filters.GlowFilter(16777215, 0, 0, 0, value.strength || 1, value.quality || 2, value.inner, value.knockout), _propNames);
            return(true);
        }
        static var API = 1;
        static var _propNames = ["color", "alpha", "blurX", "blurY", "strength", "quality", "inner", "knockout"];
    }
