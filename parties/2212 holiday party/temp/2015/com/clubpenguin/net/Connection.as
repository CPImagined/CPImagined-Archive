class com.clubpenguin.net.Connection extends XMLSocket implements com.clubpenguin.net.IConnection
{
   var isConnected = false;
   var changingRoom = false;
   var preConnection = true;
   var majVersion = 1;
   var minVersion = 5;
   var subVersion = 3;
   var MAX_SENT_COMMANDS_BUFFER_LENGTH = 10;
   var sentCommandsBuffer = [];
   var serverMessageDelimiter = "%";
   var socketConnectionTimeout = 30000;
   var debug = true;
   function Connection()
   {
      super();
      this.initialize();
      this._responded = new org.osflash.signals.Signal(String,Array);
      this.onConnect = this.connectionEstablished;
      this.onData = this.gotData;
      this.onXML = this.xmlReceived;
      this.onClose = this.connectionClosed;
      this.messageHandlers = new Object();
      this.setupMessageHandlers();
      this.arrayTags = {uLs:true,rmList:true,vars:true,bList:true,vs:true,mv:true};
      this.disabledCommands = [];
   }
   function getSentCommandsBuffer()
   {
      return this.sentCommandsBuffer;
   }
   function getResponded()
   {
      return this._responded;
   }
   function login(zone, nick, pass, confirmationHash, loginDataRaw)
   {
      var _loc3_ = {t:"sys"};
      var _loc2_ = undefined;
      if(confirmationHash)
      {
         _loc2_ = "<login z=\'" + zone + "\'><nick><![CDATA[" + loginDataRaw + "]]></nick><pword><![CDATA[" + pass + "#" + confirmationHash + "]]></pword></login>";
      }
      else
      {
         _loc2_ = "<login z=\'" + zone + "\'><nick><![CDATA[" + nick + "]]></nick><pword><![CDATA[" + pass + "]]></pword></login>";
      }
      this.send(_loc3_,"login",0,_loc2_);
   }
   function connect(ipAdr, port)
   {
      if(!this.isConnected)
      {
         this.ipAddress = ipAdr;
         this.port = port;
         super.connect(ipAdr,port);
         this.socketConnectionTimeoutThread = setInterval(com.clubpenguin.util.Delegate.create(this,this.socketTimeoutHandler),this.socketConnectionTimeout);
      }
   }
   function xmlReceived(message)
   {
      var _loc2_ = new Object();
      this.message2Object(message.childNodes,_loc2_);
      if(!this.debug)
      {
      }
      var _loc3_ = _loc2_.msg.attributes.t;
      this.messageHandlers[_loc3_].handleMessage(_loc2_.msg.body,this,"xml");
   }
   function socketTimeoutHandler()
   {
      if(this.socketConnectionTimeoutThread != null)
      {
         clearInterval(this.socketConnectionTimeoutThread);
         delete this.socketConnectionTimeoutThread;
      }
      this.preConnection = false;
      this.onConnection(false);
      this.close();
   }
   function getRandomKey()
   {
      this.send({t:"sys"},"rndK",-1,"");
   }
   function disconnect()
   {
      this.close();
      this.isConnected = false;
      this.initialize();
   }
   function connected()
   {
      return this.isConnected;
   }
   function message2Object(xmlNodes, parentObj)
   {
      var _loc8_ = 0;
      var _loc3_ = null;
      while(_loc8_ < xmlNodes.length)
      {
         var _loc4_ = xmlNodes[_loc8_];
         var _loc5_ = _loc4_.nodeName;
         var _loc6_ = _loc4_.nodeValue;
         if(parentObj instanceof Array)
         {
            _loc3_ = {};
            parentObj.push(_loc3_);
            _loc3_ = parentObj[parentObj.length - 1];
         }
         else
         {
            parentObj[_loc5_] = new Object();
            _loc3_ = parentObj[_loc5_];
         }
         for(var _loc11_ in _loc4_.attributes)
         {
            if(typeof _loc3_.attributes == "undefined")
            {
               _loc3_.attributes = {};
            }
            var _loc2_ = _loc4_.attributes[_loc11_];
            if(!isNaN(Number(_loc2_)))
            {
               _loc2_ = Number(_loc2_);
            }
            if(_loc2_.toLowerCase() == "true")
            {
               _loc2_ = true;
            }
            else if(_loc2_.toLowerCase() == "false")
            {
               _loc2_ = false;
            }
            _loc3_.attributes[_loc11_] = _loc2_;
         }
         if(this.arrayTags[_loc5_])
         {
            _loc3_[_loc5_] = [];
            _loc3_ = _loc3_[_loc5_];
         }
         if(_loc4_.hasChildNodes() && _loc4_.firstChild.nodeValue == undefined)
         {
            var _loc9_ = _loc4_.childNodes;
            this.message2Object(_loc9_,_loc3_);
         }
         else
         {
            _loc6_ = _loc4_.firstChild.nodeValue;
            if(!isNaN(_loc6_) && _loc4_.nodeName != "txt" && _loc4_.nodeName != "var")
            {
               _loc6_ = Number(_loc6_);
            }
            _loc3_.value = _loc6_;
         }
         _loc8_ = _loc8_ + 1;
      }
   }
   function makeHeader(headerObj)
   {
      var _loc2_ = "<msg";
      for(var _loc3_ in headerObj)
      {
         _loc2_ += " " + _loc3_ + "=\'" + headerObj[_loc3_] + "\'";
      }
      _loc2_ += ">";
      return _loc2_;
   }
   function closeHeader()
   {
      return "</msg>";
   }
   function send(header, action, fromRoom, message)
   {
      var _loc3_ = this.makeHeader(header);
      _loc3_ += "<body action=\'" + action + "\' r=\'" + fromRoom + "\'>" + message + "</body>" + this.closeHeader();
      com.clubpenguin.util.Log.info("--> [Sending]:  " + _loc3_ + "\n",com.clubpenguin.util.Log.SOCKET);
      super.send(_loc3_);
   }
   function sendXtMessage(xtName, cmdName, paramObj, type, roomId)
   {
      if(this.isBlocked)
      {
         return undefined;
      }
      var _loc3_ = cmdName.split("#")[1];
      var _loc2_ = 0;
      while(_loc2_ < this.disabledCommands.length)
      {
         if(this.disabledCommands[_loc2_] == _loc3_)
         {
            return undefined;
         }
         _loc2_ = _loc2_ + 1;
      }
      if(roomId == undefined)
      {
         roomId = this.activeRoomId;
      }
      if(type == undefined)
      {
         type = "str";
      }
      if(type == "str")
      {
         var _loc5_ = undefined;
         _loc5_ = this.serverMessageDelimiter + "xt" + this.serverMessageDelimiter + xtName + this.serverMessageDelimiter + cmdName + this.serverMessageDelimiter + roomId + this.serverMessageDelimiter;
         _loc2_ = 0;
         while(_loc2_ < paramObj.length)
         {
            _loc5_ += paramObj[_loc2_].toString() + this.serverMessageDelimiter;
            _loc2_ = _loc2_ + 1;
         }
         this.sendString(_loc5_);
      }
   }
   function initialize(isLogout)
   {
      if(isLogout == undefined)
      {
         isLogout = false;
      }
      this.roomList = {};
      this.buddyList = [];
      this.myBuddyVars = [];
      this.activeRoomId = null;
      this.myUserId = null;
      this.myUserName = "";
      this.playerId = null;
      this.changingRoom = false;
      this.amIModerator = false;
      if(!isLogout)
      {
         this.isConnected = false;
      }
   }
   function sendString(message)
   {
      com.clubpenguin.util.Log.info("--> [Sending]:  " + message,com.clubpenguin.util.Log.SOCKET);
      this.sentCommandsBuffer.push(message);
      if(this.sentCommandsBuffer.length > this.MAX_SENT_COMMANDS_BUFFER_LENGTH)
      {
         this.sentCommandsBuffer.splice(0,1);
      }
      super.send(message);
   }
   function connectionEstablished(ok)
   {
      if(ok)
      {
         if(this.socketConnectionTimeoutThread != null)
         {
            clearInterval(this.socketConnectionTimeoutThread);
            delete this.socketConnectionTimeoutThread;
         }
         this.preConnection = false;
         var _loc4_ = {t:"sys"};
         var _loc3_ = "<ver v=\'" + this.majVersion.toString() + this.minVersion.toString() + this.subVersion.toString() + "\' />";
         this.send(_loc4_,"verChk",0,_loc3_);
      }
      else if(flash.external.ExternalInterface.available)
      {
         flash.external.ExternalInterface.call("console.log","Connection.connectionEstablished ok:" + ok);
      }
   }
   function connectionClosed()
   {
      this.isConnected = false;
      if(this.preConnection)
      {
         this.connectionEstablished(false);
      }
      else
      {
         this.initialize();
         this.onConnectionLost();
      }
   }
   function gotData(message)
   {
      if(message.charAt(0) == this.serverMessageDelimiter)
      {
         this.strReceived(message);
      }
      else if(message.charAt(0) == "<")
      {
         this.onXML(new XML(message));
      }
   }
   function strReceived(message)
   {
      var _loc4_ = message.substr(1,message.length - 2).split(this.serverMessageDelimiter);
      var _loc3_ = _loc4_[1];
      var _loc7_ = _loc4_.slice(2);
      var _loc2_ = 0;
      while(_loc2_ < this.disabledCommands.length)
      {
         if(_loc3_ == this.disabledCommands[_loc2_])
         {
            return undefined;
         }
         _loc2_ = _loc2_ + 1;
      }
      com.clubpenguin.util.Log.info("<-- [Received]: " + message,com.clubpenguin.util.Log.SOCKET);
      var _loc6_ = _loc4_[0];
      this._responded.dispatch(_loc3_,_loc7_);
      this.messageHandlers[_loc6_].handleMessage(_loc4_.splice(1,_loc4_.length - 1),this,"str");
   }
   function setupMessageHandlers()
   {
      this.addMessageHandler("sys",this.handleSysMessages);
      this.addMessageHandler("xt",com.clubpenguin.util.Delegate.create(this,this.handleExtensionMessages));
   }
   function addMessageHandler(handlerId, handlerMethod)
   {
      if(this.messageHandlers[handlerId] == undefined)
      {
         this.messageHandlers[handlerId] = new Object();
         this.messageHandlers[handlerId].handleMessage = handlerMethod;
      }
   }
   function handleExtensionMessages(dataObj, scope, type)
   {
      if(type == undefined)
      {
         type = "xml";
      }
      if(type == "xml")
      {
         var _loc6_ = dataObj.attributes.action;
         var _loc7_ = dataObj.attributes.r;
         if(_loc6_ == "xtRes")
         {
            var _loc4_ = dataObj.value;
            var _loc5_ = scope.os.deserialize(_loc4_);
            scope.onExtensionResponse(_loc5_,type);
         }
      }
      else if(type == "str")
      {
         scope.onExtensionResponse(dataObj,type);
      }
      else if(type == "json")
      {
         scope.onExtensionResponse(dataObj.o,type);
      }
   }
   function handleSysMessages(xmlObj, scope)
   {
      var _loc1_ = xmlObj.attributes.action;
      var _loc5_ = xmlObj.attributes.r;
      if(_loc1_ == "apiOK")
      {
         scope.isConnected = true;
         scope.onConnection(true);
      }
      else if(_loc1_ == "rndK")
      {
         var _loc2_ = xmlObj.k.value;
         scope.onRandomKey(_loc2_);
      }
   }
   function disableCommands(disabledCommands)
   {
      this.disabledCommands = disabledCommands;
   }
   function enableCommands()
   {
      this.disabledCommands = [];
   }
}
