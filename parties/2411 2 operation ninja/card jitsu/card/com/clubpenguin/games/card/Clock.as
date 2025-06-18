//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.games.card.Clock
    {
        var _mc, _iTimer, _tickID, dispatchEvent;
        function Clock (mc) {
            mx.events.EventDispatcher.initialize(this);
            _mc = mc;
            _mc._visible = false;
        }
        function start() {
            _iTimer = TIME_OUT;
            _mc._visible = true;
            _mc.timer_txt.text = _iTimer;
            _tickID = setInterval(com.clubpenguin.util.Delegate.create(this, tick), 1000);
        }
        function end() {
            clearInterval(_tickID);
            _tickID = null;
            _mc.timer_txt.text = "";
            _mc.gotoAndStop(1);
            _mc._visible = false;
        }
        function timeup() {
            this.end();
            dispatchEvent({target:this, type:TIME_UP});
        }
        function tick() {
            var _local_2 = --_iTimer;
            _mc.timer_txt.text = _local_2;
            _mc.nextFrame();
            if (_local_2 > 0) {
                dispatchEvent({target:this, type:TICK});
            } else {
                timeup();
            }
        }
        function terminate() {
            if (_tickID) {
                clearInterval(_tickID);
            }
        }
        static var CLASS_PACKAGE = "com.clubpenguin.games.Clock";
        static var CLASS_NAME = "Clock";
        static var TIME_OUT = 20;
        static var TIME_UP = "time_up";
        static var TICK = "tick";
    }
