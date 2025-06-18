dynamic class com.clubpenguin.world.rooms.school.Locker extends MovieClip
{
    static var LOCKER_OPEN_FRAME: Number = 2;
    static var LOCKER_CLOSE_FRAME: Number = 11;
    var lockerMC;

    function Locker(lockerRef)
    {
        super();
        this.lockerMC = lockerRef;
    }

    function openLocker(player_id)
    {
        if (player_id == _global.getCurrentShell().getMyPlayerId()) 
        {
            var __reg3 = new Sound(this.lockerMC);
            __reg3.attachSound("sfx_LockerOpen");
            __reg3.start();
        }
        this.lockerMC.gotoAndPlay(com.clubpenguin.world.rooms.school.Locker.LOCKER_OPEN_FRAME);
    }

    function closeLocker(player_id)
    {
        if (this.lockerMC._currentFrame == com.clubpenguin.world.rooms.school.Locker.LOCKER_CLOSE_FRAME - 1) 
        {
            if (player_id == _global.getCurrentShell().getMyPlayerId()) 
            {
                var __reg3 = new Sound(this.lockerMC);
                __reg3.attachSound("sfx_LockerClose");
                __reg3.start();
            }
            this.lockerMC.gotoAndPlay(com.clubpenguin.world.rooms.school.Locker.LOCKER_CLOSE_FRAME);
        }
    }

}
