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
            var _local_2 = _target.duplicateMovieClip("__frameLabelPluginTempMC", _target._parent.getNextHighestDepth());
            _local_2.gotoAndStop(value);
            var _local_3 = _local_2._currentframe;
            _local_2.removeMovieClip();
            if (frame != _local_3) {
                addTween(this, "frame", frame, _local_3, "frame");
            }
            return(true);
        }
        static var API = 1;
    }
