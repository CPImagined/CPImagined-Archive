class com.clubpenguin.world.rooms2013.superhero.vo.SuperHeroCookieVO extends com.clubpenguin.services.vo.JsonServerCookieVO
{
   static var SUPERHERO_COOKIE_HANDLER_NAME = "shp";
   static var SUPERHERO_RECEIVE_COMMAND_NAME = "shppc";
   static var SNOWBALL_POWER_MAX = 999;
   static var ROBOT_POWER_MAX = 100;
   static var NUM_ROBOT_TYPES = 8;
   static var TOTAL_NUM_ROBOTS = 32;
   static var NUM_POWER_GLOVES = 9;
   function SuperHeroCookieVO(cookieId)
   {
      super(cookieId);
      this.snowballPowerChanged = new org.osflash.signals.Signal(Number);
      this.totalSnowballPointsChanged = new org.osflash.signals.Signal(Number);
      this.heroPrizeChanged = new org.osflash.signals.Signal(Number);
      this.robotPowerChanged = new org.osflash.signals.Signal(Number);
      this.robotTypesCollectedChanged = new org.osflash.signals.Signal(Array);
      this.robotInventoryChanged = new org.osflash.signals.Signal(Array);
      this.villainPrizeChanged = new org.osflash.signals.Signal(Boolean);
   }
   function getCookieHandlerName()
   {
      return com.clubpenguin.world.rooms2013.superhero.vo.SuperHeroCookieVO.SUPERHERO_COOKIE_HANDLER_NAME;
   }
   function getSendCommandName()
   {
      return com.clubpenguin.world.rooms2013.superhero.vo.SuperHeroCookieVO.SUPERHERO_RECEIVE_COMMAND_NAME;
   }
   function getReceiveCommandName()
   {
      return com.clubpenguin.world.rooms2013.superhero.vo.SuperHeroCookieVO.SUPERHERO_RECEIVE_COMMAND_NAME;
   }
   function get glovePower()
   {
      if(this._jsonObject.glovePower == null || this._jsonObject.glovePower < 0)
      {
         return 0;
      }
      if(this._jsonObject.glovePower > 100)
      {
         return 100;
      }
      if(this._jsonObject.glovePower > com.clubpenguin.world.rooms2013.superhero.vo.SuperHeroCookieVO.SNOWBALL_POWER_MAX)
      {
         return com.clubpenguin.world.rooms2013.superhero.vo.SuperHeroCookieVO.SNOWBALL_POWER_MAX;
      }
      return this._jsonObject.glovePower;
   }
   function set glovePower(value)
   {
      if(value == null || value < 0 || value > com.clubpenguin.world.rooms2013.superhero.vo.SuperHeroCookieVO.SNOWBALL_POWER_MAX)
      {
         this.traceSetError("glovePower",String(value));
         return undefined;
      }
      if(value > 100)
      {
         value = 100;
      }
      this._jsonObject.glovePower = value;
   }
   function get totalSnowballPoints()
   {
      return !(this._jsonObject.gloveTotal == null || this._jsonObject.gloveTotal < 0) ? this._jsonObject.gloveTotal : 0;
   }
   function set totalSnowballPoints(value)
   {
      if(value == null)
      {
         this.traceSetError("gloveTotal",String(value));
      }
      this._jsonObject.gloveTotal = value;
      this.totalSnowballPointsChanged.dispatch(value);
   }
   function get heroPrize()
   {
      if(this._jsonObject.heroPrize == null || this._jsonObject.heroPrize < 0 || this._jsonObject.heroPrize > 3)
      {
         return 0;
      }
      return this._jsonObject.heroPrize;
   }
   function set heroPrize(value)
   {
      if(value == null || value < 0 || value > 3)
      {
         this.traceSetError("heroPrize",String(value));
         return undefined;
      }
      this._jsonObject.heroPrize = value;
      this.heroPrizeChanged.dispatch(value);
   }
   function get robotPower()
   {
      if(this._jsonObject.robotPower == null || this._jsonObject.robotPower < 0)
      {
         return 0;
      }
      if(this._jsonObject.snowballPower > com.clubpenguin.world.rooms2013.superhero.vo.SuperHeroCookieVO.ROBOT_POWER_MAX)
      {
         return com.clubpenguin.world.rooms2013.superhero.vo.SuperHeroCookieVO.ROBOT_POWER_MAX;
      }
      return this._jsonObject.robotPower;
   }
   function set robotPower(value)
   {
      if(value == null || value < 0 || value > com.clubpenguin.world.rooms2013.superhero.vo.SuperHeroCookieVO.ROBOT_POWER_MAX)
      {
         this.traceSetError("robotPower",String(value));
         return undefined;
      }
      this._jsonObject.robotPower = value;
      if(this.robotPowerChanged != null && value != null)
      {
         this.robotPowerChanged.dispatch(value);
      }
   }
   function get villainPrize()
   {
      if(this._jsonObject.villainPrize == null || this._jsonObject.villainPrize < 0 || this._jsonObject.villainPrize > 3)
      {
         return 0;
      }
      return this._jsonObject.villainPrize;
   }
   function set villainPrize(value)
   {
      if(value == null || value < 0 || value > 3)
      {
         this.traceSetError("villainPrize",String(value));
         return undefined;
      }
      this._jsonObject.villainPrize = value;
      this.villainPrizeChanged.dispatch(value);
   }
   function get robotTypesCollected()
   {
      if(this._jsonObject.built == null || this._jsonObject.built.length == 0 || this._jsonObject.built.length > com.clubpenguin.world.rooms2013.superhero.vo.SuperHeroCookieVO.NUM_ROBOT_TYPES)
      {
         0;
         0;
         0;
         0;
         0;
         0;
         0;
         return new Array[0]();
      }
      return this._jsonObject.built;
   }
   function set robotTypesCollected(value)
   {
      if(this._jsonObject.built == null || this._jsonObject.built.length == 0 || this._jsonObject.built.length > com.clubpenguin.world.rooms2013.superhero.vo.SuperHeroCookieVO.NUM_ROBOT_TYPES)
      {
         this.traceSetError("robotTypesCollected",String(value));
         return undefined;
      }
      this._jsonObject.built = value;
      this.robotTypesCollectedChanged.dispatch(value);
   }
   function updateRobotInventory(robotsBuiltInGameSession)
   {
      var _loc3_ = this.__get__robotInventory();
      var _loc4_ = _loc3_.length;
      var _loc2_ = 0;
      while(_loc2_ < _loc4_)
      {
         _loc3_[_loc2_] += robotsBuiltInGameSession[_loc2_];
         _loc2_ = _loc2_ + 1;
      }
   }
   function get robotInventory()
   {
      var _loc3_ = new Array();
      if(this._jsonObject.inventory == null)
      {
         var _loc2_ = 0;
         while(_loc2_ < com.clubpenguin.world.rooms2013.superhero.vo.SuperHeroCookieVO.TOTAL_NUM_ROBOTS)
         {
            _loc3_.push(0);
            _loc2_ = _loc2_ + 1;
         }
      }
      else
      {
         _loc3_ = this._jsonObject.inventory;
      }
      return _loc3_;
   }
   function set robotInventory(value)
   {
      if(value == null)
      {
         this.traceSetError("inventory",String(value));
         return undefined;
      }
      var _loc2_ = 0;
      while(_loc2_ < value.length)
      {
         if(value[_loc2_] == null || value[_loc2_] < 0)
         {
            this.traceSetError("inventory",String(value) + ":" + value[_loc2_]);
            return undefined;
         }
         _loc2_ = _loc2_ + 1;
      }
      this._jsonObject.inventory = value;
      this.robotInventoryChanged.dispatch(value);
   }
   function traceSetError(propertyName, value)
   {
   }
}
