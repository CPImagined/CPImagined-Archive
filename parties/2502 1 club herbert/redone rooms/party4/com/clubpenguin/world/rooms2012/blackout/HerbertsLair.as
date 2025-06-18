//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2012.blackout.HerbertsLair extends com.clubpenguin.world.rooms.BaseRoom
    {
        var _stage, localize, _opcodeJournal, _destroyDelegate, _SHELL, setupNavigationButtons, _ENGINE, _INTERFACE;
        function HerbertsLair (stageReference) {
            super(stageReference);
            _stage.start_x = 400;
            _stage.start_y = 380;
            localize([_stage.background_mc.sign_mc]);
        }
        function init() {
            _destroyDelegate = com.clubpenguin.util.Delegate.create(this, destroy);
            _SHELL.addListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            _SHELL.addListener(_SHELL.BUY_INVENTORY, onInventoryBought);
            setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.cryo_btn, 258, 195), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.foreground_mc.exit_btn, 400, 410), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.ventback_mc.ventback_btn, 680, 435), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.ventforward_mc.ventforward_btn, 730, 275), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.computer_btn, 460, 250)]);
            _stage.triggers_mc.triggerexit_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "party2", 380, 390);
            _stage.triggers_mc.triggerventback_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "party2", 510, 90);
            _stage.triggers_mc.triggerventforward_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "party5", 95, 155);
            _stage.triggers_mc.triggercomputer_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, loadGame);
            if (_SHELL.isItemInMyInventory(7137)) {
				if (!_global.getCurrentParty().BaseParty.CURRENT_PARTY.getMessageViewed(12)) {
					_global.getCurrentParty().BaseParty.CURRENT_PARTY.setMessageViewed(12);
					_SHELL.sendBuyFurniture(923);
                    _INTERFACE.showContent("videoPlayer", null, undefined, {source:_SHELL.getPath("end"), autoPlay:true}, true);
				};
                setRoomState(4);
            } else if (_SHELL.isItemInMyInventory(7136)) {
                setRoomState(3);
            } else if (_global.getCurrentParty().BaseParty.CURRENT_PARTY.getMessageViewed(11)) {
                setRoomState(2);
            } else {
				setRoomState(1);
			};
        }
		function getCompleted(challenge) {
			return (_SHELL.isItemInMyInventory(challenge + 7131));
		}
        function loadGame() {
            _ENGINE.sendJoinGame(com.clubpenguin.world.rooms2012.blackout.Blackout.HACKING_MINIGAME, true, {currentLevel:6, onGameCompleteCB:com.clubpenguin.util.Delegate.create(com.clubpenguin.world.rooms2012.blackout.Blackout, com.clubpenguin.world.rooms2012.blackout.Blackout.challengeCompleted, com.clubpenguin.world.rooms2012.blackout.Blackout.CHALLENGE_6_PIN_ID, com.clubpenguin.world.rooms2012.blackout.Blackout.CHALLENGE_5_PIN_ID, com.clubpenguin.world.rooms2012.blackout.Blackout.CHALLENGE_6)});
        }
        function onInventoryBought(event) {
            if (event.success) {
                if (event.item_id == com.clubpenguin.world.rooms2012.blackout.Blackout.CHALLENGE_6_PIN_ID) {
                    setRoomState(4);
                }
            }
        }
        function setRoomState(stateID) {
            _stage.background_mc.gotoAndStop(stateID);
        }
        function exit(roomName, x, y) {
            _SHELL.sendJoinRoom(roomName, x, y);
        }
        function destroy() {
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            _SHELL.removeListener(_SHELL.BUY_INVENTORY, onInventoryBought);
        }
        static var CLASS_NAME = "HerbertsLair";
    }
