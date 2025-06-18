dynamic class com.clubpenguin.util.URLUtils
{
    static var CACHE_RESET_PARAM_NAME: String = "cr";
    static var CACHE_RESET_PARAM_VALUE: Number = 1;
    static var cacheResetEnabled: Boolean = false;

    function URLUtils()
    {
    }

    static function getCacheResetURL(url)
    {
        if (!com.clubpenguin.util.URLUtils.cacheResetEnabled) 
        {
            return url;
        }
        if (url.indexOf(".swf") == -1) 
        {
            return url;
        }
        if (url.indexOf(com.clubpenguin.util.URLUtils.CACHE_RESET_PARAM_NAME + "=" + com.clubpenguin.util.URLUtils.CACHE_RESET_PARAM_VALUE) != -1) 
        {
            return url;
        }
        var __reg2 = url + "?" + com.clubpenguin.util.URLUtils.CACHE_RESET_PARAM_NAME + "=" + com.clubpenguin.util.URLUtils.CACHE_RESET_PARAM_VALUE;
        return __reg2;
    }

    static function resetCacheOnURLsInObject(object)
    {
        for (var __reg3 in object) 
        {
            var __reg2 = com.clubpenguin.util.URLUtils.getCacheResetURL(object[__reg3]);
            object[__reg3] = __reg2;
        }
    }

}
