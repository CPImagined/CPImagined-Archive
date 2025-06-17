//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2015.march.Party1 extends com.clubpenguin.world.rooms.BaseRoom
    {
        var _stage, _SHELL, _destroyDelegate, setupNavigationButtons;
        function Party1 (stageReference) {
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
            _stage.triggers_mc.pufflewild_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "pufflewild", 215, 250);
            _stage.triggers_mc.party2_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "wilds2", 285, 285);
            setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.party2_btn, 253, 140), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.pufflewild_btn, 327, 427)]);
			_stage.party2_btn.useHandCursor = false;
            _stage.pufflewild_btn.useHandCursor = false;
        }
        function exit(roomName, x, y) {
            trace(CLASS_NAME + ": exit()");
            _SHELL.sendJoinRoom(roomName, x, y);
        }
        function destroy() {
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
        }
        static var CLASS_NAME = "Party1";
    }
