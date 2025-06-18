//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2014.holiday.Shack extends com.clubpenguin.world.rooms2014.holiday.HolidayRoom
    {
        var _stage, _SHELL, localize, _destroyDelegate, _triggerWatcher, wem, _triggerWatcherInterval, setupNavigationButtons, _volleyballBTrigger, _volleyballATrigger, _roomUpdateInterval;
        function Shack (stageReference) {
            super(stageReference);
            trace(CLASS_NAME + "()");
            _stage.start_x = 380;
            _stage.start_y = 350;
            if (!_SHELL) {
                init();
            }
            localize([_stage.lang_mc.langToy_mc]);
        }
        function init() {
            trace(CLASS_NAME + ": init()");
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
            super.configureHolidayRoomElements();
        }
        function configureNavigation() {
            setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.navForest_btn, 120, 420), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.navSchool_btn, 185, 260), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.navDojoExt_btn, 375, 175), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.navMine_btn, 435, 175), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.navSkate_btn, 705, 215)]);
            _stage.navForest_btn.useHandCursor = false;
            _stage.navDojoExt_btn.useHandCursor = false;
            _stage.navSkate_btn.useHandCursor = false;
        }
        function configureTriggers() {
            _stage.triggers_mc.school_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "school", 645, 370);
            _stage.triggers_mc.dojoExt_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "dojoext", 390, 380);
            _stage.triggers_mc.mine_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "mine", 395, 175);
            _stage.triggers_mc.forest_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "forest", 630, 205);
            _stage.triggers_mc.skate_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "skatepark", 120, 160);
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
            _stage.navSchool_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, schoolRollOver);
            _stage.navSchool_btn.onRollOut = com.clubpenguin.util.Delegate.create(this, schoolRollOut);
            _stage.navSchool_btn.onReleaseOutside = com.clubpenguin.util.Delegate.create(this, schoolRollOut);
            _stage.navMine_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, mineRollOver);
            _stage.navMine_btn.onRollOut = com.clubpenguin.util.Delegate.create(this, mineRollOut);
            _stage.navMine_btn.onReleaseOutside = com.clubpenguin.util.Delegate.create(this, mineRollOut);
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
        function schoolRollOver() {
            _stage.schoolDoor_mc.gotoAndStop(2);
        }
        function schoolRollOut() {
            _stage.schoolDoor_mc.gotoAndStop(1);
        }
        function mineRollOver() {
            _stage.mineDoor_mc.gotoAndStop(2);
        }
        function mineRollOut() {
            _stage.mineDoor_mc.gotoAndStop(1);
        }
        function coinsRollOver() {
            _stage.coins_mc.gotoAndPlay(2);
        }
        function coinsRollOut() {
            _stage.coins_mc.gotoAndStop(1);
        }
        function exit(roomName, x, y) {
            trace(CLASS_NAME + ": exit()");
            _SHELL.sendJoinRoom(roomName, x, y);
        }
        function destroy() {
            trace(CLASS_NAME + ": destroy()");
            clearInterval(_roomUpdateInterval);
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
        }
        static var CLASS_NAME = "Shack";
    }
