dynamic class com.greensock.plugins.FrameLabelPlugin extends com.greensock.plugins.FramePlugin
{
    static var API: Number = 1;
    var _target;
    var addTween;
    var frame;
    var propName;

    function FrameLabelPlugin()
    {
        super();
        this.propName = "frameLabel";
    }

    function onInitTween(target, value, tween)
    {
        if (typeof tween.target != "movieclip") 
        {
            return false;
        }
        this._target = MovieClip(target);
        this.frame = this._target._currentframe;
        var __reg2 = this._target.duplicateMovieClip("__frameLabelPluginTempMC", this._target._parent.getNextHighestDepth());
        __reg2.gotoAndStop(value);
        var __reg3 = __reg2._currentframe;
        __reg2.removeMovieClip();
        if (this.frame != __reg3) 
        {
            this.addTween(this, "frame", this.frame, __reg3, "frame");
        }
        return true;
    }

}
