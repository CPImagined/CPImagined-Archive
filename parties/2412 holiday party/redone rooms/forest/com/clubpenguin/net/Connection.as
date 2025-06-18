//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.net.Connection extends XMLSocket implements com.clubpenguin.net.IConnection
    {
        var _responded, onConnect, onData, onXML, onClose, messageHandlers, arrayTags, disabledCommands, ipAddress, port, socketConnectionTimeoutThread, onConnection, close, isBlocked, activeRoomId, roomList, buddyList, myBuddyVars, myUserId, myUserName, playerId, amIModerator, onConnectionLost;
        function Connection () {
            super();
            this.initialize();
            _responded = new org.osflash.signals.Signal(String, Array);
            onConnect = connectionEstablished;
            onData = gotData;
            onXML = xmlReceived;
            onClose = connectionClosed;
            messageHandlers = new Object();
            setupMessageHandlers();
            arrayTags = {uLs:true, rmList:true, vars:true, bList:true, vs:true, mv:true};
            disabledCommands = [];
        }
        function getSentCommandsBuffer() {
            return(sentCommandsBuffer);
        }
        function getResponded() {
            return(_responded);
        }
        function login(zone, nick, pass, confirmationHash, loginDataRaw) {
            var header = {t:"sys"};
            var message;
            if (confirmationHash) {
                message = ((((((("<login z='" + zone) + "'><nick><![CDATA[") + loginDataRaw) + "]]></nick><pword><![CDATA[") + pass) + "#") + confirmationHash) + "]]></pword></login>";
            } else {
                message = ((((("<login z='" + zone) + "'><nick><![CDATA[") + nick) + "]]></nick><pword><![CDATA[") + pass) + "]]></pword></login>";
            }
            this.send(header, "login", 0, message);
        }
        function connect(ipAdr, port) {
            if (!isConnected) {
                ipAddress = ipAdr;
                this.port = port;
                super.connect(ipAdr, port);
                socketConnectionTimeoutThread = setInterval(com.clubpenguin.util.Delegate.create(this, socketTimeoutHandler), socketConnectionTimeout);
                return;
            }
        }
        function xmlReceived(message) {
            var xmlObj = new Object();
            message2Object(message.childNodes, xmlObj);
            if (debug) {
            }
            var id = xmlObj.msg.attributes.t;
            messageHandlers[id].handleMessage(xmlObj.msg.body, this, "xml");
        }
        function socketTimeoutHandler() {
            if (socketConnectionTimeoutThread != null) {
                clearInterval(socketConnectionTimeoutThread);
                delete socketConnectionTimeoutThread;
            }
            preConnection = false;
            onConnection(false);
            this.close();
        }
        function getRandomKey() {
            this.send({t:"sys"}, "rndK", -1, "");
        }
        function disconnect() {
            this.close();
            isConnected = false;
            this.initialize();
        }
        function connected() {
            return(isConnected);
        }
        function message2Object(xmlNodes, parentObj) {
            var i = 0;
            var currObj = null;
            while (i < xmlNodes.length) {
                var node = xmlNodes[i];
                var nodeName = node.nodeName;
                var nodeValue = node.nodeValue;
                if (parentObj instanceof Array) {
                    currObj = {};
                    parentObj.push(currObj);
                    currObj = parentObj[parentObj.length - 1];
                } else {
                    parentObj[nodeName] = new Object();
                    currObj = parentObj[nodeName];
                }
                for (var att in node.attributes) {
                    if (typeof(currObj.attributes) == "undefined") {
                        currObj.attributes = {};
                    }
                    var attVal = node.attributes[att];
                    if (!isNaN(Number(attVal))) {
                        attVal = Number(attVal);
                    }
                    if (attVal.toLowerCase() == "true") {
                        attVal = true;
                    } else if (attVal.toLowerCase() == "false") {
                        attVal = false;
                    }
                    currObj.attributes[att] = attVal;
                }
                if (arrayTags[nodeName]) {
                    currObj[nodeName] = [];
                    currObj = currObj[nodeName];
                }
                if (node.hasChildNodes() && (node.firstChild.nodeValue == undefined)) {
                    var subNodes = node.childNodes;
                    message2Object(subNodes, currObj);
                } else {
                    nodeValue = node.firstChild.nodeValue;
                    if (((!isNaN(nodeValue)) && (node.nodeName != "txt")) && (node.nodeName != "var")) {
                        nodeValue = Number(nodeValue);
                    }
                    currObj.value = nodeValue;
                }
                i++;
            }
        }
        function makeHeader(headerObj) {
            var xmlData = "<msg";
            for (var item in headerObj) {
                xmlData = xmlData + ((((" " + item) + "='") + headerObj[item]) + "'");
            }
            xmlData = xmlData + ">";
            return(xmlData);
        }
        function closeHeader() {
            return("</msg>");
        }
        function send(header, action, fromRoom, message) {
            var xmlMsg = makeHeader(header);
            xmlMsg = xmlMsg + ((((((("<body action='" + action) + "' r='") + fromRoom) + "'>") + message) + "</body>") + closeHeader());
            com.clubpenguin.util.Log.info(("--> [Sending]:  " + xmlMsg) + newline, com.clubpenguin.util.Log.SOCKET);
            super.send(xmlMsg);
        }
        function sendXtMessage(xtName, cmdName, paramObj, type, roomId) {
            if (isBlocked) {
                return(undefined);
            }
            var cmd = cmdName.split("#")[1];
            var i = 0;
            while (i < disabledCommands.length) {
                if (disabledCommands[i] == cmd) {
                    return(undefined);
                }
                i++;
            }
            if (roomId == undefined) {
                roomId = activeRoomId;
            }
            if (type == undefined) {
                type = "str";
            }
            if (type == "str") {
                var hdr;
                hdr = (((((((serverMessageDelimiter + "xt") + serverMessageDelimiter) + xtName) + serverMessageDelimiter) + cmdName) + serverMessageDelimiter) + roomId) + serverMessageDelimiter;
                var i = 0;
                while (i < paramObj.length) {
                    hdr = hdr + (paramObj[i].toString() + serverMessageDelimiter);
                    i++;
                }
                sendString(hdr);
            }
        }
        function initialize(isLogout) {
            if (isLogout == undefined) {
                isLogout = false;
            }
            roomList = {};
            buddyList = [];
            myBuddyVars = [];
            activeRoomId = null;
            myUserId = null;
            myUserName = "";
            playerId = null;
            changingRoom = false;
            amIModerator = false;
            if (!isLogout) {
                isConnected = false;
            }
        }
        function sendString(message) {
            com.clubpenguin.util.Log.info("--> [Sending]:  " + message, com.clubpenguin.util.Log.SOCKET);
            sentCommandsBuffer.push(message);
            if (sentCommandsBuffer.length > MAX_SENT_COMMANDS_BUFFER_LENGTH) {
                sentCommandsBuffer.splice(0, 1);
            }
            super.send(message);
        }
        function connectionEstablished(ok) {
            if (ok) {
                if (socketConnectionTimeoutThread != null) {
                    clearInterval(socketConnectionTimeoutThread);
                    delete socketConnectionTimeoutThread;
                }
                preConnection = false;
                var header = {t:"sys"};
                var xmlMsg = (((("<ver v='" + majVersion.toString()) + minVersion.toString()) + subVersion.toString()) + "' />");
                this.send(header, "verChk", 0, xmlMsg);
            } else if (flash.external.ExternalInterface.available) {
                flash.external.ExternalInterface.call("console.log", "Connection.connectionEstablished ok:" + ok);
            }
        }
        function connectionClosed() {
            isConnected = false;
            if (preConnection) {
                connectionEstablished(false);
            } else {
                this.initialize();
                onConnectionLost();
            }
        }
        function gotData(message) {
            if (message.charAt(0) == serverMessageDelimiter) {
                strReceived(message);
            } else if (message.charAt(0) == "<") {
                this.onXML(new XML(message));
            }
        }
        function strReceived(message) {
            var params = message.substr(1, message.length - 2).split(serverMessageDelimiter);
            var responseType = params[1];
            var responseData = params.slice(2);
            var i = 0;
            while (i < disabledCommands.length) {
                if (responseType == disabledCommands[i]) {
                    return(undefined);
                }
                i++;
            }
            com.clubpenguin.util.Log.info("<-- [Received]: " + message, com.clubpenguin.util.Log.SOCKET);
            var id = params[0];
            _responded.dispatch(responseType, responseData);
            messageHandlers[id].handleMessage(params.splice(1, params.length - 1), this, "str");
        }
        function setupMessageHandlers() {
            addMessageHandler("sys", handleSysMessages);
            addMessageHandler("xt", com.clubpenguin.util.Delegate.create(this, handleExtensionMessages));
        }
        function addMessageHandler(handlerId, handlerMethod) {
            if (messageHandlers[handlerId] == undefined) {
                messageHandlers[handlerId] = new Object();
                messageHandlers[handlerId].handleMessage = handlerMethod;
                return;
            }
        }
        function handleExtensionMessages(dataObj, scope, type) {
            if (type == undefined) {
                type = "xml";
            }
            if (type == "xml") {
                var action = dataObj.attributes.action;
                var fromRoom = dataObj.attributes.r;
                if (action == "xtRes") {
                    var obj = dataObj.value;
                    var asObj = scope.os.deserialize(obj);
                    scope.onExtensionResponse(asObj, type);
                }
            } else if (type == "str") {
                scope.onExtensionResponse(dataObj, type);
            } else if (type == "json") {
                scope.onExtensionResponse(dataObj.o, type);
            }
        }
        function handleSysMessages(xmlObj, scope) {
            var action = xmlObj.attributes.action;
            var fromRoom = xmlObj.attributes.r;
            if (action == "apiOK") {
                scope.isConnected = true;
                scope.onConnection(true);
            } else if (action == "rndK") {
                var key = xmlObj.k.value;
                scope.onRandomKey(key);
            }
        }
        function disableCommands(disabledCommands) {
            this.disabledCommands = disabledCommands;
        }
        function enableCommands() {
            disabledCommands = [];
        }
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
    }
