//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.robertpenner.Line
    {
        function Line (x1_p, y1_p, x2_p, y2_p) {
            x1 = x1_p || 0;
            y1 = y1_p || 0;
            x2 = x2_p || 0;
            y2 = y2_p || 0;
        }
        function get angle() {
            return(Math.atan2(y2 - y1, x2 - x1) * 57.2957795130823);
        }
        function get angleRadians() {
            return(Math.atan2(y2 - y1, x2 - x1));
        }
        function get slope() {
            return((y2 - y1) / (x2 - x1));
        }
        function get length() {
            var _local_3 = x2 - x1;
            var _local_2 = y2 - y1;
            return(Math.sqrt((_local_3 * _local_3) + (_local_2 * _local_2)));
        }
        function get b() {
            return(y1 - (slope * x1));
        }
        function getVector() {
            return(new com.robertpenner.Vector(x2 - x1, y2 - y1));
        }
        function draw(mc) {
            mc.lineStyle(1, 0);
            mc.moveTo(x1, y1);
            mc.lineTo(x2, y2);
            mc.lineStyle();
        }
        static function getGlobalIntersect(line1, line2) {
            var _local_1 = line1.x1;
            var _local_3 = line1.y1;
            var _local_2 = line2.x2;
            var _local_8 = line2.y2;
            var _local_7 = line1.x2 - _local_1;
            var _local_6 = line2.x1 - _local_2;
            if (!(_local_7 || (_local_6))) {
                return(null);
            }
            var _local_4 = (line1.y2 - _local_3) / _local_7;
            var _local_5 = (line2.y1 - _local_8) / _local_6;
            if (!_local_7) {
                return(new com.robertpenner.Vector(_local_1, (_local_5 * (_local_1 - _local_2)) + _local_8));
            } else if (!_local_6) {
                return(new com.robertpenner.Vector(_local_2, (_local_4 * (_local_2 - _local_1)) + _local_3));
            }
            var _local_11 = (((((-_local_5) * _local_2) + _local_8) + (_local_4 * _local_1)) - _local_3) / (_local_4 - _local_5);
            var _local_12 = (_local_4 * (_local_11 - _local_1)) + _local_3;
            return(new com.robertpenner.Vector(_local_11, _local_12));
        }
        static function getLocalIntersect(line1, line2) {
            var _local_1 = getGlobalIntersect(line1, line2);
            return(null);
        }
        function midLine(a, b) {
            return({x:(a.x + b.x) / 2, y:(a.y + b.y) / 2});
        }
        function toString() {
            return(((((((((("[Line (" + x1) + ",") + y1) + ")-") + "(") + x2) + ",") + y2) + ")") + "]");
        }
        var x1 = 0;
        var y1 = 0;
        var x2 = 0;
        var y2 = 0;
    }
