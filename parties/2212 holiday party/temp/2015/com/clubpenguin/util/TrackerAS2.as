class com.clubpenguin.util.TrackerAS2
{
   static var ERROR = 0;
   static var GAME_ACTION = 1;
   static var PAGEVIEW = 2;
   static var POPUP = 3;
   static var LEVEL_UP = 4;
   static var MONEY = 5;
   static var STEP_TIMING = 6;
   static var USER_STAT_CHANGE = 7;
   static var SEND_MONEY = 8;
   static var SEND_SOCIAL_ACTION = 9;
   static var PERFORMANCE = 10;
   static var SYSTEM = 11;
   static var TEST_IMPRESSION = 12;
   static var USER_INFO = 13;
   static var CURRENCY_COINS = "coins";
   static var CURRENCY_MEDALS = "medals";
   static var CURRENCY_STAMPS = "stamps";
   static var CURRENCY_ITEMS = "items";
   var _trackerStartTimes = [];
   function TrackerAS2()
   {
      if(!this._shell && _global.getCurrentShell())
      {
         this._shell = _global.getCurrentShell();
      }
      this.currentContext = "load.login";
   }
   static function getInstance()
   {
      if(!com.clubpenguin.util.TrackerAS2.singletonInstance)
      {
         com.clubpenguin.util.TrackerAS2.singletonInstance = new com.clubpenguin.util.TrackerAS2();
      }
      return com.clubpenguin.util.TrackerAS2.singletonInstance;
   }
   function startTracker()
   {
      this._shell.startTracker();
   }
   function sendTrackingEvent(trackingKey, paramsJSONString)
   {
      this._shell.sendTrackingEvent(trackingKey,paramsJSONString);
   }
   function sendToAS3StartAssetLoad(context)
   {
      this.currentContext = context;
      this._shell.sendToAS3StartAssetLoad(context);
   }
   function sendToAS3EndAssetLoad(context, bytesTotal, path, result)
   {
   }
   function sendToAS3StartSubContextAssetLoad(context, location)
   {
      this.recordStartTime(location);
   }
   function sendToAS3EndSubContextAssetLoad(location, pathName)
   {
      if(!pathName)
      {
         pathName = "";
      }
      var _loc3_ = this.fetchElapsedTime(location);
      location;
   }
   function sendToAS3LogGameAction(context, action, itemName, payload)
   {
      this._shell.sendToAS3LogGameAction(context,action,itemName,payload);
   }
   function sendTrackLoginError()
   {
      this._shell.sendTrackLoginError();
   }
   function sendToAS3LogError(reason, context, message)
   {
      this._shell.sendToAS3LogError(reason,context,message);
   }
   function sendToAS3LogMovieClipTimeout(reason, context, message)
   {
      this._shell.sendToAS3LogMovieClipTimeout(reason,context,message);
   }
   function sendToAS3LogMovieClipLoadError(reason, context, fileURL, errorCode, httpStatus)
   {
      this._shell.sendToAS3LogMovieClipLoadError(reason,context,fileURL,errorCode,httpStatus);
   }
   function sendToAS3LogMovieClipParamError(reason, context, fileURL, caller)
   {
      this._shell.sendToAS3LogMovieClipParamError(reason,context,fileURL,caller);
   }
   function sendWorldSelectedStartLog(world_id)
   {
      this.currentContext = "load.world";
      this._shell.sendWorldSelectedStartLog(this.currentContext,world_id);
   }
   function trackUserInfo(transaction_id, isMember, player_id, city, state, country, zip)
   {
      var _loc2_ = {};
      _loc2_.type = com.clubpenguin.util.TrackerAS2.USER_INFO;
      _loc2_.transaction_id = transaction_id;
      _loc2_.isMember = isMember;
      _loc2_.player_id = player_id;
      _loc2_.city = city;
      _loc2_.state = state;
      _loc2_.country = country;
      _loc2_.zip = zip;
      this._shell.sendPlaydomTracking(_loc2_);
   }
   function trackTestImpression(test, variant, control)
   {
      var _loc2_ = {};
      _loc2_.type = com.clubpenguin.util.TrackerAS2.TEST_IMPRESSION;
      _loc2_.test = test;
      _loc2_.variant = variant;
      _loc2_.control = control;
      this._shell.sendPlaydomTracking(_loc2_);
   }
   function trackStepTimingEvent(context, location, pathName, result)
   {
   }
   function trackRewardEarned(currency, amount, maintype, subtype, balance, context, options)
   {
      if(isNaN(amount))
      {
         return undefined;
      }
      if(amount == 0)
      {
         amount = -1;
      }
      var _loc2_ = {};
      _loc2_.type = com.clubpenguin.util.TrackerAS2.MONEY;
      _loc2_.amount = amount;
      _loc2_.currency = currency;
      _loc2_.maintype = maintype;
      _loc2_.subtype = subtype;
      _loc2_.balance = balance;
      _loc2_.context = context;
      _loc2_.options = options;
      this._shell.sendPlaydomTracking(_loc2_);
   }
   function trackGameAction(action, context, options)
   {
      var _loc2_ = {};
      _loc2_.type = com.clubpenguin.util.TrackerAS2.GAME_ACTION;
      _loc2_.action = action;
      _loc2_.context = context;
      _loc2_.options = options;
      this._shell.sendPlaydomTracking(_loc2_);
   }
   function trackPopup(tracking_code, step)
   {
      var _loc2_ = {};
      _loc2_.type = com.clubpenguin.util.TrackerAS2.POPUP;
      _loc2_.tracking_code = tracking_code;
      _loc2_.step = step;
      this._shell.sendPlaydomTracking(_loc2_);
   }
   function recordStartTime(location)
   {
      if(this._trackerStartTimes[location] != null)
      {
      }
      this._trackerStartTimes[location] = getTimer();
   }
   function fetchElapsedTime(location)
   {
      if(this._trackerStartTimes[location] == null)
      {
      }
      var _loc4_ = this._trackerStartTimes[location];
      var _loc3_ = getTimer();
      var _loc5_ = _loc3_ - _loc4_;
      this._trackerStartTimes[location] = null;
      return _loc5_;
   }
}
