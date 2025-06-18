class com.clubpenguin.world.rooms.Beach extends com.clubpenguin.world.rooms.BaseRoom
{
   static var CLASS_NAME = "Beach";
   function Beach(stageReference)
   {
      super(stageReference);
      this._stage.start_x = 300;
      this._stage.start_y = 290;
      this.localize([this._stage.background_mc.ship_mc.migratortext_mc]);
      this.setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(this._stage.background_mc.light_btn,220,200)]);
      this._stage.bucket_mc.bucket_btn.onRollOver = com.clubpenguin.util.Delegate.create(this,this.bucketAnimate);
      this._stage.bucket_mc.bucket_btn.onRelease = com.clubpenguin.util.Delegate.create(this,this.moveToMouse);
      this._stage.bucket_mc.bucket_btn.useHandCursor = false;
      this._stage.triggers_mc.light_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this,this.exit,"light",300,275);
      this._stage.triggers_mc.village_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this,this.exit,"village",160,395);
      this._stage.triggers_mc.dock_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this,this.exit,"dock",230,180);
   }
   function bucketAnimate()
   {
      this._stage.bucket_mc.play();
   }
   function moveToMouse()
   {
      this._ENGINE.sendPlayerMove(_xmouse,_ymouse);
   }
   function exit(name, x, y)
   {
      this._SHELL.sendJoinRoom(name,x,y);
   }
   function init()
   {
      this._destroyDelegate = com.clubpenguin.util.Delegate.create(this,this.destroy);
      this._SHELL.addListener(this._SHELL.ROOM_DESTROYED,this._destroyDelegate);
      var _loc3_ = this._SHELL.getMascotOptions();
      trace("BEACH - mascotOptions.migrator_active : " + _loc3_.migrator_active);
      if(_loc3_.migrator_active)
      {
         this._stage.background_mc.ship_mc._visible = true;
         this._stage.triggers_mc.ship_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this,this.exit,"ship",440,300);
      }
      else
      {
         this._stage.background_mc.ship_mc._visible = false;
      }
      this.wem = new com.clubpenguin.world.rooms.weathereffects.WeatherEffectsManager(this._SHELL,this._stage.background_mc);
      this.wem.setupFireAnimationHeight(45);
      this.wem.setupRainAnimationHeight(70);
      this.wem.setupSnowAnimationHeight(70);
      this.wem.setupRainAnimationSpeed(0.4);
      this.wem.setupSnowAnimationSpeed(0.8);
      this.wem.setupRainDelayTime(2);
      this.wem.setupSnowDelayTime(2);
      this.wem.startWeatherEffectCheck();
      this._abductionDelegate = com.clubpenguin.util.Delegate.create(this,this.abductPenguin);
      _global.getCurrentAirtower().addListener("beamup",this._abductionDelegate);
   }
   function abductPenguin(data)
   {
      var _loc4_ = data[1];
      var _loc5_ = _global.getCurrentEngine().getPlayerMovieClip(_loc4_);
      this._stage.attachMovie("TractorBeam","tractorBeam_mc",this._stage.getNextHighestDepth());
      this._stage.tractorBeam_mc.swapDepths(_loc5_);
      this._stage.tractorBeam_mc._x = _loc5_._x;
      this._stage.tractorBeam_mc._y = _loc5_._y - 1;
      this.aliendAbduction = new com.clubpenguin.world.rooms.aliens.AlienAbduction();
      this.aliendAbduction.abductPlayer(_loc4_,this._stage,this);
   }
   function abductedPlayerGoToUFO(player_id)
   {
      this._stage.tractorBeam_mc.removeMovieClip();
      if(this._SHELL.isMyPlayer(player_id))
      {
         _global.getCurrentAirtower().removeListener("beamup",this._abductionDelegate);
         this._abductionDelegate = null;
         this._SHELL.sendJoinRoom("ufo",380,320);
      }
   }
   function destroy()
   {
      this._SHELL.removeListener(this._SHELL.ROOM_DESTROYED,this._destroyDelegate);
      this.wem.destroy();
      _global.getCurrentAirtower().removeListener("beamup",this._abductionDelegate);
      this._abductionDelegate = null;
   }
}
