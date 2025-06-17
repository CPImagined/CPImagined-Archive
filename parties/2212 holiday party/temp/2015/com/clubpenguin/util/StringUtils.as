class com.clubpenguin.util.StringUtils
{
   function StringUtils()
   {
   }
   static function capitalizeFirstLetter(source)
   {
      return source.substr(0,1).toUpperCase() + source.substr(1,source.length);
   }
   static function toTitleCase(source)
   {
      var _loc2_ = source.split(" ");
      var _loc3_ = _loc2_.length;
      var _loc1_ = 0;
      while(_loc1_ < _loc3_)
      {
         _loc2_[_loc1_] = com.clubpenguin.util.StringUtils.capitalizeFirstLetter(_loc2_[_loc1_]);
         _loc1_ = _loc1_ + 1;
      }
      return _loc2_.join(" ");
   }
   static function lastChar(string)
   {
      if(typeof string != "string")
      {
         return "";
      }
      return string.substr(-1,1);
   }
   static function removeLastChar(string)
   {
      if(typeof string != "string")
      {
         return "";
      }
      return string.substring(0,string.length - 1);
   }
   static function ensureTrailingSlash(string)
   {
      if(typeof string != "string")
      {
         return "";
      }
      if(com.clubpenguin.util.StringUtils.lastChar(string) != "/")
      {
         string += "/";
      }
      return string;
   }
   static function removeTrailingSlash(string)
   {
      if(typeof string != "string")
      {
         return "";
      }
      if(com.clubpenguin.util.StringUtils.lastChar(string) == "/")
      {
         return com.clubpenguin.util.StringUtils.removeLastChar(string);
      }
      return string;
   }
   static function replaceString(target, word, message)
   {
      return message.split(target).join(word);
   }
   static function trimWhitespace(str)
   {
      str = com.clubpenguin.util.StringUtils.replaceChar(str," ","");
      return str;
   }
   static function replaceChar(str, targetChar, repChar)
   {
      var _loc3_ = "";
      var _loc1_ = 0;
      while(_loc1_ < str.length)
      {
         _loc3_ += str.charAt(_loc1_) != targetChar ? str.charAt(_loc1_) : repChar;
         _loc1_ = _loc1_ + 1;
      }
      return _loc3_;
   }
   static function ResizeTextToFit(txt)
   {
      var _loc4_ = txt._y;
      if(txt.textWidth > txt._width)
      {
         var _loc5_ = txt.text;
         txt.text = "A";
         var _loc3_ = txt.textHeight;
         txt.text = _loc5_;
         while(txt.textWidth > txt._width)
         {
            var _loc2_ = txt.getTextFormat();
            _loc2_.size--;
            txt.setTextFormat(_loc2_);
         }
         txt._y = _loc4_ + (_loc3_ - txt.textHeight);
      }
   }
   static function checkStartsWithVowel(str)
   {
      var _loc1_ = str.charAt(0).toLowerCase();
      return _loc1_ == "a" || _loc1_ == "e" || _loc1_ == "i" || _loc1_ == "o" || _loc1_ == "u";
   }
}
