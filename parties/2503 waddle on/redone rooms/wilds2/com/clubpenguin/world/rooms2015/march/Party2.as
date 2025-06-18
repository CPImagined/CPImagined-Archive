//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2015.march.Party2 extends com.clubpenguin.world.rooms.BaseRoom
    {
        var _interface, _stage, _SHELL, _destroyDelegate, setupNavigationButtons;
        function Party2 (stageReference) {
            super(stageReference);
            trace(CLASS_NAME + "()");
            _interface = _global.getCurrentInterface();
            _stage.start_x = 310;
            _stage.start_y = 290;
            if (!_SHELL) {
                init();
            }
        }
        function init() {
            trace(CLASS_NAME + ": init()!!");
            _destroyDelegate = com.clubpenguin.util.Delegate.create(this, destroy);
            _SHELL.addListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            _stage.triggers_mc._visible = false;
            _stage.block_mc._visible = false;
            _stage.triggers_mc.party3_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "wilds3", 136, 199);
            _stage.triggers_mc.puffleStump_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "wilds1", 220, 186);
            _stage.forestRight_btn.useHandCursor = false;
            _stage.puffleStump_btn.useHandCursor = false;
            setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.forestRight_btn, 630, 160), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.puffleStump_btn, 190, 390)]);
        }
        function exit(roomName, x, y) {
            trace(CLASS_NAME + ": exit()");
            _SHELL.sendJoinRoom(roomName, x, y);
        }
        function destroy() {
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
        }
        static var CLASS_NAME = "Party2";
    }
