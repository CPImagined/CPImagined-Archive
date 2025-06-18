dynamic class com.clubpenguin.world.rooms.common.behaviors.RoomBehaviorFactory
{
    static var _instance = null;

    function RoomBehaviorFactory()
    {
    }

    static function getInstance()
    {
        if (com.clubpenguin.world.rooms.common.behaviors.RoomBehaviorFactory._instance == null) 
        {
            com.clubpenguin.world.rooms.common.behaviors.RoomBehaviorFactory._instance = new com.clubpenguin.world.rooms.common.behaviors.RoomBehaviorFactory();
        }
        return com.clubpenguin.world.rooms.common.behaviors.RoomBehaviorFactory._instance;
    }

    function getRoomBehavior(environmentType)
    {
        if ((__reg0 = environmentType.name) === "water") 
        {
            var __reg1 = new com.clubpenguin.world.rooms.common.behaviors.WaterRoomBehavior();
            return __reg1;
        }
        com.clubpenguin.util.Log.error("Environment name: " + environmentType.name + " does not exist in RoomBehaviorEnum");
        return null;
    }

}
