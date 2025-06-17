class com.clubpenguin.math.MathHelper
{
   function MathHelper()
   {
   }
   static function getRandomNumberInRange(min, max)
   {
      return Math.floor(Math.random() * (max - min)) + min;
   }
   static function getAngleBetweenCoordinates(x1, y1, x2, y2)
   {
      var _loc3_ = x2 - x1;
      var _loc2_ = y2 - y1;
      var _loc1_ = int(Math.atan2(_loc2_,_loc3_) * 57.29577951308232 - 90);
      if(_loc1_ < 0)
      {
         return _loc1_ + 360;
      }
      return _loc1_;
   }
   static function getAngleBetweenPoints(p1, p2)
   {
      return com.clubpenguin.math.MathHelper.getAngleBetweenCoordinates(p1.x,p1.y,p2.x,p2.y);
   }
   static function get8DirectionByAngle(angle)
   {
      var _loc1_ = Math.round(angle / 45) + 1;
      if(_loc1_ > 8)
      {
         _loc1_ = 1;
      }
      return _loc1_;
   }
}
