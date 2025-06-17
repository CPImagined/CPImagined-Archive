class com.clubpenguin.shell.PuffleStatsVO
{
   static var FOOD = "food";
   static var PLAY = "play";
   static var REST = "rest";
   static var CLEAN = "clean";
   var foodStat = -1;
   var playStat = -1;
   var restStat = -1;
   var cleanStat = -1;
   function PuffleStatsVO(food, play, rest, clean)
   {
      this.foodStat = food;
      this.playStat = play;
      this.restStat = rest;
      this.cleanStat = clean;
   }
   function getLowestStatType(statTypes, lowStatThreshold)
   {
      var _loc3_ = new Array();
      if(statTypes != null)
      {
         var _loc2_ = 0;
         while(_loc2_ < statTypes.length)
         {
            if(statTypes[_loc2_] == com.clubpenguin.shell.PuffleStatsVO.FOOD && this.foodStat != undefined && this.foodStat <= lowStatThreshold)
            {
               _loc3_.push(com.clubpenguin.shell.PuffleStatsVO.FOOD);
            }
            else if(statTypes[_loc2_] == com.clubpenguin.shell.PuffleStatsVO.PLAY && this.playStat != undefined && this.playStat <= lowStatThreshold)
            {
               _loc3_.push(com.clubpenguin.shell.PuffleStatsVO.PLAY);
            }
            else if(statTypes[_loc2_] == com.clubpenguin.shell.PuffleStatsVO.REST && this.restStat != undefined && this.restStat <= lowStatThreshold)
            {
               _loc3_.push(com.clubpenguin.shell.PuffleStatsVO.REST);
            }
            else if(statTypes[_loc2_] == com.clubpenguin.shell.PuffleStatsVO.CLEAN && this.cleanStat != undefined && this.cleanStat <= lowStatThreshold)
            {
               _loc3_.push(com.clubpenguin.shell.PuffleStatsVO.CLEAN);
            }
            _loc2_ = _loc2_ + 1;
         }
      }
      if(_loc3_.length > 1)
      {
         var _loc6_ = undefined;
         _loc6_ = Math.floor(Math.random() * _loc3_.length);
         return _loc3_[_loc6_];
      }
      if(_loc3_.length == 1)
      {
         return _loc3_[0];
      }
      if(_loc3_.length == 0)
      {
         return null;
      }
   }
}
