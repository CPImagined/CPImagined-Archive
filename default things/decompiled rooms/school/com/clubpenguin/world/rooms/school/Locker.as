//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms.school.Locker extends MovieClip
    {
        var lockerMC;
        function Locker (lockerRef) {
            super();
            lockerMC = lockerRef;
        }
        function openLocker(player_id) {
            if (player_id == _global.getCurrentShell().getMyPlayerId()) {
                var _local_3 = new Sound(lockerMC);
                _local_3.attachSound("sfx_LockerOpen");
                _local_3.start();
            }
            lockerMC.gotoAndPlay(LOCKER_OPEN_FRAME);
        }
        function closeLocker(player_id) {
            if (lockerMC._currentFrame == (LOCKER_CLOSE_FRAME - 1)) {
                if (player_id == _global.getCurrentShell().getMyPlayerId()) {
                    var _local_3 = new Sound(lockerMC);
                    _local_3.attachSound("sfx_LockerClose");
                    _local_3.start();
                }
                lockerMC.gotoAndPlay(LOCKER_CLOSE_FRAME);
            }
        }
        static var LOCKER_OPEN_FRAME = 2;
        static var LOCKER_CLOSE_FRAME = 11;
    }
