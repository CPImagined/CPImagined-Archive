class com.clubpenguin.lib.data.compression.type.CString implements com.clubpenguin.lib.data.compression.type.DataType
{
   var _value;
   var _manifest;
   static var TYPE_ID = 4;
   function CString($value, $manifest)
   {
      this._value = $value;
      if(this._value == undefined)
      {
         this._value = "";
      }
      this._manifest = $manifest;
      if(this._manifest == undefined)
      {
         this._manifest = new com.clubpenguin.lib.data.compression.manifest.ManifestEntry();
         this._manifest.type = com.clubpenguin.lib.data.compression.type.CString.TYPE_ID;
         this._manifest.size = this._value.length;
         this._manifest.setNull(0,false);
         this._manifest.setNull(1,false);
         this._manifest.setNull(2,false);
         this._manifest.setNull(3,false);
      }
   }
   function compress()
   {
      var _loc3_ = this._value;
      var _loc4_ = undefined;
      var _loc2_ = 0;
      while(_loc2_ < com.clubpenguin.lib.data.compression.type.SpecialTypes.specialTypes.length)
      {
         if(_loc3_.indexOf(com.clubpenguin.lib.data.compression.type.SpecialTypes.specialTypes[_loc2_],0) != -1)
         {
            _loc4_ = String.fromCharCode(_loc2_ + 1) + String.fromCharCode(_loc2_ + 1);
            _loc3_.split(com.clubpenguin.lib.data.compression.type.SpecialTypes.specialTypes[_loc2_]).join(_loc4_);
         }
         _loc2_ += 1;
      }
      this._manifest.size = _loc3_.length + 1;
      return this._manifest.serialize() + _loc3_;
   }
   function decompress($entry)
   {
      var _loc3_ = undefined;
      var _loc2_ = 0;
      while(_loc2_ < com.clubpenguin.lib.data.compression.type.SpecialTypes.specialTypes.length)
      {
         _loc3_ = String.fromCharCode(_loc2_ + 1) + String.fromCharCode(_loc2_ + 1);
         if($entry.indexOf(_loc3_,0) != -1)
         {
            $entry.split(_loc3_).join(com.clubpenguin.lib.data.compression.type.SpecialTypes.specialTypes[_loc2_]);
         }
         _loc2_ += 1;
      }
      this._value = $entry;
      this._manifest.size = this._value.length + 1;
   }
   function type()
   {
      return this._manifest.type;
   }
   function size()
   {
      return this._manifest.size;
   }
   function get value()
   {
      return this._value;
   }
   function set value($value)
   {
      this._value = $value;
   }
}
