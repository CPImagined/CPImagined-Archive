//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2012.medieval.Mountain extends com.clubpenguin.world.rooms.BaseRoom
    {
        var _stage, _destroyDelegate, _SHELL, setupNavigationButtons, localize, _triggerWatcher, _beachBallTrigger1, _beachBallTrigger2, _gateRequirementsTrigger, _roomUpdateInterval, _volleyBallNetPositions, _opcodeJournal, _INTERFACE, _ENGINE, _addPlayerDelegate;
        function Mountain (stageReference) {
            super(stageReference);
            _stage.start_x = 562;
            _stage.start_y = 342;
        }
        function init() {
            if (com.clubpenguin.world.rooms2012.medieval.MedievalParty.isGoodState()) {
                setToDragonDefeatedState();
            }
            _destroyDelegate = com.clubpenguin.util.Delegate.create(this, destroy);
            _SHELL.addListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            _stage.waddle100_mc.seat0_mc._visible = false;
            _stage.waddle100_mc.seat1_mc._visible = false;
            _stage.waddle100_mc.seat2_mc._visible = false;
            _stage.waddle100_mc.seat3_mc._visible = false;
            _stage.waddle101_mc.seat0_mc._visible = false;
            _stage.waddle101_mc.seat1_mc._visible = false;
            _stage.waddle101_mc.seat2_mc._visible = false;
            _stage.waddle102_mc.seat0_mc._visible = false;
            _stage.waddle102_mc.seat1_mc._visible = false;
            _stage.waddle103_mc.seat0_mc._visible = false;
            _stage.waddle103_mc.seat1_mc._visible = false;
            setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.waddle100_mc.game_btn, 700, 360), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.waddle103_mc.game_btn, 460, 425), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.waddle102_mc.game_btn, 355, 400), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.waddle101_mc.game_btn, 240, 410), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.gate.door_btn, 650, 205), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.chest_mc.chest_btn, 510, 250)]);
            setupSledGame(_stage, [new com.clubpenguin.world.rooms.common.TableGameVO(_stage.waddle100_mc, _stage.triggers_mc.waddle100_mc, "sled", "sled_hint", true, 100, [18, 18, 18, 18]), new com.clubpenguin.world.rooms.common.TableGameVO(_stage.waddle101_mc, _stage.triggers_mc.waddle101_mc, "sled", "sled_hint", true, 101, [18, 18, 18]), new com.clubpenguin.world.rooms.common.TableGameVO(_stage.waddle102_mc, _stage.triggers_mc.waddle102_mc, "sled", "sled_hint", true, 102, [17, 17]), new com.clubpenguin.world.rooms.common.TableGameVO(_stage.waddle103_mc, _stage.triggers_mc.waddle103_mc, "sled", "sled_hint", true, 103, [24, 24])]);
            localize([_stage.background_mc.ridgerun_mc, _stage.background_mc.bunnyhill_mc, _stage.express_mc, _stage.penguinrun_mc, _stage.pole_mc, _stage.chest_mc.sign_mc]);
            _stage.triggers_mc.village_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "village", 157, 309);
            _stage.triggers_mc.bridge_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "party26", 20, 446);
            _stage.interface_mc.mtn_cat_btn.onRelease = com.clubpenguin.util.Delegate.create(this, showCatalog, "mtn_catalogue");
            _stage.triggers_mc.triggeritem_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, getFreeItem);
            _triggerWatcher = new com.clubpenguin.world.rooms2012.common.triggers.TriggerWatcher(_stage, _SHELL);
            _beachBallTrigger1 = new com.clubpenguin.world.rooms2012.common.triggers.PlayerWalkTrigger(_stage.triggers_mc.triggerVolleyBall1);
            _beachBallTrigger1.playersAdded.add(com.clubpenguin.util.Delegate.create(this, onPlayerOverVolleyball, 0));
            _beachBallTrigger1.playersRemoved.add(com.clubpenguin.util.Delegate.create(this, onPlayerLeaveVolleyball, 0));
            _beachBallTrigger2 = new com.clubpenguin.world.rooms2012.common.triggers.PlayerWalkTrigger(_stage.triggers_mc.triggerVolleyBall2);
            _beachBallTrigger2.playersAdded.add(com.clubpenguin.util.Delegate.create(this, onPlayerOverVolleyball, 1));
            _beachBallTrigger2.playersRemoved.add(com.clubpenguin.util.Delegate.create(this, onPlayerLeaveVolleyball, 1));
            _gateRequirementsTrigger = new com.clubpenguin.world.rooms2012.common.triggers.PlayerWalkTrigger(_stage.triggers_mc.triggerGateCheck);
            _gateRequirementsTrigger.isLocalPlayerOnly();
            _gateRequirementsTrigger.playersAdded.add(com.clubpenguin.util.Delegate.create(this, checkGateRequirements));
            _gateRequirementsTrigger.playersRemoved.add(com.clubpenguin.util.Delegate.create(this, closeGate));
            _triggerWatcher.addTrigger(_beachBallTrigger1);
            _triggerWatcher.addTrigger(_beachBallTrigger2);
            _triggerWatcher.addTrigger(_gateRequirementsTrigger);
            clearInterval(_roomUpdateInterval);
            _roomUpdateInterval = setInterval(this, "update", 100);
            _volleyBallNetPositions = [];
            _volleyBallNetPositions[0] = false;
            _volleyBallNetPositions[1] = false;
            _opcodeJournal = new com.clubpenguin.world.rooms2012.medieval.OpcodeJournal();
            _opcodeJournal.init(_SHELL.getMyPlayerId());
        }
        function setupSledGame(stage, sledObjects) {
            var _local_2 = 0;
            while (_local_2 < sledObjects.length) {
                sledObjects[_local_2].tableClip.seat_frames = sledObjects[_local_2].seatframes;
                sledObjects[_local_2].tableClip.game_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, sledRollOver, sledObjects, _local_2);
                sledObjects[_local_2].tableClip.game_btn.onRollOut = com.clubpenguin.util.Delegate.create(this, sledRollOut, sledObjects, _local_2);
                sledObjects[_local_2].tableClip.game_btn.onReleaseOutside = com.clubpenguin.util.Delegate.create(this, sledRollOut, sledObjects, _local_2);
                sledObjects[_local_2].triggerClip.triggerFunction = com.clubpenguin.util.Delegate.create(this, sledTrigger, sledObjects, _local_2);
                _local_2++;
            }
        }
        function sledRollOver(sledObjects, whichClip) {
            _INTERFACE.showHint(sledObjects[whichClip].tableClip.game_btn, sledObjects[whichClip].hintName);
        }
        function sledRollOut(sledObjects, whichClip) {
            _INTERFACE.closeHint();
        }
        function sledTrigger(sledObjects, whichClip) {
            _ENGINE.sendJoinWaddle(sledObjects[whichClip].gameName, sledObjects[whichClip].tableID, sledObjects[whichClip].is_prompt);
        }
        function setToDragonDefeatedState() {
            _stage.background_mc.sky.gotoAndStop(2);
            _stage.banner.gotoAndStop(2);
            _stage.scornStatue.gotoAndStop(2);
        }
        function checkGateRequirements() {
            //_INTERFACE.showContent("modernPopup_lair");
			if(_SHELL.isItemInMyInventory(4219) && _SHELL.isItemInMyInventory(7027) && _SHELL.isItemInMyInventory(4362)) {
				_stage.gate.door_btn._visible = false;
            	_stage.block_mc.gotoAndStop(2);
				_stage.gate.gotoAndStop("open");
			} else {
				_INTERFACE.showContent("garyQuestLocked");
			};
        }
        function closeGate() {
            _stage.gate.gotoAndStop("closed");
            _stage.gate.door_btn._visible = true;
            _stage.block_mc.gotoAndStop(1);
        }
        function update() {
            _triggerWatcher.checkAllPlayers();
        }
        function onPlayerLeaveVolleyball(playerList, volleyBallPos) {
            _volleyBallNetPositions[volleyBallPos] = false;
            _stage.volleyball.gotoAndStop(1);
        }
        function onPlayerOverVolleyball(playerList, volleyBallPos) {
            _volleyBallNetPositions[volleyBallPos] = true;
            var _local_2 = 0;
            while (_local_2 < _volleyBallNetPositions.length) {
                if (_volleyBallNetPositions[_local_2] == false) {
                    return(undefined);
                }
                _local_2++;
            }
            if (_stage.volleyball._currentframe == 1) {
                _stage.volleyball.gotoAndPlay(2);
            }
        }
        function exit(roomName, x, y) {
            _SHELL.sendJoinRoom(roomName, x, y);
        }
        function joinWaddle(gameName, id) {
            _ENGINE.sendJoinWaddle(gameName, id, true);
        }
        function getFreeItem() {
            _INTERFACE.buyInventory(com.clubpenguin.world.rooms2012.medieval.MedievalParty.NOBLE_HELMET_ID);
        }
        function showCatalog(catalogName) {
            _INTERFACE.showContent(catalogName);
        }
        function destroy() {
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            _SHELL.removeListener(_SHELL.ADD_PLAYER, _addPlayerDelegate);
            clearInterval(_roomUpdateInterval);
        }
        static var CLASS_NAME = "Mountain";
    }
