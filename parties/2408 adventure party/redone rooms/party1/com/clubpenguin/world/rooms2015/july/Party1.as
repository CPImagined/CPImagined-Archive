//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2015.july.Party1 extends com.clubpenguin.world.rooms.BaseRoom
    {
        var _stage, localize, _destroyDelegate, _SHELL, _ENGINE, setupNavigationButtons;
        function Party1 (stageReference) {
            super(stageReference);
            _stage.start_x = 300;
            _stage.start_y = 260;
            localize([_stage.compassLetters]);
        }
        function init() {
            _destroyDelegate = com.clubpenguin.util.Delegate.create(this, destroy);
            _SHELL.addListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.skullDoor_btn, 168, 184), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.diving_btn, 230, 330)]);
			setupHint([new com.clubpenguin.world.rooms.common.HintVO(_stage.diving_btn, _stage.diving_btn, "diving_hint")]);
            _stage.skullDoor_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, skullDoorMouseOver);
            _stage.skullDoor_btn.onRollOut = com.clubpenguin.util.Delegate.create(this, skullDoorMouseOut);
            _stage.skullDoor_btn.onReleaseOutside = com.clubpenguin.util.Delegate.create(this, skullDoorMouseOut);
            _stage.triggers_mc.party2_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "party2", 666, 370);
			_stage.triggers_mc.party3_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "party3", 155, 160);
			_stage.triggers_mc.ship_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "ship", 575, 215);
			_stage.triggers_mc.diving_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, playDiving);
        }
		function playDiving() {
			var _loc1_ = new Object();
			_loc1_.isAS3 = true;
			_loc1_.hasBrownPuffle = _SHELL.isItemOnMyPlayer(759);
			_ENGINE.sendJoinGame("diving", true, {gameStartParams:_loc1_});
		}
        function skullDoorMouseOver() {
            _stage.skullMouseOver.gotoAndStop(2);
        }
        function skullDoorMouseOut() {
            _stage.skullMouseOver.gotoAndStop(1);
        }
        function exit(name, x, y) {
            _SHELL.sendJoinRoom(name, x, y);
        }
        function destroy() {
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
        }
        static var CLASS_NAME = "Party1";
    }
