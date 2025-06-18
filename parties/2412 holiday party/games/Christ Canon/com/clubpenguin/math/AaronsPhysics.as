class com.clubpenguin.math.AaronsPhysics
{
   function AaronsPhysics()
   {
   }
   static function findAngle($fromX, $fromY, $toX, $toY)
   {
      var _loc1_ = undefined;
      var _loc2_ = $toX - $fromX;
      var _loc4_ = $toY - $fromY;
      var _loc3_ = Math.atan2(_loc4_,_loc2_);
      _loc1_ = Math.round(_loc3_ / 3.141592653589793 * 180);
      return _loc1_;
   }
   static function findAngleBetweenPoints(_from, _to)
   {
      var _loc3_ = undefined;
      var _loc1_ = undefined;
      var _loc2_ = undefined;
      _loc1_ = _to.subtract(_from);
      _loc2_ = Math.atan2(_loc1_.y,_loc1_.x);
      _loc3_ = Math.round(_loc2_ / 3.141592653589793 * 180);
      return _loc3_;
   }
   static function findDistance($fromX, $fromY, $toX, $toY)
   {
      var _loc2_ = Math.round($toX - $fromX);
      var _loc1_ = Math.round($toY - $fromY);
      return Math.round(Math.sqrt(_loc2_ * _loc2_ + _loc1_ * _loc1_));
   }
   static function findMotionXFromAngle($angle, $strength)
   {
      return Math.cos($angle * 0.017453292519943295) * $strength;
   }
   static function findMotionYFromAngle($angle, $strength)
   {
      return Math.sin($angle * 0.017453292519943295) * $strength;
   }
   static function findAngleFromMotion($motionX, $motionY)
   {
      var _loc1_ = Math.atan2($motionY,$motionX);
      return Math.round(_loc1_ / 3.141592653589793 * 180);
   }
   static function findPositionXAfterParentRotation($pointX, $pointY, $parentX, $parentY, $parentAngle)
   {
      var _loc1_ = com.clubpenguin.math.AaronsPhysics.findAngle(0,0,$pointX,$pointY);
      var _loc2_ = com.clubpenguin.math.AaronsPhysics.findDistance(0,0,$pointX,$pointY);
      _loc1_ += $parentAngle;
      var _loc3_ = com.clubpenguin.math.AaronsPhysics.findMotionXFromAngle(_loc1_,_loc2_);
      return $parentX + _loc3_;
   }
   static function findPositionYAfterParentRotation($pointX, $pointY, $parentX, $parentY, $parentAngle)
   {
      var _loc1_ = com.clubpenguin.math.AaronsPhysics.findAngle(0,0,$pointX,$pointY);
      var _loc2_ = com.clubpenguin.math.AaronsPhysics.findDistance(0,0,$pointX,$pointY);
      _loc1_ += $parentAngle;
      var _loc3_ = com.clubpenguin.math.AaronsPhysics.findMotionYFromAngle(_loc1_,_loc2_);
      return $parentY + _loc3_;
   }
}
