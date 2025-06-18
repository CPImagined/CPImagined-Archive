//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.util.DateUtils
    {
        function DateUtils () {
        }
        static function getMonthLangKey(month) {
            return(MONTHS[month]);
        }
        static var MONTHS = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];
    }
