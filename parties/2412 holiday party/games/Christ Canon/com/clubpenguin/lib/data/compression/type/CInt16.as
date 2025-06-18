class com.clubpenguin.lib.data.compression.type.CInt16 implements com.clubpenguin.lib.data.compression.type.DataType
{
   var _manifest;
   var _value;
   static var TYPE_ID = 1;
   function CInt16($value, $manifest)
   {
      this._manifest = $manifest;
      if(this._manifest == undefined)
      {
         this._manifest = new com.clubpenguin.lib.data.compression.manifest.ManifestEntry();
         this._manifest.setNull(1,false);
         this._manifest.setNull(2,false);
         this._manifest.setNull(3,false);
      }
      this._value = $value;
      if(this._value == undefined)
      {
         this._value = 0;
      }
   }
   function compress()
   {
      var _loc3_ = undefined;
      if(this._value == 0)
      {
         this._manifest.setNull(0,true);
         _loc3_ = String.fromCharCode(1);
      }
      else
      {
         this._manifest.setNull(0,false);
         _loc3_ = String.fromCharCode(this._value & com.clubpenguin.lib.data.compression.type.TypeMasks.INT_16);
         var _loc2_ = 0;
         while(_loc2_ < com.clubpenguin.lib.data.compression.type.SpecialTypes.specialTypes.length)
         {
            if(_loc3_ == String(com.clubpenguin.lib.data.compression.type.SpecialTypes.specialTypes[_loc2_]))
            {
               _loc3_ = String.fromCharCode(_loc2_ + 1) + String.fromCharCode(_loc2_ + 1);
               this._manifest.size = 3;
               break;
            }
            this._manifest.size = 2;
            _loc2_ += 1;
         }
      }
      return this._manifest.serialize() + _loc3_;
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
         if(this._value >>> 15 == 1)
         {
            this._value |= com.clubpenguin.lib.data.compression.type.TypeMasks.UPPER_INT32;
         }
      }
   }
   function set value($value)
   {
      this._value = $value;
   }
   function get value()
   {
      return this._value;
   }
   function size()
   {
      return this._manifest.size;
   }
   function type()
   {
      return this._manifest.type;
   }
}
