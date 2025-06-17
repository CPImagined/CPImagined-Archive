class com.clubpenguin.world.rooms.common.triggers.PlayerAction
{
   static var DRILLING = "drilling";
   static var WALKING_PUFFLE = "walkingPuffle";
   static var DANCING = "dancing";
   static var WAVING = "waving";
   static var MOPPING = "mopping";
   static var MOVING = "moving";
   static var SITTING = "sitting";
   static var DRIVING = "driving";
   static var SNACK_SHACK_STAMP_ID = 184;
   static var COFFEE_EMOTE_ID = 13;
   static var PIZZA_EMOTE_ID = 24;
   static var ICE_CREAM_EMOTE_ID = 26;
   static var CHOCOLATE_ICE_CREAM_EMOTE_ID = 27;
   static var CAKE_EMOTE_ID = 28;
   static var POPCORN_EMOTE_ID = 29;
   function PlayerAction()
   {
   }
   static function isPlayer(player, action)
   {
      switch(action)
      {
         case com.clubpenguin.world.rooms.common.triggers.PlayerAction.MOPPING:
            return com.clubpenguin.world.rooms.common.triggers.PlayerAction.isMopping(player);
         case com.clubpenguin.world.rooms.common.triggers.PlayerAction.DRIVING:
            return com.clubpenguin.world.rooms.common.triggers.PlayerAction.isDriving(player);
         case com.clubpenguin.world.rooms.common.triggers.PlayerAction.DRILLING:
            return com.clubpenguin.world.rooms.common.triggers.PlayerAction.isDrilling(player);
         case com.clubpenguin.world.rooms.common.triggers.PlayerAction.WALKING_PUFFLE:
            return com.clubpenguin.world.rooms.common.triggers.PlayerAction.isWalkingPuffle(player);
         case com.clubpenguin.world.rooms.common.triggers.PlayerAction.DANCING:
            return com.clubpenguin.world.rooms.common.triggers.PlayerAction.isDancing(player);
         case com.clubpenguin.world.rooms.common.triggers.PlayerAction.WAVING:
            return com.clubpenguin.world.rooms.common.triggers.PlayerAction.isWaving(player);
         case com.clubpenguin.world.rooms.common.triggers.PlayerAction.MOVING:
            return com.clubpenguin.world.rooms.common.triggers.PlayerAction.isMoving(player.player_id);
         case com.clubpenguin.world.rooms.common.triggers.PlayerAction.SITTING:
            return com.clubpenguin.world.rooms.common.triggers.PlayerAction.isSitting(player);
         default:
            return false;
      }
   }
   static function isMoving(playerID)
   {
      var _loc3_ = _global.getCurrentEngine();
      var _loc2_ = _loc3_.getPlayerMovieClip(playerID);
      if(_loc2_)
      {
         return _loc2_.is_moving;
      }
      return false;
   }
   static function isDriving(player)
   {
      return player.body == 4421 || player.body == 4414 || player.body == 4415 || player.body == 4715 || player.body == 14437;
   }
   static function isLocalPlayer(player)
   {
      var _loc2_ = _global.getCurrentShell();
      return player.player_id == _loc2_.getMyPlayerId();
   }
   static function isDancing(player)
   {
      return player.frame == 26;
   }
   static function isWaving(player)
   {
      return player.frame == player.wave_frame;
   }
   static function isMopping(player)
   {
      var _loc3_ = _global.getCurrentShell();
      if(player.hand == 5084)
      {
         if(player.frame == 26 && _loc3_.getSecretFrame(player.player_id,player.frame) != 26)
         {
            return true;
         }
      }
      return false;
   }
   static function isSitting(player)
   {
      return player.frame >= 17 && player.frame <= 24;
   }
   static function isDrilling(player)
   {
      var _loc3_ = _global.getCurrentShell();
      if(player.head == 403 || player.head == 10403 || player.head == 429 || player.head == 10429 || player.head == 674 || player.head == 1133)
      {
         if(player.frame == 26 && _loc3_.getSecretFrame(player.player_id,player.frame) != 26)
         {
            return true;
         }
      }
      return false;
   }
   static function isWalkingPuffle(player)
   {
      return player.attachedPuffle != null && player.attachedPuffle != undefined;
   }
}
