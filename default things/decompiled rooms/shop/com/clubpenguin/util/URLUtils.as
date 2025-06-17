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
            var _local_2 = (((url + "?") + CACHE_RESET_PARAM_NAME) + "=") + CACHE_RESET_PARAM_VALUE;
            return(_local_2);
        }
        static function resetCacheOnURLsInObject(object) {
            for (var _local_3 in object) {
                var _local_2 = getCacheResetURL(object[_local_3]);
                object[_local_3] = _local_2;
            }
        }
        static var CACHE_RESET_PARAM_NAME = "cr";
        static var CACHE_RESET_PARAM_VALUE = 1;
        static var cacheResetEnabled = false;
    }
