//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2015.may.Dock extends com.clubpenguin.world.rooms.BaseRoom
    {
        var _stage, localize, setupNavigationButtons, _INTERFACE, _ENGINE, _SHELL, _destroyDelegate;
        function Dock (stageReference) {
            super(stageReference);
            _stage.start_x = 380;
            _stage.start_y = 220;
            localize([]);
            setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.beach_btn, 180, 145), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.village_btn, 340, 145), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.town_btn, 685, 165), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.dock_mc.boat_btn, 110, 320), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.fair_btn, 740, 300)]);
            _stage.background_mc.beach_btn.useHandCursor = false;
            _stage.background_mc.village_btn.useHandCursor = false;
            _stage.background_mc.town_btn.useHandCursor = false;
            _stage.background_mc.fair_btn.useHandCursor = false;
            _stage.tubes_mc.tubes_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, tubesAnimate);
            _stage.tubes_mc.tubes_btn.useHandCursor = false;
            _stage.interface_mc.dock_cat_btn.onRelease = com.clubpenguin.util.Delegate.create(this, showContent, "dock_catalogue");
            _stage.hydrocatalog_mc.hydrocatalog_btn.onRelease = com.clubpenguin.util.Delegate.create(this, showContent, "dock_catalogue");
            _stage.dock_mc.boat_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, showHydroHintRollOver);
            _stage.dock_mc.boat_btn.onRollOut = com.clubpenguin.util.Delegate.create(this, hideHydroHintRollOut);
            _stage.triggers_mc.beach_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "beach", 565, 205);
            _stage.triggers_mc.village_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "village", 665, 350);
            _stage.triggers_mc.town_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "town", 95, 320);
            _stage.triggers_mc.fair_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "party1", 320, 377);
            _stage.triggers_mc.hydro_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, launchHydroGame);
        }
        function tubesAnimate() {
            _stage.tubes_mc.gotoAndPlay(2);
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
        function init() {
            _destroyDelegate = com.clubpenguin.util.Delegate.create(this, destroy);
            _SHELL.addListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
        }
        function destroy() {
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
        }
        static var CLASS_NAME = "Dock";
    }
