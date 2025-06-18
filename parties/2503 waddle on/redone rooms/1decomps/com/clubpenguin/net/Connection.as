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
            var _local_3 = {t:"sys"};
            var _local_2;
            if (confirmationHash) {
                _local_2 = ((((((("<login z='" + zone) + "'><nick><![CDATA[") + loginDataRaw) + "]]></nick><pword><![CDATA[") + pass) + "#") + confirmationHash) + "]]></pword></login>";
            } else {
                _local_2 = ((((("<login z='" + zone) + "'><nick><![CDATA[") + nick) + "]]></nick><pword><![CDATA[") + pass) + "]]></pword></login>";
            }
            this.send(_local_3, "login", 0, _local_2);
        }
        function connect(ipAdr, port) {
            if (!isConnected) {
                ipAddress = ipAdr;
                this.port = port;
                super.connect(ipAdr, port);
                socketConnectionTimeoutThread = setInterval(com.clubpenguin.util.Delegate.create(this, socketTimeoutHandler), socketConnectionTimeout);
            }
        }
        function xmlReceived(message) {
            var _local_2 = new Object();
            message2Object(message.childNodes, _local_2);
            if (debug) {
            }
            var _local_3 = _local_2.msg.attributes.t;
            messageHandlers[_local_3].handleMessage(_local_2.msg.body, this, "xml");
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
            var _local_8 = 0;
            var _local_3 = null;
            while (_local_8 < xmlNodes.length) {
                var _local_4 = xmlNodes[_local_8];
                var _local_5 = _local_4.nodeName;
                var _local_6 = _local_4.nodeValue;
                if (parentObj instanceof Array) {
                    _local_3 = {};
                    parentObj.push(_local_3);
                    _local_3 = parentObj[parentObj.length - 1];
                } else {
                    parentObj[_local_5] = new Object();
                    _local_3 = parentObj[_local_5];
                }
                for (var _local_11 in _local_4.attributes) {
                    if (typeof(_local_3.attributes) == "undefined") {
                        _local_3.attributes = {};
                    }
                    var _local_2 = _local_4.attributes[_local_11];
                    if (!isNaN(Number(_local_2))) {
                        _local_2 = Number(_local_2);
                    }
                    if (_local_2.toLowerCase() == "true") {
                        _local_2 = true;
                    } else if (_local_2.toLowerCase() == "false") {
                        _local_2 = false;
                    }
                    _local_3.attributes[_local_11] = _local_2;
                }
                if (arrayTags[_local_5]) {
                    _local_3[_local_5] = [];
                    _local_3 = _local_3[_local_5];
                }
                if (_local_4.hasChildNodes() && (_local_4.firstChild.nodeValue == undefined)) {
                    var _local_9 = _local_4.childNodes;
                    message2Object(_local_9, _local_3);
                } else {
                    _local_6 = _local_4.firstChild.nodeValue;
                    if (((!isNaN(_local_6)) && (_local_4.nodeName != "txt")) && (_local_4.nodeName != "var")) {
                        _local_6 = Number(_local_6);
                    }
                    _local_3.value = _local_6;
                }
                _local_8++;
            }
        }
        function makeHeader(headerObj) {
            var _local_2 = "<msg";
            for (var _local_3 in headerObj) {
                _local_2 = _local_2 + ((((" " + _local_3) + "='") + headerObj[_local_3]) + "'");
            }
            _local_2 = _local_2 + ">";
            return(_local_2);
        }
        function closeHeader() {
            return("</msg>");
        }
        function send(header, action, fromRoom, message) {
            var _local_3 = makeHeader(header);
            _local_3 = _local_3 + ((((((("<body action='" + action) + "' r='") + fromRoom) + "'>") + message) + "</body>") + closeHeader());
            com.clubpenguin.util.Log.info(("--> [Sending]:  " + _local_3) + newline, com.clubpenguin.util.Log.SOCKET);
            super.send(_local_3);
        }
        function sendXtMessage(xtName, cmdName, paramObj, type, roomId) {
            if (isBlocked) {
                return(undefined);
            }
            var _local_3 = cmdName.split("#")[1];
            var _local_2 = 0;
            while (_local_2 < disabledCommands.length) {
                if (disabledCommands[_local_2] == _local_3) {
                    return(undefined);
                }
                _local_2++;
            }
            if (roomId == undefined) {
                roomId = activeRoomId;
            }
            if (type == undefined) {
                type = "str";
            }
            if (type == "str") {
                var _local_5;
                _local_5 = (((((((serverMessageDelimiter + "xt") + serverMessageDelimiter) + xtName) + serverMessageDelimiter) + cmdName) + serverMessageDelimiter) + roomId) + serverMessageDelimiter;
                _local_2 = 0;
                while (_local_2 < paramObj.length) {
                    _local_5 = _local_5 + (paramObj[_local_2].toString() + serverMessageDelimiter);
                    _local_2++;
                }
                sendString(_local_5);
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
                var _local_4 = {t:"sys"};
                var _local_3 = ((("<ver v='" + majVersion.toString()) + minVersion.toString()) + subVersion.toString()) + "' />";
                this.send(_local_4, "verChk", 0, _local_3);
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
            var _local_4 = message.substr(1, message.length - 2).split(serverMessageDelimiter);
            var _local_3 = _local_4[1];
            var _local_7 = _local_4.slice(2);
            var _local_2 = 0;
            while (_local_2 < disabledCommands.length) {
                if (_local_3 == disabledCommands[_local_2]) {
                    return(undefined);
                }
                _local_2++;
            }
            com.clubpenguin.util.Log.info("<-- [Received]: " + message, com.clubpenguin.util.Log.SOCKET);
            var _local_6 = _local_4[0];
            _responded.dispatch(_local_3, _local_7);
            messageHandlers[_local_6].handleMessage(_local_4.splice(1, _local_4.length - 1), this, "str");
        }
        function setupMessageHandlers() {
            addMessageHandler("sys", handleSysMessages);
            addMessageHandler("xt", com.clubpenguin.util.Delegate.create(this, handleExtensionMessages));
        }
        function addMessageHandler(handlerId, handlerMethod) {
            if (messageHandlers[handlerId] == undefined) {
                messageHandlers[handlerId] = new Object();
                messageHandlers[handlerId].handleMessage = handlerMethod;
            }
        }
        function handleExtensionMessages(dataObj, scope, type) {
            if (type == undefined) {
                type = "xml";
            }
            if (type == "xml") {
                var _local_6 = dataObj.attributes.action;
                var _local_7 = dataObj.attributes.r;
                if (_local_6 == "xtRes") {
                    var _local_4 = dataObj.value;
                    var _local_5 = scope.os.deserialize(_local_4);
                    scope.onExtensionResponse(_local_5, type);
                }
            } else if (type == "str") {
                scope.onExtensionResponse(dataObj, type);
            } else if (type == "json") {
                scope.onExtensionResponse(dataObj.o, type);
            }
        }
        function handleSysMessages(xmlObj, scope) {
            var _local_1 = xmlObj.attributes.action;
            var _local_5 = xmlObj.attributes.r;
            if (_local_1 == "apiOK") {
                scope.isConnected = true;
                scope.onConnection(true);
            } else if (_local_1 == "rndK") {
                var _local_2 = xmlObj.k.value;
                scope.onRandomKey(_local_2);
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
