//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2014.future.FutureBeach extends com.clubpenguin.world.rooms.BaseRoom
    {
        var _stage, _SHELL, _destroyDelegate, setupNavigationButtons, localize, _INTERFACE, _triggerWatcherInterval;
        function FutureBeach (stageReference) {
            super(stageReference);
            _stage.start_x = 325;
            _stage.start_y = 315;
            if (!_SHELL) {
                init();
            }
        }
        function init() {
            _destroyDelegate = com.clubpenguin.util.Delegate.create(this, destroy);
            _SHELL.addListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            configureTriggers();
            configureNavigation();
            configureRoomElements();
        }
        function configureNavigation() {
            setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.tower_btn, 240, 270)]);
        }
        function configureTriggers() {
            _stage.triggers_mc.tower_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "party8", 385, 410);
            _stage.triggers_mc.dock_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "party6", 205, 150);
        }
        function configureRoomElements() {
            localize([_stage.background_mc.textMeteor_mc, _stage.sign_mc.text_mc]);
        }
        function showContent(contentID) {
            _INTERFACE.showContent(contentID);
        }
        function exit(roomName, x, y) {
            _SHELL.sendJoinRoom(roomName, x, y);
        }
        function destroy() {
            clearInterval(_triggerWatcherInterval);
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
        }
        static var CLASS_NAME = "FutureBeach";
    }
