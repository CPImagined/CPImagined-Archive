//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms.common.behaviors.RoomBehaviorFactory
    {
        function RoomBehaviorFactory () {
        }
        static function getInstance() {
            if (_instance == null) {
                _instance = new com.clubpenguin.world.rooms.common.behaviors.RoomBehaviorFactory();
            }
            return(_instance);
        }
        function getRoomBehavior(environmentType) {
            if (!(environmentType.name === "water")) {
            } else {
                var waterRoomBehavior = (new com.clubpenguin.world.rooms.common.behaviors.WaterRoomBehavior());
                return(waterRoomBehavior);
            }
            com.clubpenguin.util.Log.error(("Environment name: " + environmentType.name) + " does not exist in RoomBehaviorEnum");
            return(null);
        }
        static var _instance = null;
    }
