class com.clubpenguin.world.rooms2012.smoothie.Coffee extends com.clubpenguin.world.rooms.BaseRoom
{
    var _stage, localize, _destroyDelegate, _SHELL, setupNavigationButtons, _opcodeJournal, _ENGINE, _INTERFACE, _triggerWatcherInterval;
    function Coffee(stageReference)
    {
        super(stageReference);
        _stage.start_x = 355;
        _stage.start_y = 235;
    } // End of the function
    function init()
    {
        this.localize([_stage.background_mc.stair_mc.timesTitle_mc, _stage.smoothieSign_mc.smoothieSign2_mc]);
        _destroyDelegate = com.clubpenguin.util.Delegate.create(this, destroy);
        _SHELL.addListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
        this.setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.stair_mc.stair_mc.stair_btn, 655, 255), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.smoothie_mc.smoothiestand_mc.smoothie_btn, 68, 325), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.door_btn, 355, 150), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.bean_mc.bean_mc.bean_btn, 690, 325), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.foreground_mc.cafeButton, 675, 385)]);
        _stage.bean_mc.bean_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, showBeansHint);
        _stage.bean_mc.bean_btn.onRollOut = com.clubpenguin.util.Delegate.create(this, hideBeansHint);
        _stage.smoothiestand_mc.smoothie_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, showSmoothieHint);
        _stage.smoothiestand_mc.smoothie_btn.onRollOut = com.clubpenguin.util.Delegate.create(this, hideSmoothieHint);
        _stage.triggers_mc.town_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "town", 290, 260);
        _stage.triggers_mc.book_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "book", 600, 290);
        _stage.triggers_mc.coffeeyard_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "coffeeyard", 600, 290);
        _stage.triggers_mc.smoothieGame_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, launchSmoothieGame);
        _opcodeJournal = new com.clubpenguin.world.rooms2012.smoothie.OpcodeJournal();
        _opcodeJournal.init(_SHELL.getMyPlayerId());
    } // End of the function
    function launchSmoothieGame()
    {
        _opcodeJournal.sendOpcode(com.clubpenguin.world.rooms2012.smoothie.OpcodeJournal.PLAY_SMOOTHIE_SMASH);
        _ENGINE.sendJoinGame("smoothie", true);
    } // End of the function
    function showSmoothieHint()
    {
        _INTERFACE.showHint(_stage.smoothie_mc.smoothie_counter, "smoothie_hint");
        _stage.smoothie_mc.fruitDance_mc.gotoAndStop(2);
    } // End of the function
    function hideSmoothieHint()
    {
        _INTERFACE.closeHint();
        _stage.smoothie_mc.fruitDance_mc.gotoAndStop(1);
    } // End of the function
    function launchBeanGame()
    {
        _ENGINE.sendJoinGame("beans", true);
    } // End of the function
    function showBeansHint()
    {
        _INTERFACE.showHint(_stage.bean_mc.bean_mc.bean_btn, "beans_hint");
    } // End of the function
    function hideBeansHint()
    {
        _INTERFACE.closeHint();
    } // End of the function
    function exit(roomName, x, y)
    {
        _SHELL.sendJoinRoom(roomName, x, y);
    } // End of the function
    function destroy()
    {
        clearInterval(_triggerWatcherInterval);
        _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
        false;
    } // End of the function
    static var CLASS_NAME = "Coffee";
} // End of Class
