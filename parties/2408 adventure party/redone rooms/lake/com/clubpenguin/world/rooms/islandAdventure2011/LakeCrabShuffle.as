//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms.islandAdventure2011.LakeCrabShuffle extends com.clubpenguin.world.rooms.BaseRoom
    {
        var _stage, localize, setupNavigationButtons, showContent, _SHELL, _INTERFACE, _dressUpDelegate, _destroyDelegate, _shellGame;
        function LakeCrabShuffle (stageReference) {
            super(stageReference);
            trace(CLASS_NAME + "()");
            _stage = stageReference;
            _stage.start_x = 157;
            _stage.start_y = 290;
            localize([_stage.scubasign_mc, _stage.crabSign, _stage.background.bg_mc.mermaidsign_mc, _stage.foreground_mc.lang]);
            setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background.highlights.cup1, 415, 410), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background.highlights.cup2, 500, 415), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background.highlights.cup3, 585, 410)]);
            showContent([new com.clubpenguin.world.rooms.common.PopupContentVO(_stage.scubasign_mc.scubasign_btn, true, "party_catalogue", ""), new com.clubpenguin.world.rooms.common.PopupContentVO(_stage.background.squiddoor_mc.keyclue_btn, true, "underwater_note", "")]);
            _stage.triggers_mc.forest_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exitForest);
            _stage.triggers_mc.cavedig_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exitCaveDig);
            _stage.triggers_mc.door_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exitUnderwater);
            _stage.background.coatPrize.coat.onPress = com.clubpenguin.util.Delegate.create(this, getCoat);
            if (!_SHELL) {
                init();
                startGame();
            }
        }
        function exitForest() {
            trace(CLASS_NAME + ": exitForest()");
            _SHELL.sendJoinRoom("forest", 235, 345);
        }
        function exitCaveDig() {
            trace(CLASS_NAME + ": exitCaveDig()");
            _SHELL.sendJoinRoom("cavemine", 659, 280);
        }
        function exitUnderwater() {
            trace(CLASS_NAME + ": exitUnderwater()");
            if (_SHELL.isItemInMyInventory(7016)) {
                _SHELL.sendJoinRoom("underwater", 270, 237);
            } else {
                _INTERFACE.showContent("underwater_note");
            }
        }
        function getCoat() {
            trace(CLASS_NAME + ": getCoat()");
            _INTERFACE.buyInventory(COAT);
        }
        function init() {
            trace(CLASS_NAME + ": init()");
            var _local_4 = _SHELL.getMyPlayerObject();
            var _local_3 = false;
            if (_SHELL.isItemInMyInventory(7016)) {
                _stage.background.squiddoor_mc.gotoAndStop(11);
            }
            var _local_2 = 0;
            while (_local_2 < CRAB_COSTUMES.length) {
                if (_local_4.body == CRAB_COSTUMES[_local_2]) {
                    _local_3 = true;
                    break;
                }
                _local_2++;
            }
			var avatar = _SHELL.getPlayerObjectById(_SHELL.getMyPlayerId()).avatar_id;
			if (avatar == 1001) {
				_local_3 = true;
			}
            if (_local_3) {
                startGame();
            } else {
                _stage.foreground_mc.lang.prompt.stop();
                _stage.cupElements.shellLids.lids.stop();
            }
            _dressUpDelegate = com.clubpenguin.util.Delegate.create(this, handlePlayerUpdate);
            _destroyDelegate = com.clubpenguin.util.Delegate.create(this, destroy);
            _SHELL.addListener(_SHELL.UPDATE_PLAYER, _dressUpDelegate);
			_SHELL.addListener(_SHELL.PLAYER_FRAME, _dressUpDelegate);
            _SHELL.addListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
        }
        function destroy() {
            trace(CLASS_NAME + ": destroy()");
            _SHELL.removeListener(_SHELL.UPDATE_PLAYER, _dressUpDelegate);
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            _shellGame.destroy();
            for (var _local_2 in this) {
                var _local_2 = null;
            }
        }
        function handlePlayerUpdate(player) {
            trace(CLASS_NAME + ": handlePlayerUpdate()");
            if (!_SHELL.isMyPlayer(player.player_id)) {
                return(undefined);
            }
            if (!_gameStarted) {
                var _local_3;
                var _local_2 = 0;
                while (_local_2 < CRAB_COSTUMES.length) {
                    if (player.body == CRAB_COSTUMES[_local_2]) {
                        _local_3 = true;
                        break;
                    }
                    _local_2++;
                }
				var avatar = _SHELL.getPlayerObjectById(_SHELL.getMyPlayerId()).avatar_id;
				if (avatar == 1001) {
					_local_3 = true;
				}
                if (_local_3) {
                    startGame();
                }
            }
        }
        function startGame() {
            trace(CLASS_NAME + ": startGame()");
            _gameStarted = true;
            _shellGame = new com.clubpenguin.world.rooms.common.ShellGame(true, com.clubpenguin.util.Delegate.create(this, awardPrize), _stage.foreground_mc, _stage.cupElements, _stage.background.highlights, COAT);
            _stage.foreground_mc.lang.prompt.play();
            _stage.cupElements.shellLids.lids.play();
        }
        function awardPrize() {
            trace(CLASS_NAME + ": awardPrize()");
            _stage.background.coatPrize.play();
        }
        var CLASS_NAME = "LakeCrabShuffle";
        var CRAB_COSTUMES = [4379, 4392, 14212, 4212];
        var COAT = 3257;
        var _gameStarted = false;
    }
