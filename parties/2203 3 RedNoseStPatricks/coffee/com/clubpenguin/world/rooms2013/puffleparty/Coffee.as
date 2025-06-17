//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2013.puffleparty.Coffee extends com.clubpenguin.world.rooms.BaseRoom
    {
        var _stage, _SHELL, localize, _destroyDelegate, setupNavigationButtons, _opcodeJournal, _INTERFACE, _ENGINE, _triggerWatcherInterval;
        function Coffee (stageReference) {
            super(stageReference);
            _stage.start_x = 355;
            _stage.start_y = 235;
            if (!_SHELL) {
                init();
            }
        }
        function init() {
            localize([_stage.background_mc.stair_mc.timesTitle_mc, _stage.smoothieSign_mc.smoothieSign2_mc, _stage.background_mc.wall.screen_mc.language_mc, _stage.background_mc.textFree_mc, _stage.background_mc.textLaugh_mc]);
            _destroyDelegate = com.clubpenguin.util.Delegate.create(this, destroy);
            _SHELL.addListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.stair_mc.stair_btn, 655, 255), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.smoothiestand_mc.smoothie_btn, 68, 325), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.door_btn, 355, 150), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.bean_mc.bean_btn, 690, 325), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.redNoseItem_btn, 270, 160), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.seat_btn, 195, 135)]);
            _stage.bean_mc.bean_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, showBeansHint);
            _stage.bean_mc.bean_btn.onRollOut = com.clubpenguin.util.Delegate.create(this, hideBeansHint);
            _stage.seat_btn.useHandCursor = false;
            _stage.smoothiestand_mc.smoothie_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, showSmoothieHint);
            _stage.smoothiestand_mc.smoothie_btn.onRollOut = com.clubpenguin.util.Delegate.create(this, hideSmoothieHint);
            _stage.triggers_mc.town_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "town", 290, 260);
            _stage.triggers_mc.book_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "book", 625, 245);
            _stage.triggers_mc.beans_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, launchBeanGame);
            _stage.triggers_mc.smoothieGame_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, launchSmoothieGame);
            _stage.triggers_mc.item_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, pickUpRedNose);
			_stage.triggers_mc.item2_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, pickUpRedNose2);
            _opcodeJournal = new com.clubpenguin.world.rooms2012.smoothie.OpcodeJournal();
            _opcodeJournal.init(_SHELL.getMyPlayerId());
        }
        function pickUpRedNose() {
            _INTERFACE.buyInventory(2112);
        }
		function pickUpRedNose2() {
            _INTERFACE.buyInventory(663);
        }
        function launchSmoothieGame() {
            _opcodeJournal.sendOpcode(com.clubpenguin.world.rooms2012.smoothie.OpcodeJournal.PLAY_SMOOTHIE_SMASH);
            _ENGINE.sendJoinGame("smoothie", true);
        }
        function showSmoothieHint() {
            _INTERFACE.showHint(_stage.smoothie_counter, "smoothie_hint");
            _stage.fruitDance_mc.gotoAndStop(2);
        }
        function hideSmoothieHint() {
            _INTERFACE.closeHint();
            _stage.fruitDance_mc.gotoAndStop(1);
        }
        function launchBeanGame() {
            _ENGINE.sendJoinGame("beans", true);
        }
        function showBeansHint() {
            _INTERFACE.showHint(_stage.bean_mc.bean_btn, "beans_hint");
        }
        function hideBeansHint() {
            _INTERFACE.closeHint();
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
