    class com.clubpenguin.world.rooms.Shack extends com.clubpenguin.world.rooms.BaseRoom
    {
        var _stage, _SHELL, localize, _destroyDelegate, _triggerWatcher, wem, _triggerWatcherInterval, _abductionDelegate, aliendAbduction, setupNavigationButtons, _volleyballBTrigger, _volleyballATrigger, _roomUpdateInterval;
        function Shack (stageReference) {
            super(stageReference);
            _stage.start_x = 380;
            _stage.start_y = 350;
            if (!_SHELL) {
                init();
            }
            localize([_stage.mineSign_mc, _stage.cpuText_mc]);
        }
        function init() {
            _destroyDelegate = com.clubpenguin.util.Delegate.create(this, destroy);
            _SHELL.addListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            _triggerWatcher = new com.clubpenguin.world.rooms.common.triggers.TriggerWatcher(_stage, _SHELL);
            configureNavigation();
            configureTriggers();
            configureRoomElements();
            wem = new com.clubpenguin.world.rooms.weathereffects.WeatherEffectsManager(_SHELL, _stage.background_mc);
            wem.setupFireAnimationHeight(60);
            wem.setupRainAnimationHeight(85);
            wem.setupSnowAnimationHeight(85);
            wem.setupRainAnimationSpeed(0.5);
            wem.setupSnowAnimationSpeed(1);
            wem.setupRainDelayTime(2);
            wem.setupSnowDelayTime(2);
            wem.startWeatherEffectCheck();
            clearInterval(_triggerWatcherInterval);
            _triggerWatcherInterval = setInterval(_triggerWatcher, "checkAllPlayers", 40);
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
        function configureNavigation() {
            setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.mineExit_btn, 495, 210), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.forest_btn, 45, 410), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.dojoExit_btn, 370, 160), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.schoolExit_btn, 240, 200), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.skateparkExit_btn, 680, 240)]);
            _stage.skateparkExit_btn.useHandCursor = false;
            _stage.forest_btn.useHandCursor = false;
            _stage.dojoExit_btn.useHandCursor = false;
        }
        function configureTriggers() {
            _stage.triggers_mc.cpuTrigger_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "school", 645, 370);
            _stage.triggers_mc.dojoTrigger_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "dojoext", 390, 380);
            _stage.triggers_mc.mineTrigger_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "mine", 395, 175);
            _stage.triggers_mc.forestTrigger_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "forest", 630, 205);
            _stage.triggers_mc.skateParkTrigger_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "skatepark", 120, 160);
            _volleyballBTrigger = new com.clubpenguin.world.rooms.common.triggers.PlayerTrigger(_stage.triggers_mc.volleyballBTrigger_mc);
            _volleyballBTrigger.playersAdded.add(com.clubpenguin.util.Delegate.create(this, playVolleyball));
            _volleyballBTrigger.playersRemoved.add(com.clubpenguin.util.Delegate.create(this, stopVolleyball));
            _triggerWatcher.addTrigger(_volleyballBTrigger);
            _volleyballATrigger = new com.clubpenguin.world.rooms.common.triggers.PlayerTrigger(_stage.triggers_mc.volleyballATrigger_mc);
            _volleyballATrigger.playersAdded.add(com.clubpenguin.util.Delegate.create(this, playVolleyball));
            _volleyballATrigger.playersRemoved.add(com.clubpenguin.util.Delegate.create(this, stopVolleyball));
            _triggerWatcher.addTrigger(_volleyballATrigger);
        }
        function configureRoomElements() {
            _stage.block_mc._visible = false;
            _stage.triggers_mc._visible = false;
            _stage.schoolExit_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, schoolExitRollOver);
            _stage.schoolExit_btn.onRollOut = com.clubpenguin.util.Delegate.create(this, schoolExitRollOut);
            _stage.schoolExit_btn.onReleaseOutside = com.clubpenguin.util.Delegate.create(this, schoolExitRollOut);
            _stage.mineExit_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, mineExitRollOver);
            _stage.mineExit_btn.onRollOut = com.clubpenguin.util.Delegate.create(this, mineExitRollOut);
            _stage.mineExit_btn.onReleaseOutside = com.clubpenguin.util.Delegate.create(this, mineExitRollOut);
        }
        function playVolleyball() {
            if (((_stage.volleyball_mc._currentframe == 1) && ((_volleyballATrigger.getPlayersWhoAre(com.clubpenguin.world.rooms.common.triggers.PlayerTrigger.STOPPED).length + _volleyballATrigger.getPlayersWhoAre(com.clubpenguin.world.rooms.common.triggers.PlayerTrigger.STANDING).length) > 0)) && ((_volleyballBTrigger.getPlayersWhoAre(com.clubpenguin.world.rooms.common.triggers.PlayerTrigger.STOPPED).length + _volleyballBTrigger.getPlayersWhoAre(com.clubpenguin.world.rooms.common.triggers.PlayerTrigger.STANDING).length) > 0)) {
                _stage.volleyball_mc.gotoAndPlay(2);
            }
        }
        function stopVolleyball() {
            if ((_stage.volleyball_mc._currentframe > 1) && (((_volleyballATrigger.getPlayersWhoAre(com.clubpenguin.world.rooms.common.triggers.PlayerTrigger.STOPPED).length + _volleyballATrigger.getPlayersWhoAre(com.clubpenguin.world.rooms.common.triggers.PlayerTrigger.STANDING).length) == 0) || ((_volleyballBTrigger.getPlayersWhoAre(com.clubpenguin.world.rooms.common.triggers.PlayerTrigger.STOPPED).length + _volleyballBTrigger.getPlayersWhoAre(com.clubpenguin.world.rooms.common.triggers.PlayerTrigger.STANDING).length) == 0))) {
                _stage.volleyball_mc.gotoAndStop(1);
            }
        }
        function schoolExitRollOver() {
            _stage.schoolExit_mc.gotoAndStop(2);
        }
        function schoolExitRollOut() {
            _stage.schoolExit_mc.gotoAndStop(1);
        }
        function mineExitRollOver() {
            _stage.mineExit_mc.gotoAndStop(2);
        }
        function mineExitRollOut() {
            _stage.mineExit_mc.gotoAndStop(1);
        }
        function exit(roomName, x, y) {
            _SHELL.sendJoinRoom(roomName, x, y);
        }
        function destroy() {
            clearInterval(_roomUpdateInterval);
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            _global.getCurrentAirtower().removeListener("beamup", _abductionDelegate);
            _abductionDelegate = null;
        }
        static var CLASS_NAME = "Shack";
    }
