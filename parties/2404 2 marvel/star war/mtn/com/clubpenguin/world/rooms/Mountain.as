//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms.Mountain extends com.clubpenguin.world.rooms.BaseRoom
    {
        var _stage, _SHELL, _destroyDelegate, _triggerWatcher, _triggerWatcherInterval, _liveEvent, _abductionDelegate, aliendAbduction, setupNavigationButtons, showContent, setupHint, wem, _ENGINE;
        function Mountain (stageReference) {
            super(stageReference);
            _stage.start_x = 370;
            _stage.start_y = 210;
            if (!_SHELL) {
                init();
            }
            _stage.waddle_list = [100, 101, 102, 103];
        }
        function init() {
            _destroyDelegate = com.clubpenguin.util.Delegate.create(this, destroy);
            _SHELL.addListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            _triggerWatcher = new com.clubpenguin.world.rooms.common.triggers.TriggerWatcher(_stage, _SHELL);
            configureNavigation();
            configureTriggers();
            configureRoomElements();
            configureWeatherEffects();
            clearInterval(_triggerWatcherInterval);
            _triggerWatcherInterval = setInterval(_triggerWatcher, "checkAllPlayers", 40);
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
        function configureTriggers() {
            _stage.triggers_mc.plaza_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "village", 223, 292);
            _stage.triggers_mc.village_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "village", 223, 292);
            _stage.triggers_mc.waddle100_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, joinSledGame, 100);
            _stage.triggers_mc.waddle101_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, joinSledGame, 101);
            _stage.triggers_mc.waddle102_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, joinSledGame, 102);
            _stage.triggers_mc.waddle103_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, joinSledGame, 103);
        }
        function configureNavigation() {
            setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.exit_btn, 630, 253), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.hut_btn, 522, 153), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.waddle100_mc.game_btn, 152, 270), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.waddle101_mc.game_btn, 322, 314), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.waddle102_mc.game_btn, 433, 314), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.waddle103_mc.game_btn, 538, 300)]);
        }
        function configureRoomElements() {
            _stage.background_mc.exit_btn.useHandCursor = false;
            _stage.background_mc.hut_btn.useHandCursor = false;
            _stage.waddle100_mc.seat0_mc._visible = false;
            _stage.waddle100_mc.seat1_mc._visible = false;
            _stage.waddle100_mc.seat2_mc._visible = false;
            _stage.waddle100_mc.seat3_mc._visible = false;
            _stage.waddle101_mc.seat0_mc._visible = false;
            _stage.waddle101_mc.seat1_mc._visible = false;
            _stage.waddle101_mc.seat2_mc._visible = false;
            _stage.waddle102_mc.seat0_mc._visible = false;
            _stage.waddle102_mc.seat1_mc._visible = false;
            _stage.waddle103_mc.seat0_mc._visible = false;
            _stage.waddle103_mc.seat1_mc._visible = false;
            _stage.waddle100_mc.seat_frames = [18, 18, 18, 18];
            _stage.waddle101_mc.seat_frames = [18, 18, 18];
            _stage.waddle102_mc.seat_frames = [17, 17];
            _stage.waddle103_mc.seat_frames = [24, 24];
            showContent([new com.clubpenguin.world.rooms.common.PopupContentVO(_stage.background_mc.catalogue_mc.catalogue_btn, true, "mtn_catalogue", ""), new com.clubpenguin.world.rooms.common.PopupContentVO(_stage.interface_mc.mtn_cat_btn, true, "mtn_catalogue", "")]);
            setupHint([new com.clubpenguin.world.rooms.common.HintVO(_stage.waddle100_mc.game_btn, _stage.waddle100_mc.game_btn, "sled_hint"), new com.clubpenguin.world.rooms.common.HintVO(_stage.waddle101_mc.game_btn, _stage.waddle101_mc.game_btn, "sled_hint"), new com.clubpenguin.world.rooms.common.HintVO(_stage.waddle102_mc.game_btn, _stage.waddle102_mc.game_btn, "sled_hint"), new com.clubpenguin.world.rooms.common.HintVO(_stage.waddle103_mc.game_btn, _stage.waddle103_mc.game_btn, "sled_hint")]);
        }
        function configureWeatherEffects() {
            wem = new com.clubpenguin.world.rooms.weathereffects.WeatherEffectsManager(_SHELL, _stage.background_mc);
            wem.setupFireAnimationHeight(60);
            wem.setupRainAnimationHeight(85);
            wem.setupSnowAnimationHeight(85);
            wem.setupRainAnimationSpeed(0.5);
            wem.setupSnowAnimationSpeed(1);
            wem.setupRainDelayTime(2);
            wem.setupSnowDelayTime(2);
            wem.startWeatherEffectCheck();
        }
        function joinSledGame(gameNumber) {
            _ENGINE.sendJoinWaddle("sled", gameNumber, true);
        }
		function playLiveEvent() {
     	   _stage.meteor_mc.event_mc.gotoAndPlay(2);
     	   _global.getCurrentAirtower().removeListener("liveevent", _liveEvent);
        }
        function exit(roomName, x, y) {
            _SHELL.sendJoinRoom(roomName, x, y);
        }
        function destroy() {
            clearInterval(_triggerWatcherInterval);
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            wem.destroy();
            _global.getCurrentAirtower().removeListener("beamup", _abductionDelegate);
			_global.getCurrentAirtower().removeListener("liveevent", _liveEvent);
            _abductionDelegate = null;
        }
        static var CLASS_NAME = "Mountain";
    }
