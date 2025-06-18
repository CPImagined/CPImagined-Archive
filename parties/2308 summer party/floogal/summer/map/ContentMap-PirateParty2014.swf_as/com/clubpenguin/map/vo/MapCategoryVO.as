dynamic class com.clubpenguin.map.vo.MapCategoryVO
{
    var categoryId;
    var name;
    var triggers;

    function MapCategoryVO()
    {
    }

    function initFromObject(obj)
    {
        this.categoryId = obj.catid;
        this.name = obj.name;
        var __reg6 = -1;
        this.triggers = [];
        var __reg2 = 0;
        for (;;) 
        {
            if (__reg2 >= obj.items.length) 
            {
                return;
            }
            var __reg4 = obj.items[__reg2];
            if (__reg6 != __reg4.mapid) 
            {
                __reg6 = __reg4.mapid;
                var __reg3 = new com.clubpenguin.map.vo.MapTriggerVO();
                __reg3.initFromObject(obj.items[__reg2]);
                __reg3.categoryId = this.categoryId;
                this.triggers.push(__reg3);
            }
            ++__reg2;
        }
    }

}
