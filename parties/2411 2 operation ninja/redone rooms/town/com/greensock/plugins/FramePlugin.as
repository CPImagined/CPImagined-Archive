    class com.greensock.plugins.FramePlugin extends com.greensock.plugins.TweenPlugin
    {
        var propName, overwriteProps, round, _target, frame, addTween, updateTweens, __get__changeFactor;
        function FramePlugin () {
            super();
            propName = "frame";
            overwriteProps = ["frame"];
            round = true;
        }
        function onInitTween(target, value, tween) {
            if ((typeof(target) != "movieclip") || (isNaN(value))) {
                return(false);
            }
            _target = MovieClip(target);
            frame = _target._currentframe;
            addTween(this, "frame", frame, value, "frame");
            return(true);
        }
        function set changeFactor(n) {
            updateTweens(n);
            _target.gotoAndStop(frame);
            //return(__get__changeFactor());
        }
        static var API = 1;
    }
