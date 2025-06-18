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
        function updatePuffleState(puffleState) {
            _puffleState = puffleState;
        }
        function getPuffleState() {
            return(_puffleState);
        }
        function getFormattedAssetURL(assetURL) {
            return(formatAssetURL(assetURL, color, subTypeID));
        }
        function isWildPuffle() {
            return((((subTypeID != null) && (subTypeID != undefined)) && (subTypeID != -1)) && (!isNaN(subTypeID)));
        }
        static function formatAssetURL(assetURL, puffleColor, puffleSubTypeID) {
            var _local_2 = ((isNaN(puffleSubTypeID) || (puffleSubTypeID == 0)) ? "" : (String(puffleSubTypeID)));
            assetURL = com.clubpenguin.util.StringUtils.replaceString("%color%", String(puffleColor), assetURL);
            assetURL = com.clubpenguin.util.StringUtils.replaceString("%wildTypeId%", String(_local_2), assetURL);
            return(assetURL);
        }
        var id = -1;
        var typeID = -1;
        var subTypeID = -1;
        var name = "";
        var _puffleState = 0;
    }
