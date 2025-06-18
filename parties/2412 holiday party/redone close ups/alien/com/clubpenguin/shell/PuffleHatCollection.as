//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.shell.PuffleHatCollection
    {
        function PuffleHatCollection () {
        }
        static function getInstance() {
            if (_instance == null) {
                _instance = new com.clubpenguin.shell.PuffleHatCollection();
            }
            return(_instance);
        }
        function init(puffleItems) {
            _puffleItems = puffleItems;
            _puffleDictionary = [];
            for (var _local_8 in _puffleItems) {
                var _local_3 = puffleItems[_local_8];
                var _local_4 = _local_3.label;
                var _local_5 = Number(_local_3.puffle_item_id);
                var _local_6 = _local_3.asset;
                var _local_2 = new com.clubpenguin.shell.puffle.PuffleHatVO();
                _local_2.id = _local_5;
                _local_2.name = _local_4;
                _local_2.label = _local_4;
                _local_2.assetLinkage = _local_6;
                _local_2.hatType = com.clubpenguin.shell.puffle.PuffleHatEnum.ACTUAL_HAT;
                _local_2.setHatFrontAsset();
                _local_2.setHatBackAsset();
                if (_local_3.is_member_only != undefined) {
                    _local_2.isMemberOnly = _local_3.is_member_only == 1;
                }
                _puffleDictionary[_local_5] = _local_2;
            }
        }
        function getPuffleHatVO(hat_id) {
            var _local_2 = ((hat_id == NO_HAT_ID) ? (com.clubpenguin.shell.puffle.PuffleHatVO.getEmptyHatVO()) : (_puffleDictionary[hat_id]));
            return(_local_2);
        }
        static var _instance = null;
        static var NO_HAT_ID = 0;
        var _puffleItems = null;
        var _puffleDictionary = null;
    }
