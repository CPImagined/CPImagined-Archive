class com.clubpenguin.world.rooms.Beach extends com.clubpenguin.world.rooms.BaseRoom
{
   var _stage, localize, setupNavigationButtons, _SHELL, _INTERFACE, _destroyDelegate, wem, _abductionDelegate, aliendAbduction;
   function Beach(stageReference)
   {
      super(stageReference);
      _stage.start_x = 300;
      _stage.start_y = 290;
      localize([_stage.background_mc.ship_mc.migratortext_mc]);
      setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.light_btn,220,200), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.freeItem_btn,420,410)]);
      _stage.bucket_mc.bucket_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, bucketAnimate);
      _stage.bucket_mc.bucket_btn.onRelease = com.clubpenguin.util.Delegate.create(this, moveToMouse);
      _stage.bucket_mc.bucket_btn.useHandCursor = false;
	  _stage.freeItem_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, freeItemRollOver);
      _stage.freeItem_btn.onRollOut = com.clubpenguin.util.Delegate.create(this, freeItemRollOut);
      _stage.freeItem_btn.onReleaseOutside = com.clubpenguin.util.Delegate.create(this, freeItemRollOut);
      _stage.triggers_mc.light_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "light", 300, 275);
      _stage.triggers_mc.village_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "village", 160, 395);
      _stage.triggers_mc.dock_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "dock", 230, 180);
	  _stage.triggers_mc.freeItem_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, pickUpFreeItem);
	  _stage.triggers_mc.centre_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "party1", 120, 280);
   }
   function freeItemRollOver() {
       _stage.freeItem_mc.gotoAndStop(2);
   }
   function freeItemRollOut() {
       _stage.freeItem_mc.gotoAndStop(1);
   }
   function pickUpFreeItem() {
       _INTERFACE.buyInventory(490);
   }
   function bucketAnimate()
   {
      _stage.bucket_mc.play();
   }
   function moveToMouse()
   {
      _ENGINE.sendPlayerMove(_xmouse,_ymouse);
   }
   function exit(name, x, y)
   {
      _SHELL.sendJoinRoom(name,x,y);
   }
   function init()
   {
      _destroyDelegate = com.clubpenguin.util.Delegate.create(this, destroy);
      _SHELL.addListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
      var _loc3_ = _SHELL.getMascotOptions();
      trace("BEACH - mascotOptions.migrator_active : " + _loc3_.migrator_active);
      if(_loc3_.migrator_active)
      {
         _stage.background_mc.ship_mc._visible = true;
         _stage.triggers_mc.ship_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "ship", 440, 300);
      }
      else
      {
         _stage.background_mc.ship_mc._visible = false;
      }
      wem = new com.clubpenguin.world.rooms.weathereffects.WeatherEffectsManager(_SHELL, _stage.background_mc);
      wem.setupFireAnimationHeight(45);
      wem.setupRainAnimationHeight(70);
      wem.setupSnowAnimationHeight(70);
      wem.setupRainAnimationSpeed(0.4);
      wem.setupSnowAnimationSpeed(0.8);
      wem.setupRainDelayTime(2);
      wem.setupSnowDelayTime(2);
      wem.startWeatherEffectCheck();
      _abductionDelegate = com.clubpenguin.util.Delegate.create(this, abductPenguin);
      _global.getCurrentAirtower().addListener("beamup", _abductionDelegate);
   }
   function abductPenguin(data)
   {
      var _loc4_ = data[1];
      var _loc5_ = _global.getCurrentEngine().getPlayerMovieClip(_loc4_);
      _stage.attachMovie("TractorBeam", "tractorBeam_mc", _stage.getNextHighestDepth());
      _stage.tractorBeam_mc.swapDepths(_loc5_);
      _stage.tractorBeam_mc._x = _loc5_._x;
      _stage.tractorBeam_mc._y = _loc5_._y - 1;
      aliendAbduction = new com.clubpenguin.world.rooms.aliens.AlienAbduction();
      aliendAbduction.abductPlayer(_loc4_, _stage, this);
   }
   function abductedPlayerGoToUFO(player_id)
   {
      _stage.tractorBeam_mc.removeMovieClip();
      if(_SHELL.isMyPlayer(player_id))
      {
         _global.getCurrentAirtower().removeListener("beamup", _abductionDelegate);
         _abductionDelegate = null;
         _SHELL.sendJoinRoom("ufo",380,320);
      }
   }
   function destroy()
   {
      _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
      wem.destroy();
      _global.getCurrentAirtower().removeListener("beamup", _abductionDelegate);
      _abductionDelegate = null;
   }
   static var CLASS_NAME = "Beach";
}
