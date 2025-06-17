class com.disney.dlearning.debug.DLSLocalConnectionProducer extends Object
{
   function DLSLocalConnectionProducer()
   {
      super();
      this.conn = new LocalConnection();
      this.conn.onStatus = this.onStatus;
   }
   function sendMessage(type, message)
   {
      var _loc2_ = new Object();
      _loc2_.type = type;
      _loc2_.message = message;
      var _loc3_ = new com.disney.dlearning.serialization.JSON();
      this.conn.send("DLS.CONNECTION","DLSlcHandler",_loc3_.stringify(_loc2_));
   }
   function onStatus(event)
   {
      switch(event.level)
      {
         case "status":
         case "error":
      }
   }
}
