
//Created by Action Script Viewer - http://www.buraks.com/asv
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
        function getRoomBehavior(_arg_2) {
            if (!(_arg_2.name === "water")) {
            } else {
                var _local_1 = new com.clubpenguin.world.rooms.common.behaviors.WaterRoomBehavior();
                return(_local_1);
            }
            com.clubpenguin.util.Log.error(("Environment name: " + _arg_2.name) + " does not exist in RoomBehaviorEnum");
            return(null);
        }
        static var _instance = null;
    }
