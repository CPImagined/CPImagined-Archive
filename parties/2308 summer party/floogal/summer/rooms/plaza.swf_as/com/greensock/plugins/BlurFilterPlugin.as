dynamic class com.greensock.plugins.BlurFilterPlugin extends com.greensock.plugins.FilterPlugin
{
    static var API: Number = 1;
    static var _propNames = ["blurX", "blurY", "quality"];
    var _target;
    var _type;
    var initFilter;
    var overwriteProps;
    var propName;

    function BlurFilterPlugin()
    {
        super();
        this.propName = "blurFilter";
        this.overwriteProps = ["blurFilter"];
    }

    function onInitTween(target, value, tween)
    {
        this._target = target;
        this._type = flash.filters.BlurFilter;
        this.initFilter(value, new flash.filters.BlurFilter(0, 0, value.quality || 2), com.greensock.plugins.BlurFilterPlugin._propNames);
        return true;
    }

}
