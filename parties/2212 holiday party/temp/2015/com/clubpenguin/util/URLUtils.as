class com.clubpenguin.util.URLUtils
{
   static var CACHE_RESET_PARAM_NAME = "cr";
   static var CACHE_RESET_PARAM_VALUE = 1;
   static var cacheResetEnabled = false;
   function URLUtils()
   {
   }
   static function getCacheResetURL(url)
   {
      if(!com.clubpenguin.util.URLUtils.cacheResetEnabled)
      {
         return url;
      }
      if(url.indexOf(".swf") == -1)
      {
         return url;
      }
      if(url.indexOf(com.clubpenguin.util.URLUtils.CACHE_RESET_PARAM_NAME + "=" + com.clubpenguin.util.URLUtils.CACHE_RESET_PARAM_VALUE) != -1)
      {
         return url;
      }
      var _loc2_ = url + "?" + com.clubpenguin.util.URLUtils.CACHE_RESET_PARAM_NAME + "=" + com.clubpenguin.util.URLUtils.CACHE_RESET_PARAM_VALUE;
      return _loc2_;
   }
   static function resetCacheOnURLsInObject(object)
   {
      for(var _loc3_ in object)
      {
         var _loc2_ = com.clubpenguin.util.URLUtils.getCacheResetURL(object[_loc3_]);
         object[_loc3_] = _loc2_;
      }
   }
}
