dynamic class com.clubpenguin.net.Connection extends XMLSocket implements com.clubpenguin.net.IConnection
{
    var isConnected: Boolean = false;
    var changingRoom: Boolean = false;
    var preConnection: Boolean = true;
    var majVersion: Number = 1;
    var minVersion: Number = 5;
    var subVersion: Number = 3;
    var MAX_SENT_COMMANDS_BUFFER_LENGTH: Number = 10;
    var sentCommandsBuffer = [];
    var serverMessageDelimiter: String = "%";
    var socketConnectionTimeout: Number = 30000;
    var debug: Boolean = true;
    var _responded;
    var activeRoomId;
    var amIModerator;
    var arrayTags;
    var buddyList;
    var close;
    var disabledCommands;
    var ipAddress;
    var isBlocked;
    var messageHandlers;
    var myBuddyVars;
    var myUserId;
    var myUserName;
    var onClose;
    var onConnect;
    var onConnection;
    var onConnectionLost;
    var onData;
    var onXML;
    var playerId;
    var port;
    var roomList;
    var socketConnectionTimeoutThread;

    function Connection()
    {
        super();
        this.initialize();
        this._responded = new org.osflash.signals.Signal(String, Array);
        this.onConnect = this.connectionEstablished;
        this.onData = this.gotData;
        this.onXML = this.xmlReceived;
        this.onClose = this.connectionClosed;
        this.messageHandlers = new Object();
        this.setupMessageHandlers();
        this.arrayTags = {uLs: true, rmList: true, vars: true, bList: true, vs: true, mv: true};
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
        var __reg3 = {t: "sys"};
        var __reg2 = undefined;
        if (confirmationHash) 
        {
            __reg2 = "<login z=\'" + zone + "\'><nick><![CDATA[" + loginDataRaw + "]]></nick><pword><![CDATA[" + pass + "#" + confirmationHash + "]]></pword></login>";
        }
        else 
        {
            __reg2 = "<login z=\'" + zone + "\'><nick><![CDATA[" + nick + "]]></nick><pword><![CDATA[" + pass + "]]></pword></login>";
        }
        this.send(__reg3, "login", 0, __reg2);
    }

    function connect(ipAdr, port)
    {
        if (this.isConnected) 
        {
            return undefined;
        }
        this.ipAddress = ipAdr;
        this.port = port;
        super.connect(ipAdr, port);
        this.socketConnectionTimeoutThread = setInterval(com.clubpenguin.util.Delegate.create(this, this.socketTimeoutHandler), this.socketConnectionTimeout);
        return undefined;
    }

    function xmlReceived(message)
    {
        var __reg2 = new Object();
        this.message2Object(message.childNodes, __reg2);
        !this.debug;
        var __reg3 = __reg2.msg.attributes.t;
        this.messageHandlers[__reg3].handleMessage(__reg2.msg.body, this, "xml");
    }

    function socketTimeoutHandler()
    {
        if (this.socketConnectionTimeoutThread != null) 
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
        this.send({t: "sys"}, "rndK", -1, "");
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
        var __reg8 = 0;
        var __reg3 = null;
        for (;;) 
        {
            if (__reg8 >= xmlNodes.length) 
            {
                return undefined;
            }
            var __reg4 = xmlNodes[__reg8];
            var __reg6 = __reg4.nodeName;
            var __reg5 = __reg4.nodeValue;
            if (parentObj instanceof Array) 
            {
                __reg3 = {};
                parentObj.push(__reg3);
                __reg3 = parentObj[parentObj.length - 1];
            }
            else 
            {
                parentObj[__reg6] = new Object();
                __reg3 = parentObj[__reg6];
            }
            for (var __reg11 in __reg4.attributes) 
            {
                if (typeof __reg3.attributes == "undefined") 
                {
                    __reg3.attributes = {};
                }
                var __reg2 = __reg4.attributes[__reg11];
                if (!isNaN(Number(__reg2))) 
                {
                    __reg2 = Number(__reg2);
                }
                if (__reg2.toLowerCase() == "true") 
                {
                    __reg2 = true;
                }
                else if (__reg2.toLowerCase() == "false") 
                {
                    __reg2 = false;
                }
                __reg3.attributes[__reg11] = __reg2;
            }
            if (this.arrayTags[__reg6]) 
            {
                __reg3[__reg6] = [];
                __reg3 = __reg3[__reg6];
            }
            if (__reg4.hasChildNodes() && __reg4.firstChild.nodeValue == undefined) 
            {
                var __reg9 = __reg4.childNodes;
                this.message2Object(__reg9, __reg3);
            }
            else 
            {
                __reg5 = __reg4.firstChild.nodeValue;
                if (!isNaN(__reg5) && __reg4.nodeName != "txt" && __reg4.nodeName != "var") 
                {
                    __reg5 = Number(__reg5);
                }
                __reg3.value = __reg5;
            }
            ++__reg8;
        }
    }

    function makeHeader(headerObj)
    {
        var __reg1 = "<msg";
        for (var __reg3 in headerObj) 
        {
            __reg1 = __reg1 + (" " + __reg3 + "=\'" + headerObj[__reg3] + "\'");
        }
        __reg1 = __reg1 + ">";
        return __reg1;
    }

    function closeHeader()
    {
        return "</msg>";
    }

    function send(header, action, fromRoom, message)
    {
        var __reg3 = this.makeHeader(header);
        __reg3 = __reg3 + ("<body action=\'" + action + "\' r=\'" + fromRoom + "\'>" + message + "</body>" + this.closeHeader());
        com.clubpenguin.util.Log.info("--> [Sending]:  " + __reg3 + "\n", com.clubpenguin.util.Log.SOCKET);
        super.send(__reg3);
    }

    function sendXtMessage(xtName, cmdName, paramObj, type, roomId)
    {
        if (this.isBlocked) 
        {
            return undefined;
        }
        var __reg5 = cmdName.split("#")[1];
        var __reg2 = 0;
        while (__reg2 < this.disabledCommands.length) 
        {
            if (this.disabledCommands[__reg2] == __reg5) 
            {
                return undefined;
            }
            ++__reg2;
        }
        if (roomId == undefined) 
        {
            roomId = this.activeRoomId;
        }
        if (type == undefined) 
        {
            type = "str";
        }
        if (type == "str") 
        {
            var __reg3 = undefined;
            __reg3 = this.serverMessageDelimiter + "xt" + this.serverMessageDelimiter + xtName + this.serverMessageDelimiter + cmdName + this.serverMessageDelimiter + roomId + this.serverMessageDelimiter;
            __reg2 = 0;
            while (__reg2 < paramObj.length) 
            {
                __reg3 = __reg3 + (paramObj[__reg2].toString() + this.serverMessageDelimiter);
                ++__reg2;
            }
            this.sendString(__reg3);
        }
    }

    function initialize(isLogout)
    {
        if (isLogout == undefined) 
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
        if (isLogout) 
        {
            return undefined;
        }
        this.isConnected = false;
    }

    function sendString(message)
    {
        com.clubpenguin.util.Log.info("--> [Sending]:  " + message, com.clubpenguin.util.Log.SOCKET);
        this.sentCommandsBuffer.push(message);
        if (this.sentCommandsBuffer.length > this.MAX_SENT_COMMANDS_BUFFER_LENGTH) 
        {
            this.sentCommandsBuffer.splice(0, 1);
        }
        super.send(message);
    }

    function connectionEstablished(ok)
    {
        if (ok) 
        {
            if (this.socketConnectionTimeoutThread != null) 
            {
                clearInterval(this.socketConnectionTimeoutThread);
                delete this.socketConnectionTimeoutThread;
            }
            this.preConnection = false;
            var __reg2 = {t: "sys"};
            var __reg3 = "<ver v=\'" + this.majVersion.toString() + this.minVersion.toString() + this.subVersion.toString() + "\' />";
            this.send(__reg2, "verChk", 0, __reg3);
            return undefined;
        }
        if (flash.external.ExternalInterface.available) 
        {
            flash.external.ExternalInterface.call("console.log", "Connection.connectionEstablished ok:" + ok);
        }
    }

    function connectionClosed()
    {
        this.isConnected = false;
        if (this.preConnection) 
        {
            this.connectionEstablished(false);
            return undefined;
        }
        this.initialize();
        this.onConnectionLost();
    }

    function gotData(message)
    {
        if (message.charAt(0) == this.serverMessageDelimiter) 
        {
            this.strReceived(message);
            return undefined;
        }
        if (message.charAt(0) == "<") 
        {
            this.onXML(new XML(message));
        }
    }

    function strReceived(message)
    {
        var __reg4 = message.substr(1, message.length - 2).split(this.serverMessageDelimiter);
        var __reg3 = __reg4[1];
        var __reg6 = __reg4.slice(2);
        var __reg2 = 0;
        while (__reg2 < this.disabledCommands.length) 
        {
            if (__reg3 == this.disabledCommands[__reg2]) 
            {
                return undefined;
            }
            ++__reg2;
        }
        com.clubpenguin.util.Log.info("<-- [Received]: " + message, com.clubpenguin.util.Log.SOCKET);
        var __reg7 = __reg4[0];
        this._responded.dispatch(__reg3, __reg6);
        this.messageHandlers[__reg7].handleMessage(__reg4.splice(1, __reg4.length - 1), this, "str");
    }

    function setupMessageHandlers()
    {
        this.addMessageHandler("sys", this.handleSysMessages);
        this.addMessageHandler("xt", com.clubpenguin.util.Delegate.create(this, this.handleExtensionMessages));
    }

    function addMessageHandler(handlerId, handlerMethod)
    {
        if (this.messageHandlers[handlerId] == undefined) 
        {
            this.messageHandlers[handlerId] = new Object();
            this.messageHandlers[handlerId].handleMessage = handlerMethod;
            return undefined;
        }
    }

    function handleExtensionMessages(dataObj, scope, type)
    {
        if (type == undefined) 
        {
            type = "xml";
        }
        if (type == "xml") 
        {
            var __reg4 = dataObj.attributes.action;
            var __reg7 = dataObj.attributes.r;
            if (__reg4 == "xtRes") 
            {
                var __reg6 = dataObj.value;
                var __reg5 = scope.os.deserialize(__reg6);
                scope.onExtensionResponse(__reg5, type);
            }
            return undefined;
        }
        if (type == "str") 
        {
            scope.onExtensionResponse(dataObj, type);
            return undefined;
        }
        if (type == "json") 
        {
            scope.onExtensionResponse(dataObj.o, type);
        }
    }

    function handleSysMessages(xmlObj, scope)
    {
        var __reg1 = xmlObj.attributes.action;
        var __reg5 = xmlObj.attributes.r;
        if (__reg1 == "apiOK") 
        {
            scope.isConnected = true;
            scope.onConnection(true);
            return undefined;
        }
        if (__reg1 == "rndK") 
        {
            var __reg4 = xmlObj.k.value;
            scope.onRandomKey(__reg4);
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
