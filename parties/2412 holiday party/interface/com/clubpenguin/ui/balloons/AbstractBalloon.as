//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.ui.balloons.AbstractBalloon
    {
        var _mc, _mcName, _linkage;
        function AbstractBalloon (mc) {
            if (mc == undefined) {
                return;
            }
            _mc = mc;
            _mcName = mc._name;
        }
        function setSize(width, height) {
            mc.balloon_mc._width = width;
            mc.pointer_mc._width = width;
            mc.balloon_mc._height = height;
            mc.balloon_mc._y = mc.pointer_mc._y - height;
        }
        function hide() {
            mc.gotoAndStop(PARKED_FRAME);
        }
        function get name() {
            return(_mcName);
        }
        function get mc() {
            return(_mc);
        }
        function get linkage() {
            return(_linkage);
        }
        function set linkage(value) {
            _linkage = value;
            //return(linkage);
        }
        function get counter() {
            return(_counter);
        }
        function set counter(value) {
            _counter = value;
            //return(counter);
        }
        function get duration() {
            return(_duration);
        }
        function set duration(value) {
            _duration = value;
            //return(duration);
        }
        function toString() {
            return(((((((("AbstractBalloon -> mc: " + mc) + " ") + "counter: ") + counter) + " ") + "duration: ") + duration) + " ");
        }
        static var PARKED_FRAME = "parked";
        var _counter = 0;
        var _duration = 125;
    }
