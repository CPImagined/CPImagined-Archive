class com.clubpenguin.world.rooms.Beach extends com.clubpenguin.world.rooms.BaseRoom
{
   var _stage, setupNavigationButtons, _SHELL, _INTERFACE, _destroyDelegate, _abductionDelegate, aliendAbduction;
   function Beach(stageReference)
   {
      super(stageReference);
      _stage.start_x = 300;
      _stage.start_y = 290;
      setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.tent_mc.door_mc.door_btn,175,230), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.epf_mc.door_btn, 553, 375)]);
	  _stage.epf_mc.epf_btn.onRelease = com.clubpenguin.util.Delegate.create(this, epfTube);
	  _stage.epf_mc.door_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, epfRollOver);
      _stage.epf_mc.door_btn.onRollOut = com.clubpenguin.util.Delegate.create(this, epfRollOut);
      _stage.triggers_mc.light_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "light", 300, 275);
      _stage.triggers_mc.village_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "village", 160, 395);
      _stage.triggers_mc.dock_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "dock", 230, 180);
	  _stage.triggers_mc.epf_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "party7", 185, 110);
   }
   		function epfTube() {
			if (_stage.epf_mc._currentframe == 1) {
				_stage.epf_mc.gotoAndPlay(2);
			} else if (_stage.epf_mc._currentframe == 14) {
				_stage.epf_mc.gotoAndPlay(15);
			};
		}
		function epfRollOver() {
			_stage.epf_mc.door1_mc.gotoAndPlay(2);
			_stage.epf_mc.platform1_mc.gotoAndPlay(2);
		}
		function epfRollOut() {
			_stage.epf_mc.door1_mc.gotoAndPlay(9);
			_stage.epf_mc.platform1_mc.gotoAndPlay(13);
		}
   function exit(name, x, y)
   {
      _SHELL.sendJoinRoom(name,x,y);
   }
   function init()
   {
      _destroyDelegate = com.clubpenguin.util.Delegate.create(this, destroy);
      _SHELL.addListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
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
      _global.getCurrentAirtower().removeListener("beamup", _abductionDelegate);
      _abductionDelegate = null;
   }
   static var CLASS_NAME = "Beach";
}
