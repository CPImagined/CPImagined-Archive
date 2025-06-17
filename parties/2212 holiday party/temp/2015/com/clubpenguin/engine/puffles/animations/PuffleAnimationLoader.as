class com.clubpenguin.engine.puffles.animations.PuffleAnimationLoader extends mx.events.EventDispatcher
{
   static var PUFFLE_ANIMATION_EVENT = "puffleAnimation";
   static var PUFFLE_ANIMATION_LOADED_EVENT = "puffleAnimationLoaded";
   function PuffleAnimationLoader(playerID, puffleID, shell_mc, engine_mc, usesEvent)
   {
      super();
      this._SHELL = shell_mc;
      this._ENGINE = engine_mc;
      this._playerMC = this._ENGINE.getPlayerMovieClip(playerID);
      this._puffleMC = this._ENGINE.puffleManager.getPuffleByID(puffleID).clip;
      this._playerID = playerID;
      this._puffleID = puffleID;
      this._usesEvent = usesEvent;
   }
   function playPuffleAnimation(animationURL, overPuffle)
   {
      this._SHELL.addListener(this._SHELL.ROOM_DESTROYED,this.cleanup,this);
      var _loc3_ = this._ENGINE.puffleAvatarController.getPuffleClip(this._puffleID);
      this._puffleAnimationClip = this._ENGINE.getRoomMovieClip().createEmptyMovieClip("puffleAnimationClip" + this._puffleID,_loc3_.getDepth() + com.clubpenguin.puffleavatar.PuffleAvatarConstants.PUFFLE_CLIP_DEPTH_PADDING);
      this._puffleAnimationClip._x = this._playerMC._x;
      this._puffleAnimationClip._y = this._playerMC._y;
      this._puffleAnimationClip._xscale = this._playerMC._xscale;
      this._puffleAnimationClip._yscale = this._playerMC._yscale;
      this._puffleAnimationClip._visible = false;
      if(overPuffle && this._puffleMC)
      {
         this._puffleAnimationClip._x = this._puffleMC._x;
         this._puffleAnimationClip._y = this._puffleMC._y;
      }
      var _loc2_ = new com.clubpenguin.hybrid.HybridMovieClipLoader();
      _loc2_.addEventListener(com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_INIT,com.clubpenguin.util.Delegate.create(this,this.onAnimationLoaded));
      _loc2_.addEventListener(com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_ERROR,com.clubpenguin.util.Delegate.create(this,this.onAnimationLoadError));
      _loc2_.loadClip(animationURL,this._puffleAnimationClip,"PuffleAnimationLoader playPuffleAnimation()");
   }
   function onAnimationLoaded(event)
   {
      com.clubpenguin.util.Log.debug("PuffleAnimationLoader onAnimationLoaded()");
      this.dispatchEvent({target:this,type:com.clubpenguin.engine.puffles.animations.PuffleAnimationLoader.PUFFLE_ANIMATION_LOADED_EVENT,playerID:this._playerID,puffleID:this._puffleID});
      this._ENGINE.puffleAvatarController.hidePuffle(this._puffleID);
      this._puffleAnimationClip._visible = true;
      var scope = this;
      this._puffleAnimationClip.onEnterFrame = function()
      {
         if(scope._puffleAnimationClip.puffle._currentframe >= scope._puffleAnimationClip.puffle._totalframes)
         {
            scope.onAnimationFinished();
         }
      };
   }
   function onAnimationLoadError(event)
   {
      com.clubpenguin.util.Log.debug("PuffleAnimationLoader onAnimationLoadError()");
      this._puffleAnimationClip.removeMovieClip();
      this.cleanup();
   }
   function onAnimationFinished()
   {
      com.clubpenguin.util.Log.debug("PuffleAnimationLoader onAnimationFinished()");
      this._puffleAnimationClip.onEnterFrame = null;
      this._puffleAnimationClip.removeMovieClip();
      this.cleanup();
   }
   function cleanup()
   {
      com.clubpenguin.util.Log.debug("PuffleAnimationLoader cleanup()");
      if(this._usesEvent)
      {
         this.dispatchEvent({target:this,type:com.clubpenguin.engine.puffles.animations.PuffleAnimationLoader.PUFFLE_ANIMATION_EVENT,playerID:this._playerID,puffleID:this._puffleID});
      }
      this._ENGINE.puffleAvatarController.showPuffle(this._puffleID);
      this._SHELL.removeListener(this._SHELL.ROOM_DESTROYED,this.cleanup,this);
   }
   function cancelAndRemoveAnimation()
   {
      com.clubpenguin.util.Log.debug("PuffleAnimationLoader cancelAndRemoveAnimation()");
      this.onAnimationFinished();
   }
}
