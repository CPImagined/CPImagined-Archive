//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2013.common.CallbackAnimation extends MovieClip
    {
        var _mc, _callback, _targetFrame;
        function CallbackAnimation (mc, callback, startFrame, targetFrame) {
            super();
            _mc = mc;
            _callback = callback;
            _targetFrame = ((targetFrame == undefined) ? (_mc._totalframes) : (targetFrame));
            var _local_3 = ((startFrame == undefined) ? 2 : (startFrame));
            _mc.gotoAndPlay(_local_3);
            _mc.onEnterFrame = com.clubpenguin.util.Delegate.create(this, tweenComplete);
        }
        function tweenComplete() {
            if (_mc._currentframe == _targetFrame) {
                _callback();
                delete _mc.onEnterFrame;
            }
        }
    }
