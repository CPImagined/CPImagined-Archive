class com.disney.dlearning.managers.DLSManager
{
   var __localConnection;
   static var __learnerID;
   static var __host;
   static var __developerID;
   static var __instance;
   var __URLLoaderCookieId = 0;
   var __URLCallbacks = new Array();
   var __sequenceID = 0;
   function DLSManager()
   {
      this.__localConnection = new com.disney.dlearning.debug.DLSLocalConnectionProducer();
   }
   static function init(learnerId, host, developerId)
   {
      com.disney.dlearning.managers.DLSManager.__learnerID = learnerId;
      if(host == null)
      {
         com.disney.dlearning.managers.DLSManager.__host = "k.api.dlsnetwork.com";
      }
      else
      {
         com.disney.dlearning.managers.DLSManager.__host = host;
      }
      if(learnerId == null)
      {
         com.disney.dlearning.managers.DLSManager.__learnerID = "-1";
      }
      else
      {
         com.disney.dlearning.managers.DLSManager.__learnerID = learnerId;
      }
      if(developerId == null)
      {
         com.disney.dlearning.managers.DLSManager.__developerID = "ClubPenguin.v1";
      }
      else
      {
         com.disney.dlearning.managers.DLSManager.__developerID = learnerId;
      }
   }
   static function get instance()
   {
      if(com.disney.dlearning.managers.DLSManager.__instance == null)
      {
         com.disney.dlearning.managers.DLSManager.__instance = new com.disney.dlearning.managers.DLSManager();
      }
      return com.disney.dlearning.managers.DLSManager.__instance;
   }
   static function set learnerID(id)
   {
      com.disney.dlearning.managers.DLSManager.__learnerID = id;
   }
   static function get learnerID()
   {
      return com.disney.dlearning.managers.DLSManager.__learnerID;
   }
   static function set host(host)
   {
      com.disney.dlearning.managers.DLSManager.__host = host;
   }
   static function get host()
   {
      return com.disney.dlearning.managers.DLSManager.__host;
   }
   function pushOpcode2(opcode, guid, callback, register1)
   {
   }
   function pushOpcode2Params(opcode, guid, callback, register1, register2)
   {
      trace("pushing opcode");
      var _loc6_ = new Date();
      var _loc4_ = Math.round(_loc6_.getTime() / 1000);
      var _loc3_ = undefined;
      var _loc5_ = this.__URLLoaderCookieId++;
      if(com.disney.dlearning.managers.DLSManager.__learnerID == "")
      {
         com.disney.dlearning.managers.DLSManager.__learnerID = "-1";
      }
      if(opcode == "")
      {
         opcode = "no_opcode_given";
      }
      _loc3_ = "http://" + com.disney.dlearning.managers.DLSManager.__host + "/v1/opcode/pushOpcode/" + opcode + "/" + com.disney.dlearning.managers.DLSManager.__learnerID + "/" + _loc4_ + "/" + guid + "/" + register1 + "/" + register2 + "/";
      var _loc8_ = this.encryptURL(_loc3_,_loc4_.toString(),com.disney.dlearning.managers.DLSManager.__developerID) + "|" + this.encryptTime(_loc4_.toString());
      var _loc2_ = new LoadVars();
      _loc2_.callback = callback;
      this.configureListeners(_loc2_);
      _loc2_.addRequestHeader("DLSNetwork-Developer-ID",com.disney.dlearning.managers.DLSManager.__developerID);
      _loc2_.addRequestHeader("DLSNetwork-Request-Key",_loc8_);
      _loc2_.addRequestHeader("DLSNetwork-Sequence-ID",String(this.__sequenceID++));
      try
      {
         trace("loading DLS url" + _loc3_);
         _loc2_.sendAndLoad(_loc3_,_loc2_,"POST");
      }
      catch(error:Error)
      {
      }
      return _loc5_;
   }
   function pushOpcode(opcode, guid, callback, register1, register2, register3)
   {
      trace("pushing opcode");
      var _loc6_ = new Date();
      var _loc4_ = Math.round(_loc6_.getTime() / 1000);
      var _loc3_ = undefined;
      var _loc5_ = this.__URLLoaderCookieId++;
      if(com.disney.dlearning.managers.DLSManager.__learnerID == "")
      {
         com.disney.dlearning.managers.DLSManager.__learnerID = "-1";
      }
      if(opcode == "")
      {
         opcode = "no_opcode_given";
      }
      _loc3_ = "http://" + com.disney.dlearning.managers.DLSManager.__host + "/v1/opcode/pushOpcode/" + opcode + "/" + com.disney.dlearning.managers.DLSManager.__learnerID + "/" + _loc4_ + "/" + guid + "/" + register1 + "/" + register2 + "/" + register3 + "/";
      var _loc8_ = this.encryptURL(_loc3_,_loc4_.toString(),com.disney.dlearning.managers.DLSManager.__developerID) + "|" + this.encryptTime(_loc4_.toString());
      var _loc2_ = new LoadVars();
      _loc2_.callback = callback;
      this.configureListeners(_loc2_);
      _loc2_.addRequestHeader("DLSNetwork-Developer-ID",com.disney.dlearning.managers.DLSManager.__developerID);
      _loc2_.addRequestHeader("DLSNetwork-Request-Key",_loc8_);
      _loc2_.addRequestHeader("DLSNetwork-Sequence-ID",String(this.__sequenceID++));
      if(com.disney.dlearning.managers.DLSManager.__learnerID == "-1")
      {
         this.__localConnection.sendMessage("API",_loc3_);
      }
      try
      {
         trace("loading DLS url" + _loc3_);
         _loc2_.sendAndLoad(_loc3_,_loc2_,"POST");
      }
      catch(error:Error)
      {
      }
      return _loc5_;
   }
   function pushOpcodeToHost(host, opcode, guid, callback, register1, register2, register3)
   {
      trace("pushing opcode");
      var _loc6_ = new Date();
      var _loc4_ = Math.round(_loc6_.getTime() / 1000);
      var _loc3_ = undefined;
      var _loc5_ = this.__URLLoaderCookieId++;
      if(com.disney.dlearning.managers.DLSManager.__learnerID == "")
      {
         com.disney.dlearning.managers.DLSManager.__learnerID = "-1";
      }
      if(opcode == "")
      {
         opcode = "no_opcode_given";
      }
      if(host == "")
      {
         host = "k.api.dlsnetwork.com";
      }
      _loc3_ = "http://" + host + "/v1/opcode/pushOpcode/" + opcode + "/" + com.disney.dlearning.managers.DLSManager.__learnerID + "/" + _loc4_ + "/" + guid + "/" + register1 + "/" + register2 + "/" + register3 + "/";
      var _loc8_ = this.encryptURL(_loc3_,_loc4_.toString(),com.disney.dlearning.managers.DLSManager.__developerID) + "|" + this.encryptTime(_loc4_.toString());
      var _loc2_ = new LoadVars();
      _loc2_.callback = callback;
      this.configureListeners(_loc2_);
      _loc2_.addRequestHeader("DLSNetwork-Developer-ID",com.disney.dlearning.managers.DLSManager.__developerID);
      _loc2_.addRequestHeader("DLSNetwork-Request-Key",_loc8_);
      _loc2_.addRequestHeader("DLSNetwork-Sequence-ID",String(this.__sequenceID++));
      if(com.disney.dlearning.managers.DLSManager.__learnerID == "-1")
      {
         this.__localConnection.sendMessage("API",_loc3_);
      }
      try
      {
         trace("loading DLS url" + _loc3_);
         _loc2_.sendAndLoad(_loc3_,_loc2_,"POST");
      }
      catch(error:Error)
      {
      }
      return _loc5_;
   }
   function getAvailableContent(callback, sortingOrder)
   {
      var _loc3_ = this.__URLLoaderCookieId++;
      this.__URLCallbacks[_loc3_] = callback;
      var _loc4_ = "http://" + com.disney.dlearning.managers.DLSManager.__host + "/v1/reports/getAvailableContent/" + com.disney.dlearning.managers.DLSManager.__learnerID + "/" + sortingOrder + "/";
      var _loc2_ = new LoadVars();
      _loc2_.callback = callback;
      this.configureListeners(_loc2_);
      try
      {
         _loc2_.load(_loc4_);
      }
      catch(error:Error)
      {
      }
      return _loc3_;
   }
   function getLearnerScores(callback)
   {
      var _loc3_ = this.__URLLoaderCookieId++;
      this.__URLCallbacks[_loc3_] = callback;
      var _loc4_ = "http://" + com.disney.dlearning.managers.DLSManager.__host + "/v1/reports/getLearnerScores/" + com.disney.dlearning.managers.DLSManager.__learnerID + "/";
      var _loc2_ = new LoadVars();
      _loc2_.callback = callback;
      try
      {
         _loc2_.load(_loc4_);
      }
      catch(error:Error)
      {
      }
      return _loc3_;
   }
   function getLearnerScoreByNode(guid, callback)
   {
      var _loc3_ = this.__URLLoaderCookieId++;
      this.__URLCallbacks[_loc3_] = callback;
      var _loc4_ = "http://" + com.disney.dlearning.managers.DLSManager.__host + "/reports/getLearnerScoreByNode/" + com.disney.dlearning.managers.DLSManager.__learnerID + "/" + guid + "/";
      var _loc2_ = new LoadVars();
      _loc2_.callback = callback;
      this.configureListeners(_loc2_);
      _loc2_.learner = com.disney.dlearning.managers.DLSManager.__learnerID;
      try
      {
         _loc2_.load(_loc4_);
      }
      catch(error:Error)
      {
      }
      return _loc3_;
   }
   function isContentUnlocked(guid, callback)
   {
      var _loc3_ = this.__URLLoaderCookieId++;
      this.__URLCallbacks[_loc3_] = callback;
      var _loc4_ = "http://" + com.disney.dlearning.managers.DLSManager.__host + "/v1/content/getAvailableContent/" + com.disney.dlearning.managers.DLSManager.__learnerID + "/" + guid + "/";
      var _loc2_ = new LoadVars();
      _loc2_.callback = callback;
      this.configureListeners(_loc2_);
      try
      {
         _loc2_.load(_loc4_);
      }
      catch(error:Error)
      {
      }
      return _loc3_;
   }
   function callback()
   {
   }
   function configureListeners(target)
   {
      target.hostThis = this;
   }
   function encryptURL(url, timestamp, developerId)
   {
      var _loc3_ = new com.disney.dlearning.security.Md5();
      var _loc1_ = url + timestamp + developerId + "_Salt";
      var _loc2_ = _loc3_.hash(_loc1_);
      return _loc2_;
   }
   function encryptTime(time)
   {
      return time;
   }
}
