class com.clubpenguin.world.rooms2014.school.Classroom extends com.clubpenguin.world.rooms2014.school.SchoolRoom
{
    var _stage, _SHELL, _destroyDelegate, _triggerWatcher, _triggerWatcherInterval, setupNavigationButtons, _checkTargetDelegate, _roomUpdateInterval;
    function Classroom(stageReference)
    {
        super(stageReference);
        trace (com.clubpenguin.world.rooms2014.school.Classroom.CLASS_NAME + "()");
        _stage.start_x = 370;
        _stage.start_y = 300;
        if (!_SHELL)
        {
            this.init();
        } // end if
    } // End of the function
    function init()
    {
        trace (com.clubpenguin.world.rooms2014.school.Classroom.CLASS_NAME + ": init()");
        _destroyDelegate = com.clubpenguin.util.Delegate.create(this, destroy);
        _SHELL.addListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
        _triggerWatcher = new com.clubpenguin.world.rooms.common.triggers.TriggerWatcher(_stage, _SHELL);
        this.configureNavigation();
        this.configureTriggers();
        this.configureSnowballTracking();
        clearInterval(_triggerWatcherInterval);
        _triggerWatcherInterval = setInterval(_triggerWatcher, "checkAllPlayers", 40);
        super.configureRoomElements();
    } // End of the function
    function configureTriggers()
    {
        _stage.triggers_mc.school_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "school", 610, 190);
    } // End of the function
    function configureNavigation()
    {
        trace ("Classroom.configureNavigation");
        this.setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.schoolDoor_btn, 38, 100)]);
    } // End of the function
    function configureSnowballTracking()
    {
        _checkTargetDelegate = com.clubpenguin.util.Delegate.create(this, onSnowballLand);
        _SHELL.addListener(_SHELL.BALL_LAND, _checkTargetDelegate);
    } // End of the function
    function onSnowballLand(snowballInfo)
    {
        var _loc3 = snowballInfo.player_id;
        if (_SHELL.getMyPlayerId() == _loc3)
        {
            var _loc2 = _SHELL.getMyPlayerObject();
            if (_loc2.x > 330)
            {
                com.clubpenguin.world.rooms2014.school.SchoolParty.playSound(_stage, "sfx_paper_" + Math.ceil(Math.random() * 3));
                ++_snowballScienceTotal;
            }
            else
            {
                com.clubpenguin.world.rooms2014.school.SchoolParty.playSound(_stage, "sfx_paint_" + Math.ceil(Math.random() * 3));
                ++_snowballPaintTotal;
            } // end if
        } // end else if
    } // End of the function
    function exit(roomName, x, y)
    {
        trace (com.clubpenguin.world.rooms2014.school.Classroom.CLASS_NAME + ": exit()");
        _SHELL.sendJoinRoom(roomName, x, y);
    } // End of the function
    function destroy()
    {
        trace (com.clubpenguin.world.rooms2014.school.Classroom.CLASS_NAME + ": destroy()");
        this.sendSnowballBI();
        clearInterval(_roomUpdateInterval);
        _SHELL.removeListener(_SHELL.BALL_LAND, _checkTargetDelegate);
        _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
    } // End of the function
    function sendSnowballBI()
    {
        if (_snowballPaintTotal > 0)
        {
            com.clubpenguin.world.rooms2014.school.SchoolParty.sendClassroomSnowballBI(SNOWBALL_TYPE_PAINT, _snowballPaintTotal);
        } // end if
        if (_snowballScienceTotal > 0)
        {
            com.clubpenguin.world.rooms2014.school.SchoolParty.sendClassroomSnowballBI(SNOWBALL_TYPE_SCIENCE, _snowballScienceTotal);
        } // end if
    } // End of the function
    static var CLASS_NAME = "Classroom";
    var SNOWBALL_TYPE_PAINT = "paint";
    var SNOWBALL_TYPE_SCIENCE = "science";
    var _snowballPaintTotal = 0;
    var _snowballScienceTotal = 0;
} // End of Class
