class com.clubpenguin.map.vo.MapCategoryVO
{
    var categoryId, name, triggers;
    function MapCategoryVO()
    {
    } // End of the function
    function initFromObject(obj)
    {
        categoryId = obj.catid;
        name = obj.name;
        var _loc6 = -1;
        triggers = [];
        for (var _loc2 = 0; _loc2 < obj.items.length; ++_loc2)
        {
            var _loc4 = obj.items[_loc2];
            if (_loc6 == _loc4.mapid)
            {
                continue;
            } // end if
            _loc6 = _loc4.mapid;
            var _loc3 = new com.clubpenguin.map.vo.MapTriggerVO();
            _loc3.initFromObject(obj.items[_loc2]);
            _loc3.categoryId = categoryId;
            triggers.push(_loc3);
        } // end of for
    } // End of the function
} // End of Class
