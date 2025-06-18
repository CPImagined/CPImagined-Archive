class com.clubpenguin.lib.data.compression.DataSet
{
   var _entries;
   var _size = 0;
   function DataSet()
   {
      this._entries = new Array();
   }
   function get size()
   {
      return this._size;
   }
   function get numEntries()
   {
      return this._entries.length;
   }
   function getData($index)
   {
      return com.clubpenguin.lib.data.compression.type.DataType(this._entries[$index]);
   }
   function setData($data, $index)
   {
      this._size += $data.size();
      if($index == undefined)
      {
         this._entries.push($data);
         return undefined;
      }
      if(this.getData($index) != undefined)
      {
         this._size -= this.getData($index).size();
      }
      this._entries[$index] = $data;
   }
   function deleteEntry($index)
   {
      var _loc2_ = this.getData($index);
      this._entries[$index] = undefined;
      return _loc2_;
   }
   function setInt16($value, $index)
   {
      this.setData(new com.clubpenguin.lib.data.compression.type.CInt16($value),$index);
   }
   function getInt16($index)
   {
      if(this.getData($index).type() != com.clubpenguin.lib.data.compression.type.CInt16.TYPE_ID)
      {
         trace("[ERROR] Data type at index:" + $index + " is not an int16! Found type:" + this.getData($index).type());
         return null;
      }
      return com.clubpenguin.lib.data.compression.type.CInt16(this.getData($index)).value;
   }
   function setBool($value, $boolIndex, $index)
   {
      var _loc4_ = undefined;
      if($boolIndex == undefined || $boolIndex > 15 || $boolIndex < 0)
      {
         trace("[ERROR] $boolIndex argument must be a number between or including 0 to 15, found $boolIndex:" + $boolIndex);
         return undefined;
      }
      if($index == undefined)
      {
         if(this.getData(this._entries.length - 1).type() == com.clubpenguin.lib.data.compression.type.CBool.TYPE_ID)
         {
            com.clubpenguin.lib.data.compression.type.CBool(this.getData(this._entries.length - 1)).setBoolAt($boolIndex,$value);
            return undefined;
         }
      }
      else if(this.getData($index) != undefined)
      {
         if(this.getData($index).type() != com.clubpenguin.lib.data.compression.type.CBool.TYPE_ID)
         {
            trace("[ERROR] Data type at index:" + $index + " is not a bool! Found type:" + this.getData($index).type());
            return undefined;
         }
         com.clubpenguin.lib.data.compression.type.CBool(this.getData($index)).setBoolAt($boolIndex,$value);
         return undefined;
      }
      _loc4_ = new com.clubpenguin.lib.data.compression.type.CBool();
      _loc4_.setBoolAt($boolIndex,$value);
      this.setData(_loc4_,$index);
   }
   function getBool($index, $boolIndex)
   {
      if($boolIndex == undefined || $boolIndex > 15 || $boolIndex < 0)
      {
         trace("[ERROR] $boolIndex argument must be a number between or including 0 to 15, found $boolIndex:" + $boolIndex);
         return null;
      }
      if(this.getData($index).type() != com.clubpenguin.lib.data.compression.type.CBool.TYPE_ID)
      {
         trace("[ERROR] Data type at index:" + $index + " is not a bool! Found type:" + this.getData($index).type());
         return null;
      }
      return com.clubpenguin.lib.data.compression.type.CBool(this.getData($index)).getBoolAt($boolIndex);
   }
   function setFloat($value, $index)
   {
      this.setData(new com.clubpenguin.lib.data.compression.type.CFloat($value),$index);
   }
   function getFloat($index)
   {
      if(this.getData($index).type() != com.clubpenguin.lib.data.compression.type.CFloat.TYPE_ID)
      {
         trace("[ERROR] Data type at index:" + $index + " is not a float! Found type:" + this.getData($index).type());
         return null;
      }
      return com.clubpenguin.lib.data.compression.type.CFloat(this.getData($index)).value;
   }
   function setString($value, $index)
   {
      this.setData(new com.clubpenguin.lib.data.compression.type.CString($value),$index);
   }
   function getString($index)
   {
      trace("DataSet.getString() at index: " + $index);
      var _loc4_ = undefined;
      _loc4_ = this.getData($index);
      trace("got data type; " + _loc4_);
      var _loc3_ = undefined;
      _loc3_ = _loc4_.type();
      trace("got dataTypeID : " + _loc3_);
      if(_loc3_ != com.clubpenguin.lib.data.compression.type.CString.TYPE_ID)
      {
         trace("[ERROR] Data type at index:" + $index + " is not a float! Found type:" + this.getData($index).type());
         return null;
      }
      trace("DataSet.getString() at index: " + $index);
      return com.clubpenguin.lib.data.compression.type.CString(this.getData($index)).value;
   }
}
