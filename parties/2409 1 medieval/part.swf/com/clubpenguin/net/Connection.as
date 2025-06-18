
//Created by Action Script Viewer - http://www.buraks.com/asv
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
        function login(_arg_7, _arg_9, _arg_6, _arg_5, _arg_8) {
            var _local_3 = {t:"sys"};
            var _local_2;
            if (_arg_5) {
                _local_2 = ((((((("<login z='" + _arg_7) + "'><nick><![CDATA[") + _arg_8) + "]]></nick><pword><![CDATA[") + _arg_6) + "#") + _arg_5) + "]]></pword></login>";
            } else {
                _local_2 = ((((("<login z='" + _arg_7) + "'><nick><![CDATA[") + _arg_9) + "]]></nick><pword><![CDATA[") + _arg_6) + "]]></pword></login>";
            }
            this.send(_local_3, "login", 0, _local_2);
        }
        function connect(_arg_3, _arg_4) {
            if (!isConnected) {
                ipAddress = _arg_3;
                port = _arg_4;
                super.connect(_arg_3, _arg_4);
                socketConnectionTimeoutThread = setInterval(com.clubpenguin.util.Delegate.create(this, socketTimeoutHandler), socketConnectionTimeout);
            }
        }
        function xmlReceived(_arg_4) {
            var _local_2 = new Object();
            message2Object(_arg_4.childNodes, _local_2);
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
        function message2Object(_arg_10, _arg_7) {
            var _local_8 = 0;
            var _local_3 = null;
            while (_local_8 < _arg_10.length) {
                var _local_4 = _arg_10[_local_8];
                var _local_5 = _local_4.nodeName;
                var _local_6 = _local_4.nodeValue;
                if (_arg_7 instanceof Array) {
                    _local_3 = {};
                    _arg_7.push(_local_3);
                    _local_3 = _arg_7[_arg_7.length - 1];
                } else {
                    _arg_7[_local_5] = new Object();
                    _local_3 = _arg_7[_local_5];
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
        function makeHeader(_arg_1) {
            var _local_2 = "<msg";
            for (var _local_3 in _arg_1) {
                _local_2 = _local_2 + ((((" " + _local_3) + "='") + _arg_1[_local_3]) + "'");
            }
            _local_2 = _local_2 + ">";
            return(_local_2);
        }
        function closeHeader() {
            return("</msg>");
        }
        function send(_arg_6, _arg_7, _arg_5, _arg_4) {
            var _local_3 = makeHeader(_arg_6);
            _local_3 = _local_3 + ((((((("<body action='" + _arg_7) + "' r='") + _arg_5) + "'>") + _arg_4) + "</body>") + closeHeader());
            com.clubpenguin.util.Log.info(("--> [Sending]:  " + _local_3) + newline, com.clubpenguin.util.Log.SOCKET);
            super.send(_local_3);
        }
        function sendXtMessage(_arg_9, _arg_8, _arg_4, _arg_7, _arg_6) {
            if (isBlocked) {
                return(undefined);
            }
            var _local_3 = _arg_8.split("#")[1];
            var _local_2 = 0;
            while (_local_2 < disabledCommands.length) {
                if (disabledCommands[_local_2] == _local_3) {
                    return(undefined);
                }
                _local_2++;
            }
            if (_arg_6 == undefined) {
                _arg_6 = activeRoomId;
            }
            if (_arg_7 == undefined) {
                _arg_7 = "str";
            }
            if (_arg_7 == "str") {
                var _local_5;
                _local_5 = (((((((serverMessageDelimiter + "xt") + serverMessageDelimiter) + _arg_9) + serverMessageDelimiter) + _arg_8) + serverMessageDelimiter) + _arg_6) + serverMessageDelimiter;
                _local_2 = 0;
                while (_local_2 < _arg_4.length) {
                    _local_5 = _local_5 + (_arg_4[_local_2].toString() + serverMessageDelimiter);
                    _local_2++;
                }
                sendString(_local_5);
            }
        }
        function initialize(_arg_2) {
            if (_arg_2 == undefined) {
                _arg_2 = false;
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
            if (!_arg_2) {
                isConnected = false;
            }
        }
        function sendString(_arg_3) {
            com.clubpenguin.util.Log.info("--> [Sending]:  " + _arg_3, com.clubpenguin.util.Log.SOCKET);
            sentCommandsBuffer.push(_arg_3);
            if (sentCommandsBuffer.length > MAX_SENT_COMMANDS_BUFFER_LENGTH) {
                sentCommandsBuffer.splice(0, 1);
            }
            super.send(_arg_3);
        }
        function connectionEstablished(_arg_2) {
            if (_arg_2) {
                if (socketConnectionTimeoutThread != null) {
                    clearInterval(socketConnectionTimeoutThread);
                    delete socketConnectionTimeoutThread;
                }
                preConnection = false;
                var _local_4 = {t:"sys"};
                var _local_3 = ((("<ver v='" + majVersion.toString()) + minVersion.toString()) + subVersion.toString()) + "' />";
                this.send(_local_4, "verChk", 0, _local_3);
            } else if (flash.external.ExternalInterface.available) {
                flash.external.ExternalInterface.call("console.log", "Connection.connectionEstablished ok:" + _arg_2);
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
        function gotData(_arg_2) {
            if (_arg_2.charAt(0) == serverMessageDelimiter) {
                strReceived(_arg_2);
            } else if (_arg_2.charAt(0) == "<") {
                this.onXML(new XML(_arg_2));
            }
        }
        function strReceived(_arg_5) {
            var _local_4 = _arg_5.substr(1, _arg_5.length - 2).split(serverMessageDelimiter);
            var _local_3 = _local_4[1];
            var _local_7 = _local_4.slice(2);
            var _local_2 = 0;
            while (_local_2 < disabledCommands.length) {
                if (_local_3 == disabledCommands[_local_2]) {
                    return(undefined);
                }
                _local_2++;
            }
            com.clubpenguin.util.Log.info("<-- [Received]: " + _arg_5, com.clubpenguin.util.Log.SOCKET);
            var _local_6 = _local_4[0];
            _responded.dispatch(_local_3, _local_7);
            messageHandlers[_local_6].handleMessage(_local_4.splice(1, _local_4.length - 1), this, "str");
        }
        function setupMessageHandlers() {
            addMessageHandler("sys", handleSysMessages);
            addMessageHandler("xt", com.clubpenguin.util.Delegate.create(this, handleExtensionMessages));
        }
        function addMessageHandler(_arg_2, _arg_3) {
            if (messageHandlers[_arg_2] == undefined) {
                messageHandlers[_arg_2] = new Object();
                messageHandlers[_arg_2].handleMessage = _arg_3;
            }
        }
        function handleExtensionMessages(_arg_2, _arg_3, _arg_1) {
            if (_arg_1 == undefined) {
                _arg_1 = "xml";
            }
            if (_arg_1 == "xml") {
                var _local_6 = _arg_2.attributes.action;
                var _local_7 = _arg_2.attributes.r;
                if (_local_6 == "xtRes") {
                    var _local_4 = _arg_2.value;
                    var _local_5 = _arg_3.os.deserialize(_local_4);
                    _arg_3.onExtensionResponse(_local_5, _arg_1);
                }
            } else if (_arg_1 == "str") {
                _arg_3.onExtensionResponse(_arg_2, _arg_1);
            } else if (_arg_1 == "json") {
                _arg_3.onExtensionResponse(_arg_2.o, _arg_1);
            }
        }
        function handleSysMessages(_arg_3, _arg_4) {
            var _local_1 = _arg_3.attributes.action;
            var _local_5 = _arg_3.attributes.r;
            if (_local_1 == "apiOK") {
                _arg_4.isConnected = true;
                _arg_4.onConnection(true);
            } else if (_local_1 == "rndK") {
                var _local_2 = _arg_3.k.value;
                _arg_4.onRandomKey(_local_2);
            }
        }
        function disableCommands(_arg_2) {
            disabledCommands = _arg_2;
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
