//Created by Action Script Viewer - https://www.buraks.com/asv
    class as_files.Coffee extends com.clubpenguin.world.rooms.BaseRoom
    {
        var _stage, _SHELL, localize, _destroyDelegate, setupNavigationButtons, _ENGINE, _INTERFACE, _triggerWatcherInterval;
        function Coffee (stageReference) {
            super(stageReference);
            trace(CLASS_NAME + "()");
            _stage.start_x = 355;
            _stage.start_y = 235;
            if (!_SHELL) {
                init();
            }
        }
        function init() {
            trace(CLASS_NAME + ": init()");
            localize([_stage.timesTitle_mc, _stage.smoothieSign2_mc]);
            _destroyDelegate = com.clubpenguin.util.Delegate.create(this, destroy);
            _SHELL.addListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.stair_btn, 655, 255), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.smoothie_btn, 68, 325), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.town_btn, 355, 150), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.bean_btn, 690, 325)]);
            _stage.bean_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, showBeansHint);
            _stage.bean_btn.onRollOut = com.clubpenguin.util.Delegate.create(this, hideBeansHint);
            _stage.smoothie_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, showSmoothieHint);
            _stage.smoothie_btn.onRollOut = com.clubpenguin.util.Delegate.create(this, hideSmoothieHint);
            _stage.hat1_btn.onRelease = com.clubpenguin.util.Delegate.create(this, getFreeItem);
            _stage.hat1_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, hatLightUp);
            _stage.hat1_btn.onRollOut = com.clubpenguin.util.Delegate.create(this, hatLightOff);
            _stage.cash_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, cashRegisterHop);
            _stage.town_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, openTownDoor);
            _stage.town_btn.onRollOut = com.clubpenguin.util.Delegate.create(this, closeTownDoor);
            _stage.stair_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, turnOnStairLight);
            _stage.stair_btn.onRollOut = com.clubpenguin.util.Delegate.create(this, turnOffStairLight);
            _stage.triggers_mc.town_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "town", 290, 260);
            _stage.triggers_mc.book_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "book", 625, 245);
            _stage.triggers_mc.beans_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, launchBeanGame);
            _stage.triggers_mc.smoothieGame_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, launchSmoothieGame);
        }
        function launchSmoothieGame() {
            _ENGINE.sendJoinGame("smoothie", true);
        }
        function showSmoothieHint() {
            trace("show hint");
            _INTERFACE.showHint(_stage.smoothie_counter, "smoothie_hint");
            _stage.smoothieLight.gotoAndStop(2);
            _stage.fruitDance_mc.gotoAndStop(2);
        }
        function hideSmoothieHint() {
            trace("hide hint");
            _INTERFACE.closeHint();
            _stage.smoothieLight.gotoAndStop(1);
            _stage.fruitDance_mc.gotoAndStop(1);
        }
        function launchBeanGame() {
            _ENGINE.sendJoinGame("beans", true);
        }
        function showBeansHint() {
            trace("show hint");
            _INTERFACE.showHint(_stage.bean_btn, "beans_hint");
            _stage.bean_mc.gotoAndStop(2);
        }
        function hideBeansHint() {
            trace("hide hint");
            _INTERFACE.closeHint();
            _stage.bean_mc.gotoAndStop(1);
        }
        function cashRegisterHop() {
            _stage.cash_register_mc.gotoAndPlay(1);
        }
        function hatLightUp() {
            _stage.table_mc.hat1_mc.gotoAndStop(2);
        }
        function hatLightOff() {
            _stage.table_mc.hat1_mc.gotoAndStop(1);
        }
        function getFreeItem() {
			_global.getCurrentParty().BaseParty.CURRENT_PARTY.setTaskComplete(2);
            _INTERFACE.buyInventory(91003);
        }
        function openTownDoor() {
            _stage.townExit_mc.gotoAndStop(2);
        }
        function closeTownDoor() {
            _stage.townExit_mc.gotoAndStop(1);
        }
        function turnOnStairLight() {
            _stage.stair_mc.gotoAndStop(2);
        }
        function turnOffStairLight() {
            _stage.stair_mc.gotoAndStop(1);
        }
        function exit(roomName, x, y) {
            trace(CLASS_NAME + ": exit()");
            _SHELL.sendJoinRoom(roomName, x, y);
        }
        function destroy() {
            trace(CLASS_NAME + ": destroy()");
            clearInterval(_triggerWatcherInterval);
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
        }
        static var CLASS_NAME = "Coffee";
    }
