
//Created by Action Script Viewer - http://www.buraks.com/asv
    class com.clubpenguin.world.rooms2013.common.CallbackAnimation extends MovieClip
    {
        var _mc, _callback, _targetFrame;
        function CallbackAnimation (_arg_6, _arg_7, _arg_5, _arg_4) {
            super();
            _mc = _arg_6;
            _callback = _arg_7;
            _targetFrame = ((_arg_4 == undefined) ? (_mc._totalframes) : (_arg_4));
            var _local_3 = ((_arg_5 == undefined) ? 2 : (_arg_5));
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
