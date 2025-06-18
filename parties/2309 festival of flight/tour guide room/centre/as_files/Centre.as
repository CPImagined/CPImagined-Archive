//Created by Action Script Viewer - https://www.buraks.com/asv
    class as_files.Centre extends com.clubpenguin.world.rooms.BaseRoom
    {
        var _stage, _SHELL, _destroyDelegate, _triggerWatcher, _triggerWatcherInterval, setupNavigationButtons, _roomUpdateInterval;
        function Centre (stageReference) {
            super(stageReference);
            _stage.start_x = 380;
            _stage.start_y = 350;
            if (!_SHELL) {
                init();
            }
        }
        function init() {
            _destroyDelegate = com.clubpenguin.util.Delegate.create(this, destroy);
            _SHELL.addListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            _triggerWatcher = new com.clubpenguin.world.rooms.common.triggers.TriggerWatcher(_stage, _SHELL);
            configureNavigation();
            configureTriggers();
            configureRoomElements();
            clearInterval(_triggerWatcherInterval);
            _triggerWatcherInterval = setInterval(_triggerWatcher, "checkAllPlayers", 40);
        }
        function configureNavigation() {
            setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.overlook_btn, 379, 418), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.book_mc.book_btn, 73, 263), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.bg_mc.quiz_btn, 169, 207)]);
        }
        function configureTriggers() {
            _stage.triggers_mc.overlook_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "overlook", 564, 310);
			_stage.triggers_mc.quiz_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, showQuiz);
			_stage.triggers_mc.book_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, showBook);
        }
		function showBook() {
			_INTERFACE.showContent("give_tour2");
		}
		function showQuiz() {
			_INTERFACE.showContent("tour_form");
		}
        function configureRoomElements() {
            _stage.block_mc._visible = false;
            _stage.triggers_mc._visible = false;
            _stage.overlook_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, overlookRollOver);
            _stage.overlook_btn.onRollOut = com.clubpenguin.util.Delegate.create(this, overlookRollOut);
        }
        function overlookRollOver() {
            _stage.exitButton_mc.gotoAndStop(2);
        }
        function overlookRollOut() {
            _stage.exitButton_mc.gotoAndStop(1);
        }
        function exit(roomName, x, y) {
            _SHELL.sendJoinRoom(roomName, x, y);
        }
        function destroy() {
            clearInterval(_roomUpdateInterval);
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
        }
        static var CLASS_NAME = "Centre";
    }
