//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms.common.skateboard.SkateboardConstants
    {
        function SkateboardConstants () {
        }
        static function isSkateboard(itemID) {
            var _local_1 = 0;
            while (_local_1 < SKATEBOARD_IDS.length) {
                if (SKATEBOARD_IDS[_local_1] == itemID) {
                    return(true);
                }
                _local_1++;
            }
            return(false);
        }
        static function getSkateboardFrame(frameNum) {
            var _local_1 = frameNum;
            switch (frameNum) {
                case 1 : 
                case 16 : 
                    _local_1 = 2;
                    break;
                case 2 : 
                case 9 : 
                    _local_1 = 3;
                    break;
                case 3 : 
                case 10 : 
                    _local_1 = 4;
                    break;
                case 4 : 
                case 11 : 
                    _local_1 = 5;
                    break;
                case 5 : 
                case 12 : 
                    _local_1 = 6;
                    break;
                case 6 : 
                case 13 : 
                    _local_1 = 7;
                    break;
                case 7 : 
                case 14 : 
                    _local_1 = 8;
                    break;
                case 8 : 
                case 15 : 
                    _local_1 = 1;
                    break;
            }
            return(_local_1);
        }
        static var SKATEBOARD_IDS = [5472, 5473, 5474, 5471, 5479];
    }
