//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2013.ninja.DojoFire extends com.clubpenguin.world.rooms.BaseRoom
    {
        var _stage, localize, setupNavigationButtons, showContent, _SHELL, setupHint, _INTERFACE, _ENGINE, _playerHasCards, wem, _destroyDelegate;
        function DojoFire (stageReference) {
            super(stageReference);
            _stage.start_x = 640;
            _stage.start_y = 310;
            localize([_stage.sensei_mc, _stage.background_mc.poster01_mc, _stage.background_mc.poster02_mc, _stage.background_mc.distant_mc]);
            setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.sensei_mc.sensei_btn, 380, 160), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.waddle300_mc.game_btn, 235, 260), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.waddle301_mc.game_btn, 520, 260), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.waddle302_mc.game_btn, 230, 380), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.waddle303_mc.game_btn, 525, 380)]);
            showContent([new com.clubpenguin.world.rooms.common.PopupContentVO(_stage.interface_mc.cards_btn, true, "ninjaProgress", "", {playerHasTuskCape:_SHELL.isItemInMyInventory(TUSK_CAPE_ITEM)}), new com.clubpenguin.world.rooms.common.PopupContentVO(_stage.background_mc.poster01_mc.poster_btn, true, "fireclothing", ""), new com.clubpenguin.world.rooms.common.PopupContentVO(_stage.background_mc.poster02_mc.poster_btn, true, "fireinstructions", "")]);
            setupHint([new com.clubpenguin.world.rooms.common.HintVO(_stage.waddle300_mc.game_btn, _stage.waddle300_mc.game_btn, "w.app.hint.cjfire"), new com.clubpenguin.world.rooms.common.HintVO(_stage.waddle301_mc.game_btn, _stage.waddle301_mc.game_btn, "w.app.hint.cjfire"), new com.clubpenguin.world.rooms.common.HintVO(_stage.waddle302_mc.game_btn, _stage.waddle302_mc.game_btn, "w.app.hint.cjfire"), new com.clubpenguin.world.rooms.common.HintVO(_stage.waddle303_mc.game_btn, _stage.waddle303_mc.game_btn, "w.app.hint.cjfire")]);
            _stage.triggers_mc.dojohide_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exitDojo);
            _stage.triggers_mc.sensei_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exitSensei);
            _stage.triggers_mc.waddle300_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, joinCJFireWaddle, waddle_list[0], WADDLE_ID_300_PLAYER_COUNT);
            _stage.triggers_mc.waddle301_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, joinCJFireWaddle, waddle_list[1], WADDLE_ID_301_PLAYER_COUNT);
            _stage.triggers_mc.waddle302_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, joinCJFireWaddle, waddle_list[2], WADDLE_ID_302_PLAYER_COUNT);
            _stage.triggers_mc.waddle303_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, joinCJFireWaddle, waddle_list[3], WADDLE_ID_303_PLAYER_COUNT);
            _stage.interface_mc.party_cat_btn.onRelease = com.clubpenguin.util.Delegate.create(_INTERFACE, _INTERFACE.showContent, "party_catalogue");
            if (!_SHELL) {
                init();
            }
        }
        function exitDojo() {
            _SHELL.sendJoinRoom("dojo", 180, 270);
        }
        function exitSensei() {
            _ENGINE.sendJoinGame("firesensei", true);
        }
        function joinCJFireWaddle(waddleID, numOfPlayers) {
            var _local_2 = "game_fire";
            if (_playerHasCards) {
                _SHELL.addCookie(_SHELL.GAME_COOKIE, _local_2, {mode:1});
                _SHELL.addCookie(_SHELL.GAME_COOKIE, _local_2, {room:ROOM_STRING});
                _ENGINE.sendJoinCJWaddle("fire", waddleID, true, numOfPlayers);
            } else {
                _INTERFACE.showPrompt("ok", _SHELL.getLocalizedString("fire_deck_prompt"));
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
            _playerHasCards = _SHELL.isItemInMyInventory(CARDS_ITEM);
            _stage.waddle300_mc.seat_frames = [6, 2];
            _stage.waddle301_mc.seat_frames = [8, 4];
            _stage.waddle302_mc.seat_frames = [8, 4, 1];
            _stage.waddle303_mc.seat_frames = [6, 2, 6, 2];
            _SHELL.sendGetNinjaRanks(_SHELL.getMyPlayerId());
            _destroyDelegate = com.clubpenguin.util.Delegate.create(this, destroy);
            _SHELL.addListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
        }
        function destroy() {
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            for (var _local_2 in this) {
                this[_local_2] = null;
            }
        }
        static var CLASS_NAME = "DojoFire";
        static var ROOM_STRING = "dojofire";
        static var CARDS_ITEM = 8006;
        static var TUSK_CAPE_ITEM = 3160;
        static var WADDLE_ID_303_PLAYER_COUNT = 4;
        static var WADDLE_ID_302_PLAYER_COUNT = 3;
        static var WADDLE_ID_301_PLAYER_COUNT = 2;
        static var WADDLE_ID_300_PLAYER_COUNT = 2;
        var waddle_list = [300, 301, 302, 303];
    }
