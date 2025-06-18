
//Created by Action Script Viewer - http://www.buraks.com/asv
    class com.clubpenguin.util.StringUtils
    {
        function StringUtils () {
        }
        static function capitalizeFirstLetter(_arg_1) {
            return(_arg_1.substr(0, 1).toUpperCase() + _arg_1.substr(1, _arg_1.length));
        }
        static function toTitleCase(_arg_4) {
            var _local_2 = _arg_4.split(" ");
            var _local_3 = _local_2.length;
            var _local_1 = 0;
            while (_local_1 < _local_3) {
                _local_2[_local_1] = capitalizeFirstLetter(_local_2[_local_1]);
                _local_1++;
            }
            return(_local_2.join(" "));
        }
        static function lastChar(_arg_1) {
            if (typeof(_arg_1) != "string") {
                return("");
            }
            return(_arg_1.substr(-1, 1));
        }
        static function removeLastChar(_arg_1) {
            if (typeof(_arg_1) != "string") {
                return("");
            }
            return(_arg_1.substring(0, _arg_1.length - 1));
        }
        static function ensureTrailingSlash(_arg_1) {
            if (typeof(_arg_1) != "string") {
                return("");
            }
            if (lastChar(_arg_1) != "/") {
                _arg_1 = _arg_1 + "/";
            }
            return(_arg_1);
        }
        static function removeTrailingSlash(_arg_1) {
            if (typeof(_arg_1) != "string") {
                return("");
            }
            if (lastChar(_arg_1) == "/") {
                return(removeLastChar(_arg_1));
            }
            return(_arg_1);
        }
        static function replaceString(_arg_3, _arg_1, _arg_2) {
            return(_arg_2.split(_arg_3).join(_arg_1));
        }
        static function ResizeTextToFit(_arg_1) {
            if (_arg_1.textWidth > _arg_1._width) {
                var _local_4 = _arg_1.text;
                _arg_1.text = "A";
                var _local_3 = _arg_1.textHeight;
                _arg_1.text = _local_4;
                while (_arg_1.textWidth > _arg_1._width) {
                    var _local_2 = _arg_1.getTextFormat();
                    _local_2.size--;
                    _arg_1.setTextFormat(_local_2);
                }
                _arg_1._y = _arg_1._y + (_local_3 - _arg_1.textHeight);
            }
        }
    }
