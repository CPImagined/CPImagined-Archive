//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2014.pirate.Dock extends com.clubpenguin.world.rooms.BaseRoom
    {
        var _stage, localize, setupNavigationButtons, _INTERFACE, _ENGINE, _SHELL, _destroyDelegate;
        function Dock (stageReference) {
            super(stageReference);
            _stage.start_x = 380;
            _stage.start_y = 220;
            localize([]);
            setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.navBeach, 125, 174), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.navVillage, 385, 152), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.navTown, 639, 187), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.navBoat, 109, 315), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.treasure_mc, 328, 386), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.seat1, 218, 175), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.seat2, 257, 170), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.seat3, 301, 163), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.seat4, 350, 160), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.seat5, 257, 235), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.seat6, 363, 272), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.seat7, 420, 265), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.seat8, 550, 230), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.seat9, 463, 311), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.seat10, 515, 296), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.seat11, 639, 273)]);
            _stage.navBeach.useHandCursor = false;
            _stage.navVillage.useHandCursor = false;
            _stage.navTown.useHandCursor = false;
            _stage.seat1.useHandCursor = false;
            _stage.seat2.useHandCursor = false;
            _stage.seat3.useHandCursor = false;
            _stage.seat4.useHandCursor = false;
            _stage.seat5.useHandCursor = false;
            _stage.seat6.useHandCursor = false;
            _stage.seat7.useHandCursor = false;
            _stage.seat8.useHandCursor = false;
            _stage.seat9.useHandCursor = false;
            _stage.seat10.useHandCursor = false;
            _stage.seat11.useHandCursor = false;
            _stage.interface_mc.dock_cat_btn.onRelease = com.clubpenguin.util.Delegate.create(this, showContent, "dock_catalogue");
            _stage.hydrocatalog_mc.hydrocatalog_btn.onRelease = com.clubpenguin.util.Delegate.create(this, showContent, "dock_catalogue");
            _stage.navBoat.onRollOver = com.clubpenguin.util.Delegate.create(this, showHydroHintRollOver);
            _stage.navBoat.onRollOut = com.clubpenguin.util.Delegate.create(this, hideHydroHintRollOut);
            _stage.triggers_mc.beach_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "beach", 565, 205);
            _stage.triggers_mc.village_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "village", 665, 350);
            _stage.triggers_mc.town_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "town", 95, 320);
            _stage.triggers_mc.hydro_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, launchHydroGame);
            _global.getCurrentParty().PirateParty.configureTreasureChestState(_stage.chest_mc, _stage.crabs_mc, _stage.treasure_btn);
        }
        function initializePartyCookieDependentAssets() {
            _global.getCurrentParty().PirateParty.configureTreasureChestState(_stage.chest_mc, _stage.crabs_mc, _stage.treasure_btn);
        }
        function showContent(contentID) {
            _INTERFACE.showContent(contentID);
        }
        function showHydroHintRollOver() {
            _INTERFACE.showHint(_stage.hinthydro_mc, "hydro_hint");
            _stage.boat_mc.gameShip.gotoAndStop(2);
        }
        function hideHydroHintRollOut() {
            _INTERFACE.closeHint();
            _stage.boat_mc.gameShip.gotoAndStop(1);
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
