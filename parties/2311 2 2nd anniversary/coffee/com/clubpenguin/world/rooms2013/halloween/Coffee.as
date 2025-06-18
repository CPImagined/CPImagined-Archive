//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2013.halloween.Coffee extends com.clubpenguin.world.rooms.BaseRoom
    {
        var _stage, localize, _destroyDelegate, _SHELL, _triggerWatcher, setupNavigationButtons, _opcodeJournal, _ENGINE, _INTERFACE, _triggerWatcherInterval;
        function Coffee (stageReference) {
            super(stageReference);
            _stage.start_x = 355;
            _stage.start_y = 235;
            init();
        }
        function init() {
            localize([_stage.background_mc.stair_mc.timesTitle_mc, _stage.smoothieSign_mc.smoothieSign2_mc, _stage.frontTables_mc.text_mc, _stage.background_mc.items_mc.text_mc]);
            _destroyDelegate = com.clubpenguin.util.Delegate.create(this, destroy);
            _SHELL.addListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            _triggerWatcher = new com.clubpenguin.world.rooms.common.triggers.TriggerWatcher(_stage, _SHELL);
            setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.stair_mc.stair_btn, 655, 255), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.smoothiestand_mc.smoothie_btn, 68, 325), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.door_btn, 355, 150), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.bean_mc.bean_btn, 690, 325), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.camera_mc.camerabutton_btn, 524, 227)]);
            _stage.table_mc.cake_mc.cakeButton.onRollOver = com.clubpenguin.util.Delegate.create(this, blowOutCandles);
            _stage.table_mc.year_mc.year1_btn.onRelease = com.clubpenguin.util.Delegate.create(this, showCatalog, "year2223_book");
            _stage.bean_mc.bean_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, showBeansHint);
            _stage.bean_mc.bean_btn.onRollOut = com.clubpenguin.util.Delegate.create(this, hideBeansHint);
            _stage.smoothiestand_mc.smoothie_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, showSmoothieHint);
            _stage.smoothiestand_mc.smoothie_btn.onRollOut = com.clubpenguin.util.Delegate.create(this, hideSmoothieHint);
            _stage.triggers_mc.town_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "town", 205, 300);
            _stage.triggers_mc.book_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "book", 625, 245);
            _stage.triggers_mc.beans_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, launchBeanGame);
            _stage.triggers_mc.smoothieGame_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, launchSmoothieGame);
            _stage.table_mc.hat_mc.hat1_btn.onRelease = com.clubpenguin.util.Delegate.create(this, getHatItem);
        }
        function blowOutCandles() {
            _stage.table_mc.cake_mc.gotoAndPlay("blowOutCandles");
            _SHELL.stampEarned(CELEBRATION_STAMP_ID);
        }
        function launchSmoothieGame() {
            _ENGINE.sendJoinGame("smoothie", true);
        }
        function showSmoothieHint() {
            _INTERFACE.showHint(_stage.smoothie_counter, "smoothie_hint");
        }
        function hideSmoothieHint() {
            _INTERFACE.closeHint();
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
        function showCatalog(catalogName) {
            _INTERFACE.showContent(catalogName);
        }
        function getHatItem() {
            _INTERFACE.buyInventory(ANNIVERSARY_HAT_ID);
        }
        function destroy() {
            clearInterval(_triggerWatcherInterval);
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
        }
        static var CLASS_NAME = "Coffee";
        var CELEBRATION_STAMP_ID = 186;
        var ANNIVERSARY_HAT_ID = 90020;
    }
