//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.text.TextResize
    {
        function TextResize () {
        }
        static function scaleDown(_arg_1, _arg_13, _arg_3) {
            if (_arg_1.autoSize != "none") {
                return(undefined);
            }
            var _local_7 = _arg_1._width;
            var _local_5 = _arg_1._height;
            var _local_6;
            var _local_10 = _arg_1.textHeight;
            var _local_11;
            var _local_9 = _arg_1._x;
            var _local_8 = _arg_1._y;
            var _local_2 = _arg_1.getTextFormat();
            var _local_12 = _local_2.size;
            var _local_4 = true;
            _local_6 = _local_2.align;
            _local_11 = _local_2.size;
            _arg_3 = ((_arg_3 == undefined) ? 2 : (_arg_3));
            if (_arg_1.multiline) {
                _arg_1.wordWrap = true;
            } else {
                _arg_1.wordWrap = false;
            }
            while (_local_4) {
                _arg_1.autoSize = _local_6;
                if ((_arg_1._width > _local_7) || (_arg_1._height > _local_5)) {
                    _local_2.size--;
                    if (_local_2.size < _arg_3) {
                        _local_2.size = _arg_3;
                        _local_4 = false;
                    }
                } else {
                    _local_4 = false;
                }
                _arg_1.autoSize = "none";
                _local_2.align = _local_6;
                _arg_1.setTextFormat(_local_2);
                _arg_1._height = _local_5;
                _arg_1._width = _local_7;
                _arg_1._x = _local_9;
                _arg_1._y = _local_8;
            }
            if (!_arg_1.multiline) {
                switch (_arg_13) {
                    case "center" : 
                        _arg_1._y = _arg_1._y + (((_local_10 - _arg_1.textHeight) - 1) / 2);
                        break;
                    case "bottom" : 
                        _arg_1._y = _arg_1._y + ((_local_10 - _arg_1.textHeight) - 1);
                        break;
                    case "top" : 
                    default : 
                        _arg_1._y++;
                }
            }
        }
    }
