//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms.islandAdventure2011.TreasureCove extends com.clubpenguin.world.rooms.BaseRoom
    {
        var _stage, localize, setupNavigationButtons, showContent, setupHint, _SHELL, _ENGINE, _localPlayerID, _destroyDelegate, _updatePlayerDelegate, _diggingIntervalID;
        function TreasureCove (stageReference) {
            super(stageReference);
            _stage = stageReference;
            _stage.start_x = 420;
            _stage.start_y = 240;
            localize([_stage.soda.barrels.barrelStack.creamSoda.barrelpaper_mc, _stage.hmspuffle_mc.hmssign_mc.surfsign_states]);
            setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.hut_mc.waves_btn, 630, 250)]);
            showContent([new com.clubpenguin.world.rooms.common.PopupContentVO(_stage.interface_mc.cove_cat_btn, true, "cove_catalogue", ""), new com.clubpenguin.world.rooms.common.PopupContentVO(_stage.cove_cat_obj_mc.cove_cat_obj_btn, true, "cove_catalogue", "")]);
            setupHint([new com.clubpenguin.world.rooms.common.HintVO(_stage.hut_mc.waves_btn, _stage.hut_mc.waves_btn, "waves_hint")]);
            _stage.triggers_mc.forest_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exitForest);
            _stage.triggers_mc.waves_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exitWaves);
            _stage.triggers_mc.party_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exitParty);
            _stage.triggers_mc.freeitem_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, freeItem);
			_stage.background_mc.waterfall_mc.cave_mc.water_btn.onRelease = com.clubpenguin.util.Delegate.create(this, waterItem);
            if (!_SHELL) {
                init();
            };
			addEventListeners();
        }
        function exitForest() {
            _SHELL.sendJoinRoom("forest", 595, 375);
        }
        function exitWaves() {
            _ENGINE.sendJoinGame("waves", true);
        }
        function exitParty() {
            _SHELL.sendJoinRoom("party4", 680, 202);
        }
        function freeItem() {
            _INTERFACE.buyInventory(429);
        }
		function waterItem() {
            _INTERFACE.buyInventory(7040);
        }
        function init() {
            var _local_2 = _SHELL.isItemInMyInventory(FINAL_ITEM);
            _localPlayerID = _SHELL.getMyPlayerId();
            if (!_SHELL) {
                _local_2 = false;
            }
            _destroyDelegate = com.clubpenguin.util.Delegate.create(this, destroy);
            _SHELL.addListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
			if (!_global.getCurrentParty().BaseParty.CURRENT_PARTY.partyCookie.hasPlayerViewedQCMessage(8) || !_global.getCurrentParty().BaseParty.CURRENT_PARTY.partyCookie.hasPlayerViewedQCMessage(10)) {
				_stage.background_mc.xmts.gotoAndStop("park");
				return;
			};
            if (!_local_2) {
                _stage.background_mc.xmts.gotoAndStop("x");
            } else if (_local_2) {
                _stage.background_mc.xmts.gotoAndStop("dig4");
                _stage.soda.gotoAndStop("on");
                _stage.soda.barrels.barrelStack.play();
                _stage.soda.barrels.chest.play();
                _holeLevel = _treasureDepth;
            }
        }
		
		// add _SHELL event listeners
		function addEventListeners() {
			_SHELL.addListener(_SHELL.PLAYER_MOVE, com.clubpenguin.util.Delegate.create(this, handleUpdatePlayer)); 
			_SHELL.addListener(_SHELL.PLAYER_FRAME, com.clubpenguin.util.Delegate.create(this, handleUpdatePlayer));
			_SHELL.addListener(_SHELL.UPDATE_PLAYER, com.clubpenguin.util.Delegate.create(this, handleUpdatePlayer));
		}
	
		// remove _SHELL event listeners
		function removeEventListeners() {
			_SHELL.removeListener(_SHELL.PLAYER_MOVE, com.clubpenguin.util.Delegate.create(this, handleUpdatePlayer));
			_SHELL.removeListener(_SHELL.PLAYER_FRAME, com.clubpenguin.util.Delegate.create(this, handleUpdatePlayer));
			_SHELL.removeListener(_SHELL.UPDATE_PLAYER, com.clubpenguin.util.Delegate.create(this, handleUpdatePlayer));
		}
		
		function handleUpdatePlayer(event) {
			digDeeper(event);
			if (_SHELL.getMyPlayerId() == event.player_id) {
				var __reg2 = _SHELL.getPlayerObjectById(event.player_id);
				if (_stage.triggers_mc.water_mc.hitTest(__reg2.x, __reg2.y)) {
					var __reg5 = _SHELL.getSecretFrame(__reg2.player_id, __reg2.frame);
					if (__reg2.frame == DANCE_FRAME && __reg5 != __reg2.frame) {
						if (__reg2.head == 1087 && __reg2.face == 2025 && __reg2.body == 4121 && __reg2.feet == 6026 && (__reg2.neck == 3032 || __reg2.neck == 0)) {
							if (_stage.background_mc.waterfall_mc.cave_mc._currentframe == 1) {
								_stage.background_mc.waterfall_mc.cave_mc.gotoAndPlay(2);
							}
						}
					} else {
						if (_stage.background_mc.waterfall_mc.cave_mc._currentframe == 70) {
							_stage.background_mc.waterfall_mc.cave_mc.gotoAndPlay(71);
						}
					}
				}
			}
		}
        function destroy() {
            clearInterval(_diggingIntervalID);
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            removeEventListeners();
        }
        function digDeeper(event) {
			if (_SHELL.getMyPlayerId() == event.player_id) {
				var __reg2 = _SHELL.getPlayerObjectById(event.player_id);
				if (_stage.triggers_mc.treasure.hitTest(__reg2.x, __reg2.y)) {
					var __reg5 = _SHELL.getSecretFrame(__reg2.player_id, __reg2.frame);
					if (__reg2.frame == DANCE_FRAME && __reg5 != __reg2.frame) {
						if (__reg2.hand == SHOVEL_ID[0] || __reg2.hand == SHOVEL_ID[1] || __reg2.head == HARD_HAT_ID[0] || __reg2.head == HARD_HAT_ID[1] || __reg2.head == HARD_HAT_ID[2] || __reg2.head == HARD_HAT_ID[3] || __reg2.head == HARD_HAT_ID[4] || __reg2.head == HARD_HAT_ID[5] || __reg2.head == HARD_HAT_ID[6] || __reg2.head == HARD_HAT_ID[7]) {
							 if (_holeLevel == _treasureDepth) {
								if (!_SHELL.isItemInMyInventory(FINAL_ITEM)) {
									_INTERFACE.buyInventory(FINAL_ITEM);
								};
								clearInterval(_diggingIntervalID);
								_stage.soda.gotoAndStop("on");
								_stage.soda.barrels.barrelStack.play();
								_stage.soda.barrels.chest.play();
								_digging = false;
								return(undefined);
							}
							_holeLevel++;
							_stage.background_mc.xmts.play();
            				clearInterval(_diggingIntervalID);
            				_diggingIntervalID = setInterval(com.clubpenguin.util.Delegate.create(this, digDeeper, event), DIG_DELAY);
						} else {
							clearInterval(_diggingIntervalID);
						}
					}
				}
			}
        }
        var CLASS_NAME = "TreasureCove";
        var FINAL_ITEM = 93034;
        var DANCE_FRAME = 26;
        var DIG_DELAY = 4000;
        var _digging = false;
        var _holeLevel = 0;
        var _treasureDepth = 4;
    	public static var SHOVEL_ID = [342, 5177];
    	public static var HARD_HAT_ID = [403, 429, 674, 1133, 10403, 10429, 11133, 21118];
    }
