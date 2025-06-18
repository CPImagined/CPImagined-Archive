//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.robertpenner.Vector
    {
        var x, y;
        function Vector (xValue, yValue) {
            x = xValue;
            y = yValue;
        }
        function toString() {
            var _local_3 = Math.round(x * 1000) / 1000;
            var _local_2 = Math.round(y * 1000) / 1000;
            return(((("[" + _local_3) + ", ") + _local_2) + "]");
        }
        function reset(xValue, yValue) {
            x = xValue;
            y = yValue;
        }
        function getClone() {
            return(new com.robertpenner.Vector(x, y));
        }
        function plus(v) {
            x = x + v.x;
            y = y + v.y;
        }
        function plusNew(v) {
            return(new com.robertpenner.Vector(x + v.x, y + v.y));
        }
        function minus(v) {
            x = x - v.x;
            y = y - v.y;
        }
        function minusNew(v) {
            return(new com.robertpenner.Vector(x - v.x, y - v.y));
        }
        function negate() {
            x = -x;
            y = -y;
        }
        function negateNew() {
            return(new com.robertpenner.Vector(-x, -y));
        }
        function scale(s) {
            x = x * s;
            y = y * s;
        }
        function scaleNew(s) {
            return(new com.robertpenner.Vector(x * s, y * s));
        }
        function get length() {
            return(Math.sqrt((x * x) + (y * y)));
        }
        function set length(len) {
            var _local_2 = length;
            if (_local_2) {
                scale(len / _local_2);
            } else {
                x = len;
            }
            //return(length);
        }
        function get angle() {
            return(Math.atan2(y, x) * 57.2957795130823);
        }
        function set angle(ang) {
            var _local_2 = length;
            x = _local_2 * Math.cos(ang * (Math.PI/180));
            y = _local_2 * Math.sin(ang * (Math.PI/180));
            //return(angle);
        }
        function rotate(ang) {
            var _local_3 = Math.cos(ang * (Math.PI/180));
            var _local_2 = Math.sin(ang * (Math.PI/180));
            var _local_5 = (x * _local_3) - (y * _local_2);
            var _local_4 = (x * _local_2) + (y * _local_3);
            x = _local_5;
            y = _local_4;
        }
        function rotateNew(ang) {
            var _local_2 = new com.robertpenner.Vector(x, y);
            _local_2.rotate(ang);
            return(_local_2);
        }
        function rotateAround(p, ang) {
            var _local_4 = Math.cos(ang * (Math.PI/180));
            var _local_3 = Math.sin(ang * (Math.PI/180));
            var _local_6 = ((x - p.x) * _local_4) - ((y - p.y) * _local_3);
            var _local_5 = ((x - p.x) * _local_3) + ((y - p.y) * _local_4);
            x = _local_6 + p.x;
            y = _local_5 + p.y;
        }
        function rotateAroundNew(p, ang) {
            var _local_2 = new com.robertpenner.Vector(x, y);
            _local_2.rotateAround(p, ang);
            return(_local_2);
        }
        function dot(v) {
            return((x * v.x) + (y * v.y));
        }
        function getNormal() {
            return(new com.robertpenner.Vector(-y, x));
        }
        function isNormalTo(v) {
            return(dot(v) == 0);
        }
        function angleBetween(v) {
            var _local_3 = dot(v);
            var _local_2 = _local_3 / (length * v.length);
            return(Math.acos(_local_2) * 57.2957795130823);
        }
        function get slope() {
            return(y / x);
        }
        function reflectOff(v) {
            rotate(-v.angle);
            y = -y;
            rotate(v.angle);
        }
    }
