class com.clubpenguin.world.rooms2015.automated.vo.PartyJSON_Parser implements com.clubpenguin.util.ISerializable
{
   function PartyJSON_Parser()
   {
      this.deserialized = new org.osflash.signals.Signal();
      this._jsonObject = new Object();
   }
   function jsonObject()
   {
      return this._jsonObject;
   }
   function serialize()
   {
      return com.clubpenguin.util.JSONParser.stringify(this._jsonObject);
   }
   function deserialize(data)
   {
      if(data == undefined || data.length == 0)
      {
         this._jsonObject = new Object();
      }
      else
      {
         var _loc2_ = com.clubpenguin.util.JSONParser.parse(data);
         if(this._jsonObject == null)
         {
            this._jsonObject = new Object();
         }
         for(var _loc3_ in _loc2_)
         {
            this._jsonObject[_loc3_] = _loc2_[_loc3_];
         }
      }
      this.deserialized.dispatch(this._jsonObject);
   }
}
