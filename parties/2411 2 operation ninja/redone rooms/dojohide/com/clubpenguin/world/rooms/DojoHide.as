//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms.DojoHide extends com.clubpenguin.world.rooms.BaseRoom
    {
        var _stage, localize, showContent, _SHELL, setupHint, setupNavigationButtons, _playerHasCards, _INTERFACE, _ENGINE, _destroyDelegate, _handleGetNinjaRanksDelegate;
        function DojoHide (stageReference) {
            super(stageReference);
            _stage.start_x = 390;
            _stage.start_y = 395;
            localize([]);
            if (!_SHELL) {
                init();
            }
			setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.waddle200_mc.game_btn, 230, 295), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.waddle201_mc.game_btn, 525, 295), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.waddle202_mc.game_btn, 175, 385), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.waddle203_mc.game_btn, 575, 385)]);
        	showContent([new com.clubpenguin.world.rooms.common.PopupContentVO(_stage.interface_mc.ninja_btn, true, "ninja_catalogue", ""), new com.clubpenguin.world.rooms.common.PopupContentVO(_stage.interface_mc.cards_btn, true, "ninjaProgress", {playerHasTuskCape:_SHELL.isItemInMyInventory(3160)})]);
            setupHint([new com.clubpenguin.world.rooms.common.HintVO(_stage.waddle200_mc.game_btn, _stage.waddle200_mc.game_btn, "w.app.hint.cj"), new com.clubpenguin.world.rooms.common.HintVO(_stage.waddle201_mc.game_btn, _stage.waddle201_mc.game_btn, "w.app.hint.cj"), new com.clubpenguin.world.rooms.common.HintVO(_stage.waddle202_mc.game_btn, _stage.waddle202_mc.game_btn, "w.app.hint.cjfire"), new com.clubpenguin.world.rooms.common.HintVO(_stage.waddle203_mc.game_btn, _stage.waddle203_mc.game_btn, "w.app.hint.cjwater")]);
        }
        function shop() {
            _INTERFACE.showContent("ninja_catalogue");
        }
        function joinCJWaddle(waddleID) {
			switch (waddleID) {
				case 202:
					if (_playerHasCards) {
						_SHELL.addCookie(_SHELL.GAME_COOKIE, "game_fire", {mode:1});
						_SHELL.addCookie(_SHELL.GAME_COOKIE, "game_fire", {room:"dojohide"});
						_ENGINE.sendJoinCJWaddle("fire", waddleID, true, WADDLE_PLAYER_COUNT);
					} else {
						_INTERFACE.showPrompt("ok", _SHELL.getLocalizedString("starter_deck_prompt"));
					}
				case 203:
					if (_playerHasCards) {
						_SHELL.addCookie(_SHELL.GAME_COOKIE, "game_water", {mode:1});
						_SHELL.addCookie(_SHELL.GAME_COOKIE, "game_water", {room:"dojohide"});
						_ENGINE.sendJoinCJWaddle("water", waddleID, true, WADDLE_PLAYER_COUNT);
					} else {
						_INTERFACE.showPrompt("ok", _SHELL.getLocalizedString("starter_deck_prompt"));
					}
				default:
					if (_playerHasCards) {
						_SHELL.addCookie(_SHELL.GAME_COOKIE, "game_ninja", {mode:1});
						_SHELL.addCookie(_SHELL.GAME_COOKIE, "game_ninja", {room:"dojohide"});
						_ENGINE.sendJoinCJWaddle("card", waddleID, true, WADDLE_PLAYER_COUNT);
					} else {
						_INTERFACE.showPrompt("ok", _SHELL.getLocalizedString("starter_deck_prompt"));
					}
			}
        }
        function init() {
            var _local_2 = _SHELL.getMyPlayerId();
            _SHELL.sendGetNinjaRanks(_local_2);
			_playerHasCards = _SHELL.isItemInMyInventory(CARDS_ITEM);
            _stage.waddle200_mc.seat_frames = [7, 3];
            _stage.waddle201_mc.seat_frames = [7, 3];
            _stage.waddle202_mc.seat_frames = [7, 3];
            _stage.waddle203_mc.seat_frames = [7, 3];
            _stage.gong01_mc.gong01_btn.onRelease = com.clubpenguin.util.Delegate.create(_stage.gong01_mc, play);
            _stage.gong02_mc.gong02_btn.onRelease = com.clubpenguin.util.Delegate.create(_stage.gong02_mc, play);
            _stage.gong03_mc.gong03_btn.onRelease = com.clubpenguin.util.Delegate.create(_stage.gong03_mc, play);
            _stage.gong04_mc.gong04_btn.onRelease = com.clubpenguin.util.Delegate.create(_stage.gong04_mc, play);
			_stage.foreground_mc.exit_btn.onRelease = com.clubpenguin.util.Delegate.create(this, dojoExit);
            _destroyDelegate = com.clubpenguin.util.Delegate.create(this, destroy);
            _handleGetNinjaRanksDelegate = com.clubpenguin.util.Delegate.create(this, handleGetNinjaRanks);
            _SHELL.addListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            _SHELL.addListener(_SHELL.GET_NINJA_RANKS, _handleGetNinjaRanksDelegate);
			_stage.triggers_mc.ninja_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, shop);
            _stage.triggers_mc.waddle200_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, joinCJWaddle, waddle_list[0]);
            _stage.triggers_mc.waddle201_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, joinCJWaddle, waddle_list[1]);
            _stage.triggers_mc.waddle202_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, joinCJWaddle, waddle_list[2]);
            _stage.triggers_mc.waddle203_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, joinCJWaddle, waddle_list[3]);
        }
		function dojoExit() {
			_ENGINE.sendJoinRoom("dojo");
		}
        function destroy() {
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            _SHELL.removeListener(_SHELL.GET_NINJA_RANKS, _handleGetNinjaRanksDelegate);
            for (var _local_2 in this) {
                this[_local_2] = null;
            }
        }
        function handleThrow(ball) {
            if ((ball._x > 43) && (ball._x < 95)) {
                if ((ball._y > 90) && (ball._y < 148)) {
                    _stage.gong01_mc.gotoAndPlay(2);
                    ball._visible = false;
                }
            }
            if ((ball._x > 160) && (ball._x < 228)) {
                if ((ball._y > 53) && (ball._y < 119)) {
                    _stage.gong02_mc.gotoAndPlay(2);
                    ball._visible = false;
                }
            }
            if ((ball._x > 525) && (ball._x < 610)) {
                if ((ball._y > 37) && (ball._y < 122)) {
                    _stage.gong03_mc.gotoAndPlay(2);
                    ball._visible = false;
                }
            }
            if ((ball._x > 643) && (ball._x < 740)) {
                if ((ball._y > 23) && (ball._y < 153)) {
                    _stage.gong04_mc.gotoAndPlay(2);
                    ball._visible = false;
                }
            }
        }
        function handleGetNinjaRanks(event) {
			if (_SHELL.isMyPlayer(event.playerID) && !(event.cardJitsuRank >= 14) && !(_SHELL.playerModel.isPlayerModerator())) {
				//_ENGINE.sendJoinRoom("dojo");
			};
            if (_SHELL.isMyPlayer(event.playerID) && (event.firePathRank >= 5)) {
                _SHELL.removeListener(_SHELL.GET_NINJA_RANKS, handleGetNinjaRanks, this);
                _stage.background_mc.pathfinal_mc.iconfire_mc.gotoAndStop(2);
            }
            if (_SHELL.isMyPlayer(event.playerID) && (event.waterPathRank >= 5)) {
                _SHELL.removeListener(_SHELL.GET_NINJA_RANKS, handleGetNinjaRanks, this);
                _stage.background_mc.pathfinal_mc.iconwater_mc.gotoAndStop(2);
            }
			if (_SHELL.isMyPlayer(event.playerID) && (event.snowPathRank >= 13)) {
		        _SHELL.removeListener(_SHELL.GET_NINJA_RANKS, handleGetNinjaRanks, this);
		        _stage.background_mc.pathfinal_mc.iconsnow_mc.gotoAndStop(2);
		    }
        }
		static var CARDS_ITEM = 821;
        static var CLASS_NAME = "DojoHide";
        static var ROOM_STRING = "dojohide";
		static var WADDLE_PLAYER_COUNT = 2;
        var waddle_list = [200, 201, 202, 203];
    }
