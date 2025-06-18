//Created by Action Script Viewer - https://www.buraks.com/asv
    class as_files.Dock extends as_files.ScavengerHuntRoom
    {
        var _stage, _destroyDelegate, _SHELL, _triggerWatcher, localize, setupNavigationButtons, _INTERFACE, _ENGINE, _triggerWatcherInterval;
        function Dock (stageReference) {
            super(stageReference);
            _stage.start_x = 475;
            _stage.start_y = 260;
        }
        function init() {
            _destroyDelegate = com.clubpenguin.util.Delegate.create(this, destroy);
            _SHELL.addListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            _triggerWatcher = new com.clubpenguin.world.rooms.common.triggers.TriggerWatcher(_stage, _SHELL);
            localize([_stage.adoptContainer_mc]);
            setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.beach_btn, 165, 155), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.village_btn, 305, 145), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.town_btn, 600, 155), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.boat_btn, 75, 380), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.throne_btn, 69, 174)]);
            _stage.beach_btn.useHandCursor = false;
            _stage.village_btn.useHandCursor = false;
            _stage.town_btn.useHandCursor = false;
            _stage.throne_btn.useHandCursor = false;
            _stage.interface_mc.dock_cat_btn.onRelease = com.clubpenguin.util.Delegate.create(this, showContent, "dock_catalogue");
            _stage.boat_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, showHydroHintRollOver);
            _stage.boat_btn.onRollOut = com.clubpenguin.util.Delegate.create(this, hideHydroHintRollOut);
            _stage.boat_btn.onReleaseOutside = com.clubpenguin.util.Delegate.create(this, hideHydroHintRollOut);
            _stage.adopt_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, ghostPuffleRollOver);
            _stage.adopt_btn.onRollOut = com.clubpenguin.util.Delegate.create(this, ghostPuffleRollOut);
            _stage.adopt_btn.onReleaseOutside = com.clubpenguin.util.Delegate.create(this, ghostPuffleRollOut);
            _stage.adopt_btn.onRelease = com.clubpenguin.util.Delegate.create(this, ghostPuffleReleaseHandler);
            _stage.triggers_mc.beach_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "beach", 595, 180);
            _stage.triggers_mc.village_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "village", 670, 365);
            _stage.triggers_mc.town_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "town", 110, 345);
            _stage.triggers_mc.hydro_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, launchHydroGame);
        }
        function showContent(contentID) {
            _INTERFACE.showContent(contentID);
        }
        function ghostPuffleRollOver() {
            _stage.adoptContainer_mc.adopt_mc.gotoAndStop(2);
        }
        function ghostPuffleRollOut() {
            _stage.adoptContainer_mc.adopt_mc.gotoAndStop(1);
        }
        function ghostPuffleReleaseHandler() {
            _INTERFACE.showContent("puffle_adoption", null, null, {puffleAdoptionType:1022}, true);
        }
        function showHydroHintRollOver() {
            _INTERFACE.showHint(_stage.hinthydro_mc, "hydro_hint");
            _stage.boatContainer_mc.boat_mc.boathover_mc.gotoAndStop(2);
        }
        function hideHydroHintRollOut() {
            _INTERFACE.closeHint();
            _stage.boatContainer_mc.boat_mc.boathover_mc.gotoAndStop(1);
        }
        function launchHydroGame() {
            _ENGINE.sendJoinGame("hydro", true);
        }
        function exit(roomName, x, y) {
            _SHELL.sendJoinRoom(roomName, x, y);
        }
        function destroy() {
            clearInterval(_triggerWatcherInterval);
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
        }
        static var CLASS_NAME = "Dock";
        var robotVisible = false;
        var robotDefeated = false;
        var playerHasScareItem = false;
        static var QUEST_TASK_ID = 1;
    }
