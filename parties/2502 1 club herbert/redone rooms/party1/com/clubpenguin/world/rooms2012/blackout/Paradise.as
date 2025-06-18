//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2012.blackout.Paradise extends com.clubpenguin.world.rooms.BaseRoom
    {
        var _stage, _SHELL, _destroyDelegate, _triggerWatcher, setupNavigationButtons, _triggerWatcherInterval;
        function Paradise (stageReference) {
            super(stageReference);
            _stage.start_x = 610;
            _stage.start_y = 380;
            if (!_SHELL) {
                init();
            }
        }
        function init() {
            _destroyDelegate = com.clubpenguin.util.Delegate.create(this, destroy);
            _SHELL.addListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            _triggerWatcher = new com.clubpenguin.world.rooms2012.common.triggers.TriggerWatcher(_stage, _SHELL);
            _stage.triggers_mc.vault_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "party2", 200, 395);
            _stage.triggers_mc.vaultvent_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "party2", 185, 330);
            _stage.triggers_mc.party3vent_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "party3", 180, 360);
            _stage.triggers_mc.skivillage_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "pufflewild", 190, 245);
            setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.vaultdoor_btn, 600, 215), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.vaultvent_mc.vaultvent_btn, 605, 80), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.frontdoor_mc.skivillage_btn, 705, 450), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.party3vent_mc.party3vent_btn, 260, 67)]);
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
        static var CLASS_NAME = "Paradise";
    }
