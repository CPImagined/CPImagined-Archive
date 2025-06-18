//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms.Forest extends com.clubpenguin.world.rooms.BaseRoom
    {
        var _stage, _SHELL, _destroyDelegate, wem, _abductionDelegate, aliendAbduction, _liveEvent;
        function Forest (stageReference) {
            super(stageReference);
            _stage.start_x = 175;
            _stage.start_y = 245;
            _stage.triggers_mc.plaza_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exitPlaza);
            _stage.triggers_mc.cove_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exitCove);
            _stage.triggers_mc.shack_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exitShack);
            _stage.triggers_mc.what_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exitLake);
        }
        function exitPlaza() {
            _SHELL.sendJoinRoom("plaza", 620, 330);
        }
        function exitCove() {
            _SHELL.sendJoinRoom("cove", 260, 208);
        }
        function exitShack() {
            _SHELL.sendJoinRoom("shack", 200, 330);
        }
        function exitLake() {
            _SHELL.sendJoinRoom("lake", 220, 160);
        }
        function init() {
            _destroyDelegate = com.clubpenguin.util.Delegate.create(this, destroy);
            _SHELL.addListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            wem = new com.clubpenguin.world.rooms.weathereffects.WeatherEffectsManager(_SHELL, _stage.background_mc);
            wem.setupFireAnimationHeight(50);
            wem.setupRainAnimationHeight(75);
            wem.setupSnowAnimationHeight(75);
            wem.setupRainAnimationSpeed(0.4);
            wem.setupSnowAnimationSpeed(0.8);
            wem.setupRainDelayTime(2);
            wem.setupSnowDelayTime(2);
            wem.startWeatherEffectCheck();
            _abductionDelegate = com.clubpenguin.util.Delegate.create(this, abductPenguin);
			_liveEvent = com.clubpenguin.util.Delegate.create(this, playLiveEvent);
            _global.getCurrentAirtower().addListener("beamup", _abductionDelegate);
			_global.getCurrentAirtower().addListener("liveevent", _liveEvent);
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
		function playLiveEvent() {
			   _stage.background_mc.skip_mc.gotoAndPlay(2);
		}
        function destroy() {
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            wem.destroy();
            _global.getCurrentAirtower().removeListener("beamup", _abductionDelegate);
			_global.getCurrentAirtower().removeListener("liveevent", _liveEvent);
            _abductionDelegate = null;
        }
        static var CLASS_NAME = "Forest";
    }
