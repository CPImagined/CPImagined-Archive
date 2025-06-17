class com.clubpenguin.world.rooms.common.behaviors.RoomBehaviorFactory
{
   static var _instance = null;
   function RoomBehaviorFactory()
   {
   }
   static function getInstance()
   {
      if(com.clubpenguin.world.rooms.common.behaviors.RoomBehaviorFactory._instance == null)
      {
         com.clubpenguin.world.rooms.common.behaviors.RoomBehaviorFactory._instance = new com.clubpenguin.world.rooms.common.behaviors.RoomBehaviorFactory();
      }
      return com.clubpenguin.world.rooms.common.behaviors.RoomBehaviorFactory._instance;
   }
   function getRoomBehavior(environmentType)
   {
      var _loc0_ = null;
      if((_loc0_ = environmentType.name) !== "water")
      {
         com.clubpenguin.util.Log.error("Environment name: " + environmentType.name + " does not exist in RoomBehaviorEnum");
         return null;
      }
      var _loc1_ = new com.clubpenguin.world.rooms.common.behaviors.WaterRoomBehavior();
      return _loc1_;
   }
}
