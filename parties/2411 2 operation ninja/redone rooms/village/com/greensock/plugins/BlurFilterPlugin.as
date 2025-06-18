    class com.greensock.plugins.BlurFilterPlugin extends com.greensock.plugins.FilterPlugin
    {
        var propName, overwriteProps, _target, _type, initFilter;
        function BlurFilterPlugin () {
            super();
            propName = "blurFilter";
            overwriteProps = ["blurFilter"];
        }
        function onInitTween(target, value, tween) {
            _target = target;
            _type = flash.filters.BlurFilter;
            initFilter(value, new flash.filters.BlurFilter(0, 0, value.quality || 2), _propNames);
            return(true);
        }
        static var API = 1;
        static var _propNames = ["blurX", "blurY", "quality"];
    }
