class com.clubpenguin.engine.projectiles.SnowballHitController
{
   function SnowballHitController(shell, _interface)
   {
      this._SHELL = shell;
      this._INTERFACE = _interface;
      this._hitSnowballs = {};
      this._activeRoomId = -1;
      this._joinRoomDelegate = com.clubpenguin.util.Delegate.create(this,this.handleJoinRoom);
      this._playerMoveDelegate = com.clubpenguin.util.Delegate.create(this,this.handlePlayerMove);
      this._playerTransformDelegate = com.clubpenguin.util.Delegate.create(this,this.handlePlayerTransform);
      this._playerRemovedDelegate = com.clubpenguin.util.Delegate.create(this,this.handlePlayerRemoved);
      this._SHELL.addListener(this._SHELL.JOIN_ROOM,this._joinRoomDelegate);
      this._SHELL.addListener(this._SHELL.PLAYER_MOVE,this._playerMoveDelegate);
      this._SHELL.addListener(this._SHELL.PLAYER_AVATAR_TRANSFORMED,this._playerTransformDelegate);
      this._SHELL.addListener(this._SHELL.REMOVE_PLAYER,this._playerRemovedDelegate);
   }
   function playerSnowballHitCheck(snowballEvent, snowballHitCheck)
   {
      var _loc3_ = snowballHitCheck.hitCheck(snowballEvent);
      if(_loc3_ > 0)
      {
         snowballEvent.hit_player_id = _loc3_;
         this._hitSnowballs[snowballEvent.id] = snowballEvent;
         if(this._SHELL.isMyPlayer(snowballEvent.hit_player_id))
         {
            this._INTERFACE.stopQuickKeys();
         }
         this._SHELL.updateListeners(com.clubpenguin.engine.projectiles.events.SnowballEvent.SNOWBALL_HIT,snowballEvent);
      }
   }
   function handleJoinRoom()
   {
      if(this._activeRoomId != this._SHELL.getCurrentRoomId())
      {
         this._activeRoomId = this._SHELL.getCurrentRoomId();
         this._hitSnowballs = {};
      }
   }
   function handlePlayerRemoved(player_id)
   {
      this.handlePlayerMove(this._SHELL.getPlayerObjectById(player_id));
   }
   function handlePlayerTransform(eventData)
   {
      if(eventData.avatarId != 0)
      {
         this.handlePlayerMove(eventData.player);
      }
   }
   function handlePlayerMove(playerObj)
   {
      if(this._SHELL.isMyPlayer(playerObj.player_id))
      {
         this._INTERFACE.startQuickKeys();
      }
      var _loc3_ = [];
      for(var _loc5_ in this._hitSnowballs)
      {
         if(playerObj.player_id == this._hitSnowballs[_loc5_].hit_player_id)
         {
            _loc3_.push(_loc5_);
         }
      }
      var _loc2_ = _loc3_.length - 1;
      while(_loc2_ > -1)
      {
         this._hitSnowballs[_loc3_[_loc2_]].snowballMC._visible = false;
         delete this._hitSnowballs[_loc3_[_loc2_]];
         _loc2_ = _loc2_ - 1;
      }
      _loc3_ = null;
   }
   function removeSnowball(snowballMC)
   {
      for(var _loc3_ in this._hitSnowballs)
      {
         var _loc2_ = this._hitSnowballs[_loc3_];
         if(_loc2_.snowballMC == snowballMC && _loc2_.hit_player_id != undefined)
         {
            if(this._SHELL.isMyPlayer(_loc2_.hit_player_id))
            {
               this._INTERFACE.startQuickKeys();
            }
            delete this._hitSnowballs[_loc3_];
            break;
         }
      }
   }
   function get hitSnowballCount()
   {
      return this._hitSnowballs.length;
   }
}
