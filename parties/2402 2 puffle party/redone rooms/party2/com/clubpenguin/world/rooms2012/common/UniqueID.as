//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2012.common.UniqueID
    {
        function UniqueID () {
        }
        static function getID(prefix) {
            count++;
            if (!prefix) {
                return("uid" + count.toString());
            }
            return(prefix + count.toString());
        }
        static var count = 0;
    }
