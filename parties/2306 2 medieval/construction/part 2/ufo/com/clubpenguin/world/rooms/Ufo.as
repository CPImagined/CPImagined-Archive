//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms.Ufo extends com.clubpenguin.world.rooms.BaseRoom
    {
        var _stage, _SHELL, _destroyDelegate, localize, setupNavigationButtons, _engine, _engineOverrides, _returnPenguinDelegate, _INTERFACE;
        function Ufo (stageReference) {
            super(stageReference);
            _stage.start_x = 219;
            _stage.start_y = 142;
            if (!_SHELL) {
                init();
            }
        }
        function init() {
            _destroyDelegate = com.clubpenguin.util.Delegate.create(this, destroy);
            _SHELL.addListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            localize([_stage.foreground_mc.annBanner_mc]);
            setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.navLadder, 123, 355)]);
            _stage.navLadder.onRollOver = com.clubpenguin.util.Delegate.create(this, ladderRollOver);
            _stage.navLadder.onRollOut = com.clubpenguin.util.Delegate.create(this, ladderRollOut);
            _stage.navLadder.onReleaseOutside = com.clubpenguin.util.Delegate.create(this, ladderRollOut);
            _stage.triggers_mc.ufoHub_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "party3", 645, 193);
            _engine = _global.getCurrentEngine();
            _engineOverrides = new com.clubpenguin.world.rooms.aliens.AlienAbduction_EngineOverrides();
            _engineOverrides.init();
            activateEngineOverrides();
            _returnPenguinDelegate = com.clubpenguin.util.Delegate.create(this, joinLastRoom);
            setTimeout(_returnPenguinDelegate, 5000);
        }
        function joinLastRoom() {
            deactivateEngineOverrides();
			if(!_SHELL.isItemInMyInventory(21052)) {
				_SHELL.sendUpdatePlayerHead(21052);
				_SHELL.sendBuyInventory(21052);
			}
            _SHELL.sendJoinLastRoom();
        }
        function activateEngineOverrides() {
            _engine.movePlayer = com.clubpenguin.util.Delegate.create(_engine, _engineOverrides.movePlayer);
            _engine.sendPlayerMove = com.clubpenguin.util.Delegate.create(_engine, _engineOverrides.sendPlayerMove);
        }
        function deactivateEngineOverrides() {
            _engine.movePlayer = com.clubpenguin.util.Delegate.create(_engine, _engineOverrides.defaultMovePlayer);
            _engine.sendPlayerMove = com.clubpenguin.util.Delegate.create(_engine, _engineOverrides.defaultSendPlayerMove);
        }
        function ladderRollOver() {
            _stage.ladderLight.gotoAndStop(2);
        }
        function ladderRollOut() {
            _stage.ladderLight.gotoAndStop(1);
        }
        function showContent(contentID) {
            _INTERFACE.showContent(contentID);
        }
        function exit(name, x, y) {
            _SHELL.sendJoinRoom(name, x, y);
        }
        function destroy() {
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            _returnPenguinDelegate = null;
        }
        static var CLASS_NAME = "Ufo";
    }
