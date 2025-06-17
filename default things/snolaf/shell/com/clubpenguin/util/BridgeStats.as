//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.util.BridgeStats
    {
        function BridgeStats () {
        }
        static function getTimestamp() {
            var _local_1 = new Date();
            return(_local_1.valueOf());
        }
        static var sendCount = 0;
    }
