//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.greensock.plugins.FrameLabelPlugin extends com.greensock.plugins.FramePlugin
    {
        var propName, _target, frame, addTween;
        function FrameLabelPlugin () {
            super();
            propName = "frameLabel";
        }
        function onInitTween(target, value, tween) {
            if (typeof(tween.target) != "movieclip") {
                return(false);
            }
            _target = MovieClip(target);
            frame = _target._currentframe;
            var mc = _target.duplicateMovieClip("__frameLabelPluginTempMC", _target._parent.getNextHighestDepth());
            mc.gotoAndStop(value);
            var endFrame = mc._currentframe;
            mc.removeMovieClip();
            if (frame != endFrame) {
                addTween(this, "frame", frame, endFrame, "frame");
            }
            return(true);
        }
        static var API = 1;
    }
