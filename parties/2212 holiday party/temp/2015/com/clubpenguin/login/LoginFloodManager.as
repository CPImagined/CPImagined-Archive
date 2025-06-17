class com.clubpenguin.login.LoginFloodManager
{
   static var SHARED_OBJECT_NAME = "floodControl";
   static var NEXT_LOGIN_TIME = "nlt";
   static var LOGIN_ATTEMPTS = "att";
   static var LOGIN_DELAYS = [0,20,40];
   static var RANDOM_RANGE = 20;
   static var MIN_DELAY = 10;
   static var ONE_SECOND = 1000;
   function LoginFloodManager()
   {
   }
   static function clearFloodControl()
   {
      try
      {
         var _loc1_ = SharedObject.getLocal(com.clubpenguin.login.LoginFloodManager.SHARED_OBJECT_NAME,"/");
         _loc1_.clear();
         _loc1_ = null;
      }
      catch(e:Error)
      {
      }
   }
   static function setLoginAttempt()
   {
      var _loc2_ = SharedObject.getLocal(com.clubpenguin.login.LoginFloodManager.SHARED_OBJECT_NAME,"/");
      var _loc4_ = undefined;
      var _loc5_ = new Date();
      var _loc1_ = 0;
      var _loc3_ = 0;
      try
      {
         if(_loc2_.data[com.clubpenguin.login.LoginFloodManager.LOGIN_ATTEMPTS] != undefined)
         {
            _loc1_ = _loc2_.data[com.clubpenguin.login.LoginFloodManager.LOGIN_ATTEMPTS];
         }
         _loc1_ = _loc1_ + 1;
         if(_loc1_ > com.clubpenguin.login.LoginFloodManager.LOGIN_DELAYS.length - 1)
         {
            _loc1_ = 0;
         }
         if(_loc1_ == 0)
         {
            _loc3_ = com.clubpenguin.login.LoginFloodManager.MIN_DELAY;
         }
         _loc2_.data[com.clubpenguin.login.LoginFloodManager.LOGIN_ATTEMPTS] = _loc1_;
         _loc2_.data[com.clubpenguin.login.LoginFloodManager.NEXT_LOGIN_TIME] = Number(_loc5_.getTime() + (com.clubpenguin.login.LoginFloodManager.LOGIN_DELAYS[_loc1_] + com.clubpenguin.math.MathHelper.getRandomNumberInRange(_loc3_,com.clubpenguin.login.LoginFloodManager.RANDOM_RANGE)) * com.clubpenguin.login.LoginFloodManager.ONE_SECOND);
         _loc4_ = _loc2_.flush();
      }
      catch(error:Error)
      {
         return false;
      }
      return true;
   }
}
