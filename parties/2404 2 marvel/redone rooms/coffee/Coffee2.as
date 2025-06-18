//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2012.superhero.Coffee extends com.clubpenguin.world.rooms.BaseRoom
    {
        var _stage, _destroyDelegate, _SHELL, _triggerWatcher, localize, setupNavigationButtons, _triggerWatcherInterval, _ENGINE, _INTERFACE;
        function Coffee (stageReference) {
            super(stageReference);
            _stage.start_x = 320;
            _stage.start_y = 240;
        }
        function init() {
            _destroyDelegate = com.clubpenguin.util.Delegate.create(this, destroy);
            _SHELL.addListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            _triggerWatcher = new com.clubpenguin.world.rooms2012.common.triggers.TriggerWatcher(_stage, _SHELL);
            localize([_stage.beans_btn_states, _stage.background_mc.background_mc_2.board_mc_states, _stage.town_btn_states, _stage.background_mc.wall.exit_mc_states, _stage.background_mc.wall.screen_mc.language_mc, _stage.background_mc.background_mc_2.coffeeshop_mc_states, _stage.background_mc.background_mc_2.coffeebag_mc_states, _stage.background_mc.background_mc_2.exit_txt, _stage.background_mc.timesdoor_mc.timessign_mc]);
            _stage.beans_btn_states.beans_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, showBeansHint);
            _stage.beans_btn_states.beans_btn.onRollOut = com.clubpenguin.util.Delegate.create(this, hideBeansHint);
            _stage.triggers_mc.town_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "town", 290, 260);
            _stage.triggers_mc.book_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "book", 600, 290);
            _stage.triggers_mc.beans_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, joinBeans);
            _stage.camera_mc.camerabutton_btn.onRelease = com.clubpenguin.util.Delegate.create(this, cameraPressed);
            _stage.triggers_mc.triggercamera_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, getFreeItem);
            setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.beans_btn_states.beans_btn, 500, 335), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.town_btn_states.town_btn, 375, 196), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.background_mc_2.book_btn, 630, 410)]);
            clearInterval(_triggerWatcherInterval);
            _triggerWatcherInterval = setInterval(_triggerWatcher, "checkAllPlayers", 40);
        }
        function joinBeans() {
            _ENGINE.sendJoinGame("beans", true);
        }
        function showBeansHint() {
            _INTERFACE.showHint(_stage.beans_btn_states.beans_btn, "beans_hint");
        }
        function hideBeansHint() {
            _INTERFACE.closeHint();
        }
        function cameraPressed() {
            _stage.camera_mc.mainbutton_mc.gotoAndStop(2);
            _ENGINE.sendPlayerMove(155, 280);
        }
        function getFreeItem() {
            if ((_stage.camera_mc.mainbutton_mc._currentframe == 2) && (_stage.foreground_mc._currentframe == 1)) {
                _stage.foreground_mc.play();
                _stage.camera_mc.mainbutton_mc.gotoAndStop(1);
            }
            if (!_SHELL.isItemInMyInventory(9142)) {
                _INTERFACE.buyInventory(9142);
            }
        }
        function exit(roomName, x, y) {
            _SHELL.sendJoinRoom(roomName, x, y);
        }
        function destroy() {
            clearInterval(_triggerWatcherInterval);
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
        }
        static var CLASS_NAME = "Coffee";
    }
