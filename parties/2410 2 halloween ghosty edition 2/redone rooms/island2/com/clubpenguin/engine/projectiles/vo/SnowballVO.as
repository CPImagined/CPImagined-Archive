//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.engine.projectiles.vo.SnowballVO
    {
        var _type, _maxHeightOffset, _wait, _duration, _showAnimation, _alpha, _scale;
        function SnowballVO (type, maxHeightOffset, wait, duration, showAnimation, alpha, scale) {
            _type = type;
            _maxHeightOffset = maxHeightOffset;
            _wait = wait;
            _duration = ((duration != undefined) ? (duration) : -1);
            _showAnimation = ((showAnimation != undefined) ? (showAnimation) : true);
            _alpha = ((alpha != undefined) ? (alpha) : 100);
            _scale = ((scale != undefined) ? (scale) : 100);
        }
        function set type(snowballType) {
            _type = snowballType;
            //return(type);
        }
        function get type() {
            return(_type);
        }
        function get maxHeightOffset() {
            return(_maxHeightOffset);
        }
        function get wait() {
            return(_wait);
        }
        function get duration() {
            return(_duration);
        }
        function get showAnimation() {
            return(_showAnimation);
        }
        function get alpha() {
            return(_alpha);
        }
        function get scale() {
            return(_scale);
        }
        function clone() {
            return(new com.clubpenguin.engine.projectiles.vo.SnowballVO(_type, _maxHeightOffset, _wait, _duration, _showAnimation, _alpha, _scale));
        }
        function toString() {
            return(((((((((((((("[" + _type) + "|") + _maxHeightOffset) + "|") + _wait) + "|") + _duration) + "|") + _showAnimation) + "|") + _alpha) + "|") + _scale) + "]");
        }
    }
