dynamic class com.clubpenguin.map.vo.MapTriggerVO
{
    var categoryId;
    var label;
    var mapId;
    var roomId;
    var rotation;
    var spawnPoint;
    var trigger;
    var triggerId;
    var x;
    var y;

    function MapTriggerVO()
    {
    }

    function MapTrigger()
    {
    }

    function initFromObject(obj)
    {
        this.triggerId = obj.tid;
        this.mapId = obj.mapid;
        this.roomId = obj.roomid;
        this.label = obj.label;
        this.trigger = obj.trigger;
        this.x = obj.x;
        this.y = obj.y;
        this.rotation = obj.rotation;
        this.spawnPoint = obj.spawn;
        this.categoryId = 0;
    }

    function toString()
    {
        return "[MapTriggerVO] triggerID: " + this.triggerId + "  mapId: " + this.mapId + "  label: " + this.label;
    }

}
