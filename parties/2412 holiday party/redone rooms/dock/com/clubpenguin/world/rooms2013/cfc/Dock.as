//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2013.cfc.Dock extends com.clubpenguin.world.rooms.BaseRoom
    {
        var _stage, localize, setupNavigationButtons, _INTERFACE, _ENGINE, _SHELL, _destroyDelegate, _triggerWatcher, _triggerWatcherInterval, _houseTrigger1, _houseTrigger2;
        function Dock (stageReference) {
            super(stageReference);
            _stage.start_x = 380;
            _stage.start_y = 220;
            localize([_stage.arch1_mc]);
            setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.beach_btn, 80, 289), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.town_btn, 723, 301), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.dock_mc.boat_btn, 196, 424), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.block_mc.ground_mc.navButton_BigDoor, 364, 167)]);
            _stage.background_mc.beach_btn.useHandCursor = false;
            _stage.background_mc.town_btn.useHandCursor = false;
            _stage.background_mc.igloo2_btn.useHandCursor = false;
            _stage.interface_mc.dock_cat_btn.onRelease = com.clubpenguin.util.Delegate.create(this, showContent, "dock_catalogue");
            _stage.hydrocatalog_mc.hydrocatalog_btn.onRelease = com.clubpenguin.util.Delegate.create(this, showContent, "dock_catalogue");
            _stage.dock_mc.boat_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, showHydroHintRollOver);
            _stage.dock_mc.boat_btn.onRollOut = com.clubpenguin.util.Delegate.create(this, hideHydroHintRollOut);
			_stage.background_mc.block_mc.ground_mc.navButton_BigDoor.onRollOver = com.clubpenguin.util.Delegate.create(this, bigDoorRollOver);
            _stage.background_mc.block_mc.ground_mc.navButton_BigDoor.onRollOut = com.clubpenguin.util.Delegate.create(this, bigDoorRollOut);
            _stage.triggers_mc.beach2_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "beach", 630, 230);
            _stage.triggers_mc.town2_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "town", 130, 330);
            _stage.triggers_mc.igloo2_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "igloo", 130, 330);
			_stage.triggers_mc.area501_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "party2", 617, 249);
            _stage.triggers_mc.hydro_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, launchHydroGame);
        }
        function showContent(contentID) {
            _INTERFACE.showContent(contentID);
        }
        function showHydroHintRollOver() {
            _INTERFACE.showHint(_stage.hinthydro_mc, "hydro_hint");
            _stage.dock_mc.boat_mc.boathover_mc.gotoAndStop(2);
        }
        function hideHydroHintRollOut() {
            _INTERFACE.closeHint();
            _stage.dock_mc.boat_mc.boathover_mc.gotoAndStop(1);
        }
        function launchHydroGame() {
            _ENGINE.sendJoinGame("hydro", true);
        }
        function exit(name, x, y) {
            _SHELL.sendJoinRoom(name, x, y);
        }
		function bigDoorRollOver() {
            _stage.background_mc.block_mc.ground_mc.bigDoor.gotoAndPlay("open");
        }
        function bigDoorRollOut() {
            _stage.background_mc.block_mc.ground_mc.bigDoor.gotoAndPlay("close");
        }
        function init() {
            _destroyDelegate = com.clubpenguin.util.Delegate.create(this, destroy);
            _SHELL.addListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            _triggerWatcher = new com.clubpenguin.world.rooms.common.triggers.TriggerWatcher(_stage, _SHELL);
            configureIglooDoors();
            clearInterval(_triggerWatcherInterval);
            _triggerWatcherInterval = setInterval(_triggerWatcher, "checkAllPlayers", 40);
        }
        function configureIglooDoors() {
            _houseTrigger1 = new com.clubpenguin.world.rooms.common.triggers.PlayerTrigger(_stage.triggers_mc.house0Trigger);
            _houseTrigger1.playersAdded.add(com.clubpenguin.util.Delegate.create(this, houseCheck, 0));
            _houseTrigger1.playersRemoved.add(com.clubpenguin.util.Delegate.create(this, houseCheck, 0));
            _triggerWatcher.addTrigger(_houseTrigger1);
            _houseTrigger2 = new com.clubpenguin.world.rooms.common.triggers.PlayerTrigger(_stage.triggers_mc.house1Trigger);
            _houseTrigger2.playersAdded.add(com.clubpenguin.util.Delegate.create(this, houseCheck, 1));
            _houseTrigger2.playersRemoved.add(com.clubpenguin.util.Delegate.create(this, houseCheck, 1));
            _triggerWatcher.addTrigger(_houseTrigger2);
        }
        function houseCheck(players, house) {
            var _local_3 = this["_houseTrigger" + (house + 1)].getPlayerCount();
            if (_local_3 > 0) {
                if (houseStates[house] != HOUSE_STATE_OPEN) {
                    houseStates[house] = HOUSE_STATE_OPEN;
                    _stage["house" + house].door.gotoAndStop(HOUSE_STATE_OPEN);
                }
            } else if (houseStates[house] == HOUSE_STATE_OPEN) {
                houseStates[house] = HOUSE_STATE_CLOSE;
                _stage["house" + house].door.gotoAndStop(HOUSE_STATE_CLOSE);
            }
        }
        function handleThrow(ball) {
            if (_stage.tree1_mc.hitTest(ball._x, ball._y, true)) {
                if (_stage.tree1_mc._currentframe < _stage.tree1_mc._totalframes) {
                    _stage.tree1_mc.nextFrame();
                }
            }
            if (_stage.house1.tree2_mc.hitTest(ball._x, ball._y, true)) {
                if (_stage.house1.tree2_mc._currentframe < _stage.house1.tree2_mc._totalframes) {
                    _stage.house1.tree2_mc.nextFrame();
                }
            }
            if (_stage.tree3_mc.hitTest(ball._x, ball._y, true)) {
                if (_stage.tree3_mc._currentframe < _stage.tree3_mc._totalframes) {
                    _stage.tree3_mc.nextFrame();
                }
            }
        }
        function destroy() {
            clearInterval(_triggerWatcherInterval);
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
        }
        static var CLASS_NAME = "Dock";
        static var HOUSES_AMOUNT = 2;
        static var HOUSE_STATE_PARK = "park";
        static var HOUSE_STATE_OPEN = "open";
        static var HOUSE_STATE_CLOSE = "close";
        var houseVisitors = [false, false, false, false];
        var houseStates = [HOUSE_STATE_PARK, HOUSE_STATE_PARK, HOUSE_STATE_PARK, HOUSE_STATE_PARK];
    }
