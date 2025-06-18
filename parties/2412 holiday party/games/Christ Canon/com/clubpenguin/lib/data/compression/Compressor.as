class com.clubpenguin.lib.data.compression.Compressor
{
   function Compressor()
   {
   }
   static function compress($data)
   {
      var _loc3_ = "";
      var _loc1_ = 0;
      while(_loc1_ < $data.numEntries)
      {
         if($data.getData(_loc1_) != undefined && $data.getData(_loc1_) != null)
         {
            _loc3_ += $data.getData(_loc1_).compress();
         }
         _loc1_ += 1;
      }
      trace("After Compression:\n" + _loc3_ + "\nTotal Length: " + _loc3_.length);
      return _loc3_;
   }
   static function decompress($cData)
   {
      trace("Before Decompression:\n" + $cData + "\nTotal Length: " + $cData.length);
      var _loc5_ = new com.clubpenguin.lib.data.compression.DataSet();
      var _loc3_ = undefined;
      var _loc6_ = undefined;
      var _loc2_ = undefined;
      var _loc4_ = undefined;
      _loc4_ = $cData.length + 2;
      while($cData.length > 0 && $cData.length != _loc4_)
      {
         _loc2_ = new com.clubpenguin.lib.data.compression.manifest.ManifestEntry($cData.charAt(0));
         _loc6_ = $cData.substr(1,_loc2_.size - 1);
         switch(_loc2_.type)
         {
            case com.clubpenguin.lib.data.compression.type.CInt16.TYPE_ID:
               _loc3_ = new com.clubpenguin.lib.data.compression.type.CInt16(0,_loc2_);
               trace("TypeInt " + $cData.length);
               break;
            case com.clubpenguin.lib.data.compression.type.CBool.TYPE_ID:
               _loc3_ = new com.clubpenguin.lib.data.compression.type.CBool(0,_loc2_);
               trace("TypeBool");
               break;
            case com.clubpenguin.lib.data.compression.type.CFloat.TYPE_ID:
               _loc3_ = new com.clubpenguin.lib.data.compression.type.CFloat(0,_loc2_);
               trace("TypeFloat");
               break;
            case com.clubpenguin.lib.data.compression.type.CString.TYPE_ID:
               _loc3_ = new com.clubpenguin.lib.data.compression.type.CString(null,_loc2_);
               trace("TypeString");
               break;
            default:
               trace("[ERROR] Unknown type id:" + _loc2_.type);
               return _loc5_;
         }
         _loc3_.decompress(_loc6_);
         _loc5_.setData(_loc3_);
         _loc4_ = $cData.length;
         $cData = $cData.substring(_loc2_.size,$cData.length);
      }
      if($cData.length != 0)
      {
         trace("!!!!!!!!!!!!!!!!!!!!!!!!!**********************!!!!!!!!!!!!!!!!!!! data fail in decompress(): manifesttype" + _loc2_.type + " at cdatalength " + $cData.length);
      }
      trace("All data decompressed ok!");
      return _loc5_;
   }
}
