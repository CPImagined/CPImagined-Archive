//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.shell.PuffleModel
    {
        var mood, hat, stats, color;
        function PuffleModel () {
            mood = new com.clubpenguin.shell.PuffleMoodVO();
            hat = new com.clubpenguin.shell.puffle.PuffleHatVO();
            stats = new com.clubpenguin.shell.PuffleStatsVO();
        }
        function hasHat() {
            return(((hat.hatType == com.clubpenguin.shell.puffle.PuffleHatEnum.ACTUAL_HAT) ? true : false));
        }
        function updateStats() {
        }
        function updatePuffleState(_arg_2) {
            _puffleState = _arg_2;
        }
        function getPuffleState() {
            return(_puffleState);
        }
        function getFormattedAssetURL(_arg_2) {
            return(formatAssetURL(_arg_2, color, subTypeID));
        }
        function isWildPuffle() {
            return((((subTypeID != null) && (subTypeID != undefined)) && (subTypeID != -1)) && (!isNaN(subTypeID)));
        }
        static function formatAssetURL(_arg_1, _arg_4, _arg_3) {
            var _local_2 = ((isNaN(_arg_3) || (_arg_3 == 0)) ? "" : (String(_arg_3)));
            _arg_1 = com.clubpenguin.util.StringUtils.replaceString("%color%", String(_arg_4), _arg_1);
            _arg_1 = com.clubpenguin.util.StringUtils.replaceString("%wildTypeId%", String(_local_2), _arg_1);
            return(_arg_1);
        }
        var id = -1;
        var typeID = -1;
        var subTypeID = -1;
        var name = "";
        var _puffleState = 0;
    }
