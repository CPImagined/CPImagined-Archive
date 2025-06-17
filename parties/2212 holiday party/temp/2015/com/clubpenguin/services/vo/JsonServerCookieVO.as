class com.clubpenguin.services.vo.JsonServerCookieVO extends com.clubpenguin.services.vo.ServerCookieVO
{
   function JsonServerCookieVO(cookieId)
   {
      super(cookieId);
      this.deserialized = new org.osflash.signals.Signal();
      this._jsonObject = new Object();
   }
   function destroy()
   {
      super.destroy();
   }
   function isInitialized()
   {
      return this._jsonObject != null;
   }
   function update(vo)
   {
      this.deserialize(com.clubpenguin.services.vo.JsonServerCookieVO(vo).serialize());
   }
   function toString()
   {
      return "[JsonServerCookie:" + this.serialize() + "]";
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
      this.deserialized.dispatch();
   }
}
