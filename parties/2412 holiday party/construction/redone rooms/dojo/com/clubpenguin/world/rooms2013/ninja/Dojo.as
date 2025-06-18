//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2013.ninja.Dojo extends com.clubpenguin.world.rooms.BaseRoom
    {
        var _stage, localize, _SHELL, _destroyDelegate, _rankDelegate, setupNavigationButtons, _triggerWatcher, _triggerWatcherInterval, setupHint, showContent, _ENGINE, _playerHasCards, _INTERFACE;
        function Dojo (stageReference) {
            super(stageReference);
            _stage.start_x = 385;
            _stage.start_y = 354;
            localize([_stage.interface_mc.book_mc, _stage.sensei_mc]);
            if (!_SHELL) {
                init();
            }
        }
        function init() {
            _destroyDelegate = com.clubpenguin.util.Delegate.create(this, destroy);
			_rankDelegate = com.clubpenguin.util.Delegate.create(this, handleGetNinjaRanks);
            _SHELL.addListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
			_SHELL.addListener(_SHELL.GET_NINJA_RANKS, _rankDelegate);
            _stage.waddle200_mc.seat_frames = [7, 3];
            _stage.waddle201_mc.seat_frames = [7, 3];
            _stage.waddle202_mc.seat_frames = [7, 3];
            _stage.waddle203_mc.seat_frames = [7, 3];
			_stage.interface_mc.shadow_btn._visible = false;
			_stage.background_mc.cached01.pathfinal_mc.gems_mc.fireglow_mc._visible = false;
			_stage.background_mc.cached01.pathfinal_mc.gems_mc.waterglow_mc._visible = false;
			_stage.background_mc.cached01.pathfinal_mc.gems_mc.snowglow_mc._visible = false;
			_SHELL.sendGetNinjaRanks(_SHELL.getMyPlayerId());
            configureNavigation();
            configureTriggers();
            configureRoomElements();
        }
        function configureNavigation() {
            setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.waterDojo_btn, 380, 162), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.sensei_mc.sensei_btn, 380, 310), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.fireDojo_btn, 94, 235), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.snowDojo_btn, 665, 231), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.exit_mc.exit_btn, 380, 465), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.waddle200_mc.game_btn, 224, 330), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.waddle201_mc.game_btn, 532, 330), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.waddle202_mc.game_btn, 208, 374), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.waddle203_mc.game_btn, 550, 374)]);
        }
        function configureTriggers() {
            _triggerWatcher = new com.clubpenguin.world.rooms.common.triggers.TriggerWatcher(_stage, _SHELL);
            _stage.triggers_mc.exitTrigger_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "dojoext", 389, 350);
            _stage.triggers_mc.snowDojoTrigger_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "dojosnow", 270, 330);
            _stage.triggers_mc.waterDojoTrigger_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "dojowater", 380, 330);
            _stage.triggers_mc.fireDojoTrigger_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "dojofire", 612, 318);
			_stage.triggers_mc.shadowDojoTrigger_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "dojohide", 390, 395);
            _stage.triggers_mc.senseiTrigger_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exitSensei);
            _stage.triggers_mc.waddle200_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, joinCJWaddle, waddle_list[0]);
            _stage.triggers_mc.waddle201_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, joinCJWaddle, waddle_list[1]);
            _stage.triggers_mc.waddle202_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, joinCJWaddle, waddle_list[2]);
            _stage.triggers_mc.waddle203_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, joinCJWaddle, waddle_list[3]);
            clearInterval(_triggerWatcherInterval);
            _triggerWatcherInterval = setInterval(_triggerWatcher, "checkAllPlayers", 40);
        }
		function handleGetNinjaRanks(event) {
			if (event.playerID == _SHELL.getMyPlayerId() && event.cardJitsuRank >= 14) {
				_SHELL.removeListener(_SHELL.GET_NINJA_RANKS, _rankDelegate, this);
				_stage.interface_mc.shadow_btn._visible = true;
			}
		    if (event.playerID == _SHELL.getMyPlayerId() && event.firePathRank >= 5) {
		        _SHELL.removeListener(_SHELL.GET_NINJA_RANKS, _rankDelegate, this);
		        _stage.background_mc.cached01.pathfinal_mc.gems_mc.iconfire_mc.gotoAndStop(2);
				_stage.background_mc.cached01.pathfinal_mc.gems_mc.fireglow_mc._visible = true;
		    }
		    if (event.playerID == _SHELL.getMyPlayerId() && event.waterPathRank >= 5) {
		        _SHELL.removeListener(_SHELL.GET_NINJA_RANKS, _rankDelegate, this);
		        _stage.background_mc.cached01.pathfinal_mc.gems_mc.iconwater_mc.gotoAndStop(2);
				_stage.background_mc.cached01.pathfinal_mc.gems_mc.waterglow_mc._visible = true;
		    }
			if (event.playerID == _SHELL.getMyPlayerId() && event.snowPathRank >= 13) {
		        _SHELL.removeListener(_SHELL.GET_NINJA_RANKS, _rankDelegate, this);
		        _stage.background_mc.cached01.pathfinal_mc.gems_mc.iconsnow_mc.gotoAndStop(2);
				_stage.background_mc.cached01.pathfinal_mc.gems_mc.snowglow_mc._visible = true;
		    }
		}
        function configureRoomElements() {
            setupHint([new com.clubpenguin.world.rooms.common.HintVO(_stage.background_mc.waddle200_mc.game_btn, _stage.background_mc.waddle200_mc.game_btn, "w.app.hint.cj"), new com.clubpenguin.world.rooms.common.HintVO(_stage.background_mc.waddle201_mc.game_btn, _stage.background_mc.waddle201_mc.game_btn, "w.app.hint.cj"), new com.clubpenguin.world.rooms.common.HintVO(_stage.background_mc.waddle202_mc.game_btn, _stage.background_mc.waddle202_mc.game_btn, "w.app.hint.cj"), new com.clubpenguin.world.rooms.common.HintVO(_stage.background_mc.waddle203_mc.game_btn, _stage.background_mc.waddle203_mc.game_btn, "w.app.hint.cj")]);
            showContent([new com.clubpenguin.world.rooms.common.PopupContentVO(_stage.interface_mc.cardIcon_btn, true, "ninjaProgress", "", {playerHasTuskCape:_SHELL.isItemInMyInventory(TUSK_CAPE_ITEM)}), new com.clubpenguin.world.rooms.common.PopupContentVO(_stage.interface_mc.book_mc.ninja_btn, true, "ninja_catalogue", ""), new com.clubpenguin.world.rooms.common.PopupContentVO(_stage.pillarLeft_mc.poster_mc.poster_btn, true, "ninjabelts", ""), new com.clubpenguin.world.rooms.common.PopupContentVO(_stage.pillarRight_mc.instructions_mc.instructions_btn, true, "instructions", "")]);
        }
        function exitSensei() {
            _ENGINE.sendJoinGame("sensei", true);
        }
        function joinCJWaddle(waddleID) {
            _playerHasCards = _SHELL.isItemInMyInventory(CARDS_ITEM);
            if (_playerHasCards) {
                _SHELL.addCookie(_SHELL.GAME_COOKIE, "game_ninja", {mode:1});
                _SHELL.addCookie(_SHELL.GAME_COOKIE, "game_ninja", {room:"dojo"});
                _ENGINE.sendJoinCJWaddle("card", waddleID, true, WADDLE_PLAYER_COUNT);
            } else {
                _INTERFACE.showPrompt("ok", _SHELL.getLocalizedString("starter_deck_prompt"));
            }
        }
        function exit(roomName, x, y) {
            _SHELL.sendJoinRoom(roomName, x, y);
        }
        function destroy() {
            clearInterval(_triggerWatcherInterval);
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
			_SHELL.removeListener(_SHELL.GET_NINJA_RANKS, _rankDelegate);
            for (var _local_2 in this) {
                this[_local_2] = null;
            }
        }
        static var CLASS_NAME = "Dojo";
        static var CARDS_ITEM = 821;
        static var WADDLE_PLAYER_COUNT = 2;
        static var TUSK_CAPE_ITEM = 3160;
        var waddle_list = [200, 201, 202, 203];
    }
