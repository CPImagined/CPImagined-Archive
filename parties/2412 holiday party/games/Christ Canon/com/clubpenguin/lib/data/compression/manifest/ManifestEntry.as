class com.clubpenguin.lib.data.compression.manifest.ManifestEntry
{
   var nullChars;
   var _type = 1;
   var _size = 2;
   function ManifestEntry($char)
   {
      this.nullChars = new Array(true,true,true,true);
      if($char != undefined)
      {
         this.deserialize($char);
      }
   }
   function serialize()
   {
      var _loc3_ = 0;
      var _loc2_ = 0;
      while(_loc2_ < this.nullChars.length)
      {
         _loc3_ |= !!Boolean(this.nullChars[_loc2_]) ? 1 << _loc2_ : 0;
         _loc2_ += 1;
      }
      _loc3_ |= this.type << 4;
      _loc3_ |= this.size << 8;
      return String.fromCharCode(_loc3_);
   }
   function deserialize($char)
   {
      var _loc3_ = $char.charCodeAt(0);
      var _loc2_ = 0;
      while(_loc2_ < this.nullChars.length)
      {
         this.nullChars[_loc2_] = !!(_loc3_ >>> _loc2_ & com.clubpenguin.lib.data.compression.manifest.ManifestMasks.NULL_MASK == 1) ? true : false;
         _loc2_ += 1;
      }
      this._type = _loc3_ >>> 4 & com.clubpenguin.lib.data.compression.manifest.ManifestMasks.TYPE_MASK;
      this._size = _loc3_ >>> 8 & com.clubpenguin.lib.data.compression.manifest.ManifestMasks.SIZE_MASK;
   }
   function isNull($charIndex)
   {
      return Boolean(this.nullChars[$charIndex]);
   }
   function setNull($charIndex, $null)
   {
      this.nullChars[$charIndex] = $null;
   }
   function get type()
   {
      return this._type;
   }
   function set type($newVal)
   {
      this._type = $newVal;
   }
   function get size()
   {
      return this._size;
   }
   function set size($newVal)
   {
      this._size = $newVal;
   }
   function toString()
   {
      return "[ManifestEntry type:" + this._type + " size:" + this._size + " nullChars:" + this.nullChars + "]";
   }
}
