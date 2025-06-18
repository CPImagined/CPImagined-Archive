class com.clubpenguin.games.cannon.saves.PlayerInitializer implements com.clubpenguin.lib.IDisposable
{
   var penguin;
   var callback;
   var saveData;
   var dataSet;
   function PlayerInitializer()
   {
      com.clubpenguin.lib.event.EventManager.removeEventListener(com.clubpenguin.lib.data.event.SaveDataEvent.EVENT_GET_GAME_DATA,this.handleGetGameData,this);
      com.clubpenguin.lib.event.EventManager.addEventListener(com.clubpenguin.lib.data.event.SaveDataEvent.EVENT_GET_GAME_DATA,this.handleGetGameData,this);
   }
   function loadPlayer(penguin, callback)
   {
      this.penguin = penguin;
      this.callback = callback;
      this.saveData = penguin.saveData;
      trace("[PlayerInitializer] loadPlayer()  about to getGameData()");
      this.saveData.getGameData();
   }
   function handleGetGameData(event)
   {
      trace("[PlayerInitializer] about to create the dataSet");
      this.dataSet = com.clubpenguin.lib.data.compression.DataSet(event.data);
      trace("[PlayerInitializer] dataSet was built");
      if(this.dataSet.numEntries == 0)
      {
         this.initializeDataSet();
      }
      else
      {
         this.loadDataSet();
      }
      trace("[PlayerInitializer] dataSet was created");
      this.penguin.dataSet = this.dataSet;
      this.callback();
   }
   function initializeDataSet()
   {
      trace("[PlayerInitializer] new dataSet");
      var _loc6_ = 0;
      while(_loc6_ < 36)
      {
         this.dataSet.setInt16(0);
         _loc6_ += 1;
      }
      var _loc5_ = 36;
      while(_loc5_ < 72)
      {
         this.dataSet.setInt16(600);
         _loc5_ += 1;
      }
      var _loc2_ = 0;
      while(_loc2_ < 16)
      {
         this.dataSet.setBool(false,_loc2_,72);
         _loc2_ += 1;
      }
      var _loc3_ = 0;
      while(_loc3_ < 16)
      {
         this.dataSet.setBool(false,_loc3_,73);
         _loc3_ += 1;
      }
      var _loc4_ = 0;
      while(_loc4_ < 3)
      {
         this.dataSet.setBool(false,_loc4_,74);
         _loc4_ += 1;
      }
   }
   function loadDataSet()
   {
      trace("[PlayerInitializer] loadDataSet");
      var _loc2_ = undefined;
      var _loc3_ = undefined;
      var _loc4_ = 1;
      while(_loc4_ < 37)
      {
         _loc2_ = this.dataSet.getInt16(_loc4_ - 1);
         if(_loc2_ == null || _loc2_ < 0)
         {
            _loc2_ = 0;
            this.dataSet.setData(new com.clubpenguin.lib.data.compression.type.CInt16(_loc2_),_loc4_ - 1);
         }
         this.penguin["level" + _loc4_ + "playerPuffleOs"] = _loc2_;
         _loc4_ += 1;
      }
      var _loc5_ = 1;
      while(_loc5_ < 37)
      {
         _loc2_ = this.dataSet.getInt16(_loc5_ + 35);
         if(_loc2_ == null || _loc2_ < 0)
         {
            _loc2_ = 600;
            this.dataSet.setData(new com.clubpenguin.lib.data.compression.type.CInt16(_loc2_),_loc5_ + 35);
         }
         this.penguin["level" + _loc5_ + "bestTime"] = _loc2_;
         _loc5_ += 1;
      }
      var _loc6_ = 0;
      while(_loc6_ < 16)
      {
         _loc3_ = this.dataSet.getBool(72,_loc6_);
         if(_loc3_ == null)
         {
            _loc3_ = false;
            this.dataSet.setData(new com.clubpenguin.lib.data.compression.type.CBool(0),72);
         }
         this.penguin["level" + (_loc6_ + 1) + "turboDone"] = _loc3_;
         _loc6_ += 1;
      }
      var _loc8_ = 0;
      while(_loc8_ < 16)
      {
         _loc3_ = this.dataSet.getBool(73,_loc8_);
         if(_loc3_ == null)
         {
            _loc3_ = false;
            this.dataSet.setData(new com.clubpenguin.lib.data.compression.type.CBool(0),73);
         }
         this.penguin["level" + (_loc8_ + 17) + "turboDone"] = _loc3_;
         _loc8_ += 1;
      }
      var _loc7_ = 0;
      while(_loc7_ < 4)
      {
         _loc3_ = this.dataSet.getBool(74,_loc7_);
         if(_loc3_ == null)
         {
            _loc3_ = false;
            this.dataSet.setData(new com.clubpenguin.lib.data.compression.type.CBool(0),74);
         }
         this.penguin["level" + (_loc7_ + 33) + "turboDone"] = _loc3_;
         _loc7_ += 1;
      }
   }
   function dispose()
   {
      com.clubpenguin.lib.event.EventManager.removeEventListener(com.clubpenguin.lib.data.event.SaveDataEvent.EVENT_GET_GAME_DATA,this.handleGetGameData,this);
      this.saveData.dispose();
      this.saveData = null;
      this.penguin = null;
      this.dataSet = null;
      this.callback = null;
   }
}
