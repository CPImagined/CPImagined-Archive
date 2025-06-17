class com.clubpenguin.map.vo.MapCategoriesVO
{
    var categories;
    function MapCategoriesVO()
    {
    } // End of the function
    function MapTriggersVO()
    {
    } // End of the function
    function initFromObject(obj)
    {
        categories = [];
        for (var _loc2 = 0; _loc2 < obj.categories.length; ++_loc2)
        {
            var _loc3 = new com.clubpenguin.map.vo.MapCategoryVO();
            _loc3.initFromObject(obj.categories[_loc2]);
            categories.push(_loc3);
        } // end of for
    } // End of the function
    function getCategoryById(id)
    {
        for (var _loc2 = 0; _loc2 < categories.length; ++_loc2)
        {
            if (categories[_loc2].categoryId == id)
            {
                return (categories[_loc2]);
            } // end if
        } // end of for
        return (null);
    } // End of the function
    function getTriggerByMapId(categoryId, mapId)
    {
        var _loc3 = this.getCategoryById(categoryId);
        if (_loc3 == null)
        {
            return (null);
        } // end if
        for (var _loc2 = 0; _loc2 < _loc3.triggers.length; ++_loc2)
        {
            if (_loc3.triggers[_loc2].mapId == mapId)
            {
                return (_loc3.triggers[_loc2]);
            } // end if
        } // end of for
        return (null);
    } // End of the function
    function getTriggerByTriggerId(categoryId, triggerId)
    {
        var _loc3 = this.getCategoryById(categoryId);
        if (_loc3 == null)
        {
            return (null);
        } // end if
        for (var _loc2 = 0; _loc2 < _loc3.triggers.length; ++_loc2)
        {
            if (_loc3.triggers[_loc2].triggerId == triggerId)
            {
                return (_loc3.triggers[_loc2]);
            } // end if
        } // end of for
        return (null);
    } // End of the function
    function getTriggerByTriggerName(triggerName)
    {
        for (var _loc4 = 0; _loc4 < categories.length; ++_loc4)
        {
            var _loc3 = categories[_loc4];
            for (var _loc2 = 0; _loc2 < _loc3.triggers.length; ++_loc2)
            {
                if (_loc3.triggers[_loc2].trigger == triggerName)
                {
                    return (_loc3.triggers[_loc2]);
                } // end if
            } // end of for
        } // end of for
        return (null);
    } // End of the function
    static var CATEGORY_NONE_ID = 0;
    static var CATEGORY_GAMES_ID = 1;
    static var CATEGORY_PETS_ID = 3;
    static var CATEGORY_SHOPPING_ID = 2;
    static var CATEGORY_PLACES_ID = 4;
} // End of Class
