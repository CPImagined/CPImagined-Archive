class com.clubpenguin.lib.data.compression.type.CBool extends com.clubpenguin.lib.data.compression.type.CInt16
{
   var _manifest;
   var _value;
   static var TYPE_ID = 2;
   function CBool($value, $manifest)
   {
      super($value,$manifest);
      this._manifest.type = com.clubpenguin.lib.data.compression.type.CBool.TYPE_ID;
   }
   function decompress($entry)
   {
      if(this._manifest.size == 3)
      {
         var _loc2_ = String(com.clubpenguin.lib.data.compression.type.SpecialTypes.specialTypes[$entry.charCodeAt(0) - 1]);
         $entry = _loc2_;
      }
      if(this._manifest.isNull(0))
      {
         this._value = 0;
      }
      else
      {
         this._value = $entry.charCodeAt(0);
      }
   }
   function getBoolAt($bit)
   {
      return !!(this._value >>> $bit & true) ? true : false;
   }
   function setBoolAt($bit, $value)
   {
      if($value)
      {
         this._value |= 1 << $bit;
      }
      else
      {
         this._value &= com.clubpenguin.lib.data.compression.type.TypeMasks.INT_16 ^ 1 << $bit;
      }
   }
}
