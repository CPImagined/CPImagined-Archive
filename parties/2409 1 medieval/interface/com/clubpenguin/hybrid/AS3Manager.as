//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.hybrid.AS3Manager
    {
        function AS3Manager () {
        }
        static function isUnderAS3() {
            return(isRunningUnderAS3);
        }
        static function isUnderAS2() {
            return(isRunningUnderAS2);
        }
        static var isRunningUnderAS3 = ((_level0 == undefined) ? true : false);
        static var isRunningUnderAS2 = ((_level0 == undefined) ? false : true);
    }
