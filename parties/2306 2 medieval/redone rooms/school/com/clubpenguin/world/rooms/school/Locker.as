//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms.school.Locker extends MovieClip
    {
        var lockerMC;
        function Locker (lockerRef) {
            super();
            lockerMC = lockerRef;
        }
        function openLocker() {
            lockerMC.gotoAndPlay(LOCKER_OPEN_FRAME);
        }
        function closeLocker() {
            if (lockerMC._currentFrame == (LOCKER_CLOSE_FRAME - 1)) {
                lockerMC.gotoAndPlay(LOCKER_CLOSE_FRAME);
            }
        }
        static var LOCKER_OPEN_FRAME = 2;
        static var LOCKER_CLOSE_FRAME = 11;
    }
