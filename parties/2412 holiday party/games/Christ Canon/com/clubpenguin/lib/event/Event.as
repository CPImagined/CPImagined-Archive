class com.clubpenguin.lib.event.Event extends Object
{
   var __eventDispatcher;
   var __eventType;
   var __eventData;
   function Event(_source, _type, _data)
   {
      super();
      this.__eventDispatcher = _source;
      this.__eventType = _type;
      this.__eventData = _data;
   }
   function get target()
   {
      return this.__eventDispatcher;
   }
   function set target(_val)
   {
      this.__eventDispatcher = _val;
   }
   function get data()
   {
      return this.__eventData;
   }
   function set data(_val)
   {
      this.__eventData = _val;
   }
   function get type()
   {
      return this.__eventType;
   }
   function set type(_val)
   {
      this.__eventType = _val;
   }
   function clone()
   {
      var _loc2_ = undefined;
      _loc2_ = this.createEvent();
      return _loc2_;
   }
   function createEvent()
   {
      return new com.clubpenguin.lib.event.Event(this.__eventDispatcher,this.__eventType,this.__eventData);
   }
   function toString()
   {
      var _loc1_ = undefined;
      _loc1_ = "Event";
      return _loc1_;
   }
}
