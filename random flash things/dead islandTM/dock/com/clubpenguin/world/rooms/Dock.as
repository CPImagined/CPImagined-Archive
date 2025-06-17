class com.clubpenguin.world.rooms.Dock extends com.clubpenguin.world.rooms.BaseRoom
{
    var _stage, localize, setupNavigationButtons, _INTERFACE, _ENGINE, _SHELL, _destroyDelegate;
    function Dock(stageReference)
    {
        super(stageReference);
        trace (com.clubpenguin.world.rooms.Dock.CLASS_NAME + "()");
        _stage.start_x = 380;
        _stage.start_y = 220;
        this.localize([]);
        this.setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.beach_btn, 180, 145), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.village_btn, 340, 145), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.town_btn, 685, 165), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.dock_mc.boat_btn, 110, 320)]);
        _stage.background_mc.beach_btn.useHandCursor = false;
        _stage.background_mc.village_btn.useHandCursor = false;
        _stage.background_mc.town_btn.useHandCursor = false;
        _stage.tubes_mc.tubes_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, tubesAnimate);
        _stage.tubes_mc.tubes_btn.useHandCursor = false;
        _stage.interface_mc.dock_cat_btn.onRelease = com.clubpenguin.util.Delegate.create(this, showContent, "dock_catalogue");
        _stage.hydrocatalog_mc.hydrocatalog_btn.onRelease = com.clubpenguin.util.Delegate.create(this, showContent, "dock_catalogue");
        _stage.dock_mc.boat_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, showHydroHintRollOver);
        _stage.dock_mc.boat_btn.onRollOut = com.clubpenguin.util.Delegate.create(this, hideHydroHintRollOut);
        _stage.triggers_mc.beach_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "beach", 565, 205);
        _stage.triggers_mc.village_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "village", 665, 350);
        _stage.triggers_mc.town_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "town", 95, 320);
        _stage.triggers_mc.hydro_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, launchHydroGame);
    } // End of the function
    function tubesAnimate()
    {
        _stage.tubes_mc.gotoAndPlay(2);
    } // End of the function
    function showContent(contentID)
    {
        trace ("show contnet");
        _INTERFACE.showContent(contentID);
    } // End of the function
    function showHydroHintRollOver()
    {
        trace ("show hint");
        _INTERFACE.showHint(_stage.hinthydro_mc, "hydro_hint");
        _stage.dock_mc.boat_mc.boathover_mc.gotoAndStop(2);
    } // End of the function
    function hideHydroHintRollOut()
    {
        trace ("hide hint");
        _INTERFACE.closeHint();
        _stage.dock_mc.boat_mc.boathover_mc.gotoAndStop(1);
    } // End of the function
    function launchHydroGame()
    {
        _ENGINE.sendJoinGame("hydro", true);
    } // End of the function
    function exit(name, x, y)
    {
        trace (com.clubpenguin.world.rooms.Dock.CLASS_NAME + ": exit()");
        _SHELL.sendJoinRoom(name, x, y);
    } // End of the function
    function init()
    {
        trace (com.clubpenguin.world.rooms.Dock.CLASS_NAME + ": init()");
        _destroyDelegate = com.clubpenguin.util.Delegate.create(this, destroy);
        _SHELL.addListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
    } // End of the function
    function destroy()
    {
        trace (com.clubpenguin.world.rooms.Dock.CLASS_NAME + ": destroy()");
        _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
    } // End of the function
    static var CLASS_NAME = "Dock";
} // End of Class
