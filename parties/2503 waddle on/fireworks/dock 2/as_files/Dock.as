//Created by Action Script Viewer - https://www.buraks.com/asv
    class as_files.Dock extends com.clubpenguin.world.rooms.BaseRoom
    {
        var _stage, localize, setupNavigationButtons, _INTERFACE, _ENGINE, _SHELL, _destroyDelegate;
        function Dock (stageReference) {
            super(stageReference);
            trace(CLASS_NAME + "()");
            _stage.start_x = 400;
            _stage.start_y = 280;
            localize([_stage.music_mc.musicSign_mc.musiclang_mc, _stage.background_mc.casa_mc.building_mc.casa_text_mc, _stage.background_mc.casa_mc.building_mc.casa_shadow_mc, _stage.background_mc.casa_mc.building_mc.casa_shadow_2_mc]);
            setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.beach_btn, 140, 130), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.village_btn, 230, 130), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.town_btn, 660, 130), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.casa_btn, 445, 166), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.light_mc.party1_btn, 150, 340), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.dock_mc.boat_btn, 590, 410)]);
            _stage.background_mc.beach_btn.useHandCursor = false;
            _stage.background_mc.village_btn.useHandCursor = false;
            _stage.background_mc.town_btn.useHandCursor = false;
            _stage.background_mc.party1_btn.useHandCursor = false;
            _stage.tubes_mc.tubes_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, tubesAnimate);
            _stage.tubes_mc.tubes_btn.useHandCursor = false;
            _stage.background_mc.casa_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, casaRollOver);
            _stage.background_mc.casa_btn.onRollOut = com.clubpenguin.util.Delegate.create(this, casaRollOut);
            _stage.background_mc.casa_btn.onReleaseOutside = com.clubpenguin.util.Delegate.create(this, casaRollOut);
            _stage.interface_mc.dock_cat_btn.onRelease = com.clubpenguin.util.Delegate.create(this, showContent, "dock_catalogue");
            _stage.hydrocatalog_mc.hydrocatalog_btn.onRelease = com.clubpenguin.util.Delegate.create(this, showContent, "dock_catalogue");
            _stage.dock_mc.boat_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, showHydroHintRollOver);
            _stage.dock_mc.boat_btn.onRollOut = com.clubpenguin.util.Delegate.create(this, hideHydroHintRollOut);
            _stage.triggers_mc.beach_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "beach", 565, 205);
            _stage.triggers_mc.village_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "village", 665, 350);
            _stage.triggers_mc.town_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "town", 85, 260);
            _stage.triggers_mc.party1_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "party18", 370, 370);
            _stage.triggers_mc.town_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "town", 95, 320);
            _stage.triggers_mc.casa_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "party24", 380, 142);
			_stage.triggers_mc.fair_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "party1", 320, 377);
            _stage.triggers_mc.hydro_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, launchHydroGame);
        }
        function casaRollOver() {
            _stage.background_mc.casaDoor_mc.gotoAndStop("open");
        }
        function casaRollOut() {
            _stage.background_mc.casaDoor_mc.gotoAndStop("close");
        }
        function tubesAnimate() {
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
            trace(CLASS_NAME + ": exit()");
            _SHELL.sendJoinRoom(name, x, y);
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
        static var CLASS_NAME = "Dock";
    }
