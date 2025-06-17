class com.clubpenguin.model.vo.PlayerVO implements com.clubpenguin.util.IVO
{
   var isUsingSlide = false;
   var hasNotMovedSince = -1;
   var lastFrame = -1;
   function PlayerVO()
   {
   }
   function get avatar_id()
   {
      return this.avatarVO.avatar_id;
   }
   function set avatar_id(value)
   {
   }
   function destroy()
   {
      false;
   }
   function isReadyToBeBitmapCached()
   {
      return this.hasNotMovedSince > 0 && getTimer() - this.hasNotMovedSince > 3000;
   }
   function setIsBitmapCacheable(isCacheable)
   {
      if(isCacheable && this.hasNotMovedSince == -1)
      {
         this.hasNotMovedSince = getTimer();
      }
      else if(!isCacheable)
      {
         this.hasNotMovedSince = -1;
      }
   }
   function getID()
   {
      return String(this.player_id);
   }
   function update(vo)
   {
      for(var _loc3_ in vo)
      {
         this[_loc3_] = vo[_loc3_];
      }
   }
   function toString()
   {
      return "PlayerVO{player_id:" + this.player_id + ", nickname:" + this.nickname + ", avatar_id:" + this.avatarVO.avatar_id + "}";
   }
   function toDetailedString()
   {
      var _loc2_ = "\n*** PlayerVO ***\n";
      for(var _loc3_ in this)
      {
         _loc2_ += _loc3_ + " : " + this[_loc3_] + " | ";
      }
      _loc2_ += "\n****************\n";
      return _loc2_;
   }
   function equals(vo)
   {
      if(this === vo)
      {
         return true;
      }
      return false;
   }
}
