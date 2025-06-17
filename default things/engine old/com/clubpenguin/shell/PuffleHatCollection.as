class com.clubpenguin.shell.PuffleHatCollection
{
    function PuffleHatCollection()
    {
    } // End of the function
    static function getInstance()
    {
        if (com.clubpenguin.shell.PuffleHatCollection._instance == null)
        {
            _instance = new com.clubpenguin.shell.PuffleHatCollection();
        } // end if
        return (com.clubpenguin.shell.PuffleHatCollection._instance);
    } // End of the function
    function init(puffleItems)
    {
        _puffleItems = puffleItems;
        _puffleDictionary = [];
        for (var _loc8 in _puffleItems)
        {
            var _loc3 = puffleItems[_loc8];
            var _loc4 = _loc3.label;
            var _loc5 = Number(_loc3.puffle_item_id);
            var _loc6 = _loc3.asset;
            var _loc2 = new com.clubpenguin.shell.puffle.PuffleHatVO();
            _loc2.id = _loc5;
            _loc2.name = _loc4;
            _loc2.label = _loc4;
            _loc2.assetLinkage = _loc6;
            _loc2.hatType = com.clubpenguin.shell.puffle.PuffleHatEnum.ACTUAL_HAT;
            _loc2.setHatFrontAsset();
            _loc2.setHatBackAsset();
            if (_loc3.is_member_only != undefined)
            {
                _loc2.isMemberOnly = _loc3.is_member_only == 1;
            } // end if
            _puffleDictionary[_loc5] = _loc2;
        } // end of for...in
    } // End of the function
    function getPuffleHatVO(hat_id)
    {
        var _loc2 = hat_id == com.clubpenguin.shell.PuffleHatCollection.NO_HAT_ID ? (com.clubpenguin.shell.puffle.PuffleHatVO.getEmptyHatVO()) : (_puffleDictionary[hat_id]);
        return (_loc2);
    } // End of the function
    static var _instance = null;
    static var NO_HAT_ID = 0;
    var _puffleItems = null;
    var _puffleDictionary = null;
} // End of Class
