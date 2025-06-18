//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms.Village extends com.clubpenguin.world.rooms.BaseRoom
    {
        var _stage, localize, setupNavigationButtons, _ivalId, _INTERFACE, _SHELL, _destroyDelegate, wem, _abductionDelegate, aliendAbduction;
        function Village (stageReference) {
            super(stageReference);
            _stage.start_x = 380;
            _stage.start_y = 340;
            localize([_stage.tour_mc.langTour_mc, _stage.background_mc.epfsign_mc]);
            setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.lodge_btn, 504, 201), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.epf_btn, 660, 260)]);
            _stage.tour_mc.tour_btn.onRelease = com.clubpenguin.util.Delegate.create(this, onTourButtonClicked);
            _stage.triggers_mc.beach_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "beach", 445, 175);
            _stage.triggers_mc.mtn_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "mtn", 420, 160);
            _stage.triggers_mc.lodge_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "lodge", 160, 320);
            _stage.triggers_mc.epf_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "agentlobbymulti", 180, 265);
            _stage.triggers_mc.dock_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "dock", 340, 171);
            _stage.triggers_mc.wild_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "pufflewild", 360, 300);
            _stage.background_mc.lodge_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, lodgeRollOver);
            _stage.background_mc.lodge_btn.onRollOut = com.clubpenguin.util.Delegate.create(this, lodgeRollOut);
            _stage.background_mc.lodge_btn.onReleaseOutside = com.clubpenguin.util.Delegate.create(this, lodgeRollOut);
            _stage.background_mc.epf_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, epfRollOver);
            _stage.background_mc.epf_btn.onRollOut = com.clubpenguin.util.Delegate.create(this, epfRollOut);
            _stage.background_mc.epf_btn.onReleaseOutside = com.clubpenguin.util.Delegate.create(this, epfRollOut);
            _stage.tour_mc.tour_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, tourRollOver);
            _stage.tour_mc.tour_btn.onRollOut = com.clubpenguin.util.Delegate.create(this, tourRollOut);
            _stage.tour_mc.tour_btn.onReleaseOutside = com.clubpenguin.util.Delegate.create(this, tourRollOut);
			_ivalId = setInterval(com.clubpenguin.util.Delegate.create(this, doUpdate), 5000);
        }
		function doUpdate() {
			_stage.doUpdate();
		}
        function lodgeRollOver() {
            _stage.background_mc.lodgeDoor_mc.gotoAndStop(2);
        }
        function lodgeRollOut() {
            _stage.background_mc.lodgeDoor_mc.gotoAndStop(1);
        }
        function epfRollOver() {
            _stage.background_mc.epfDoor_mc.gotoAndStop(2);
        }
        function epfRollOut() {
            _stage.background_mc.epfDoor_mc.gotoAndStop(1);
        }
        function tourRollOver() {
            _stage.tour_mc.gotoAndStop(2);
        }
        function tourRollOut() {
            _stage.tour_mc.gotoAndStop(1);
        }
        function showContent(contentID) {
            _INTERFACE.showContent(contentID);
        }
        function onTourButtonClicked() {
            if (_INTERFACE.isTourGuide()) {
                _INTERFACE.showContent("give_tour");
            } else {
                _INTERFACE.showContent("take_tour");
            }
        }
        function exit(name, x, y) {
            _SHELL.sendJoinRoom(name, x, y);
        }
        function init() {
            _destroyDelegate = com.clubpenguin.util.Delegate.create(this, destroy);
            _SHELL.addListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            wem = new com.clubpenguin.world.rooms.weathereffects.WeatherEffectsManager(_SHELL, _stage.background_mc);
            wem.setupFireAnimationHeight(40);
            wem.setupRainAnimationHeight(65);
            wem.setupSnowAnimationHeight(65);
            wem.setupRainAnimationSpeed(0.4);
            wem.setupSnowAnimationSpeed(0.8);
            wem.setupRainDelayTime(2);
            wem.setupSnowDelayTime(2);
            wem.startWeatherEffectCheck();
            _abductionDelegate = com.clubpenguin.util.Delegate.create(this, abductPenguin);
            _global.getCurrentAirtower().addListener("beamup", _abductionDelegate);
        }
        function abductPenguin(data) {
            var _local_4 = data[1];
            var _local_3 = _global.getCurrentEngine().getPlayerMovieClip(_local_4);
            _stage.attachMovie("TractorBeam", "tractorBeam_mc", _stage.getNextHighestDepth());
            _stage.tractorBeam_mc.swapDepths(_local_3);
            _stage.tractorBeam_mc._x = _local_3._x;
            _stage.tractorBeam_mc._y = _local_3._y - 1;
            aliendAbduction = new com.clubpenguin.world.rooms.aliens.AlienAbduction();
            aliendAbduction.abductPlayer(_local_4, _stage, this);
        }
        function abductedPlayerGoToUFO(player_id) {
            _stage.tractorBeam_mc.removeMovieClip();
            if (_SHELL.isMyPlayer(player_id)) {
                _global.getCurrentAirtower().removeListener("beamup", _abductionDelegate);
                _abductionDelegate = null;
                _SHELL.sendJoinRoom("ufo", 380, 320);
            }
        }
        function destroy() {
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            wem.destroy();
            _global.getCurrentAirtower().removeListener("beamup", _abductionDelegate);
            _abductionDelegate = null;
			clearInterval(_ivalId);
        }
        static var CLASS_NAME = "Village";
    }
