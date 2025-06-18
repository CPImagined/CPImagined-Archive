//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2015.july.Party2 extends com.clubpenguin.world.rooms.BaseRoom
    {
        var _stage, _SHELL, localize, _destroyDelegate, _triggerWatcher, setupNavigationButtons, _triggerWatcherInterval;
        function Party2 (stageReference) {
            super(stageReference);
            _stage.start_x = 115;
            _stage.start_y = 340;
            if (!_SHELL) {
                init();
            }
            localize([]);
        }
        function init() {
            _destroyDelegate = com.clubpenguin.util.Delegate.create(this, destroy);
            _SHELL.addListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            _triggerWatcher = new com.clubpenguin.world.rooms.common.triggers.TriggerWatcher(_stage, _SHELL);
            setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.exit_btn, 715, 390), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.tube_btn, 360, 250), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.chair_btn, 534, 146)]);
            _stage.exit_btn.useHandCursor = false;
            _stage.tube_btn.useHandCursor = false;
            _stage.chair_btn.useHandCursor = false;
            _stage.triggers_mc.party1_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "party1", 80, 255);
            clearInterval(_triggerWatcherInterval);
            _triggerWatcherInterval = setInterval(_triggerWatcher, "checkAllPlayers", 40);
        }
        function exit(roomName, x, y) {
            _SHELL.sendJoinRoom(roomName, x, y);
        }
        function destroy() {
            clearInterval(_triggerWatcherInterval);
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
        }
        static var CLASS_NAME = "Party2";
    }
