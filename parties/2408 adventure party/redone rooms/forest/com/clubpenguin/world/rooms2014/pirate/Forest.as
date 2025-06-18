//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2014.pirate.Forest extends com.clubpenguin.world.rooms.BaseRoom
    {
        var _stage, _SHELL, _destroyDelegate, _triggerWatcher, setupNavigationButtons, _triggerWatcherInterval;
        function Forest (stageReference) {
            super(stageReference);
            _stage.start_x = 393;
            _stage.start_y = 306;
            if (!_SHELL) {
                init();
            }
        }
        function init() {
            _destroyDelegate = com.clubpenguin.util.Delegate.create(this, destroy);
            _SHELL.addListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            _triggerWatcher = new com.clubpenguin.world.rooms.common.triggers.TriggerWatcher(_stage, _SHELL);
            _stage.triggers_mc.plaza_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "plaza", 635, 347);
            _stage.triggers_mc.shack_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "shack", 200, 330);
            _stage.triggers_mc.cove_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "cove", 113, 217);
            _stage.triggers_mc.lake_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "lake", 220, 160);
			_stage.triggers_mc.party_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "party", 250, 375);
            setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.plaza_btn, 72, 175), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.shack_btn, 677, 187), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.cove_btn, 572, 415)]);
            _stage.cove_btn.useHandCursor = false;
            _stage.plaza_btn.useHandCursor = false;
            _stage.shack_btn.useHandCursor = false;
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
        static var CLASS_NAME = "Forest";
    }
