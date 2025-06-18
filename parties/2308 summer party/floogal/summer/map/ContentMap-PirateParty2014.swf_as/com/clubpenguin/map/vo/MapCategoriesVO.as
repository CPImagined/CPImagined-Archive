dynamic class com.clubpenguin.map.vo.MapCategoriesVO
{
    static var CATEGORY_NONE_ID: Number = 0;
    static var CATEGORY_GAMES_ID: Number = 1;
    static var CATEGORY_PETS_ID: Number = 3;
    static var CATEGORY_SHOPPING_ID: Number = 2;
    static var CATEGORY_PLACES_ID: Number = 4;
    var categories;

    function MapCategoriesVO()
    {
    }

    function MapTriggersVO()
    {
    }

    function initFromObject(obj)
    {
        this.categories = [];
        var __reg2 = 0;
        for (;;) 
        {
            if (__reg2 >= obj.categories.length) 
            {
                return;
            }
            var __reg3 = new com.clubpenguin.map.vo.MapCategoryVO();
            __reg3.initFromObject(obj.categories[__reg2]);
            this.categories.push(__reg3);
            ++__reg2;
        }
    }

    function getCategoryById(id)
    {
        trace("catid: " + id);
        var __reg2 = 0;
        while (__reg2 < this.categories.length) 
        {
            trace([this.categories[__reg2].categoryId, id]);
            if (this.categories[__reg2].categoryId == id) 
            {
                return this.categories[__reg2];
            }
            ++__reg2;
        }
        trace("return null");
        return null;
    }

    function getTriggerByMapId(categoryId, mapId)
    {
        var __reg3 = this.getCategoryById(categoryId);
        if (__reg3 == null) 
        {
            return null;
        }
        var __reg2 = 0;
        while (__reg2 < __reg3.triggers.length) 
        {
            if (__reg3.triggers[__reg2].mapId == mapId) 
            {
                return __reg3.triggers[__reg2];
            }
            ++__reg2;
        }
        return null;
    }

    function getTriggerByTriggerId(categoryId, triggerId)
    {
        var __reg3 = this.getCategoryById(categoryId);
        if (__reg3 == null) 
        {
            return null;
        }
        var __reg2 = 0;
        while (__reg2 < __reg3.triggers.length) 
        {
            if (__reg3.triggers[__reg2].triggerId == triggerId) 
            {
                return __reg3.triggers[__reg2];
            }
            ++__reg2;
        }
        return null;
    }

    function getTriggerByTriggerName(triggerName)
    {
        var __reg4 = 0;
        while (__reg4 < this.categories.length) 
        {
            var __reg3 = this.categories[__reg4];
            var __reg2 = 0;
            while (__reg2 < __reg3.triggers.length) 
            {
                if (__reg3.triggers[__reg2].trigger == triggerName) 
                {
                    return __reg3.triggers[__reg2];
                }
                ++__reg2;
            }
            ++__reg4;
        }
        return null;
    }

}
