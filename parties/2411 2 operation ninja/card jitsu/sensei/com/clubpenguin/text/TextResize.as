//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.text.TextResize
    {
        function TextResize () {
        }
        static function scaleDown($field, $verticalAlign, $minFontSize) {
            if ($field.autoSize != "none") {
                trace("(TextResize): Error, cannont resize fields that have autoSize enabled!\r(textResize): Error occured at " + $field);
                return(undefined);
            }
            var _local_7 = $field._width;
            var _local_5 = $field._height;
            var _local_6;
            var _local_10 = $field.textHeight;
            var _local_11;
            var _local_9 = $field._x;
            var _local_8 = $field._y;
            var _local_2 = $field.getTextFormat();
            var _local_12 = _local_2.size;
            var _local_4 = true;
            _local_6 = _local_2.align;
            _local_11 = _local_2.size;
            $minFontSize = (($minFontSize == undefined) ? 2 : ($minFontSize));
            if ($field.multiline) {
                $field.wordWrap = true;
            } else {
                $field.wordWrap = false;
            }
            while (_local_4) {
                $field.autoSize = _local_6;
                if (($field._width > _local_7) || ($field._height > _local_5)) {
                    _local_2.size--;
                    if (_local_2.size < $minFontSize) {
                        trace((((("(TextResize): Error, font size is < " + $minFontSize) + "!") + newline) + "(textResize): Error occured at ") + $field);
                        _local_2.size = $minFontSize;
                        _local_4 = false;
                    }
                } else {
                    _local_4 = false;
                }
                $field.autoSize = "none";
                _local_2.align = _local_6;
                $field.setTextFormat(_local_2);
                $field._height = _local_5;
                $field._width = _local_7;
                $field._x = _local_9;
                $field._y = _local_8;
            }
            if (!$field.multiline) {
                switch ($verticalAlign) {
                    case "center" : 
                        $field._y = $field._y + (((_local_10 - $field.textHeight) - 1) / 2);
                        break;
                    case "bottom" : 
                        $field._y = $field._y + ((_local_10 - $field.textHeight) - 1);
                        break;
                    case "top" : 
                    default : 
                        $field._y++;
                        break;
                }
            }
        }
    }
