//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2014.puffles.Dock extends com.clubpenguin.world.rooms.BaseRoom
    {
        var _stage, _SHELL, _destroyDelegate, _triggerWatcher, setupNavigationButtons, localize, _triggerWatcherInterval, _INTERFACE, _ENGINE, _feedStation_meat, _feedStation_carrots, _feedStationTrigger_meat, _feedStationTrigger_carrots;
        function Dock (stageReference) {
            super(stageReference);
            trace(CLASS_NAME + "()");
            _stage.start_x = 320;
            _stage.start_y = 270;
            if (!_SHELL) {
                init();
            }
        }
        function init() {
            trace(CLASS_NAME + ": init()");
            _destroyDelegate = com.clubpenguin.util.Delegate.create(this, destroy);
            _SHELL.addListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            _triggerWatcher = new com.clubpenguin.world.rooms.common.triggers.TriggerWatcher(_stage, _SHELL);
            _stage.triggers_mc.town_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "town", 175, 325);
            _stage.triggers_mc.beach_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "beach", 600, 180);
            _stage.triggers_mc.booth_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, openQuestInterface);
            setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.town_btn, 618, 137), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.beach_btn, 160, 140), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.boothContainer_mc.booth_btn, 410, 295), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.foodmeat_btn, (_global.getCurrentParty().PuffleParty.getIsPuffleTransformWithoutPuffleWalk(_SHELL.getMyPlayerId()) ? 150 : 133), 249), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.foodveggies_btn, (_global.getCurrentParty().PuffleParty.getIsPuffleTransformWithoutPuffleWalk(_SHELL.getMyPlayerId()) ? 650 : 621), (_global.getCurrentParty().PuffleParty.getIsPuffleTransformWithoutPuffleWalk(_SHELL.getMyPlayerId()) ? 295 : 282)), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.ticketbooth_btn, 482, 169), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.dock_mc.boat_btn, 72, 390)]);
            _stage.triggers_mc.hydro_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, launchHydroGame);
            _stage.background_mc.town_btn.useHandCursor = false;
            _stage.background_mc.beach_btn.useHandCursor = false;
            _stage.background_mc.ticketbooth_btn.useHandCursor = false;
            _stage.foodveggies_btn.useHandCursor = false;
            _stage.foodveggies_btn.useHandCursor = false;
            _stage.interface_mc.dock_cat_btn.onRelease = com.clubpenguin.util.Delegate.create(this, showContent, "dock_catalogue");
            _stage.dock_mc.boat_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, showHydroHintRollOver);
            _stage.dock_mc.boat_btn.onRollOut = com.clubpenguin.util.Delegate.create(this, hideHydroHintRollOut);
            localize([_stage.foreground_mc.parktitle_mc]);
            clearInterval(_triggerWatcherInterval);
            _triggerWatcherInterval = setInterval(_triggerWatcher, "checkAllPlayers", 40);
            configureFeedingStationTriggers();
        }
		function openQuestInterface() {
			_INTERFACE.showContent("w.app.p2014.itembooth");
		}
        function showContent(contentID) {
            trace("show contnet");
            _INTERFACE.showContent(contentID);
        }
        function showHydroHintRollOver() {
            trace("show hint");
            _INTERFACE.showHint(_stage.hinthydro_mc, "hydro_hint");
            _stage.dock_mc.boat_mc.boathover_mc.gotoAndStop(2);
        }
        function hideHydroHintRollOut() {
            trace("hide hint");
            _INTERFACE.closeHint();
            _stage.dock_mc.boat_mc.boathover_mc.gotoAndStop(1);
        }
        function launchHydroGame() {
            _ENGINE.sendJoinGame("hydro", true);
        }
        function exit(roomName, x, y) {
            trace(CLASS_NAME + ": exit()");
            _SHELL.sendJoinRoom(roomName, x, y);
        }
        function destroy() {
            trace(CLASS_NAME + ": destroy()");
            clearInterval(_triggerWatcherInterval);
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            _feedStation_meat.cleanStation();
            _feedStation_carrots.cleanStation();
        }
        function updateItemBoothState() {
            trace("updating item booth state in room");
            _global.getCurrentParty().PuffleParty.configureItemBooth(_stage.boothContainer_mc);
        }
        function configureFeedingStationTriggers() {
            trace("FeedingBowl configureFeedingStationTriggers");
            _feedStation_meat = new com.clubpenguin.world.rooms.common.carestations.FeedingBowl(_stage.pufflefeeding_meat);
            _feedStation_carrots = new com.clubpenguin.world.rooms.common.carestations.FeedingBowl(_stage.pufflefeeding_carrots);
            _feedStationTrigger_meat = new com.clubpenguin.world.rooms.common.triggers.PlayerTrigger(_stage.triggers_mc.feedStation_meat_mc);
            _feedStationTrigger_meat.playersAdded.add(com.clubpenguin.util.Delegate.create(_feedStation_meat, _feedStation_meat.beginFeeding));
            _feedStationTrigger_meat.playersRemoved.add(com.clubpenguin.util.Delegate.create(_feedStation_meat, _feedStation_meat.endFeeding));
            _triggerWatcher.addTrigger(_feedStationTrigger_meat);
            _feedStationTrigger_carrots = new com.clubpenguin.world.rooms.common.triggers.PlayerTrigger(_stage.triggers_mc.feedStation_carrot_mc);
            _feedStationTrigger_carrots.playersAdded.add(com.clubpenguin.util.Delegate.create(_feedStation_carrots, _feedStation_carrots.beginFeeding));
            _feedStationTrigger_carrots.playersRemoved.add(com.clubpenguin.util.Delegate.create(_feedStation_carrots, _feedStation_carrots.endFeeding));
            _triggerWatcher.addTrigger(_feedStationTrigger_carrots);
        }
        static var CLASS_NAME = "Dock";
    }
