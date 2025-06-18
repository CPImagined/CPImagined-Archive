//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2014.halloween.Coffin extends com.clubpenguin.world.rooms.school.Locker
    {
        var lockerMC;
        function Coffin (lockerRef) {
            super();
            lockerMC = lockerRef;
        }
        function openLocker() {
            lockerMC.gotoAndPlay(LOCKER_OPEN_FRAME);
        }
        function closeLocker() {
            if (lockerMC._currentFrame != 1) {
                lockerMC.gotoAndPlay(LOCKER_CLOSE_FRAME);
            }
        }
        static var LOCKER_OPEN_FRAME = 10;
        static var LOCKER_CLOSE_FRAME = 30;
    }
