class com.clubpenguin.world.rooms.common.RoomEnvironmentManager
{
   function RoomEnvironmentManager(stageReference, shellMC, engineMC)
   {
      this._stageReference = stageReference;
      this._SHELL = shellMC;
      this._ENGINE = engineMC;
      this._roomBehaviorFactory = com.clubpenguin.world.rooms.common.behaviors.RoomBehaviorFactory.getInstance();
      this._playerMoveDoneFunc = com.clubpenguin.util.Delegate.create(this,this.onPlayerMoveDone);
      this._SHELL.addListener(this._SHELL.PLAYER_MOVE_DONE,this._playerMoveDoneFunc);
   }
   function destroy()
   {
      this._SHELL.removeListener(this._SHELL.PLAYER_MOVE_DONE,this._playerMoveDoneFunc);
   }
   function setupEnvironmentTriggers()
   {
      this._environmentMovieClips = new Array();
      this.searchForEnvironmentMovieClips();
   }
   function searchForEnvironmentMovieClips()
   {
      for(var _loc2_ in this._stageReference)
      {
         if(this._stageReference[_loc2_].environmentType)
         {
            this._environmentMovieClips.push(this._stageReference[_loc2_]);
         }
      }
   }
   function checkTriggers(player_obj)
   {
      var _loc2_ = 0;
      while(_loc2_ < this._environmentMovieClips.length)
      {
         var _loc3_ = this._ENGINE.puffleAvatarController.getPuffleClip(player_obj.attachedPuffle.id);
         if(_loc3_ && this._environmentMovieClips[_loc2_].hitTest(_loc3_._x,_loc3_._y,true))
         {
            var _loc4_ = this._roomBehaviorFactory.getRoomBehavior(this._environmentMovieClips[_loc2_].environmentType);
            _loc4_.applyEffect(player_obj.player_id);
         }
         _loc2_ = _loc2_ + 1;
      }
   }
   function onPlayerMoveDone(player_obj)
   {
      if(player_obj.attachedPuffle)
      {
         this.checkTriggers(player_obj);
      }
   }
   function checkHitTestWithEnvironmentMC(targetMC)
   {
      var _loc2_ = 0;
      while(_loc2_ < this._environmentMovieClips.length)
      {
         if(this._environmentMovieClips[_loc2_].hitTest(targetMC._x,targetMC._y,true))
         {
            return true;
         }
         _loc2_ = _loc2_ + 1;
      }
      return false;
   }
}
