class com.clubpenguin.map.vo.MapTriggerVO
{
    var triggerId, mapId, roomId, label, trigger, x, y, rotation, spawnPoint, categoryId;
    function MapTriggerVO()
    {
    } // End of the function
    function MapTrigger()
    {
    } // End of the function
    function initFromObject(obj)
    {
        triggerId = obj.tid;
        mapId = obj.mapid;
        roomId = obj.roomid;
        label = obj.label;
        trigger = obj.trigger;
        x = obj.x;
        y = obj.y;
        rotation = obj.rotation;
        spawnPoint = obj.spawn;
        categoryId = 0;
    } // End of the function
    function toString()
    {
        return ("[MapTriggerVO] triggerID: " + triggerId + "  mapId: " + mapId + "  label: " + label);
    } // End of the function
} // End of Class
