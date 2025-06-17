class com.clubpenguin.world.rooms2015.automated.party.DecemberSnowballManager extends com.clubpenguin.engine.projectiles.SnowballManager
{
   var MALL_ROOM = 340;
   var PLAZA_ROOM = 300;
   function DecemberSnowballManager(shell, engine, _interface)
   {
      super(shell,engine,_interface);
      var _loc4_ = new com.clubpenguin.world.rooms2013.superhero.SnowballHitCheck();
      this._currentParty = _global.getCurrentParty().BaseParty.CURRENT_PARTY;
   }
   function throwBall(playerId, target_x, target_y, snowballVO)
   {
      com.clubpenguin.util.Log.debug("DecemberSnowballManager throwBall");
      var _loc7_ = this._INTERFACE.getIgnoreList();
      var _loc4_ = 0;
      while(_loc4_ < _loc7_.length)
      {
         if(playerId == _loc7_[_loc4_].player_id)
         {
            return undefined;
         }
         _loc4_ = _loc4_ + 1;
      }
      var _loc2_ = {};
      var _loc3_ = this._ENGINE.getPlayerMovieClip(playerId);
      var _loc12_ = this._SHELL.getPlayerObjectById(playerId);
      var _loc11_ = this._ENGINE.getRoomMovieClip();
      var _loc15_ = _loc11_.customPenguinSize;
      var _loc22_ = this._SHELL.getRoomObject().room_id;
      var _loc5_ = undefined;
      var _loc10_ = undefined;
      if(snowballVO == undefined || snowballVO == null)
      {
         snowballVO = _loc12_.avatarVO.snowball;
         var _loc18_ = this._SHELL.getPlayerObjectById(playerId).avatarVO.avatar_id;
         if(_loc18_ == this._currentParty.getTransformationVOs()[this._currentParty.getLengthOfTransformationVOs() - 1].transformId)
         {
            snowballVO = new com.clubpenguin.engine.projectiles.vo.SnowballVO(com.clubpenguin.engine.projectiles.SnowballEnum.SNOW_BALL_NORMAL,-25,26);
            com.clubpenguin.world.rooms2015.automated.party.DecemberSounds.playFrostbiteSnowballThrow();
         }
      }
      if(_loc3_.is_reading)
      {
         this._ENGINE.removePlayerBook(playerId);
      }
      if(_loc3_.is_ready && !_loc3_.is_moving)
      {
         var _loc19_ = this._ENGINE.findAngle(_loc3_._x,_loc3_._y,target_x,target_y);
         var _loc16_ = this._ENGINE.findDirectionQuarters(_loc19_);
         var _loc17_ = Number(this._SHELL.DANCE_FRAME + _loc16_);
         this._ENGINE.updatePlayerFrame(playerId,_loc17_);
         var _loc9_ = undefined;
         if(_loc3_.art_mc.body.snowballOrigin == undefined || _loc3_.art_mc.body.snowballOrigin == undefined || _loc3_.art_mc.body.localToGlobal == undefined)
         {
            _loc9_ = {x:_loc3_._x,y:_loc3_._y};
         }
         else if(snowballVO.__get__type().__get__originAtHead())
         {
            _loc9_ = {x:_loc3_._x,y:Number(_loc3_._y - _loc3_.art_mc._height / 2)};
         }
         else if(snowballVO.__get__type().__get__originAtCenter())
         {
            _loc9_ = {x:_loc3_._x,y:Number(_loc3_._y - _loc3_.art_mc._height / 5)};
         }
         else
         {
            _loc9_ = {x:_loc3_.art_mc.body.snowballOrigin._x,y:_loc3_.art_mc.body.snowballOrigin._y};
            _loc3_.art_mc.body.localToGlobal(_loc9_);
         }
         if(this.throwItemCounter >= this.maxSnowballs)
         {
            this.throwItemCounter = 0;
         }
         _loc2_.playerId = playerId;
         _loc2_.id = this.throwItemCounter;
         _loc2_.snowballType = snowballVO.type;
         _loc2_.start_x = _loc9_.x;
         _loc2_.start_y = _loc9_.y;
         _loc2_.distance = this._ENGINE.findDistance(_loc2_.start_x,_loc2_.start_y,target_x,target_y);
         if(snowballVO.__get__duration() == -1)
         {
            _loc2_.duration = _loc2_.distance / 15;
         }
         else
         {
            _loc2_.duration = _loc2_.distance / 15 * snowballVO.__get__duration();
         }
         _loc2_.change_x = target_x - _loc2_.start_x;
         _loc2_.change_y = target_y - _loc2_.start_y;
         _loc2_.peak = _loc2_.duration / 2;
         _loc2_.start_height = _loc9_.y - _loc3_._y;
         _loc2_.max_height = _loc2_.start_height + snowballVO.__get__maxHeightOffset();
         _loc2_.change_height1 = _loc2_.max_height - _loc2_.start_height;
         _loc2_.change_height2 = - _loc2_.max_height;
         _loc2_.wait = snowballVO.wait;
         com.clubpenguin.util.Log.debug("snowballInfo.wait " + _loc2_.wait);
         _loc2_.w = 0;
         _loc2_.t = 0;
         _loc10_ = snowballVO.__get__type().__get__symbolName() + this.throwItemCounter;
         this.snowballData[_loc10_] = _loc2_;
         if(_loc11_[_loc10_] != undefined)
         {
            _loc11_[_loc10_].removeMovieClip();
         }
         _loc5_ = _loc11_.attachMovie(snowballVO.__get__type().__get__symbolName(),_loc10_,Number(1000200 + this.throwItemCounter),{_x:_loc2_.start_x,_y:_loc2_.start_y});
         if(_loc5_ == undefined)
         {
            _loc5_ = _loc11_.attachMovie("ball",_loc10_,Number(1000200 + this.throwItemCounter),{_x:_loc2_.start_x,_y:_loc2_.start_y});
         }
         _loc5_.art._y = _loc2_.start_height;
         _loc5_._visible = false;
         _loc5_._xscale = _loc5_._yscale = _loc15_;
         this._ENGINE.updateItemDepth(_loc5_,this.throwItemCounter);
         if(snowballVO.__get__type().__get__hasTail())
         {
            _loc5_.art._rotation = com.clubpenguin.math.MathHelper.getAngleBetweenCoordinates(_loc9_.x,_loc9_.y,target_x,target_y);
         }
         if(snowballVO.__get__type().__get__playAbovePlayer() && _loc5_.getDepth() < _loc3_.getDepth())
         {
            _loc5_.swapDepths(_loc3_.getDepth() + 1);
         }
         if(snowballVO.__get__type().__get__playUnderPlayer() && _loc5_.getDepth() > _loc3_.getDepth())
         {
            _loc5_.swapDepths(_loc3_.getDepth());
         }
         if(snowballVO.__get__type().__get__intelligentSort())
         {
            if(_loc2_.target_y > _loc2_.start_y && _loc5_.getDepth() < _loc3_.getDepth())
            {
               _loc5_.swapDepths(_loc3_.getDepth() + 1);
            }
            else if(_loc2_.target_y < _loc2_.start_y && _loc5_.getDepth() > _loc3_.getDepth())
            {
               _loc5_.swapDepths(_loc3_);
            }
         }
         if(snowballVO.__get__type().__get__delayAnimStart())
         {
            _loc5_.art.gotoAndStop(1);
         }
         if(snowballVO.__get__type().__get__playerInvisible())
         {
            _loc3_._visible = false;
            this._ENGINE.getNicknameMovieClip(playerId)._visible = false;
         }
         if(_loc2_.snowballType.hasTrail)
         {
            _loc5_.art.gotoAndStop(1);
            _loc5_.art._visible = false;
         }
         this.throwItemCounter++;
      }
   }
   function onBallLand(event)
   {
      var _loc2_ = this._ENGINE.avatarManager.model.getSnowballHitCheck(event.snowballType);
      this.snowballHitController.playerSnowballHitCheck(event,_loc2_);
      if(this._SHELL.getCurrentRoomId() != this.PLAZA_ROOM && this._SHELL.getCurrentRoomId() != this.MALL_ROOM)
      {
         com.clubpenguin.world.rooms2015.automated.party.DecemberSounds.playNormalSnowballImpact();
      }
   }
}
