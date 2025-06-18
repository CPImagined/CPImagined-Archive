//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2015.july.Party3 extends com.clubpenguin.world.rooms.BaseRoom
    {
        var _stage, localize, _destroyDelegate, _SHELL, setupNavigationButtons;
        function Party3 (stageReference) {
            super(stageReference);
            _stage.start_x = 250;
            _stage.start_y = 250;
        }
        function init() {
            _destroyDelegate = com.clubpenguin.util.Delegate.create(this, destroy);
            _SHELL.addListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.exit_btn, 113, 123)]);
            _stage.exit_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, exitMouseOver);
            _stage.exit_btn.onRollOut = com.clubpenguin.util.Delegate.create(this, exitMouseOut);
            _stage.exit_btn.onReleaseOutside = com.clubpenguin.util.Delegate.create(this, exitMouseOut);
            _stage.triggers_mc.party1_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "party1", 200, 215);
        }
        function exitMouseOver() {
            _stage.exitGlow.gotoAndStop(2);
        }
        function exitMouseOut() {
            _stage.exitGlow.gotoAndStop(1);
        }
        function exit(name, x, y) {
            _SHELL.sendJoinRoom(name, x, y);
        }
        function destroy() {
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
        }
        static var CLASS_NAME = "Party3";
    }
