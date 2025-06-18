//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2013.medieval.Coffee extends com.clubpenguin.world.rooms.BaseRoom
    {
        var _stage, _SHELL, _destroyDelegate, setupNavigationButtons, localize, _opcodeJournal, _ENGINE, _INTERFACE;
        function Coffee (stageReference) {
            super(stageReference);
            _stage.start_x = 350;
            _stage.start_y = 230;
            if (!_SHELL) {
                init();
            }
        }
        function init() {
            _destroyDelegate = com.clubpenguin.util.Delegate.create(this, destroy);
            _SHELL.addListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            configureNavigation();
            configureTriggers();
            configureRoomElements();
        }
        function configureTriggers() {
            _stage.triggers_mc.town_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "town", 271, 277);
            _stage.triggers_mc.book_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "book", 625, 245);
            _stage.triggers_mc.beans_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, launchBeanGame);
            _stage.triggers_mc.smoothieGame_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, launchSmoothieGame);
        }
        function configureNavigation() {
            setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.exit_mc.exit_btn, 350, 157), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.book_mc.book_btn, 654, 268), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.bean_mc.bean_btn, 673, 368), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.smoothiestand_mc.smoothie_btn, 67, 334)]);
        }
        function configureRoomElements() {
            localize([_stage.smoothieSign_mc.smoothieSign2_mc, _stage.background_mc.cacheBitmapBG.clubPenguinTimes_mc]);
            _opcodeJournal = new com.clubpenguin.world.rooms2012.smoothie.OpcodeJournal();
            _opcodeJournal.init(_SHELL.getMyPlayerId());
            _stage.block_mc._visible = false;
            _stage.triggers_mc._visible = false;
            _stage.bean_mc.bean_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, showBeansHint);
            _stage.bean_mc.bean_btn.onRollOut = com.clubpenguin.util.Delegate.create(this, hideBeansHint);
            _stage.smoothiestand_mc.smoothie_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, showSmoothieHint);
            _stage.smoothiestand_mc.smoothie_btn.onRollOut = com.clubpenguin.util.Delegate.create(this, hideSmoothieHint);
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
        function launchPizzatronGame() {
            _ENGINE.sendJoinGame("pizzatron", true);
        }
        function exit(roomName, x, y) {
            _SHELL.sendJoinRoom(roomName, x, y);
        }
        function destroy() {
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
        }
        static var CLASS_NAME = "Coffee";
    }
