//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2013.ninja.DojoExterior extends com.clubpenguin.world.rooms.BaseRoom
    {
        var _stage, _SHELL, _destroyDelegate, wem, _liveEvent, _triggerWatcher, _triggerWatcherInterval, setupNavigationButtons, showContent, _roomUpdateInterval, _handlePlayerFrameDelegate;
        function DojoExterior (stageReference) {
            super(stageReference);
            _stage.start_x = 390;
            _stage.start_y = 365;
            if (!_SHELL) {
                init();
                showCards();
            }
        }
        function showCards() {
            _stage.interface_mc.cardIcon_btn._visible = true;
        }
        function hideCards() {
            _stage.interface_mc.cardIcon_btn._visible = false;
        }
        function initFunctionality() {
            _global.getCurrentInterface().enableInterface();
        }
        function init() {
            _destroyDelegate = com.clubpenguin.util.Delegate.create(this, destroy);
            _SHELL.addListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            if ((((!_SHELL.isItemInMyInventory(STARTER_DECK_ITEM_ID_VANILLA)) || (!_SHELL.isItemInMyInventory(STARTER_DECK_ITEM_ID_FIRE))) || (!_SHELL.isItemInMyInventory(STARTER_DECK_ITEM_ID_WATER))) || (!_SHELL.isItemInMyInventory(STARTER_DECK_ITEM_ID_SNOW))) {
                _global.getCurrentInterface().disableInterface();
                hideCards();
                newplayerexperiencecomplete();
            } else {
                _global.getCurrentInterface().enableInterface();
            }
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
			_liveEvent = com.clubpenguin.util.Delegate.create(this, playLiveEvent);
			_global.getCurrentAirtower().addListener("liveevent", _liveEvent);
        }
        function configureTriggers() {
            _triggerWatcher = new com.clubpenguin.world.rooms.common.triggers.TriggerWatcher(_stage, _SHELL);
            _stage.triggers_mc.dojoTrigger_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "dojo", 380, 355);
            _stage.triggers_mc.exitTrigger_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "shack", 400, 215);
            clearInterval(_triggerWatcherInterval);
            _triggerWatcherInterval = setInterval(_triggerWatcher, "checkAllPlayers", 40);
        }
        function configureNavigation() {
            setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.dojo_btn, 388, 290)]);
        }
        function configureRoomElements() {
            showContent([new com.clubpenguin.world.rooms.common.PopupContentVO(_stage.interface_mc.cardIcon_btn, true, NINJA_PROGRESS_UI, "", {playerHasTuskCape:_SHELL.isItemInMyInventory(TUSK_CAPE_ITEM)})]);
        }
		function playLiveEvent() {
     	   _stage.foreground_mc.event_mc.gotoAndPlay(2);
     	   //_global.getCurrentAirtower().removeListener("liveevent", _liveEvent);
        }
        function exit(roomName, x, y) {
            if (_SHELL.isNewPlayerExperienceRunning == false) {
                _SHELL.sendJoinRoom(roomName, x, y);
            }
        }
        function destroy() {
            clearInterval(_roomUpdateInterval);
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            _SHELL.removeListener(_SHELL.PLAYER_FRAME, _handlePlayerFrameDelegate);
			_global.getCurrentAirtower().removeListener("liveevent", _liveEvent);
        }
        function newplayerexperiencecomplete() {
            _SHELL.sendOpenAS3Module("courtyard_sensei", null, {modalBackgroundEnabled:false, hideLoadingDialog:true});
        }
        static var CLASS_NAME = "DojoExterior";
        static var FIRE = "fire";
        static var WATER = "water";
        static var SNOW = "snow";
        static var STARTER_DECK_ITEM_ID_VANILLA = 821;
        static var STARTER_DECK_ITEM_ID_FIRE = 8006;
        static var STARTER_DECK_ITEM_ID_WATER = 8010;
        static var STARTER_DECK_ITEM_ID_SNOW = 8011;
        static var TUSK_CAPE_ITEM = 3160;
        static var NINJA_PROGRESS_UI = "ninjaProgress";
    }
