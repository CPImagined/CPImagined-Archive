//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms.DojoSnow extends com.clubpenguin.world.rooms.BaseRoom
    {
        var _stage, _SHELL, wem, _destroyDelegate, localize, setupNavigationButtons, _ENGINE, _INTERFACE, showContent, _handleGetNinjaRanksDelegate;
        function DojoSnow (stageReference) {
            super(stageReference);
            _stage.start_x = 260;
            _stage.start_y = 260;
            if (!_SHELL) {
                init();
                setupTuskDoor();
            }
        }
        function init() {
            wem = new com.clubpenguin.world.rooms.weathereffects.WeatherEffectsManager(_SHELL, _stage.background_mc);
            wem.setupFireAnimationHeight(40);
            wem.setupRainAnimationHeight(65);
            wem.setupSnowAnimationHeight(65);
            wem.setupRainAnimationSpeed(0.4);
            wem.setupSnowAnimationSpeed(0.8);
            wem.setupRainDelayTime(2);
            wem.setupSnowDelayTime(2);
            wem.startWeatherEffectCheck();
            _destroyDelegate = com.clubpenguin.util.Delegate.create(this, destroy);
            _SHELL.addListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            localize([_stage.interface_mc.book_mc]);
            configureNavigation();
            configureTriggers();
            configureRoomElements();
            fetchNinjaRank();
			setupTuskDoor();
        }
        function configureNavigation() {
            setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.mound.dojo_btn, 80, 370), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.tuskDoor.tusk_btn, 140, 220), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.game_btn, 463, 210)]);
        }
        function configureTriggers() {
            _stage.triggers_mc.dojo_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, EXIT_TO_DOJO, 550, 265);
            _stage.triggers_mc.game_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, _ENGINE.sendJoinGame, CJ_SNOW_GAME, true, {gameStartParams:{isAS3:true, gameMode:GAME_MODE_REGULAR}});
        }
        function configureRoomElements() {
            var _local_2 = 2;
            _stage.interface_mc.book_mc.ninja_btn.onRelease = com.clubpenguin.util.Delegate.create(_INTERFACE, _INTERFACE.openCatalog, "ninja_catalogue", _local_2);
            showContent([new com.clubpenguin.world.rooms.common.PopupContentVO(_stage.interface_mc.cardicon_btn, true, NINJA_PROGRESS_UI, "", {playerHasTuskCape:_SHELL.isItemInMyInventory(TUSK_CAPE_ITEM)})]);
            _stage.tablet_mc.game_btn.onRelease = com.clubpenguin.util.Delegate.create(this, _INTERFACE.openCatalog, "ninja_catalogue", _local_2);
            _stage.game_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, bridgeRollOver);
            _stage.game_btn.onRollOut = com.clubpenguin.util.Delegate.create(this, bridgeRollOut);
            _stage.game_btn.onReleaseOutside = com.clubpenguin.util.Delegate.create(this, bridgeRollOut);
        }
        function bridgeRollOver() {
            _INTERFACE.showHint(_stage.game_btn, GAME_HINT_SNOW);
            _stage.bridgeDirector.gotoAndPlay(BRIDGE_SWING_STATE);
        }
        function bridgeRollOut() {
            _INTERFACE.closeHint(_stage.game_btn, GAME_HINT_SNOW);
        }
        function fetchNinjaRank() {
            var _local_2 = _SHELL.getMyPlayerId();
            _SHELL.sendGetNinjaRanks(_local_2);
            _handleGetNinjaRanksDelegate = com.clubpenguin.util.Delegate.create(this, handleGetNinjaRanks);
            _SHELL.addListener(_SHELL.GET_NINJA_RANKS, _handleGetNinjaRanksDelegate);
            _ninjaRankListening = true;
        }
        function handleGetNinjaRanks(event) {
            _SHELL.removeListener(_SHELL.GET_NINJA_RANKS, _handleGetNinjaRanksDelegate);
            _ninjaRankListening = false;
            if (_SHELL.isMyPlayer(Number(event.playerID)) && (event.snowPathRank >= TUSK_RANK_THRESHOLD)) {
                if (!_SHELL.isItemInMyInventory(SNOW_GEM_PIN_ID)) {
                    _INTERFACE.showContent(GEM_EARNED_CONTENT);
                    _SHELL.sendBuyInventory(SNOW_GEM_PIN_ID);
                }
                setupTuskDoor();
            }
        }
        function setupTuskDoor() {
            _stage.background_mc.tuskDoor.gotoAndStop(TUSK_DOOR_OPEN_STATE);
            _stage.background_mc.tuskDoor.tusk_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, tuskDoorRollOver);
            _stage.background_mc.tuskDoor.tusk_btn.onRollOut = com.clubpenguin.util.Delegate.create(this, tuskDoorRollOut);
            _stage.background_mc.tuskDoor.tusk_btn.onReleaseOutside = com.clubpenguin.util.Delegate.create(this, tuskDoorRollOut);
            _stage.triggers_mc.tusk_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, _ENGINE.sendJoinGame, CJ_SNOW_GAME, true, {gameStartParams:{isAS3:true, gameMode:GAME_MODE_TUSK}});
        }
        function tuskDoorRollOver() {
            _stage.background_mc.tuskDoor.doorFlakes.gotoAndPlay(TUSK_DOOR_SNOW_STATE);
            _INTERFACE.showHint(_stage.background_mc.hint_mc, GAME_HINT_TUSK);
        }
        function tuskDoorRollOut() {
            _stage.background_mc.tuskDoor.doorFlakes.gotoAndStop("park");
            _INTERFACE.closeHint(_stage.background_mc.hint_mc, GAME_HINT_TUSK);
        }
        function exit(name, x, y) {
            _SHELL.sendJoinRoom(name, x, y);
        }
        function destroy() {
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            if (_ninjaRankListening) {
                _SHELL.removeListener(_SHELL.GET_NINJA_RANKS, _handleGetNinjaRanksDelegate);
            }
        }
        static var CLASS_NAME = "DojoSnow";
        static var NINJA_PROGRESS_UI = "ninjaProgress";
        static var GEM_EARNED_CONTENT = "w.cj.snow.earnsnowgem";
        static var GAME_HINT_SNOW = "w.app.hint.cjsnow";
        static var GAME_HINT_TUSK = "w.app.hint.cjsnowtusk";
        static var TUSK_DOOR_OPEN_STATE = "open";
        static var TUSK_DOOR_SNOW_STATE = "startSnow";
        static var BRIDGE_SWING_STATE = "bridgeSwing";
        static var EXIT_TO_DOJO = "dojo";
        static var CJ_SNOW_GAME = "snow";
        static var GAME_MODE_REGULAR = 0;
        static var GAME_MODE_TUSK = 1;
        static var SNOW_GEM_PIN_ID = 7159;
        static var TUSK_CAPE_ITEM = 3160;
        static var TUSK_RANK_THRESHOLD = 13;
        var _ninjaRankListening = false;
        var tuskDoorOver = false;
    }
