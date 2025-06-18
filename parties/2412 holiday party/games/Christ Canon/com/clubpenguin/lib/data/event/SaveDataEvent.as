class com.clubpenguin.lib.data.event.SaveDataEvent extends com.clubpenguin.lib.event.Event
{
   var __dataSet;
   var __orgString;
   static var EVENT_GET_GAME_DATA = "eventGetGameData";
   function SaveDataEvent(_source, _type, _data, _dataSet, _orgString)
   {
      super(_source,_type,_data);
      this.__dataSet = _dataSet;
      this.__orgString = _orgString;
   }
   function get dataSet()
   {
      return this.__dataSet;
   }
   function get stringSource()
   {
      return this.__orgString;
   }
}
