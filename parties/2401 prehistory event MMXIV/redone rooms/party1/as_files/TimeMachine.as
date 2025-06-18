//Created by Action Script Viewer - https://www.buraks.com/asv
    class as_files.TimeMachine extends com.clubpenguin.world.rooms.BaseRoom
    {
        var _stage, _destroyDelegate, _SHELL, _triggerWatcher, setupNavigationButtons, _triggerWatcherInterval;
        function TimeMachine (stageReference) {
            super(stageReference);
            _stage.start_x = 195;
            _stage.start_y = 360;
            _stage._quality = "MEDIUM";
        }
        function init() {
            _destroyDelegate = com.clubpenguin.util.Delegate.create(this, destroy);
            _SHELL.addListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            _triggerWatcher = new com.clubpenguin.world.rooms.common.triggers.TriggerWatcher(_stage, _SHELL);
            _stage.triggers_mc.dock_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "forts", 420, 300);
            _stage.triggers_mc.party5_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "party2", 352, 373);
            setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.nav_dock, 81, 342), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.nav_party5, 645, 340)]);
            _stage.nav_dock.useHandCursor = false;
            _stage.nav_party5.useHandCursor = false;
            clearInterval(_triggerWatcherInterval);
            _triggerWatcherInterval = setInterval(_triggerWatcher, "checkAllPlayers", 40);
            _opcodeJournal = new com.clubpenguin.world.rooms2013.prehistoric.OpcodeJournal();
            _opcodeJournal.init(_SHELL.getMyPlayerId());
            _opcodeJournal.sendOpcode(com.clubpenguin.world.rooms2013.prehistoric.OpcodeJournal.PLAYER_IN_PARTY_ROOM_FIRST_TIME);
        }
        function exit(roomName, x, y) {
            _SHELL.sendJoinRoom(roomName, x, y);
        }
        function destroy() {
            _opcodeJournal = null;
            _stage._quality = "BEST";
            clearInterval(_triggerWatcherInterval);
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
        }
        static var CLASS_NAME = "TimeMachine";
        static var TIME_SPENT_IN_EACH_TIME_PERIOD = 25;
        var _opcodeJournal = null;
    }
