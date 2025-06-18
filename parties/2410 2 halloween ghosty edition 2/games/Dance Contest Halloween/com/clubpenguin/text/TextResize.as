
//Created by Action Script Viewer - http://www.buraks.com/asv
    class com.clubpenguin.text.TextResize
    {
        function TextResize () {
        }
        static function scaleDown($field, $verticalAlign, $minFontSize) {
            if ($field.autoSize != "none") {
                return(undefined);
            }
            var _local7 = $field._width;
            var _local5 = $field._height;
            var _local6;
            var _local10 = $field.textHeight;
            var _local11;
            var _local9 = $field._x;
            var _local8 = $field._y;
            var _local2 = $field.getTextFormat();
            var _local12 = _local2.size;
            var _local4 = true;
            _local6 = _local2.align;
            _local11 = _local2.size;
            $minFontSize = (($minFontSize == undefined) ? 2 : ($minFontSize));
            if ($field.multiline) {
                $field.wordWrap = true;
            } else {
                $field.wordWrap = false;
            }
            while (_local4) {
                $field.autoSize = _local6;
                if (($field._width > _local7) || ($field._height > _local5)) {
                    _local2.size--;
                    if (_local2.size < $minFontSize) {
                        _local2.size = $minFontSize;
                        _local4 = false;
                    }
                } else {
                    _local4 = false;
                }
                $field.autoSize = "none";
                _local2.align = _local6;
                $field.setTextFormat(_local2);
                $field._height = _local5;
                $field._width = _local7;
                $field._x = _local9;
                $field._y = _local8;
            }
            if (!$field.multiline) {
                switch ($verticalAlign) {
                    case "center" : 
                        $field._y = $field._y + (((_local10 - $field.textHeight) - 1) / 2);
                        break;
                    case "bottom" : 
                        $field._y = $field._y + ((_local10 - $field.textHeight) - 1);
                        break;
                    case "top" : 
                    default : 
                        $field._y++;
                        break;
                }
            }
        }
    }
