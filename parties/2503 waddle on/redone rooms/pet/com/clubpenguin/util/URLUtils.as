//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.util.URLUtils
    {
        function URLUtils () {
        }
        static function getCacheResetURL(_arg_1) {
            if (!cacheResetEnabled) {
                return(_arg_1);
            }
            if (_arg_1.indexOf(".swf") == -1) {
                return(_arg_1);
            }
            if (_arg_1.indexOf((CACHE_RESET_PARAM_NAME + "=") + CACHE_RESET_PARAM_VALUE) != -1) {
                return(_arg_1);
            }
            var _local_2 = (((_arg_1 + "?") + CACHE_RESET_PARAM_NAME) + "=") + CACHE_RESET_PARAM_VALUE;
            return(_local_2);
        }
        static function resetCacheOnURLsInObject(_arg_1) {
            for (var _local_3 in _arg_1) {
                var _local_2 = getCacheResetURL(_arg_1[_local_3]);
                _arg_1[_local_3] = _local_2;
            }
        }
        static var CACHE_RESET_PARAM_NAME = "cr";
        static var CACHE_RESET_PARAM_VALUE = 1;
        static var cacheResetEnabled = false;
    }
