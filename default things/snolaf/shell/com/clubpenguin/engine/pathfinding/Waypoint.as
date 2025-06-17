//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.engine.pathfinding.Waypoint extends flash.geom.Point
    {
        var _mc, x, y;
        function Waypoint (mc) {
            super();
            if (mc == undefined) {
                return;
            }
            _mc = mc;
            x = Math.round(_mc._x);
            y = Math.round(_mc._y);
            _mc.gotoAndStop(PARK_LABEL);
        }
        function set used(value) {
            _used = value;
            //return(used);
        }
        function get used() {
            return(_used);
        }
        function set active(value) {
            _active = value;
            //return(active);
        }
        function get active() {
            return(_active);
        }
        static var PARK_LABEL = "park";
        var _active = true;
        var _used = false;
    }
