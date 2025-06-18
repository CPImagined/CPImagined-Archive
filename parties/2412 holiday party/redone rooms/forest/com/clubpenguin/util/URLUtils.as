//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.util.URLUtils
    {
        function URLUtils () {
        }
        static function getCacheResetURL(url) {
            if (!cacheResetEnabled) {
                return(url);
            }
            if (url.indexOf(".swf") == -1) {
                return(url);
            }
            if (url.indexOf((CACHE_RESET_PARAM_NAME + "=") + CACHE_RESET_PARAM_VALUE) != -1) {
                return(url);
            }
            var resetURL = ((((url + "?") + CACHE_RESET_PARAM_NAME) + "=") + CACHE_RESET_PARAM_VALUE);
            return(resetURL);
        }
        static function resetCacheOnURLsInObject(object) {
            for (var key in object) {
                var cacheResetURL = getCacheResetURL(object[key]);
                object[key] = cacheResetURL;
            }
        }
        static var CACHE_RESET_PARAM_NAME = "cr";
        static var CACHE_RESET_PARAM_VALUE = 1;
        static var cacheResetEnabled = false;
    }
