class com.clubpenguin.net.Airtower
{
   static var linkageId = "__Packages.com.clubpenguin.net.Airtower";
   static var serializable = Object.registerClass(com.clubpenguin.net.Airtower.linkageId,com.clubpenguin.net.Airtower);
   static var $_lc = new com.clubpenguin.util.LogChannel("Airtower");
   var SERVER_MESSAGE_DELIMITER = "%";
   var STRING_TYPE = "str";
   var XML_TYPE = "xml";
   var PLAY_EXT = "s";
   var GAME_EXT = "z";
   var NAVIGATION = "j";
   var PLAYER_HANDLER = "u";
   var ITEM_HANDLER = "i";
   var IGNORE_HANDLER = "n";
   var BUDDY_HANDLER = "b";
   var TOY_HANDLER = "t";
   var TABLE_HANDLER = "a";
   var IGLOO_HANDLER = "g";
   var PET_HANDLER = "p";
   var MESSAGE_HANDLER = "m";
   var MAIL_HANDLER = "l";
   var SURVEY_HANDLER = "e";
   var WADDLE = "w";
   var SETTING_HANDLER = "s";
   var MODERATION_HANDLER = "o";
   var NINJA_HANDLER = "ni";
   var CARD_HANDLER = "cd";
   var ROOM_HANDLER = "r";
   var NEW_USER_EXPERIENCE_HANDLER = "nx";
   var PLAYER_TRANSFORMATION_HANDLER = "pt";
   var GHOST_BUSTER_HANDLER = "gb";
   var PLAYER_TICKET_HANDLER = "tic";
   var COOKIE_BAKERY_HANDLER = "ba";
   var BATTLE_ROOM_COUNTDOWN_UPDATE = "brcu";
   var BATTLE_ROOM_STATUS_UPDATE = "brsu";
   var BATTLE_ROOM_HIT_SNOWBALL = "bhs";
   var BATTLE_ROOM_THROW_SNOWBALL = "brts";
   var REDEMPTION = "red";
   var REDEMPTION_JOIN_WORLD = "rjs";
   var HANDLE_LOGIN = "l";
   var HANDLE_LOGIN_EXPIRED = "loginMustActivate";
   var HANDLE_ALERT = "a";
   var HANDLE_ERROR = "e";
   var GET_BUDDY_LIST = "gb";
   var GET_IGNORE_LIST = "gn";
   var GET_PLAYER = "gp";
   var GET_ROOM_LIST = "gr";
   var GET_TABLE = "gt";
   var JOIN_WORLD = "js";
   var JOIN_ROOM = "jr";
   var CLIENT_ROOM_LOADED = "crl";
   var REFRESH_ROOM = "grs";
   var LOAD_PLAYER = "lp";
   var ADD_PLAYER = "ap";
   var REMOVE_PLAYER = "rp";
   var UPDATE_PLAYER = "up";
   var PLAYER_MOVE = "sp";
   var PLAYER_TELEPORT = "tp";
   var REFRESH_PLAYER_FRIEND_INFORMATION = "rpfi";
   var PLAYER_FRAME = "sf";
   var PLAYER_ACTION = "sa";
   var OPEN_BOOK = "at";
   var CLOSE_BOOK = "rt";
   var THROW_BALL = "sb";
   var JOIN_GAME = "jg";
   var JOIN_NON_BLACK_HOLE_GAME = "jnbhg";
   var LEAVE_NON_BLACK_HOLE_GAME = "lnbhg";
   var SEND_MESSAGE = "sm";
   var SEND_PHRASECHAT_MESSAGE = "sc";
   var SEND_BLOCKED_MESSAGE = "mm";
   var SEND_EMOTE = "se";
   var SEND_JOKE = "sj";
   var SEND_SAFE_MESSAGE = "ss";
   var SEND_LINE_MESSAGE = "sl";
   var SEND_QUICK_MESSAGE = "sq";
   var SEND_TOUR_GUIDE_MESSAGE = "sg";
   var COIN_DIG_UPDATE = "cdu";
   var GET_INVENTORY_LIST = "gi";
   var GET_CURRENT_TOTAL_COIN = "gtc";
   var NINJA_GET_INVENTORY_LIST = "ngi";
   var GET_CURRENCIES = "currencies";
   var MAIL_START_ENGINE = "mst";
   var GET_MAIL = "mg";
   var SEND_MAIL = "ms";
   var RECEIVE_MAIL = "mr";
   var DELETE_MAIL = "md";
   var DELETE_MAIL_FROM_PLAYER = "mdp";
   var GET_MAIL_DETAILS = "mgd";
   var MAIL_CHECKED = "mc";
   var GAME_OVER = "zo";
   var BUY_INVENTORY = "ai";
   var CHECK_INVENTORY = "qi";
   var ADD_IGNORE = "an";
   var REMOVE_IGNORE = "rn";
   var REMOVE_BUDDY = "rb";
   var REQUEST_BUDDY = "br";
   var ACCEPT_BUDDY = "ba";
   var BUDDY_ONLINE = "bon";
   var BUDDY_OFFLINE = "bof";
   var FIND_BUDDY = "bf";
   var GET_PLAYER_OBJECT = "gp";
   var GET_MASCOT_OBJECT = "gmo";
   var REPORT_PLAYER = "r";
   var GET_ACTION_STATUS = "gas";
   var UPDATE_PLAYER_COLOUR = "upc";
   var UPDATE_PLAYER_HEAD = "uph";
   var UPDATE_PLAYER_FACE = "upf";
   var UPDATE_PLAYER_NECK = "upn";
   var UPDATE_PLAYER_BODY = "upb";
   var UPDATE_PLAYER_HAND = "upa";
   var UPDATE_PLAYER_FEET = "upe";
   var UPDATE_PLAYER_FLAG = "upl";
   var UPDATE_PLAYER_PHOTO = "upp";
   var UPDATE_PLAYER_REMOVE = "upr";
   var SEND_ACTION_DANCE = "sdance";
   var SEND_ACTION_WAVE = "swave";
   var SEND_ACTION_SNOWBALL = "ssnowball";
   var GET_FURNITURE_LIST = "gii";
   var UPDATE_ROOM = "up";
   var UPDATE_FLOOR = "ag";
   var UPDATE_IGLOO_TYPE = "au";
   var BUY_IGLOO_LOCATION = "aloc";
   var UNLOCK_IGLOO = "or";
   var LOCK_IGLOO = "cr";
   var UPDATE_IGLOO_MUSIC = "um";
   var GET_IGLOO_DETAILS = "gm";
   var JOIN_PLAYER_ROOM = "jp";
   var SAVE_IGLOO_FURNITURE = "ur";
   var JUMP_TO_IGLOO = "ji";
   var GET_IGLOO_LIST = "gr";
   var GET_IGLOO_LIST_ITEM = "gri";
   var PLAYER_IGLOO_OPEN = "pio";
   var BUY_FURNITURE = "af";
   var BUY_MULTIPLE_FURNITURE = "buy_multiple_furniture";
   var SEND_IGLOO = "sig";
   var GET_OWNED_IGLOOS = "go";
   var ACTIVATE_IGLOO = "ao";
   var GET_MY_PLAYER_PUFFLES = "pgu";
   var RETURN_PUFFLE = "prp";
   var GET_PLAYER_PUFFLES = "pg";
   var PUFFLE_FRAME = "ps";
   var PUFFLE_MOVE = "pm";
   var PUFFLE_VISITOR_HAT_UPDATE = "puphi";
   var ADD_A_PUFFLE = "addpuffle";
   var REST_PUFFLE = "pr";
   var BATH_PUFFLE = "pb";
   var PLAY_PUFFLE = "pp";
   var BUBBLE_GUM_PUFFLE = "pbg";
   var FEED_PUFFLE = "pf";
   var WALK_PUFFLE = "pw";
   var TREAT_PUFFLE = "pt";
   var SWAP_PUFFLE = "puffleswap";
   var WALK_SWAP_PUFFLE = "pufflewalkswap";
   var INTERACTION_PLAY = "ip";
   var INTERACTION_REST = "ir";
   var INTERACTION_FEED = "if";
   var PUFFLE_INIT_INTERACTION_PLAY = "pip";
   var PUFFLE_INIT_INTERACTION_REST = "pir";
   var ADOPT_PUFFLE = "pn";
   var PUFFLE_QUIZ_STATUS = "pgas";
   var ADD_PUFFLE_CARE_ITEM = "papi";
   var UPDATE_TABLE = "ut";
   var GET_TABLE_POPULATION = "gt";
   var JOIN_TABLE = "jt";
   var LEAVE_TABLE = "lt";
   var UPDATE_WADDLE = "uw";
   var GET_WADDLE_POPULATION = "gw";
   var GET_WADDLE_CJ = "gwcj";
   var JOIN_WADDLE = "jw";
   var LEAVE_WADDLE = "lw";
   var START_WADDLE = "sw";
   var SEND_WADDLE = "jx";
   var CARD_JITSU_MATCH_SUCCESSFUL = "cjms";
   var SPY_PHONE_REQUEST = "spy";
   var HEARTBEAT = "h";
   var TIMEOUT = "t";
   var MODERATOR_ACTION = "ma";
   var KICK = "k";
   var MUTE = "m";
   var BAN = "b";
   var INT_BAN = "initban";
   var SEND_MASCOT_MESSAGE = "sma";
   var DONATE = "dc";
   var POLL = "spl";
   var CONNECTION_LOST = "con";
   var GET_CARDS = "gcd";
   var GET_NINJA_LEVEL = "gnl";
   var GET_FIRE_LEVEL = "gfl";
   var GET_WATER_LEVEL = "gwl";
   var GET_SNOW_LEVEL = "gsl";
   var GET_NINJA_RANKS = "gnr";
   var BUY_POWER_CARDS = "bpc";
   var SET_SAVED_MAP_CATEGORY = "mcs";
   var SET_PLAYER_CARD_OPENED = "pcos";
   var SET_VISITED_CONTENT_FLAGS = "vcfs";
   var GET_VISITED_CONTENT_FLAGS = "vcf";
   var PLAYER_TRANSFORMATION = "spts";
   var GET_LAST_REVISION = "glr";
   var MOBILE_ACCOUNT_ACTIVATION_REQUIRED = "maar";
   var GET_PLAYER_ID_AND_NAME_BY_SWID = "pbs";
   var GET_PLAYER_INFO_BY_NAME = "pbn";
   var GET_PLAYER_INFO_BY_ID = "pbi";
   var GET_PLAYER_IDS_BY_SWIDS = "pbsm";
   var PBSM_START = "pbsms";
   var PBSM_FINISHED = "pbsmf";
   static var LOGIN_ZONE = "w1";
   static var SERVER_ZONE = "w1";
   var SCAVENGER_HUNT_NOTIFICATION = "shn";
   var GET_SCAVENGER_HUNT_TICKETS = "gptc";
   var INC_SCAVENGER_HUNT_TICKETS = "iptc";
   var DEC_SCAVENGER_HUNT_TICKETS = "dptc";
   var COINS_AWARDED = "$";
   var PLAYER_DIRECTOR_POINTS = "pdp";
   var GET_COINS_FOR_CHANGE_TOTALS = "gcfct";
   var CAN_PURCHASE_COOKIE = "cac";
   var PURCHASE_COOKIE = "ac";
   var COOKIES_READY = "cr";
   var GET_BAKERY_ROOM_STATE = "barsu";
   var SEND_SNOWBALL_ENTER_HOPPER = "seh";
   var GET_COOKIE_STOCK = "ctc";
   var CANCEL_COOKIE_RESERVATION = "cc";
   var GET_PARTY_COOKIE = "qpc";
   var SET_PARTY_COOKIE = "spd";
   var SET_PLAYER_TEST_GROUP_ID = "pigt";
   var UPDATE_EGG_TIMER = "uet";
   var SNOWBALL_HIT = "sh";
   var GET_AB_TEST_DATA = "gabcms";
   var GET_ACTIVE_FEATURES = "activefeatures";
   var server_ip = "";
   var server_port = 0;
   var loginObject = {};
   var username = "";
   var password = "";
   var playerId = -1;
   var rand_key = "";
   var is_logged_in = false;
   var server = null;
   var sf_listener_container = new Object();
   var isRedemption = false;
   var isJump = false;
   var isJumpToNewServerInProgress = false;
   var FRAME_LABEL_WELCOME = "welcome";
   var FRAME_LABEL_EXPIRED = "expired";
   var debugName = "";
   function Airtower(shell)
   {
      com.clubpenguin.util.Log.debug("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA");
      this.shell = shell;
      this._isBlocked = false;
   }
   function toString()
   {
      return "Airtower[" + this.debugName + "]";
   }
   function init()
   {
      var _loc2_ = this.shell.getLoginServer();
      this.LOGIN_IP = _loc2_.ip;
      com.clubpenguin.util.Log.debug("LOGIN_IP: " + this.LOGIN_IP);
      this.LOGIN_PORT = _loc2_.port;
      com.clubpenguin.util.Log.debug("LOGIN_PORT: " + this.LOGIN_PORT);
      this.sf_listener_container = new Object();
      this.server = new com.clubpenguin.net.Connection();
   }
   function getServer()
   {
      return this.server;
   }
   function setIsJumpToNewServerInProgress(isJumping)
   {
      this.isJumpToNewServerInProgress = isJumping;
   }
   function getSentCommandsBuffer()
   {
      var _loc4_ = "";
      var _loc3_ = this.getServer().getSentCommandsBuffer();
      var _loc2_ = 0;
      while(_loc2_ < _loc3_.length)
      {
         _loc4_ += _loc3_[_loc2_];
         if(_loc2_ != _loc3_.length - 1)
         {
            _loc4_ += "\n";
         }
         _loc2_ = _loc2_ + 1;
      }
      return _loc4_;
   }
   function cloneListeners(cloneTo)
   {
      for(var _loc6_ in this.sf_listener_container)
      {
         var _loc4_ = this.sf_listener_container[_loc6_];
         var _loc3_ = 0;
         while(_loc3_ < _loc4_.length)
         {
            var _loc2_ = _loc4_[_loc3_];
            com.clubpenguin.util.Log.debug("clone listener -> type: " + _loc6_ + " listener.func: " + _loc2_.func + " listener.scope: " + _loc2_.scope);
            cloneTo.addListener(_loc6_,_loc2_.func,_loc2_.scope);
            _loc3_ = _loc3_ + 1;
         }
      }
   }
   function addListener(type, func, scope)
   {
      if(type == undefined || func == undefined)
      {
         this.shell.$e("addListner() -> You must pass a valid listener type and function! type: " + type + " func: " + func);
         return false;
      }
      var _loc3_ = this.getListenersArray(type);
      var _loc4_ = this.getListenerIndex(_loc3_,func);
      if(_loc4_ == -1)
      {
         this.shell.$d("[airtower] Successfully added listener to: \"" + type + "\"");
         _loc3_.push({func:func,scope:scope});
         return true;
      }
      this.shell.$d("[airtower] Failed to add listener. Tried to add a duplicate listener to: \"" + type + "\"");
      return false;
   }
   function removeListener(type, func)
   {
      var _loc2_ = this.getListenersArray(type);
      var _loc3_ = this.getListenerIndex(_loc2_,func);
      if(_loc3_ != -1)
      {
         this.shell.$d("[airtower] Successfully removed listener from: \"" + type + "\"");
         _loc2_.splice(_loc3_,1);
         return true;
      }
      this.shell.$d("[airtower] Failed to remove listener which did not exist from: \"" + type + "\"");
      return false;
   }
   function getListenerIndex(array, func)
   {
      var _loc2_ = array.length;
      var _loc1_ = 0;
      while(_loc1_ < _loc2_)
      {
         if(array[_loc1_].func == func)
         {
            return _loc1_;
         }
         _loc1_ = _loc1_ + 1;
      }
      return -1;
   }
   function updateListeners(type, obj)
   {
      var _loc3_ = this.getListenersArray(type);
      var _loc5_ = _loc3_.length;
      if(_loc5_ < 1)
      {
         this.shell.$d("[airtower] No listeners currently attached to: \"" + type + "\"");
         return false;
      }
      if(_loc5_ == 1)
      {
         !_loc3_[0].scope ? _loc3_[0].func(obj) : _loc3_[0].func.call(_loc3_[0].scope,obj);
         return true;
      }
      var _loc2_ = 0;
      while(_loc2_ < _loc5_)
      {
         !_loc3_[_loc2_].scope ? _loc3_[_loc2_].func(obj) : _loc3_[_loc2_].func.call(_loc3_[_loc2_].scope,obj);
         _loc2_ = _loc2_ + 1;
      }
      return true;
   }
   function getListenersArray(type)
   {
      if(this.sf_listener_container[type] == undefined)
      {
         this.sf_listener_container[type] = new Array();
      }
      return this.sf_listener_container[type];
   }
   function onAirtowerResponse(eventData, type, overrideBlock)
   {
      if(!this._isBlocked || overrideBlock == true)
      {
         com.clubpenguin.util.Log.debug("Airtower.onAirTowerResponse eventData " + eventData);
         var _loc2_ = String(eventData[0]);
         if(com.clubpenguin.net.BridgeFilter.messageIsSentToAS3(this,_loc2_))
         {
            this.shell.sendAirtowerEvent(eventData.join(this.SERVER_MESSAGE_DELIMITER) + this.SERVER_MESSAGE_DELIMITER);
         }
         com.clubpenguin.util.Log.debug("onAirtowerResponse (eventType = " + _loc2_ + ")",com.clubpenguin.net.Airtower.$_lc);
         com.clubpenguin.util.Log.debug("onAirtowerResponse after service test (eventType = " + _loc2_ + ")",com.clubpenguin.net.Airtower.$_lc);
         eventData.shift();
         switch(_loc2_)
         {
            case "gwcj":
            case "gw":
            case "jw":
            case "sw":
            case "cjms":
            case "jx":
            case "gz":
            case "jz":
            case "uz":
            case "sz":
            case "uw":
               this.sendAck(_loc2_,eventData.slice());
         }
         this.updateListeners(_loc2_,eventData);
      }
   }
   function sendAck(command, data)
   {
      data = data.slice();
      data.unshift(command);
      data.unshift("time=" + String(new Date().getTime()));
      this.send(this.PLAY_EXT,"bi#ack",data,"str",_global.getCurrentShell().getCurrentServerRoomId());
   }
   function isBlocked()
   {
      return this._isBlocked;
   }
   function block()
   {
      this._isBlocked = true;
      this.server.isBlocked = true;
      this.server.onConnectionLost = null;
   }
   function unblock()
   {
      this._isBlocked = false;
      this.server.isBlocked = false;
      this.server.onConnectionLost = com.clubpenguin.util.Delegate.create(this,this.handleLostConnection);
   }
   function setConnection(connection)
   {
      this.server = connection || this.server;
   }
   function setUsername(in_username)
   {
      this.username = in_username;
   }
   function setPlayerId(in_playerId)
   {
      this.playerId = in_playerId;
   }
   function connectToLogin(in_username, in_pass, login_response, doAutoLogin)
   {
      com.clubpenguin.util.Log.debug("\n");
      com.clubpenguin.util.Log.debug("********************************************************************");
      com.clubpenguin.util.Log.debug("connectToLogin");
      com.clubpenguin.util.Log.debug("this = " + this);
      com.clubpenguin.util.Log.debug("in_username: " + in_username);
      com.clubpenguin.util.Log.debug("in_pass: " + in_pass);
      com.clubpenguin.util.Log.debug("login_response: " + login_response);
      com.clubpenguin.util.Log.debug("doAutoLogin: " + doAutoLogin);
      com.clubpenguin.util.Log.debug("server: " + this.server);
      com.clubpenguin.util.Log.debug("server.connected(); " + this.server.connected());
      com.clubpenguin.util.Log.debug("is_logged_in: " + this.is_logged_in);
      if(!this.is_logged_in)
      {
         if(this.server.connected())
         {
            this.server.disconnect();
         }
         this.on_login_response = login_response;
         this.username = in_username;
         this.password = in_pass;
         this.autoLogin = doAutoLogin;
         this.server.onConnection = com.clubpenguin.util.Delegate.create(this,this.handleLoginConnection);
         this.server.onRandomKey = com.clubpenguin.util.Delegate.create(this,this.handleLoginRandomKey);
         this.server.onExtensionResponse = com.clubpenguin.util.Delegate.create(this,this.onAirtowerResponse);
         this.server.debug = true;
         this.addListener(this.HANDLE_LOGIN,this.handleOnLogin,this);
         this.addListener(this.HANDLE_LOGIN_EXPIRED,this.handleExpiredPreactivationLogin,this);
         this.server.connect(this.LOGIN_IP,this.LOGIN_PORT);
      }
      else
      {
         this.shell.$e("connectToLogin() -> Your already logged in! Cant login again");
      }
      com.clubpenguin.util.Log.debug("********************************************************************");
   }
   function handleLostConnection()
   {
      com.clubpenguin.util.Log.debug("Airtower.handleLostConnection() this = " + this);
      if(!this.isJumpToNewServerInProgress)
      {
         this.shell.sendIdlePlayerTimeout();
      }
      this.updateListeners(this.CONNECTION_LOST,null);
   }
   function handleLoginConnection(success)
   {
      if(success)
      {
         this.server.getRandomKey();
      }
      else
      {
         this.server.disconnect();
         this.on_login_response(false);
      }
   }
   function handleLoginRandomKey(key)
   {
      this.rand_key = key;
      this.login();
   }
   function login()
   {
      if(!this.autoLogin)
      {
         this.server.login(com.clubpenguin.net.Airtower.LOGIN_ZONE,this.username,this.getLoginHash());
      }
      else
      {
         this.server.login(com.clubpenguin.net.Airtower.LOGIN_ZONE,this.username,this.password);
      }
   }
   function handleOnLogin(serverResponse)
   {
      this.removeListener(this.HANDLE_LOGIN,this.handleOnLogin);
      this.removeListener(this.HANDLE_LOGIN_EXPIRED,this.handleExpiredPreactivationLogin,this);
      this.server.disconnect();
      com.clubpenguin.util.Log.debug("handleOnLogin: " + serverResponse);
      var _loc5_ = serverResponse[1].split("|");
      this.loginObject = {};
      this.loginObject.loginDataRaw = serverResponse[1];
      this.loginObject.playerID = _loc5_[0];
      this.loginObject.swid = _loc5_[1];
      this.loginObject.username = _loc5_[2];
      this.loginObject.loginKey = _loc5_[3];
      this.loginObject.languageApproved = _loc5_[5];
      this.loginObject.languageRejected = _loc5_[6];
      this.loginObject.friendsLoginKey = serverResponse[3];
      this.loginObject.confirmationHash = serverResponse[2];
      this.loginObject.emailAddress = serverResponse[5];
      if(serverResponse[6] != null)
      {
         var _loc3_ = serverResponse[6].split("|");
         this.loginObject.remaining_hours = _loc3_[0];
         this.loginObject.trialMax = _loc3_[1];
         this.loginObject.max_grace_hours = _loc3_[2];
         var _loc6_ = new Object();
         _loc6_.modalBackgroundEnbaled = true;
         _loc6_.blockPuffleNotifications = true;
         _loc6_.hideLoadingDialog = true;
         var _loc4_ = new Object();
         _loc4_.state = this.FRAME_LABEL_WELCOME;
         _loc4_.trialRemaining = _loc3_[0];
         _loc4_.trialMax = _loc3_[1];
         _loc4_.graceMax = _loc3_[2];
         _loc4_.confirmationHash = this.loginObject.confirmationHash;
         _loc4_.loginDataRaw = this.loginObject.loginDataRaw;
         this.shell.sendOpenAS3Module("preactivation",_loc4_,_loc6_);
         flash.external.ExternalInterface.call("showActivationBanner",_loc3_[0]);
      }
      for(var _loc7_ in serverResponse)
      {
      }
      for(var _loc8_ in this.loginObject)
      {
         com.clubpenguin.util.Log.debug("loginObject." + _loc8_ + ":" + this.loginObject[_loc8_]);
      }
      this.shell.playerModel.initMyPlayer(this.loginObject);
      this.playerId = this.loginObject.playerID;
      this.shell.updateWorldPopulations(serverResponse[4]);
      var _loc9_ = new Object();
      _loc9_.type = 15;
      _loc9_.playerSWID = this.loginObject.swid;
      _loc9_.playerID = this.loginObject.playerID;
      this.shell.sendPlaydomTracking(_loc9_);
      this.on_login_response(true);
      this.is_logged_in = true;
      com.clubpenguin.login.LoginFloodManager.clearFloodControl();
      var _loc10_ = this.shell.getLanguageBitmask();
      com.clubpenguin.util.Log.debug("\t-loginObject.languageRejected: " + this.loginObject.languageRejected);
      com.clubpenguin.util.Log.debug("\t-lang: " + _loc10_);
      com.clubpenguin.util.Log.debug(" -loginObject.languageRejected & lang: " + this.loginObject.languageRejected + _loc10_);
      if(this.loginObject.languageRejected & _loc10_)
      {
         com.clubpenguin.util.Log.debug("calling out to nameResubmission");
         flash.external.ExternalInterface.call("nameResubmission",this.loginObject.playerID,this.loginObject.confirmationHash,this.loginObject.loginDataRaw);
      }
   }
   function handleExpiredPreactivationLogin(serverResponse)
   {
      this.removeListener(this.HANDLE_LOGIN,this.handleOnLogin);
      this.removeListener(this.HANDLE_LOGIN_EXPIRED,this.handleExpiredPreactivationLogin,this);
      var _loc3_ = new Object();
      _loc3_.modalBackgroundEnbaled = true;
      _loc3_.blockPuffleNotifications = true;
      _loc3_.hideLoadingDialog = true;
      var _loc2_ = new Object();
      _loc2_.state = this.FRAME_LABEL_EXPIRED;
      _loc2_.graceRemaining = serverResponse[1];
      _loc2_.confirmationHash = serverResponse[2];
      _loc2_.loginDataRaw = serverResponse[3];
      _loc2_.emailAddress = serverResponse[4];
      this.shell.sendOpenAS3Module("preactivation",_loc2_,_loc3_);
      var _loc4_ = this.shell.getLanguageBitmask();
      if(this.loginObject.languageRejected & _loc4_)
      {
         flash.external.ExternalInterface.call("nameResubmission",this.loginObject.playerID,this.loginObject.confirmationHash,this.loginObject.loginDataRaw);
      }
   }
   function connectToRedemption(server_ip, server_port, connect_to_world_response)
   {
      this.isRedemption = true;
      this.on_world_response = connect_to_world_response;
      this.server.onConnection = com.clubpenguin.util.Delegate.create(this,this.handleWorldConnection);
      this.server.onRandomKey = com.clubpenguin.util.Delegate.create(this,this.handleWorldRandomKey);
      this.addListener(this.HANDLE_LOGIN,this.joinWorld,this);
      this.server.connect(server_ip,server_port);
   }
   function connectToWorld(server_ip, server_port, connect_to_world_response, loginKey)
   {
      this.isRedemption = false;
      this.on_world_response = connect_to_world_response;
      this.server.onConnection = com.clubpenguin.util.Delegate.create(this,this.handleWorldConnection);
      this.server.onRandomKey = com.clubpenguin.util.Delegate.create(this,this.handleWorldRandomKey);
      this.server.onExtensionResponse = com.clubpenguin.util.Delegate.create(this,this.onAirtowerResponse);
      this.server.debug = true;
      this.addListener(this.HANDLE_LOGIN,this.joinWorld,this);
      this.server.connect(server_ip,server_port);
   }
   function handleWorldConnection(success)
   {
      if(success)
      {
         this.server.getRandomKey();
      }
      else
      {
         this.server.onConnection = null;
         this.server.onConnectionLost = null;
         this.server.onRandomKey = null;
         this.server.onExtensionResponse = null;
         this.on_world_response(false,false,false,false,false);
         this.on_world_response = null;
      }
   }
   function handleWorldRandomKey(key)
   {
      this.rand_key = key;
      this.worldLogin();
   }
   function worldLogin()
   {
      com.clubpenguin.util.Log.debug("worldLogin isJump = " + this.isJump + "   use encryption");
      var _loc2_ = this.encryptPassword(this.loginObject.loginKey + this.rand_key) + this.loginObject.loginKey;
      this.server.login(com.clubpenguin.net.Airtower.SERVER_ZONE,this.loginObject.Username,_loc2_,this.shell.getMyPlayerObject().confirmationHash,this.shell.getMyPlayerObject().loginDataRaw);
   }
   function joinWorld()
   {
      this.removeListener(this.HANDLE_LOGIN,this.joinWorld);
      this.server.onConnectionLost = com.clubpenguin.util.Delegate.create(this,this.handleLostConnection);
      var _loc2_ = new Array();
      if(this.isRedemption)
      {
         _loc2_.push(this.loginObject.loginDataRaw);
         _loc2_.push(this.loginObject.confirmationHash);
      }
      else
      {
         _loc2_.push(this.playerId);
         _loc2_.push(this.loginObject.loginKey);
      }
      _loc2_.push(this.shell.getLanguageAbbriviation());
      if(!this.isJump)
      {
         var _loc3_ = com.clubpenguin.util.QueryParams.getQueryParams();
         if(Number(_loc3_.rm))
         {
            _loc2_.push(Number(_loc3_.rm));
         }
      }
      else
      {
         _loc2_.push("jmp");
      }
      if(this.isRedemption)
      {
         this.addListener(this.REDEMPTION_JOIN_WORLD,this.handleJoinRedemption,this);
         this.send(this.REDEMPTION,this.REDEMPTION_JOIN_WORLD,_loc2_,"str",-1);
         return undefined;
      }
      this.addListener(this.JOIN_WORLD,this.handleJoinWorld,this);
      this.addListener(this.GET_ACTIVE_FEATURES,this.handleGetActiveFeatures,this);
      this.send(this.PLAY_EXT,this.NAVIGATION + "#" + this.JOIN_WORLD,_loc2_,"str",-1);
   }
   function handleJoinRedemption(obj)
   {
      this.removeListener(this.REDEMPTION_JOIN_WORLD,this.handleJoinRedemption);
      var _loc4_ = new Array();
      var _loc5_ = new Array();
      var _loc6_ = false;
      var _loc7_ = obj.shift();
      if(obj[0] != "")
      {
         _loc4_ = obj[0];
      }
      if(obj[1] != "")
      {
         _loc5_ = obj[1];
      }
      if(obj[2] != "")
      {
         _loc6_ = Boolean(Number(obj[2]));
      }
      var _loc3_ = new Array();
      _loc3_[0] = _loc4_;
      _loc3_[1] = _loc5_;
      _loc3_[2] = _loc6_;
      this.on_world_response(_loc3_);
      this.on_world_response = undefined;
   }
   function handleJoinWorld(obj)
   {
      com.clubpenguin.util.Log.debug("\n");
      com.clubpenguin.util.Log.debug("*********************************************");
      com.clubpenguin.util.Log.debug("handleJoinWorld");
      for(var _loc3_ in obj)
      {
         com.clubpenguin.util.Log.debug("prop: " + _loc3_ + "  " + obj[_loc3_]);
      }
      com.clubpenguin.util.Log.debug("*********************************************");
      this.removeListener(this.JOIN_WORLD,this.handleJoinWorld);
      var _loc6_ = Boolean(Number(obj[1]));
      var _loc4_ = Boolean(Number(obj[2]));
      var _loc5_ = Boolean(Number(obj[4]));
      this.shell.playerModel.setUpModeratorPenguin(Number(obj[3]));
      this.on_world_response(true,_loc6_,_loc4_,_loc5_);
      this.on_world_response = undefined;
      this.isJump = false;
      this.shell.sendGetABTestData();
      this.send(this.PLAY_EXT,this.NEW_USER_EXPERIENCE_HANDLER + "#" + this.GET_ACTION_STATUS,null,"str",-1);
      this.addListener(this.GET_ACTION_STATUS,this.handleGetActionStatus,this);
   }
   function handleGetActionStatus(serverResponse)
   {
      com.clubpenguin.util.Log.debug("handleGetActionStatus: " + serverResponse);
      this.removeListener(this.GET_ACTION_STATUS,this.handleGetActionStatus);
      var _loc4_ = new Array(serverResponse[1],serverResponse[2],serverResponse[3]);
      this.shell.playerModel.initActionStatus(_loc4_);
      _global.getCurrentEngine().localPlayerSpecialActionIndicators();
   }
   function handleGetActiveFeatures(obj)
   {
      this.removeListener(this.GET_ACTIVE_FEATURES,this.handleGetActiveFeatures);
      this.shell.activeFeaturesArray = obj.slice(1);
      this.shell.updateListeners(this.shell.UPDATE_ACTIVE_FEATURES);
   }
   function send(extension, command, arr, type, room_id)
   {
      com.clubpenguin.util.Log.debug("@@@@@ Airtower.send()  this=" + this);
      this.server.sendXtMessage(extension,command,arr,type,room_id);
   }
   function disconnect(disconnectFriends)
   {
      com.clubpenguin.util.Log.debug("[airtower] disconnect() this = " + this + "  disconnectFriends=" + disconnectFriends);
      if(disconnectFriends == undefined)
      {
         disconnectFriends = true;
      }
      if(this.server.connected())
      {
         if(!this.isJumpToNewServerInProgress)
         {
            if(disconnectFriends)
            {
               this.shell.disconnectFromFriends();
            }
         }
         this.server.disconnect();
      }
      else
      {
         this.shell.$d("[airtower] disconnect() -> Trying to disconnect the server when its not connected");
      }
   }
   function getLoginHash()
   {
      var _loc2_ = this.encryptPassword(this.password).toUpperCase();
      _loc2_ = this.encryptPassword(_loc2_ + this.rand_key + this.encryptPassword((_loc2_ += this.password) + this.encryptPassword(this.password += _loc2_)));
      return _loc2_;
   }
   function hex_md5(s)
   {
      return com.clubpenguin.crypto.MD5.hash(s);
   }
   function encryptPassword(pass)
   {
      var _loc1_ = com.clubpenguin.crypto.MD5.hash(pass);
      _loc1_ = _loc1_.substr(16,16) + "" + _loc1_.substr(0,16);
      return _loc1_;
   }
}
