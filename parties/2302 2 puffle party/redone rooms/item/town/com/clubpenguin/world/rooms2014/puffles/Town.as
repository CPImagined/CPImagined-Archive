//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2014.puffles.Town extends com.clubpenguin.world.rooms.BaseRoom
    {
        var _stage, localize, setupNavigationButtons, _SHELL, _destroyDelegate;
        function Town (stageReference) {
            super(stageReference);
            trace(CLASS_NAME + "()");
            _stage.start_x = 355;
            _stage.start_y = 310;
            localize([_stage.background_mc.signs_mc]);
            _stage.triggers_mc.booth_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, openQuestInterface);
            setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.dock_btn, 80, 285), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.coffee_btn, 265, 225), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.nightclub_mc.clubinside_mc.dance_btn, 390, 215), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.giftshop_mc.giftinside_mc.shop_btn, 530, 240), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.boothContainer_mc.booth_btn, 470, 350), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.forts_btn, 690, 270)]);
            _stage.background_mc.dock_btn.useHandCursor = false;
            _stage.background_mc.forts_btn.useHandCursor = false;
            _stage.boothContainer_mc.ticketbooth_btn.useHandCursor = false;
            _stage.background_mc.dance_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, danceRollOver);
            _stage.background_mc.dance_btn.onRollOut = com.clubpenguin.util.Delegate.create(this, danceRollOut);
            _stage.triggers_mc.dock_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "dock", 570, 165);
            _stage.triggers_mc.coffee_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "coffee", 360, 180);
            _stage.triggers_mc.dance_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "dance", 170, 270);
            _stage.triggers_mc.shop_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "shop", 650, 220);
            _stage.triggers_mc.forts_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "forts", 70, 215);
        }
		function openQuestInterface() {
			_INTERFACE.showContent("w.app.p2014.itembooth");
		}
        function danceRollOver() {
            _stage.danceawning_mc.gotoAndStop(2);
            _stage.background_mc.dancedoor_mc.gotoAndPlay(2);
        }
        function danceRollOut() {
            _stage.danceawning_mc.gotoAndStop(1);
            _stage.background_mc.dancedoor_mc.gotoAndPlay(8);
        }
        function exit(name, x, y) {
            trace(CLASS_NAME + ": exit()");
            if (_SHELL.isNewPlayerExperienceRunning == false) {
                _SHELL.sendJoinRoom(name, x, y);
            }
        }
        function init() {
            trace(CLASS_NAME + ": init()");
            _destroyDelegate = com.clubpenguin.util.Delegate.create(this, destroy);
            _SHELL.addListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
        }
        function destroy() {
            trace(CLASS_NAME + ": destroy()");
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
        }
        function updateItemBoothState() {
            trace("updating item booth state in room");
            _global.getCurrentParty().PuffleParty.configureItemBooth(_stage.boothContainer_mc);
        }
        static var CLASS_NAME = "Town";
    }
