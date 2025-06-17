class com.clubpenguin.world.rooms.common.behaviors.WaterRoomBehavior extends com.clubpenguin.world.rooms.common.behaviors.RoomBehavior implements com.clubpenguin.world.rooms.common.behaviors.IRoomBehavior
{
   static var WATER_ANIMATION_PATH = "w.puffle.sprite.splash";
   static var WATER_SPLASH_EFFECT = "waterSplashEffect";
   function WaterRoomBehavior()
   {
      super();
      this._ENGINE = _global.getCurrentEngine();
   }
   function destroy()
   {
      super.destroy();
      this._loader.removeEventListener(com.clubpenguin.engine.puffles.animations.PuffleAnimationLoader.PUFFLE_ANIMATION_EVENT,this._onAnimationCompleteDelegate);
   }
   function applyEffect(playerID)
   {
      this._playerId = playerID;
      this._puffleModel = this._SHELL.getPlayerObjectById(playerID).attachedPuffle;
      if(this._puffleModel)
      {
         var _loc3_ = this._ENGINE.puffleAvatarController.getPuffleAvatar(this._puffleModel.id).splashCount;
         if(_loc3_ < 1)
         {
            this._ENGINE.puffleAvatarController.getPuffleAvatar(this._puffleModel.id).splashCount = _loc3_ + 1;
            this._loader = new com.clubpenguin.engine.puffles.animations.PuffleAnimationLoader(playerID,this._puffleModel.id,this._SHELL,this._ENGINE,true);
            this._onAnimationCompleteDelegate = com.clubpenguin.util.Delegate.create(this,this.onAnimationCompleted);
            this._loader.addEventListener(com.clubpenguin.engine.puffles.animations.PuffleAnimationLoader.PUFFLE_ANIMATION_EVENT,this._onAnimationCompleteDelegate);
            var _loc5_ = this._puffleModel.color;
            var _loc2_ = this._SHELL.getPath(com.clubpenguin.world.rooms.common.behaviors.WaterRoomBehavior.WATER_ANIMATION_PATH);
            _loc2_ = this._puffleModel.getFormattedAssetURL(_loc2_);
            this._loader.playPuffleAnimation(_loc2_);
            if(this._SHELL.isMyPlayer(this._playerId))
            {
               com.clubpenguin.engine.puffles.pufflecarestations.PuffleCareStationLogging.sendPuffleCareStationBI(com.clubpenguin.engine.puffles.pufflecarestations.PuffleCareStationsConstants.SPLASH_CARESTATION,com.clubpenguin.engine.puffles.pufflecarestations.PuffleCareStationsConstants.PUFFLE_CLEAN_STATION);
            }
         }
      }
   }
   function onAnimationCompleted(event)
   {
      if(this._isShowStatsBarWidget && this._SHELL.isMyPlayer(event.playerID))
      {
         var _loc3_ = this._SHELL.getMyPlayerObject().attachedPuffle.id;
         _global.getCurrentEngine().puffleAvatarController.displayPuffleWidget(_loc3_,"statsBarWidget",com.clubpenguin.engine.puffles.pufflecarestations.PuffleCareStationsConstants.PUFFLE_CLEAN_ITEM_ID);
      }
      this._SHELL.updateListeners(this._SHELL.ROOM_EFFECT_COMPLETE,{playerId:event.playerID,effectType:com.clubpenguin.world.rooms.common.behaviors.WaterRoomBehavior.WATER_SPLASH_EFFECT});
      this.destroy();
   }
}
