    class com.clubpenguin.shell.puffle.PuffleHatVO
    {
        var assetLinkage, hatFrontAsset, hatBackAsset;
        function PuffleHatVO () {
        }
        function getAS2AssetPath() {
            var _local_2 = assetLinkage.indexOf("/") + 1;
            var _local_4 = assetLinkage.indexOf(".");
            var _local_3 = assetLinkage.substring(_local_2, _local_4);
            return(_local_3);
        }
        function setHatFrontAsset() {
            var _local_2 = (getAS2AssetPath() + HAT) + FRONT;
            _local_2 = _local_2.toLowerCase();
            _local_2 = _local_2 + SWF;
            hatFrontAsset = _local_2;
        }
        function setHatBackAsset() {
            var _local_2 = (getAS2AssetPath() + HAT) + BACK;
            _local_2 = _local_2.toLowerCase();
            _local_2 = _local_2 + SWF;
            hatBackAsset = _local_2;
        }
        static function getEmptyHatVO() {
            var _local_1 = new com.clubpenguin.shell.puffle.PuffleHatVO();
            _local_1.id = EMPTY_HAT_ID;
            _local_1.name = "";
            _local_1.label = "";
            _local_1.assetLinkage = "";
            _local_1.hatType = com.clubpenguin.shell.puffle.PuffleHatEnum.EMPTY_HAT;
            return(_local_1);
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
