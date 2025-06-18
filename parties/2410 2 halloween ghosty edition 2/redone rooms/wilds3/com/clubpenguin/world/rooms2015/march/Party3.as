//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2015.march.Party3 extends com.clubpenguin.world.rooms.BaseRoom
    {
        var _stage, _SHELL, _destroyDelegate, setupNavigationButtons;
        function Party3 (stageReference) {
            super(stageReference);
            trace(CLASS_NAME + "()");
            _stage.start_x = 325;
            _stage.start_y = 250;
            if (!_SHELL) {
                init();
            }
        }
        function init() {
            trace(CLASS_NAME + ": init()");
            _destroyDelegate = com.clubpenguin.util.Delegate.create(this, destroy);
            _SHELL.addListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            _stage.triggers_mc._visible = false;
            _stage.block_mc._visible = false;
            _stage.triggers_mc.forestLeft_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "wilds2", 575, 200);
            _stage.triggers_mc.puffleStump_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "pufflewild", 500, 280);
            _stage.forestLeft_btn.useHandCursor = false;
            _stage.puffleStump_btn.useHandCursor = false;
            setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.forestLeft_btn, 75, 150), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.puffleStump_btn, 275, 400)]);
        }
        function exit(roomName, x, y) {
            trace(CLASS_NAME + ": exit()");
            _SHELL.sendJoinRoom(roomName, x, y);
        }
        function destroy() {
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
        }
        static var CLASS_NAME = "Party3";
    }
