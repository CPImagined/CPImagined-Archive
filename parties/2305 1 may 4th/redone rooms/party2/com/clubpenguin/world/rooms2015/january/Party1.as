//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2015.january.Party1 extends com.clubpenguin.world.rooms.BaseRoom
    {
        var _triggerWatcher, _stage, _SHELL, setupNavigationButtons, _triggerWatcherInterval, _destroyDelegate;
        function Party1 (stageReference) {
            super(stageReference);
            _triggerWatcher = new com.clubpenguin.world.rooms.common.triggers.TriggerWatcher(_stage, _SHELL);
            _stage.start_x = 360;
            _stage.start_y = 245;
            _stage.triggers_mc.map_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exitPlaza);
            setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.planet_btn, 100, 100)]);
            clearInterval(_triggerWatcherInterval);
            _triggerWatcherInterval = setInterval(_triggerWatcher, "checkAllPlayers", 40);
        }
        function exitPlaza() {
            _SHELL.sendJoinRoom("party8", 307, 177);
        }
        function init() {
            _destroyDelegate = com.clubpenguin.util.Delegate.create(this, destroy);
            _SHELL.addListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
        }
        function destroy() {
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            clearInterval(_triggerWatcherInterval);
        }
        static var CLASS_NAME = "Party1";
    }
