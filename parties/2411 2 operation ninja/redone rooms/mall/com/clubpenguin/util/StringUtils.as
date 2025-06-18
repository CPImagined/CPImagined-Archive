//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.util.StringUtils
    {
        function StringUtils () {
        }
        static function capitalizeFirstLetter(source) {
            return(source.substr(0, 1).toUpperCase() + source.substr(1, source.length));
        }
        static function toTitleCase(source) {
            var _local_2 = source.split(" ");
            var _local_3 = _local_2.length;
            var _local_1 = 0;
            while (_local_1 < _local_3) {
                _local_2[_local_1] = capitalizeFirstLetter(_local_2[_local_1]);
                _local_1++;
            }
            return(_local_2.join(" "));
        }
        static function lastChar(string) {
            if (typeof(string) != "string") {
                return("");
            }
            return(string.substr(-1, 1));
        }
        static function removeLastChar(string) {
            if (typeof(string) != "string") {
                return("");
            }
            return(string.substring(0, string.length - 1));
        }
        static function ensureTrailingSlash(string) {
            if (typeof(string) != "string") {
                return("");
            }
            if (lastChar(string) != "/") {
                string = string + "/";
            }
            return(string);
        }
        static function removeTrailingSlash(string) {
            if (typeof(string) != "string") {
                return("");
            }
            if (lastChar(string) == "/") {
                return(removeLastChar(string));
            }
            return(string);
        }
        static function replaceString(target, word, message) {
            return(message.split(target).join(word));
        }
        static function trimWhitespace(str) {
            trace("String in: " + str);
            str = replaceChar(str, " ", "");
            trace("string out:" + str);
            return(str);
        }
        static function replaceChar(str, targetChar, repChar) {
            var _local_3 = "";
            var _local_1 = 0;
            while (_local_1 < str.length) {
                _local_3 = _local_3 + ((str.charAt(_local_1) == targetChar) ? (repChar) : (str.charAt(_local_1)));
                _local_1++;
            }
            return(_local_3);
        }
        static function ResizeTextToFit(txt) {
            var _local_4 = txt._y;
            if (txt.textWidth > txt._width) {
                var _local_5 = txt.text;
                txt.text = "A";
                var _local_3 = txt.textHeight;
                txt.text = _local_5;
                while (txt.textWidth > txt._width) {
                    var _local_2 = txt.getTextFormat();
                    _local_2.size--;
                    txt.setTextFormat(_local_2);
                }
                txt._y = _local_4 + (_local_3 - txt.textHeight);
            }
        }
        static function checkStartsWithVowel(str) {
            var _local_1 = str.charAt(0).toLowerCase();
            return(((((_local_1 == "a") || (_local_1 == "e")) || (_local_1 == "i")) || (_local_1 == "o")) || (_local_1 == "u"));
        }
    }
