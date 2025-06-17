class com.clubpenguin.world.rooms2015.february.Town extends com.clubpenguin.world.rooms.BaseRoom
{
    var _stage, localize, setupNavigationButtons, _SHELL, _destroyDelegate;
    function Town(stageReference)
    {
        super(stageReference);
        _stage.start_x = 355;
        _stage.start_y = 310;
        this.localize([_stage.background_mc.signs_mc]);
        this.setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.dock_btn, 65, 290), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.coffee_btn, 215, 230), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.dance_btn, 420, 210), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.shop_btn, 545, 230), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.forts_btn, 700, 295), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.seat01_btn, 272, 234), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.seat02_btn, 347, 232)]);
        _stage.background_mc.dock_btn.useHandCursor = false;
        _stage.background_mc.forts_btn.useHandCursor = false;
        _stage.background_mc.seat01_btn.useHandCursor = false;
        _stage.background_mc.seat02_btn.useHandCursor = false;
        _stage.background_mc.coffee_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, coffeeRollOver);
        _stage.background_mc.coffee_btn.onRollOut = com.clubpenguin.util.Delegate.create(this, coffeeRollOut);
        _stage.background_mc.dance_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, danceRollOver);
        _stage.background_mc.dance_btn.onRollOut = com.clubpenguin.util.Delegate.create(this, danceRollOut);
        _stage.background_mc.shop_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, shopRollOver);
        _stage.background_mc.shop_btn.onRollOut = com.clubpenguin.util.Delegate.create(this, shopRollOut);
        _stage.triggers_mc.dock_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "dock", 635, 195);
        _stage.triggers_mc.coffee_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "coffee", 355, 200);
        _stage.triggers_mc.dance_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "dance", 170, 270);
        _stage.triggers_mc.shop_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "shop", 555, 210);
        _stage.triggers_mc.forts_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "forts", 180, 370);
    } // End of the function
    function coffeeRollOver()
    {
        _stage.background_mc.coffee_mc.gotoAndStop("2");
    } // End of the function
    function coffeeRollOut()
    {
        _stage.background_mc.coffee_mc.gotoAndStop("1");
    } // End of the function
    function danceRollOver()
    {
        _stage.background_mc.dance_mc.gotoAndStop("2");
    } // End of the function
    function danceRollOut()
    {
        _stage.background_mc.dance_mc.gotoAndStop("1");
    } // End of the function
    function shopRollOver()
    {
        _stage.background_mc.shop_mc.gotoAndStop("2");
    } // End of the function
    function shopRollOut()
    {
        _stage.background_mc.shop_mc.gotoAndStop("1");
    } // End of the function
    function exit(name, x, y)
    {
        if (_SHELL.isNewPlayerExperienceRunning == false)
        {
            _SHELL.sendJoinRoom(name, x, y);
        } // end if
    } // End of the function
    function init()
    {
        _destroyDelegate = com.clubpenguin.util.Delegate.create(this, destroy);
        _SHELL.addListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
    } // End of the function
    function destroy()
    {
        _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
    } // End of the function
    static var CLASS_NAME = "Town";
} // End of Class
