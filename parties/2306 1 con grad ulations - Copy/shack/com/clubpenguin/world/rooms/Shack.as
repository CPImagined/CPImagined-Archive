//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms.Shack extends com.clubpenguin.world.rooms.BaseRoom
    {
        var _stage, _SHELL, localize, _liveEvent, _destroyDelegate, _triggerWatcher, wem, _triggerWatcherInterval, _volleyballBTrigger, _volleyballATrigger, setupNavigationButtons, _roomUpdateInterval;
        function Shack (stageReference) {
            super(stageReference);
            _stage.start_x = 380;
            _stage.start_y = 350;
            if (!_SHELL) {
                init();
            }
            localize([_stage.background_mc.mineSign_mc, _stage.cpuEntrance_mc.cpuText_mc]);
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
			_liveEvent = com.clubpenguin.util.Delegate.create(this, playLiveEvent);
			_global.getCurrentAirtower().addListener("liveevent", _liveEvent);
        }
        function configureTriggers() {
            _stage.triggers_mc.cpuTrigger_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "school", 645, 370);
            _stage.triggers_mc.dojoTrigger_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "dojoext", 390, 380);
            _stage.triggers_mc.mineTrigger_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "mine", 395, 175);
            _stage.triggers_mc.forestTrigger_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "forest", 630, 205);
            _volleyballBTrigger = new com.clubpenguin.world.rooms.common.triggers.PlayerTrigger(_stage.triggers_mc.volleyballBTrigger_mc);
            _volleyballBTrigger.playersAdded.add(com.clubpenguin.util.Delegate.create(this, playVolleyball));
            _volleyballBTrigger.playersRemoved.add(com.clubpenguin.util.Delegate.create(this, stopVolleyball));
            _triggerWatcher.addTrigger(_volleyballBTrigger);
            _volleyballATrigger = new com.clubpenguin.world.rooms.common.triggers.PlayerTrigger(_stage.triggers_mc.volleyballATrigger_mc);
            _volleyballATrigger.playersAdded.add(com.clubpenguin.util.Delegate.create(this, playVolleyball));
            _volleyballATrigger.playersRemoved.add(com.clubpenguin.util.Delegate.create(this, stopVolleyball));
            _triggerWatcher.addTrigger(_volleyballATrigger);
        }
        function configureNavigation() {
            setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.mine_btn, 495, 210), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.exit_mc.forest_btn, 45, 410), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.dojoExt_mc.dojoExt_btn, 370, 160), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.school_btn, 240, 200)]);
        }
        function configureRoomElements() {
            _stage.exit_mc.forest_btn.useHandCursor = false;
            _stage.dojoExt_mc.dojoExt_btn.useHandCursor = false;
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
        function exit(roomName, x, y) {
            _SHELL.sendJoinRoom(roomName, x, y);
        }
		function playLiveEvent()
        {
     	   _SHELL.startMusicById(2027);
        }
        function destroy() {
            clearInterval(_roomUpdateInterval);
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
			_global.getCurrentAirtower().removeListener("liveevent", _liveEvent);
        }
        static var CLASS_NAME = "Shack";
    }
