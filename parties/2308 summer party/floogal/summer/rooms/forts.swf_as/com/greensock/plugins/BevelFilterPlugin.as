dynamic class com.greensock.plugins.BevelFilterPlugin extends com.greensock.plugins.FilterPlugin
{
    static var API: Number = 1;
    static var _propNames = ["distance", "angle", "highlightColor", "highlightAlpha", "shadowColor", "shadowAlpha", "blurX", "blurY", "strength", "quality"];
    var _target;
    var _type;
    var initFilter;
    var overwriteProps;
    var propName;

    function BevelFilterPlugin()
    {
        super();
        this.propName = "bevelFilter";
        this.overwriteProps = ["bevelFilter"];
    }

    function onInitTween(target, value, tween)
    {
        this._target = target;
        this._type = flash.filters.BevelFilter;
        this.initFilter(value, new flash.filters.BevelFilter(0, 0, 16777215, 0.5, 0, 0.5, 2, 2, 0, value.quality || 2), com.greensock.plugins.BevelFilterPlugin._propNames);
        return true;
    }

}
