class com.clubpenguin.world.rooms2014.school.Gym extends com.clubpenguin.world.rooms2014.school.SchoolRoom
{
    var _stage, _SHELL, _destroyDelegate, setupNavigationButtons, _checkTargetDelegate;
    function Gym(stageReference)
    {
        super(stageReference);
        trace (com.clubpenguin.world.rooms2014.school.Gym.CLASS_NAME + "()");
        _stage.start_x = 380;
        _stage.start_y = 270;
        if (!_SHELL)
        {
            this.init();
        } // end if
    } // End of the function
    function init()
    {
        trace (com.clubpenguin.world.rooms2014.school.Gym.CLASS_NAME + ": init()");
        _destroyDelegate = com.clubpenguin.util.Delegate.create(this, destroy);
        _SHELL.addListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
        this.configureNavigation();
        this.configureTriggers();
        this.configureSpecialFunctions();
        this.configureSnowballTracking();
        super.configureRoomElements();
    } // End of the function
    function configureNavigation()
    {
        this.setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.exit_btn, 180, 120)]);
    } // End of the function
    function configureTriggers()
    {
        _stage.triggers_mc.exitTrigger_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "school", 400, 150);
    } // End of the function
    function configureSpecialFunctions()
    {
        _stage.exit_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, exitRollOver);
        _stage.exit_btn.onRollOut = com.clubpenguin.util.Delegate.create(this, exitRollOut);
        _stage.exit_btn.onReleaseOutside = com.clubpenguin.util.Delegate.create(this, exitRollOut);
    } // End of the function
    function configureSnowballTracking()
    {
        _checkTargetDelegate = com.clubpenguin.util.Delegate.create(this, onSnowballLand);
        _SHELL.addListener(_SHELL.BALL_LAND, _checkTargetDelegate);
    } // End of the function
    function onSnowballLand(snowballInfo)
    {
        trace ("Gym.onSnowballLand: " + snowballInfo.player_id + " " + _SHELL.getMyPlayerId());
        var _loc2 = snowballInfo.player_id;
        if (_SHELL.getMyPlayerId() == _loc2)
        {
            com.clubpenguin.world.rooms2014.school.SchoolParty.playSound(_stage, "sfx_dodgeball_" + Math.ceil(Math.random() * 3));
            ++_snowballTotal;
        } // end if
    } // End of the function
    function exitRollOver()
    {
        _stage.exit_mc.gotoAndStop(2);
    } // End of the function
    function exitRollOut()
    {
        _stage.exit_mc.gotoAndStop(1);
    } // End of the function
    function exit(roomName, x, y)
    {
        trace (com.clubpenguin.world.rooms2014.school.Gym.CLASS_NAME + ": exit()");
        _SHELL.sendJoinRoom(roomName, x, y);
    } // End of the function
    function destroy()
    {
        trace (com.clubpenguin.world.rooms2014.school.Gym.CLASS_NAME + ": destroy()");
        this.sendSnowballBI();
        _SHELL.removeListener(_SHELL.BALL_LAND, _checkTargetDelegate);
        _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
    } // End of the function
    function sendSnowballBI()
    {
        trace ("Gym.sendSnowballBI: " + _snowballTotal);
        if (_snowballTotal > 0)
        {
            com.clubpenguin.world.rooms2014.school.SchoolParty.sendGymSnowballBI(_snowballTotal);
        } // end if
    } // End of the function
    static var CLASS_NAME = "Gym";
    var _snowballTotal = 0;
} // End of Class
