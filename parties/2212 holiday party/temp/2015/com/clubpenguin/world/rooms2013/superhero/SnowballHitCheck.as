class com.clubpenguin.world.rooms2013.superhero.SnowballHitCheck implements com.clubpenguin.engine.projectiles.ISnowballHitCheck
{
   function SnowballHitCheck()
   {
   }
   function hitCheck(snowballInfo)
   {
      var _loc12_ = _global.getCurrentShell();
      var _loc7_ = _global.getCurrentEngine();
      var _loc8_ = _loc12_.getPlayerList();
      var _loc6_ = snowballInfo.snowballMC;
      var _loc10_ = new Array();
      var _loc11_ = new Array();
      var _loc13_ = undefined;
      var _loc16_ = -1;
      if(_loc12_.isMyPlayer(snowballInfo.player_id))
      {
         _loc7_.setPlayerAction("wait");
      }
      if(!_loc6_._visible)
      {
         return undefined;
      }
      for(var _loc14_ in _loc8_)
      {
         var _loc3_ = _loc8_[_loc14_];
         var _loc18_ = _loc7_.getPlayerMovieClip(_loc3_.player_id);
         var _loc5_ = _loc18_.hitTest(snowballInfo.__get__x(),snowballInfo.__get__y(),true);
         if(com.clubpenguin.world.rooms2013.superhero.SuperHeroParty.__get__instance().isRobotEquipped(_loc3_.player_id))
         {
            if(_loc18_.hand_mc.hitTest(snowballInfo.__get__x(),snowballInfo.__get__y(),true))
            {
               _loc11_.push(_loc3_);
            }
         }
         if(_loc5_)
         {
            _loc10_.push(_loc3_);
         }
      }
      if(_loc10_.length > 0)
      {
         _loc10_.sortOn("y",[Array.NUMERIC | Array.DESCENDING]);
         var _loc9_ = _loc10_[0];
         var _loc19_ = _loc7_.getPlayerMovieClip(_loc9_.player_id);
         if(com.clubpenguin.world.rooms.common.triggers.PlayerAction.isMoving(_loc9_.player_id))
         {
            _loc13_ = com.clubpenguin.engine.projectiles.SnowballHitStateConstant.BOUNCE;
         }
         else
         {
            _loc16_ = _loc9_.player_id;
            _loc13_ = com.clubpenguin.engine.projectiles.SnowballHitStateConstant.HIT;
            var _loc15_ = _loc7_.getPlayerMovieClip(_loc16_);
            if(Math.abs(_loc9_.x - _loc6_._x) <= _loc15_.art_mc._width && Math.abs(_loc9_.y - _loc6_._y) <= _loc15_.art_mc._height)
            {
               _loc6_._x = _loc9_.x;
               _loc6_._y = _loc9_.y;
            }
            if(_loc6_.getDepth() < _loc19_.getDepth())
            {
               _loc6_.swapDepths(_loc19_);
            }
            if(snowballInfo.snowballType != com.clubpenguin.engine.projectiles.SnowballEnum.SNOW_BALL_NORMAL && _loc11_.length > 0)
            {
               _loc10_.sortOn("y",[Array.NUMERIC | Array.DESCENDING]);
               var _loc21_ = _loc11_[0];
               var _loc17_ = _loc21_.player_id;
               com.clubpenguin.world.rooms2013.superhero.SuperHeroParty.__get__instance().handleRobotSnowballHit(snowballInfo.player_id,_loc17_,com.clubpenguin.world.rooms2013.superhero.SuperHeroParty.ROBOT_HIT_FRAME);
            }
         }
      }
      else
      {
         _loc13_ = com.clubpenguin.engine.projectiles.SnowballHitStateConstant.MISS;
      }
      if(_loc6_._totalFrames == 4)
      {
         _loc6_.gotoAndStop(_loc13_);
      }
      else
      {
         _loc6_.gotoAndStop(2);
      }
      var _loc23_ = _loc6_._x - _loc7_.getPlayerMovieClip(snowballInfo.player_id)._x;
      var _loc22_ = _loc7_.getPlayerMovieClip(snowballInfo.player_id)._y - _loc6_._y;
      if(snowballInfo.snowballType.returnsToPlayer)
      {
         _loc18_ = _loc7_.getPlayerMovieClip(snowballInfo.player_id);
         var _loc20_ = _loc7_.getNicknameMovieClip(snowballInfo.player_id);
         if(snowballInfo.snowballType.playerInvisible)
         {
            if(this.isTeleportationPowerGlove(snowballInfo.player_id))
            {
               _loc6_.onEnterFrame = com.clubpenguin.util.Delegate.create(this,this.trackAnimation,_loc6_,_loc18_,_loc20_);
            }
            else
            {
               _loc18_._visible = true;
            }
         }
      }
      return _loc16_;
   }
   function isTeleportationPowerGlove(player_id)
   {
      var _loc3_ = _global.getCurrentShell().getPlayerObjectById(player_id);
      var _loc2_ = _loc3_.hand;
      return _loc2_ != com.clubpenguin.world.rooms2013.superhero.SuperHeroParty.TELEPORT_POWERGLOVE_ID ? false : true;
   }
   function trackAnimation(snowballMC, playerMC, playerNicknameMC)
   {
      if(snowballMC.art._currentframe == 40)
      {
         snowballMC.art._x = playerMC._x - snowballMC._x;
         snowballMC.art._y = playerMC._y - snowballMC._y - playerMC._height / 2;
         playerMC._visible = true;
         playerNicknameMC._visible = true;
         delete snowballMC.onEnterFrame;
      }
   }
}
