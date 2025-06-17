class com.clubpenguin.world.rooms.common.invitation.InvitationManagerFactory
{
   function InvitationManagerFactory()
   {
   }
   static function register(managerClass)
   {
      var _loc4_ = managerClass.split(".");
      var _loc3_ = _global;
      var _loc2_ = 0;
      while(_loc2_ < _loc4_.length)
      {
         _loc3_ = _loc3_[_loc4_[_loc2_]];
         _loc2_ = _loc2_ + 1;
      }
      if(_loc3_ instanceof Function)
      {
         com.clubpenguin.world.rooms.common.invitation.InvitationManagerFactory._clazz = Function(_loc3_);
      }
      else
      {
         §§push(com.clubpenguin.world.rooms.common.invitation.InvitationManagerFactory._clazz);
      }
      return Boolean(com.clubpenguin.world.rooms.common.invitation.InvitationManagerFactory._clazz);
   }
   static function create()
   {
      var _loc1_ = new com.clubpenguin.world.rooms.common.invitation.InvitationManagerFactory._clazz();
      return _loc1_;
   }
}
