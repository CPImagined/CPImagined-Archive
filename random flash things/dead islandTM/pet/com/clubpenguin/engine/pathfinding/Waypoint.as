//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.engine.pathfinding.Waypoint extends flash.geom.Point
    {
        var _mc, x, y;
        function Waypoint (_arg_3) {
            super();
            if (_arg_3 == undefined) {
                return;
            }
            _mc = _arg_3;
            x = Math.round(_mc._x);
            y = Math.round(_mc._y);
            _mc.gotoAndStop(PARK_LABEL);
        }
        function set used(_arg_2) {
            _used = _arg_2;
            //return(used);
        }
        function get used() {
            return(_used);
        }
        function set active(_arg_2) {
            _active = _arg_2;
            //return(active);
        }
        function get active() {
            return(_active);
        }
        static var PARK_LABEL = "park";
        var _active = true;
        var _used = false;
    }
