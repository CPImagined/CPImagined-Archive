class com.clubpenguin.world.rooms2013.superhero.SuperHeroParty
{
   static var PARTY_COOKIE_ID = "20130424";
   static var UNAVAILABLE = 0;
   static var AVAILABLE = 1;
   static var COLLECTED = 2;
   static var NUM_POWER_GLOVES = 9;
   static var HEROPRIZETHRESHOLD = 50000;
   static var MAXSNOWBALLPOWER = 100;
   static var MAXROBOTPOWER = 40;
   static var NUM_ROBOT_TYPES = 8;
   static var HERO_PRIZE_ITEM_ID = 4841;
   static var VILLAIN_PRIZE_ITEM_ID = 4842;
   static var CRYSTALSHARDS_POWERGLOVE_ID = 5243;
   static var SLIME_POWERGLOVE_ID = 5245;
   static var LASER_POWERGLOVE_ID = 5241;
   static var TELEKINETIC_POWERGLOVE_ID = 5244;
   static var TORNADO_POWERGLOVE_ID = 5246;
   static var TELEPORT_POWERGLOVE_ID = 5240;
   static var SONIC_POWERGLOVE_ID = 5247;
   static var STOMP_POWERGLOVE_ID = 5242;
   static var FIXING_POWERGLOVE_ID = 5249;
   static var FREE_MONEY_BAG = 5153;
   static var MUGSHOT = 9143;
   static var REMOTE_CONTROLLER = 5248;
   static var PARTY_DAY = 0;
   static var SUPERHERO_UI = "w.p2013.superhero.superheroui";
   static var VILLAIN_UI = "w.p2013.superhero.villainui";
   static var LOGIN_SCREEN = "w.p2013.superhero.loginprompt";
   static var ROBOT_HIT_FRAME = 31;
   static var ROBOT_DEATH_FRAME = 32;
   static var HERO_PRIZE_COLLECTED_RESPONSE_NAME = "shphp";
   static var VILLAIN_PRIZE_COLLECTED_RESPONSE_NAME = "shpvp";
   static var ROBOT_HIT_RESPONSE_NAME = "shprh";
   static var PARTY_CATALOGUE = "w.party.catalogue.party1";
   static var POWER_SNOWBALL_RESPONSE_NAME = "shpgp";
   static var SUPER_HERO_HANDLER_NAME = "shp";
   static var OOPS_POWERGLOVE = "oops_party3";
   static var OOPS_ROBOT = "oops_party2";
   static var OOPS_PARTY_CATALOG = "oops_party1_catalog";
   function SuperHeroParty()
   {
   }
   static function get instance()
   {
      if(com.clubpenguin.world.rooms2013.superhero.SuperHeroParty._instance == null)
      {
         com.clubpenguin.world.rooms2013.superhero.SuperHeroParty._instance = new com.clubpenguin.world.rooms2013.superhero.SuperHeroParty();
      }
      return com.clubpenguin.world.rooms2013.superhero.SuperHeroParty._instance;
   }
   function init()
   {
      this._shell = _global.getCurrentShell();
      this._airtower = _global.getCurrentAirtower();
      this._interface = _global.getCurrentInterface();
      this._engine = _global.getCurrentEngine();
      this._serverCookieService = this._shell.getServerCookieService();
      this._serverCookie = new com.clubpenguin.world.rooms2013.superhero.vo.SuperHeroCookieVO(com.clubpenguin.world.rooms2013.superhero.SuperHeroParty.PARTY_COOKIE_ID);
      this._serverCookieService.registerCookieVO(this._serverCookie.getID(),this._serverCookie);
      this._heroPrizeCollectedReceivedDelegate = com.clubpenguin.util.Delegate.create(this,this.onHeroPrizeCollectedReceived);
      this._villainPrizeCollectedReceivedDelegate = com.clubpenguin.util.Delegate.create(this,this.onVillainPrizeCollectedReceived);
      this._robotHitReceivedDelegate = com.clubpenguin.util.Delegate.create(this,this.onRobotHitReceived);
      this.handlePowerSnowballThrownDelegate = com.clubpenguin.util.Delegate.create(this,this.updatePlayerGlovePower);
      this._shell.addListener(this._shell.JOIN_ROOM,this.showLoginScreen,this);
      this.opcodeJournal = new com.clubpenguin.world.rooms2013.superhero.OpcodeJournal();
   }
   function showLoginScreen()
   {
      this._shell.removeListener(this._shell.JOIN_ROOM,this.showLoginScreen);
      var _loc2_ = this._shell.getRoomObject();
      if(_loc2_.room_id != 112)
      {
         this._interface.showContent(com.clubpenguin.world.rooms2013.superhero.SuperHeroParty.LOGIN_SCREEN);
      }
   }
   static function launchCatalog()
   {
      _global.getCurrentInterface().showContent(com.clubpenguin.world.rooms2013.superhero.SuperHeroParty.PARTY_CATALOGUE);
   }
   function get getSuperHeroCookieVO()
   {
      return com.clubpenguin.world.rooms2013.superhero.vo.SuperHeroCookieVO(this._serverCookie);
   }
   function sendSomething(something)
   {
      var _loc1_ = something;
   }
   function get glovePower()
   {
      return this._serverCookie != null ? this._serverCookie.glovePower : 0;
   }
   function set glovePower(num)
   {
      if(this._serverCookie != null)
      {
         this._serverCookie.glovePower = num;
      }
   }
   function get totalSnowballPoints()
   {
      return this._serverCookie != null ? this._serverCookie.totalSnowballPoints : 0;
   }
   function set totalSnowballPoints(num)
   {
      if(this._serverCookie != null)
      {
         this._serverCookie.totalSnowballPoints = num;
      }
   }
   function get heroPrize()
   {
      if(this._serverCookie == null)
      {
         return 0;
      }
      if(this._shell.isItemInMyInventory(com.clubpenguin.world.rooms2013.superhero.SuperHeroParty.HERO_PRIZE_ITEM_ID))
      {
         return 2;
      }
      if(this._serverCookie.totalSnowballPoints >= com.clubpenguin.world.rooms2013.superhero.SuperHeroParty.HEROPRIZETHRESHOLD)
      {
         return 1;
      }
      return 0;
   }
   function isPowerGloveEquipped(player_id)
   {
      var _loc3_ = this._shell.getPlayerObjectById(player_id);
      var _loc2_ = _loc3_.hand;
      return this.isItemAPowerGlove(_loc2_);
   }
   function isStaticPowerGloveEquipped(player_id)
   {
      var _loc3_ = this._shell.getPlayerObjectById(player_id);
      var _loc2_ = _loc3_.hand;
      if(_loc2_ == com.clubpenguin.world.rooms2013.superhero.SuperHeroParty.LASER_POWERGLOVE_ID || _loc2_ == com.clubpenguin.world.rooms2013.superhero.SuperHeroParty.TELEKINETIC_POWERGLOVE_ID || _loc2_ == com.clubpenguin.world.rooms2013.superhero.SuperHeroParty.TORNADO_POWERGLOVE_ID || _loc2_ == com.clubpenguin.world.rooms2013.superhero.SuperHeroParty.TELEPORT_POWERGLOVE_ID || _loc2_ == com.clubpenguin.world.rooms2013.superhero.SuperHeroParty.SONIC_POWERGLOVE_ID || _loc2_ == com.clubpenguin.world.rooms2013.superhero.SuperHeroParty.STOMP_POWERGLOVE_ID)
      {
         return true;
      }
      return false;
   }
   function isStompPowerGloveEquipped(player_id)
   {
      var _loc3_ = this._shell.getPlayerObjectById(player_id);
      var _loc2_ = _loc3_.hand;
      if(_loc2_ == com.clubpenguin.world.rooms2013.superhero.SuperHeroParty.STOMP_POWERGLOVE_ID)
      {
         return true;
      }
      return false;
   }
   function isItemAPowerGlove(itemID)
   {
      var _loc1_ = 5240;
      while(_loc1_ <= 5247)
      {
         if(itemID == _loc1_)
         {
            return true;
         }
         _loc1_ = _loc1_ + 1;
      }
      if(itemID == com.clubpenguin.world.rooms2013.superhero.SuperHeroParty.FIXING_POWERGLOVE_ID)
      {
         return true;
      }
      return false;
   }
   function collectHeroItem()
   {
      this._shell.sendBuyInventory(com.clubpenguin.world.rooms2013.superhero.SuperHeroParty.HERO_PRIZE_ITEM_ID);
   }
   function sendClaimHeroPrize()
   {
      this._airtower.send(this._airtower.PLAY_EXT,"shp#" + com.clubpenguin.world.rooms2013.superhero.SuperHeroParty.HERO_PRIZE_COLLECTED_RESPONSE_NAME,[],"str",this._shell.getCurrentServerRoomId());
      this._airtower.addListener(com.clubpenguin.world.rooms2013.superhero.SuperHeroParty.HERO_PRIZE_COLLECTED_RESPONSE_NAME,this._heroPrizeCollectedReceivedDelegate,this);
   }
   function onHeroPrizeCollectedReceived(data)
   {
      this._airtower.removeListener(com.clubpenguin.world.rooms2013.superhero.SuperHeroParty.HERO_PRIZE_COLLECTED_RESPONSE_NAME,this._heroPrizeCollectedReceivedDelegate);
      var _loc2_ = Number(data[1]);
      var _loc5_ = this._shell.getInventoryObjectById(_loc2_);
      var _loc4_ = this._shell.getMyInventoryArray();
      if(_loc2_ > 0 && !this._shell.isItemInMyInventory(_loc2_))
      {
         _loc4_.push(_loc5_);
         this.showItemCollectedPrompt(_loc2_);
      }
      var _loc3_ = Number(data[2]);
      this._shell.setMyPlayerTotalCoins(_loc3_);
   }
   function handlePowerSnowballThrown()
   {
      this._airtower.addListener(com.clubpenguin.world.rooms2013.superhero.SuperHeroParty.POWER_SNOWBALL_RESPONSE_NAME,this.handlePowerSnowballThrownDelegate,this);
   }
   function updatePlayerGlovePower(data)
   {
      this._airtower.removeListener(com.clubpenguin.world.rooms2013.superhero.SuperHeroParty.POWER_SNOWBALL_RESPONSE_NAME,this.handlePowerSnowballThrownDelegate);
      this._serverCookie.glovePower = Number(data[1]);
      this._interface.updateHeroPowerMeter();
   }
   function get villainPrize()
   {
      if(this.__get__numRobotTypesCollected() == com.clubpenguin.world.rooms2013.superhero.SuperHeroParty.NUM_ROBOT_TYPES)
      {
         return 1;
      }
      return 0;
   }
   function get robotPower()
   {
      return !(this._serverCookie == null || !this.isRobotEquipped(this._shell.getMyPlayerId())) ? this._serverCookie.robotPower : 0;
   }
   function set robotPower(num)
   {
      if(this._serverCookie != null)
      {
         this._serverCookie.robotPower = num;
      }
   }
   function isRobotEquipped(player_id)
   {
      var _loc3_ = this._shell.getPlayerObjectById(player_id);
      var _loc2_ = _loc3_.hand;
      return this.isItemARobot(_loc2_);
   }
   function isItemARobot(itemID)
   {
      var _loc1_ = 5300;
      while(_loc1_ <= 5331)
      {
         if(itemID == _loc1_)
         {
            return true;
         }
         _loc1_ = _loc1_ + 1;
      }
      return false;
   }
   function get numRobotTypesCollected()
   {
      if(this._serverCookie == null)
      {
         return 0;
      }
      var _loc4_ = 0;
      var _loc3_ = this._serverCookie.robotTypesCollected;
      var _loc2_ = 0;
      while(_loc2_ < _loc3_.length)
      {
         if(_loc3_[_loc2_] == true)
         {
            _loc4_ = _loc4_ + 1;
         }
         _loc2_ = _loc2_ + 1;
      }
      return _loc4_;
   }
   function get robotTypesCollected()
   {
      return this._serverCookie != null ? this._serverCookie.robotTypesCollected : new Array(false,false,false,false,false,false,false,false);
   }
   function set robotTypesCollected(value)
   {
      if(this._serverCookie == null)
      {
         this._serverCookie.robotTypesCollected = value;
      }
   }
   function get robotInventory()
   {
      var _loc3_ = new Array();
      if(this._serverCookie == null)
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
         _loc3_ = this._serverCookie.robotInventory;
      }
      return _loc3_;
   }
   function getSelectedRobotCollection(robotType)
   {
      var _loc3_ = new Array();
      if(this._serverCookie == null)
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
         _loc3_ = this._serverCookie.robotInventory;
      }
      var _loc5_ = new Array();
      var _loc4_ = 4;
      _loc2_ = 0;
      while(_loc2_ < _loc4_)
      {
         _loc5_.push(_loc3_[_loc2_ + (robotType - 1) * _loc4_]);
         _loc2_ = _loc2_ + 1;
      }
      return _loc5_;
   }
   function set robotCollection(value)
   {
      if(this._serverCookie != null)
      {
         this._serverCookie.robotCollection = value;
      }
   }
   function collectVillainItem()
   {
      this._shell.sendBuyInventory(com.clubpenguin.world.rooms2013.superhero.SuperHeroParty.VILLAIN_PRIZE_ITEM_ID);
   }
   function sendClaimVillainPrize()
   {
      this._airtower.send(this._airtower.PLAY_EXT,"shp#" + com.clubpenguin.world.rooms2013.superhero.SuperHeroParty.VILLAIN_PRIZE_COLLECTED_RESPONSE_NAME,[],"str",this._shell.getCurrentServerRoomId());
      this._airtower.addListener(com.clubpenguin.world.rooms2013.superhero.SuperHeroParty.VILLAIN_PRIZE_COLLECTED_RESPONSE_NAME,this._villainPrizeCollectedReceivedDelegate,this);
   }
   function onVillainPrizeCollectedReceived(data)
   {
      this._airtower.removeListener(com.clubpenguin.world.rooms2013.superhero.SuperHeroParty.VILLAIN_PRIZE_COLLECTED_RESPONSE_NAME,this._villainPrizeCollectedReceivedDelegate);
      var _loc2_ = Number(data[1]);
      var _loc5_ = this._shell.getInventoryObjectById(_loc2_);
      var _loc4_ = this._shell.getMyInventoryArray();
      if(_loc2_ > 0 && !this._shell.isItemInMyInventory(_loc2_))
      {
         _loc4_.push(_loc5_);
         this.showItemCollectedPrompt(_loc2_);
      }
      var _loc3_ = Number(data[2]);
      this._shell.setMyPlayerTotalCoins(_loc3_);
   }
   function showItemCollectedPrompt(itemID)
   {
      var _loc4_ = this._shell.getInventoryObjectById(itemID);
      var _loc3_ = this._shell.getLocalizedString("buy_inventory_done");
      _loc3_ = com.clubpenguin.util.StringUtils.replaceString("%name%",_loc4_.name,_loc3_);
      _global.getCurrentInterface().showPrompt("ok",_loc3_);
   }
   function handleRobotSnowballHit(snowball_player_id, hit_player_id, frame)
   {
      var _loc2_ = this._engine.getPlayerMovieClip(hit_player_id);
      _loc2_.hand_mc.gotoAndStop(frame);
      if(_loc2_.hand_mc.robot._currentframe > 1)
      {
         _loc2_.hand_mc.robot.gotoAndPlay(1);
      }
      if(this._shell.isMyPlayer(hit_player_id))
      {
         this._airtower.addListener(com.clubpenguin.world.rooms2013.superhero.SuperHeroParty.ROBOT_HIT_RESPONSE_NAME,this._robotHitReceivedDelegate,this);
         this.sendRobotHit(snowball_player_id);
      }
   }
   function handleMyRobotHit(player_id)
   {
      this._robotHitReceivedDelegate = com.clubpenguin.util.Delegate.create(this,this.onRobotHitReceived,player_id);
      this._airtower.addListener(com.clubpenguin.world.rooms2013.superhero.SuperHeroParty.ROBOT_HIT_RESPONSE_NAME,this._robotHitReceivedDelegate,this);
      this.sendRobotHit(player_id);
   }
   function sendRobotHit(player_id)
   {
      this._airtower.send(this._airtower.PLAY_EXT,"shp#" + com.clubpenguin.world.rooms2013.superhero.SuperHeroParty.ROBOT_HIT_RESPONSE_NAME,[player_id],"str",this._shell.getCurrentServerRoomId());
   }
   function onRobotHitReceived(data)
   {
      this._airtower.removeListener(com.clubpenguin.world.rooms2013.superhero.SuperHeroParty.ROBOT_HIT_RESPONSE_NAME,this._robotHitReceivedDelegate);
      if(data == null)
      {
         return undefined;
      }
      this.updateRobotHealth(Number(data[1]));
   }
   function updateRobotHealth(robotPower)
   {
      this._serverCookie.robotPower = robotPower;
      if(Number(this._serverCookie.robotPower) == 0)
      {
         this.handleDestroyRobot();
      }
      else
      {
         this._interface.updateRobotMeter();
      }
   }
   function handleDestroyRobot()
   {
      var _loc2_ = this._engine.getPlayerMovieClip(this._shell.getMyPlayerId()).hand_mc;
      _loc2_.gotoAndStop(com.clubpenguin.world.rooms2013.superhero.SuperHeroParty.ROBOT_DEATH_FRAME);
      _loc2_.onEnterFrame = com.clubpenguin.util.Delegate.create(this,this.trackRobotDeathAnimation,_loc2_);
   }
   function trackRobotDeathAnimation(robotMC)
   {
      if(robotMC.robot._currentframe == robotMC.robot._totalframes)
      {
         this._shell.sendUpdatePlayerHand(0);
         delete robotMC.onEnterFrame;
      }
   }
   function playSpecialStompAnimation(player_id)
   {
      var _loc2_ = this._engine.getPlayerMovieClip(player_id);
      var _loc3_ = _loc2_.attachMovie("StompEffect","stompEffect",_loc2_.art_mc.getDepth() - 5);
   }
   function trackDanceAnimation(player_id)
   {
      if(this.stompDanceCounter == 10)
      {
         var _loc2_ = this._engine.getPlayerMovieClip(player_id);
         this._engine.updatePlayerFrame(player_id,1,false);
         this.stompDanceCounter = 0;
         delete _loc2_.art_mc.onEnterFrame;
         return undefined;
      }
      this.stompDanceCounter++;
   }
   function fetchRobotSnowballOrigin(player_id)
   {
      var _loc3_ = this._shell.getPlayerObjectById(player_id);
      var _loc2_ = _loc3_.hand;
      if(_loc2_ >= 5300 && _loc2_ <= 5303)
      {
         return 17;
      }
      if(_loc2_ >= 5304 && _loc2_ <= 5307)
      {
         return 16;
      }
      if(_loc2_ >= 5308 && _loc2_ <= 5311)
      {
         return 18;
      }
      if(_loc2_ >= 5312 && _loc2_ <= 5315)
      {
         return 20;
      }
      if(_loc2_ >= 5316 && _loc2_ <= 5319)
      {
         return 16;
      }
      if(_loc2_ >= 5320 && _loc2_ <= 5323)
      {
         return 17;
      }
      if(_loc2_ >= 5324 && _loc2_ <= 5327)
      {
         return 21;
      }
      if(_loc2_ >= 5328 && _loc2_ <= 5331)
      {
         return 26;
      }
      return 14;
   }
}
