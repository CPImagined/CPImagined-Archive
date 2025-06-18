//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.map.vo.MapTriggerVO
    {
        var triggerId, mapId, roomId, label, trigger, x, y, rotation, spawnPoint, categoryId;
        function MapTriggerVO () {
        }
        function MapTrigger() {
        }
        function initFromObject(obj) {
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
        }
        function toString() {
            return((((("[MapTriggerVO] triggerID: " + triggerId) + "  mapId: ") + mapId) + "  label: ") + label);
        }
    }
