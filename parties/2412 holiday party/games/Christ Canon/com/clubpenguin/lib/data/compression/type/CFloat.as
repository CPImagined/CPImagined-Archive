class com.clubpenguin.lib.data.compression.type.CFloat implements com.clubpenguin.lib.data.compression.type.DataType
{
   var _manifest;
   var _value;
   static var TYPE_ID = 3;
   function CFloat($value, $manifest)
   {
      this._manifest = $manifest;
      if(this._manifest == undefined)
      {
         this._manifest = new com.clubpenguin.lib.data.compression.manifest.ManifestEntry();
         this._manifest.type = com.clubpenguin.lib.data.compression.type.CFloat.TYPE_ID;
         this._manifest.size = 3;
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
      var _loc2_ = this._value >>> 15 & com.clubpenguin.lib.data.compression.type.TypeMasks.INT_16;
      var _loc3_ = this._value & com.clubpenguin.lib.data.compression.type.TypeMasks.INT_16;
      if(_loc2_ == 0)
      {
         this._manifest.setNull(0,true);
         _loc2_ = 1;
      }
      else
      {
         this._manifest.setNull(0,false);
      }
      if(_loc3_ == 0)
      {
         this._manifest.setNull(1,true);
         _loc3_ = 1;
      }
      else
      {
         this._manifest.setNull(1,false);
      }
      var _loc5_ = String.fromCharCode(_loc2_);
      var _loc4_ = String.fromCharCode(_loc3_);
      return this._manifest.serialize() + _loc5_ + _loc4_;
   }
   function decompress($entry)
   {
      var _loc2_ = $entry.charCodeAt(0);
      var _loc3_ = $entry.charCodeAt(1);
      if(this._manifest.isNull(0))
      {
         _loc2_ = 0;
      }
      if(this._manifest.isNull(1))
      {
         _loc3_ = 0;
      }
      this._value = _loc3_ | _loc2_ << 15;
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
