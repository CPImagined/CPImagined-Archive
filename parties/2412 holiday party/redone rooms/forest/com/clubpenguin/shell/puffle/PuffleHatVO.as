//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.shell.puffle.PuffleHatVO
    {
        var assetLinkage, hatFrontAsset, hatBackAsset;
        function PuffleHatVO () {
        }
        function getAS2AssetPath() {
            var startIndex = (assetLinkage.indexOf("/") + 1);
            var endIndex = assetLinkage.indexOf(".");
            var newName = assetLinkage.substring(startIndex, endIndex);
            return(newName);
        }
        function setHatFrontAsset() {
            var frontHat = ((getAS2AssetPath() + HAT) + FRONT);
            frontHat = frontHat.toLowerCase();
            frontHat = frontHat + SWF;
            hatFrontAsset = frontHat;
        }
        function setHatBackAsset() {
            var backHat = ((getAS2AssetPath() + HAT) + BACK);
            backHat = backHat.toLowerCase();
            backHat = backHat + SWF;
            hatBackAsset = backHat;
        }
        static function getEmptyHatVO() {
            var emptyHatVO = (new com.clubpenguin.shell.puffle.PuffleHatVO());
            emptyHatVO.id = EMPTY_HAT_ID;
            emptyHatVO.name = "";
            emptyHatVO.label = "";
            emptyHatVO.assetLinkage = "";
            emptyHatVO.hatType = com.clubpenguin.shell.puffle.PuffleHatEnum.EMPTY_HAT;
            return(emptyHatVO);
        }
        function outputHatVO() {
        }
        static var HAT_DATA_DELIMITER = "@";
        static var EMPTY_HAT_ID = 0;
        static var HAT = "_hat";
        static var FRONT = "_front";
        static var BACK = "_back";
        static var SWF = ".swf";
    }
