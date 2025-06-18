//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.engine.projectiles.vo.SnowballVO
    {
        var _type, _maxHeightOffset, _wait, _duration, _showAnimation, _alpha, _scale;
        function SnowballVO (_arg_7, _arg_8, _arg_6, _arg_2, _arg_4, _arg_5, _arg_3) {
            _type = _arg_7;
            _maxHeightOffset = _arg_8;
            _wait = _arg_6;
            _duration = ((_arg_2 != undefined) ? (_arg_2) : -1);
            _showAnimation = ((_arg_4 != undefined) ? (_arg_4) : true);
            _alpha = ((_arg_5 != undefined) ? (_arg_5) : 100);
            _scale = ((_arg_3 != undefined) ? (_arg_3) : 100);
        }
        function set type(_arg_2) {
            _type = _arg_2;
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
