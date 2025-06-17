class com.clubpenguin.engine.projectiles.SnowballManager
{
   function SnowballManager(shell, engine, _interface)
   {
      this._SHELL = shell;
      this._ENGINE = engine;
      this._INTERFACE = _interface;
      this.snowballHitController = new com.clubpenguin.engine.projectiles.SnowballHitController(this._SHELL,this._INTERFACE);
      this.maxSnowballs = 10;
      this.resetData();
      this._SHELL.addListener(this._SHELL.BALL_LAND,com.clubpenguin.util.Delegate.create(this,this.onBallLand));
      this._SHELL.addListener(this._SHELL.JOIN_ROOM,com.clubpenguin.util.Delegate.create(this,this.resetData));
   }
   function setMaxSnowballs(value)
   {
      this.maxSnowballs = value;
   }
   function throwBall(playerId, target_x, target_y, snowballVO)
   {
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
      var _loc10_ = this._ENGINE.getRoomMovieClip();
      var _loc15_ = _loc10_.customPenguinSize;
      var _loc22_ = this._SHELL.getRoomObject().room_id;
      var _loc5_ = undefined;
      var _loc11_ = undefined;
      var _loc18_ = this._SHELL.getPlayerObjectById(playerId);
      if(snowballVO == undefined || snowballVO == null)
      {
         var _loc19_ = this._SHELL.getPlayerObjectById(playerId).avatarVO.avatar_id;
         snowballVO = _loc18_.avatarVO.snowball;
      }
      if(this._SHELL.getIsRoomIgloo() || this._ENGINE.playerHostedRoomType == com.clubpenguin.world.rooms.common.RoomConstants.PLAYER_HOSTED_ROOM_BACKYARD)
      {
         snowballVO = new com.clubpenguin.engine.projectiles.vo.SnowballVO(com.clubpenguin.engine.projectiles.SnowballEnum.SNOW_BALL_NORMAL,-100,20);
      }
      else
      {
         var _loc14_ = _loc10_.attachMovie(snowballVO.__get__type().__get__symbolName(),"testSnowball",1);
         if(_loc14_ == undefined)
         {
            snowballVO = new com.clubpenguin.engine.projectiles.vo.SnowballVO(com.clubpenguin.engine.projectiles.SnowballEnum.SNOW_BALL_NORMAL,-100,20);
         }
         else
         {
            _loc14_.removeMovieClip();
         }
      }
      if(_loc3_.is_reading)
      {
         this._ENGINE.removePlayerBook(playerId);
      }
      if(_loc3_.is_ready && !_loc3_.is_moving)
      {
         var _loc17_ = this._ENGINE.findAngle(_loc3_._x,_loc3_._y,target_x,target_y);
         var _loc16_ = this._ENGINE.findDirectionQuarters(_loc17_);
         this._ENGINE.updatePlayerFrame(playerId,this._SHELL.DANCE_FRAME + _loc16_);
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
         _loc2_.start_y = _loc3_._y;
         _loc2_.distance = this._ENGINE.findDistance(_loc2_.start_x,_loc2_.start_y,target_x,target_y);
         _loc2_.duration = _loc2_.distance / 15;
         _loc2_.change_x = target_x - _loc2_.start_x;
         _loc2_.change_y = target_y - _loc2_.start_y;
         _loc2_.peak = _loc2_.duration / 2;
         _loc2_.start_height = _loc9_.y - _loc3_._y;
         _loc2_.max_height = _loc2_.start_height + snowballVO.__get__maxHeightOffset();
         _loc2_.change_height1 = _loc2_.max_height - _loc2_.start_height;
         _loc2_.change_height2 = - _loc2_.max_height;
         _loc2_.wait = snowballVO.wait;
         _loc2_.w = 0;
         _loc2_.t = 0;
         _loc11_ = snowballVO.__get__type().__get__symbolName() + this.throwItemCounter;
         this.snowballData[_loc11_] = _loc2_;
         if(_loc10_[_loc11_] != undefined)
         {
            _loc10_[_loc11_].removeMovieClip();
         }
         _loc5_ = _loc10_.attachMovie(snowballVO.__get__type().__get__symbolName(),_loc11_,Number(1000200 + this.throwItemCounter),{_x:_loc2_.start_x,_y:_loc2_.start_y});
         if(_loc5_ == undefined)
         {
            _loc5_ = _loc10_.attachMovie("ball",_loc11_,Number(1000200 + this.throwItemCounter),{_x:_loc2_.start_x,_y:_loc2_.start_y});
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
   }
   function update()
   {
      var _loc4_ = this._ENGINE.getRoomMovieClip();
      var _loc6_ = [];
      var _loc10_ = getTimer();
      for(var _loc9_ in this.snowballData)
      {
         var _loc3_ = _loc4_[_loc9_];
         var _loc2_ = this.snowballData[_loc9_];
         if(_loc2_.w > _loc2_.wait)
         {
            _loc3_._visible = true;
            if(_loc2_.snowballType.delayAnimStart && _loc3_.art._currentframe == 1)
            {
               _loc3_.art.gotoAndPlay(2);
            }
            _loc2_.t++;
            if(_loc2_.t < _loc2_.duration)
            {
               if(_loc2_.snowballType.isFixed)
               {
                  _loc3_._visible = false;
                  if(_loc2_.t == 1)
                  {
                     var _loc7_ = _loc3_.duplicateMovieClip("snowballTrail" + _loc2_.t,_loc3_.getDepth() + _loc2_.t);
                     _loc7_._rotation = _loc3_.art._rotation;
                  }
               }
               else
               {
                  _loc3_._x = this._ENGINE.mathLinearTween(_loc2_.t,_loc2_.start_x,_loc2_.change_x,_loc2_.duration);
                  _loc3_._y = this._ENGINE.mathLinearTween(_loc2_.t,_loc2_.start_y,_loc2_.change_y,_loc2_.duration);
                  this._ENGINE.updateItemDepth(_loc3_,_loc2_.id);
                  if(_loc2_.t < _loc2_.peak)
                  {
                     _loc3_.art._y = this._ENGINE.mathEaseOutQuad(_loc2_.t,_loc2_.start_height,_loc2_.change_height1,_loc2_.peak);
                  }
                  else
                  {
                     _loc3_.art._y = this._ENGINE.mathEaseInQuad(_loc2_.t - _loc2_.peak,_loc2_.max_height,_loc2_.change_height2,_loc2_.peak);
                  }
               }
            }
            else
            {
               _loc3_._x = _loc2_.target_x;
               _loc3_._y = _loc2_.target_y;
               _loc3_.art._y = 0;
               _loc3_.player_id = _loc2_.playerId;
               if(_loc4_.roomFunctionality.handleThrow != undefined)
               {
                  _loc4_.roomFunctionality.handleThrow(_loc3_);
               }
               else if(_loc4_.room.handleThrow != undefined)
               {
                  _loc4_.room.handleThrow(_loc3_);
               }
               else
               {
                  _loc4_.handleThrow(_loc3_);
               }
               if(_loc4_.snowballBlock != undefined)
               {
                  if(_loc4_.snowballBlock.hitTest(_loc3_._x,_loc3_._y,true))
                  {
                     _loc3_._visible = false;
                  }
               }
               var _loc8_ = new com.clubpenguin.engine.projectiles.events.SnowballEvent(com.clubpenguin.engine.projectiles.events.SnowballEvent.SNOWBALL_HIT,_loc2_.id,_loc3_,_loc2_.playerId,_loc2_.snowballType);
               this._SHELL.updateListeners(this._SHELL.BALL_LAND,_loc8_);
               _loc6_.push(_loc9_);
            }
         }
         else
         {
            _loc2_.w++;
         }
      }
      var _loc5_ = 0;
      while(_loc5_ < _loc6_.length)
      {
         delete this.snowballData[_loc6_[_loc5_]];
         _loc5_ = _loc5_ + 1;
      }
   }
   function resetData()
   {
      this.throwItemCounter = 0;
      this.lastUpdate = getTimer();
      this.snowballData = {};
   }
}
