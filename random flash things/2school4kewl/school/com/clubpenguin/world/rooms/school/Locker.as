class com.clubpenguin.world.rooms.school.Locker extends MovieClip
{
    var lockerMC;
    function Locker(lockerRef)
    {
        super();
        lockerMC = lockerRef;
    } // End of the function
    function openLocker(player_id)
    {
        if (player_id == _global.getCurrentShell().getMyPlayerId())
        {
            var _loc3 = new Sound(lockerMC);
            _loc3.attachSound("sfx_LockerOpen");
            _loc3.start();
        } // end if
        lockerMC.gotoAndPlay(com.clubpenguin.world.rooms.school.Locker.LOCKER_OPEN_FRAME);
    } // End of the function
    function closeLocker(player_id)
    {
        if (lockerMC._currentFrame == com.clubpenguin.world.rooms.school.Locker.LOCKER_CLOSE_FRAME - 1)
        {
            if (player_id == _global.getCurrentShell().getMyPlayerId())
            {
                var _loc3 = new Sound(lockerMC);
                _loc3.attachSound("sfx_LockerClose");
                _loc3.start();
            } // end if
            lockerMC.gotoAndPlay(com.clubpenguin.world.rooms.school.Locker.LOCKER_CLOSE_FRAME);
        } // end if
    } // End of the function
    static var LOCKER_OPEN_FRAME = 2;
    static var LOCKER_CLOSE_FRAME = 11;
} // End of Class
