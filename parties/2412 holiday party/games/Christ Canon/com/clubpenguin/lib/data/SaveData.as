class com.clubpenguin.lib.data.SaveData implements com.clubpenguin.lib.event.IEventDispatcher, com.clubpenguin.lib.IDisposable
{
   var uid;
   var roomId;
   var AIRTOWER;
   static var SERVER_SIDE_EXTENSION_NAME = "z";
   static var SERVER_SIDE_MESSAGE_TYPE = "str";
   static var MESSAGE_GET_GAME_DATA = "ggd";
   static var MESSAGE_SET_GAME_DATA = "sgd";
   static var uids = -1;
   function SaveData()
   {
      this.uid = ++com.clubpenguin.lib.data.SaveData.uids;
      this.roomId = _global.getCurrentShell().getCurrentServerRoomId();
      this.AIRTOWER = _global.getCurrentAirtower();
      this.AIRTOWER.removeListener(com.clubpenguin.lib.data.SaveData.MESSAGE_GET_GAME_DATA,this.handleGetGameData,this);
      this.AIRTOWER.removeListener(com.clubpenguin.lib.data.SaveData.MESSAGE_SET_GAME_DATA,this.handleSetGameData,this);
      this.AIRTOWER.addListener(com.clubpenguin.lib.data.SaveData.MESSAGE_GET_GAME_DATA,this.handleGetGameData,this);
      this.AIRTOWER.addListener(com.clubpenguin.lib.data.SaveData.MESSAGE_SET_GAME_DATA,this.handleSetGameData,this);
   }
   function getGameData(index)
   {
      trace("GET GAME DATA in SaveData.as index of: " + index);
      var _loc2_ = new Array();
      if(index != undefined)
      {
         _loc2_.push(index.toString());
      }
      this.AIRTOWER.send(com.clubpenguin.lib.data.SaveData.SERVER_SIDE_EXTENSION_NAME,com.clubpenguin.lib.data.SaveData.MESSAGE_GET_GAME_DATA,_loc2_,com.clubpenguin.lib.data.SaveData.SERVER_SIDE_MESSAGE_TYPE,this.roomId);
   }
   function setGameData(data, index)
   {
      trace("SET GAME DATA in SaveData.as index of: " + index);
      var _loc2_ = new Array();
      if(index != undefined)
      {
         _loc2_.push(index.toString());
      }
      var _loc3_ = com.clubpenguin.lib.data.compression.Compressor.compress(data);
      _loc2_.push(_loc3_);
      this.AIRTOWER.send(com.clubpenguin.lib.data.SaveData.SERVER_SIDE_EXTENSION_NAME,com.clubpenguin.lib.data.SaveData.MESSAGE_SET_GAME_DATA,_loc2_,com.clubpenguin.lib.data.SaveData.SERVER_SIDE_MESSAGE_TYPE,this.roomId);
   }
   function handleGetGameData(responseArray)
   {
      var _loc2_ = String(responseArray[1]);
      var _loc3_ = com.clubpenguin.lib.data.compression.Compressor.decompress(_loc2_);
      com.clubpenguin.lib.event.EventManager.dispatchEvent(new com.clubpenguin.lib.data.event.SaveDataEvent(this,com.clubpenguin.lib.data.event.SaveDataEvent.EVENT_GET_GAME_DATA,_loc3_,_loc3_,_loc2_));
   }
   function handleSetGameData(resonseArray)
   {
   }
   function getUniqueName()
   {
      return "[SaveGameData" + this.uid + "]";
   }
   function dispose()
   {
      this.AIRTOWER.removeListener(com.clubpenguin.lib.data.SaveData.MESSAGE_GET_GAME_DATA,this.handleGetGameData,this);
      this.AIRTOWER.removeListener(com.clubpenguin.lib.data.SaveData.MESSAGE_SET_GAME_DATA,this.handleSetGameData,this);
      this.AIRTOWER = null;
   }
}
