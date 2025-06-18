class com.clubpenguin.games.cannon.saves.PenguinSaver
{
   function PenguinSaver()
   {
   }
   function savePlayer(penguin)
   {
      trace("[PenguinSaver] savePlayer function is running");
      var _loc9_ = penguin.dataSet;
      var _loc10_ = penguin.saveData;
      var _loc1_ = undefined;
      var _loc2_ = undefined;
      var _loc6_ = 1;
      while(_loc6_ < 37)
      {
         _loc1_ = Number(penguin["level" + _loc6_ + "playerPuffleOs"]);
         if(!isNaN(_loc1_) && _loc1_ != undefined && _loc1_ != null && _loc1_ >= 0)
         {
            _loc1_ = Math.round(_loc1_);
            _loc9_.setInt16(_loc1_,_loc6_ - 1);
            trace("DataSet: index:" + (_loc6_ - 1) + " level" + _loc6_ + "playerPuffleOs:" + penguin["level" + _loc6_ + "playerPuffleOs"]);
         }
         else
         {
            trace("[ERROR] @ PenguinSaver#savePlayer playerPuffleOs for level:" + _loc6_ + " was num:" + _loc1_);
         }
         _loc6_ += 1;
      }
      var _loc5_ = 1;
      while(_loc5_ < 37)
      {
         _loc1_ = Number(penguin["level" + _loc5_ + "bestTime"]);
         if(!isNaN(_loc1_) && _loc1_ != undefined && _loc1_ != null && _loc1_ >= 0)
         {
            _loc1_ = Math.round(_loc1_);
            _loc9_.setInt16(_loc1_,_loc5_ + 35);
            trace("DataSet: index:" + (_loc5_ + 35) + " level" + _loc5_ + "bestTime:" + penguin["level" + _loc5_ + "bestTime"]);
         }
         else
         {
            trace("[ERROR] @ PenguinSaver#savePlayer bestTime for level:" + _loc5_ + " was num:" + _loc1_);
         }
         _loc5_ += 1;
      }
      var _loc7_ = 0;
      while(_loc7_ < 16)
      {
         _loc2_ = Boolean(penguin["level" + (_loc7_ + 1) + "turboDone"]);
         if(_loc2_ == true || _loc2_ == false)
         {
            _loc9_.setBool(_loc2_,_loc7_,72);
            trace("DataSet: index:72 boolIndex:" + _loc7_ + " turboDone:" + penguin["level" + (_loc7_ + 1) + "turboDone"]);
         }
         else
         {
            trace("[ERROR] @ PenguinSaver#savePlayer turboDone for level:" + (_loc7_ + 1) + " was bool:" + _loc2_);
         }
         _loc7_ += 1;
      }
      var _loc8_ = 0;
      while(_loc8_ < 16)
      {
         _loc2_ = Boolean(penguin["level" + (_loc8_ + 17) + "turboDone"]);
         if(_loc2_ == true || _loc2_ == false)
         {
            _loc9_.setBool(_loc2_,_loc8_,73);
            trace("DataSet: index:73 boolIndex:" + _loc8_ + " turboDone:" + penguin["level" + (_loc8_ + 17) + "turboDone"]);
         }
         else
         {
            trace("[ERROR] @ PenguinSaver#savePlayer turboDone for level:" + (_loc8_ + 17) + " was bool:" + _loc2_);
         }
         _loc8_ += 1;
      }
      var _loc4_ = 0;
      while(_loc4_ < 4)
      {
         _loc2_ = Boolean(penguin["level" + (_loc4_ + 33) + "turboDone"]);
         if(_loc2_ == true || _loc2_ == false)
         {
            _loc9_.setBool(_loc2_,_loc4_,74);
            trace("DataSet: index:74 boolIndex:" + _loc4_ + " turboDone:" + penguin["level" + (_loc4_ + 33) + "turboDone"]);
         }
         else
         {
            trace("[ERROR] @ PenguinSaver#savePlayer turboDone for level:" + (_loc4_ + 33) + " was bool:" + _loc2_);
         }
         _loc9_.setBool(Boolean(penguin["level" + (_loc4_ + 33) + "turboDone"]),_loc4_,74);
         _loc4_ += 1;
      }
      trace("[PenguinSaver] saveData.setGameData(dataSet)");
      _loc10_.setGameData(_loc9_);
   }
}
