//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.util.StringUtils
    {
        function StringUtils () {
        }
        static function capitalizeFirstLetter(source) {
            return(source.substr(0, 1).toUpperCase() + source.substr(1, source.length));
        }
        static function toTitleCase(source) {
            var words = source.split(" ");
            var len = words.length;
            var i = 0;
            while (i < len) {
                words[i] = capitalizeFirstLetter(words[i]);
                i++;
            }
            return(words.join(" "));
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
        static function ResizeTextToFit(txt) {
            if (txt.textWidth > txt._width) {
                var contents = txt.text;
                txt.text = "A";
                var originalYHeight = txt.textHeight;
                txt.text = contents;
                while (txt.textWidth > txt._width) {
                    var tf = txt.getTextFormat();
                    tf.size--;
                    txt.setTextFormat(tf);
                }
                txt._y = txt._y + (originalYHeight - txt.textHeight);
            }
        }
    }
