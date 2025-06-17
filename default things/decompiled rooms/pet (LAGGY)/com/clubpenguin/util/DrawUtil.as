//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.util.DrawUtil
    {
        function DrawUtil () {
        }
        static function fillRect(_arg_1, _arg_3, _arg_2, _arg_4) {
            drawRect(_arg_1, _arg_3, _arg_2, _arg_4);
        }
        static function drawRect(_arg_2, _arg_1, _arg_4, _arg_3, _arg_7, _arg_6, _arg_5) {
            _arg_2.clear();
            if (((_arg_7 != null) && (_arg_6 != null)) && (_arg_5 != null)) {
                _arg_2.lineStyle(_arg_7, _arg_6, _arg_5);
            }
            if ((_arg_4 != null) && (_arg_3 != null)) {
                _arg_2.beginFill(_arg_4, _arg_3);
            }
            _arg_2.moveTo(_arg_1.left, _arg_1.top);
            _arg_2.lineTo(_arg_1.right, _arg_1.top);
            _arg_2.lineTo(_arg_1.right, _arg_1.bottom);
            _arg_2.lineTo(_arg_1.left, _arg_1.bottom);
            _arg_2.lineTo(_arg_1.left, _arg_1.top);
            _arg_2.endFill();
        }
        static function setStyle(_arg_5, _arg_4, _arg_6, _arg_3, _arg_1, _arg_2) {
            if (_arg_6) {
                _arg_3 = _arg_3 || 0;
                _arg_2 = ((_arg_2 == undefined) ? "none" : (_arg_2));
                _arg_5.lineStyle(_arg_3, _arg_6, 100, true, _arg_2, "round", "miter", 1);
            }
            if (_arg_4) {
                _arg_1 = ((_arg_1 == undefined) ? 100 : (_arg_1));
                _arg_5.beginFill(_arg_4, _arg_1);
            }
        }
        static function drawRoundedRectangle(_arg_3, _arg_7, _arg_4, _arg_9, _arg_10, _arg_8) {
            setStyle(_arg_3, _arg_9, _arg_10, _arg_8);
            var _local_2 = _arg_7.x;
            var _local_1 = _arg_7.y;
            var _local_6 = _arg_7.width;
            var _local_5 = _arg_7.height;
            _arg_3.moveTo(_local_2, _local_1 + _arg_4);
            _arg_3.curveTo(_local_2, _local_1, _local_2 + _arg_4, _local_1);
            _arg_3.lineTo((_local_2 + _local_6) - _arg_4, _local_1);
            _arg_3.curveTo(_local_2 + _local_6, _local_1, _local_2 + _local_6, _local_1 + _arg_4);
            _arg_3.lineTo(_local_2 + _local_6, (_local_1 + _local_5) - _arg_4);
            _arg_3.curveTo(_local_2 + _local_6, _local_1 + _local_5, (_local_2 + _local_6) - _arg_4, _local_1 + _local_5);
            _arg_3.lineTo(_local_2 + _arg_4, _local_1 + _local_5);
            _arg_3.curveTo(_local_2, _local_1 + _local_5, _local_2, (_local_1 + _local_5) - _arg_4);
            _arg_3.lineTo(_local_2, _local_1 + _arg_4);
            _arg_3.endFill();
        }
        static function drawCircle(_arg_5, _arg_2, _arg_1, _arg_4, _arg_6, _arg_3) {
            drawEllipse(_arg_5, new flash.geom.Rectangle(_arg_2.x, _arg_2.y, _arg_1 * 2, _arg_1 * 2), _arg_4, _arg_6, _arg_3, 100, "none");
        }
        static function drawRing(_arg_3, _arg_5, _arg_2, _arg_4, _arg_1) {
            drawEllipse(_arg_3, _arg_5, _arg_2, _arg_4, _arg_1, 0, "normal");
        }
        static function drawEllipse(_arg_5, _arg_6, _arg_11, _arg_12, _arg_9, _arg_10, _arg_13) {
            var _local_2 = _arg_6.x;
            var _local_1 = _arg_6.y;
            var _local_8 = _arg_6.width;
            var _local_3 = _local_8 / 2;
            var _local_7 = _arg_6.height;
            var _local_4 = _local_7 / 2;
            setStyle(_arg_5, _arg_11, _arg_12, _arg_9, _arg_10, _arg_13);
            _arg_5.moveTo(_local_2 + _local_3, _local_1);
            _arg_5.curveTo(_local_3 + _local_2, (TAN_PI_8 * _local_4) + _local_1, (SIN_PI_4 * _local_3) + _local_2, (SIN_PI_4 * _local_4) + _local_1);
            _arg_5.curveTo((TAN_PI_8 * _local_3) + _local_2, _local_4 + _local_1, _local_2, _local_4 + _local_1);
            _arg_5.curveTo(((-TAN_PI_8) * _local_3) + _local_2, _local_4 + _local_1, ((-SIN_PI_4) * _local_3) + _local_2, (SIN_PI_4 * _local_4) + _local_1);
            _arg_5.curveTo((-_local_3) + _local_2, (TAN_PI_8 * _local_4) + _local_1, (-_local_3) + _local_2, _local_1);
            _arg_5.curveTo((-_local_3) + _local_2, ((-TAN_PI_8) * _local_4) + _local_1, ((-SIN_PI_4) * _local_3) + _local_2, ((-SIN_PI_4) * _local_4) + _local_1);
            _arg_5.curveTo(((-TAN_PI_8) * _local_3) + _local_2, (-_local_4) + _local_1, _local_2, (-_local_4) + _local_1);
            _arg_5.curveTo((TAN_PI_8 * _local_3) + _local_2, (-_local_4) + _local_1, (SIN_PI_4 * _local_3) + _local_2, ((-SIN_PI_4) * _local_4) + _local_1);
            _arg_5.curveTo(_local_3 + _local_2, ((-TAN_PI_8) * _local_4) + _local_1, _local_3 + _local_2, _local_1);
            _arg_5.endFill();
        }
        static function drawDonut(_arg_1, _arg_5, _arg_3, _arg_4, _arg_2, _arg_11, _arg_10, _arg_9, _arg_8, _arg_7, _arg_6, _arg_13, _arg_14, _arg_12) {
            setStyle(_arg_1, _arg_13, _arg_14, _arg_12);
            _arg_1.moveTo(_arg_5, _arg_4 + _arg_7);
            _arg_1.curveTo(_arg_5, _arg_4, _arg_5 + _arg_7, _arg_4);
            _arg_1.lineTo((_arg_5 + _arg_11) - _arg_7, _arg_4);
            _arg_1.curveTo(_arg_5 + _arg_11, _arg_4, _arg_5 + _arg_11, _arg_4 + _arg_7);
            _arg_1.lineTo(_arg_5 + _arg_11, (_arg_4 + _arg_9) - _arg_7);
            _arg_1.curveTo(_arg_5 + _arg_11, _arg_4 + _arg_9, (_arg_5 + _arg_11) - _arg_7, _arg_4 + _arg_9);
            _arg_1.lineTo(_arg_5 + _arg_7, _arg_4 + _arg_9);
            _arg_1.curveTo(_arg_5, _arg_4 + _arg_9, _arg_5, (_arg_4 + _arg_9) - _arg_7);
            _arg_1.lineTo(_arg_5, _arg_4 + _arg_7);
            _arg_1.moveTo(_arg_3, _arg_2 + _arg_6);
            _arg_1.curveTo(_arg_3, _arg_2, _arg_3 + _arg_6, _arg_2);
            _arg_1.lineTo((_arg_3 + _arg_10) - _arg_6, _arg_2);
            _arg_1.curveTo(_arg_3 + _arg_10, _arg_2, _arg_3 + _arg_10, _arg_2 + _arg_6);
            _arg_1.lineTo(_arg_3 + _arg_10, (_arg_2 + _arg_8) - _arg_6);
            _arg_1.curveTo(_arg_3 + _arg_10, _arg_2 + _arg_8, (_arg_3 + _arg_10) - _arg_6, _arg_2 + _arg_8);
            _arg_1.lineTo(_arg_3 + _arg_6, _arg_2 + _arg_8);
            _arg_1.curveTo(_arg_3, _arg_2 + _arg_8, _arg_3, (_arg_2 + _arg_8) - _arg_6);
            _arg_1.lineTo(_arg_3, _arg_2 + _arg_6);
            _arg_1.endFill();
        }
        static function drawPolygon(_arg_3, _arg_2, _arg_5, _arg_6, _arg_4) {
            if (_arg_2.length <= 2) {
                return(undefined);
            }
            setStyle(_arg_3, _arg_5, _arg_6, _arg_4);
            _arg_3.moveTo(_arg_2[0].x, _arg_2[0].y);
            var _local_1 = 1;
            while (_local_1 < _arg_2.length) {
                _arg_3.lineTo(_arg_2[_local_1].x, _arg_2[_local_1].y);
                _local_1++;
            }
            _arg_3.lineTo(_arg_2[0].x, _arg_2[0].y);
            _arg_3.endFill();
        }
        static var RED = 16711680;
        static var ORANGE = 16753920;
        static var YELLOW = 16776960;
        static var GREEN = 65280;
        static var BLUE = 255;
        static var PURPLE = 16711935;
        static var TAN_PI_8 = 0.414213562373095;
        static var SIN_PI_4 = 0.707106781186547;
    }
