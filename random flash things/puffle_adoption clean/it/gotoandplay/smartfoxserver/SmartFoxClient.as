//Created by Action Script Viewer - https://www.buraks.com/asv
package it.gotoandplay.smartfoxserver
{
    import flash.events.EventDispatcher;
    import flash.utils.ByteArray;
    import flash.net.Socket;
    import it.gotoandplay.smartfoxserver.handlers.SysHandler;
    import it.gotoandplay.smartfoxserver.handlers.ExtHandler;
    import flash.events.Event;
    import flash.events.ErrorEvent;
    import flash.events.IOErrorEvent;
    import flash.events.ProgressEvent;
    import it.gotoandplay.smartfoxserver.handlers.IMessageHandler;
    import flash.utils.getTimer;
    import it.gotoandplay.smartfoxserver.data.Room;
    import it.gotoandplay.smartfoxserver.data.User;
    import it.gotoandplay.smartfoxserver.util.Entities;
    import it.gotoandplay.smartfoxserver.util.ObjectSerializer;
    import com.adobe.serialization.json.JSON;

    public class SmartFoxClient extends EventDispatcher 
    {

        private static const EOM:int = 0;
        private static const MSG_XML:String = "<";
        private static const MSG_STR:String = "%";
        private static const MSG_JSON:String = "{";
        public static const MODMSG_TO_USER:String = "u";
        public static const MODMSG_TO_ROOM:String = "r";
        public static const MODMSG_TO_ZONE:String = "z";
        public static const XTMSG_TYPE_XML:String = "xml";
        public static const XTMSG_TYPE_STR:String = "str";
        public static const XTMSG_TYPE_JSON:String = "json";

        private var connected:Boolean;
        private var benchStartTime:int;
        public var myUserId:int;
        private var roomList:Array;
        private var minVersion:Number;
        public var buddyVars:Array;
        public var debug:Boolean;
        private var byteBuffer:ByteArray;
        private var subVersion:Number;
        public var buddyList:Array;
        private var messageHandlers:Array;
        private var majVersion:Number;
        private var socketConnection:Socket;
        private var sysHandler:SysHandler;
        public var myUserName:String;
        public var playerId:int;
        public var amIModerator:Boolean;
        public var changingRoom:Boolean;
        private var extHandler:ExtHandler;
        public var activeRoomId:int;

        public function SmartFoxClient(debug:Boolean=false)
        {
            this.majVersion = 1;
            this.minVersion = 3;
            this.subVersion = 4;
            this.activeRoomId = -1;
            this.debug = debug;
            this.messageHandlers = [];
            setupMessageHandlers();
            socketConnection = new Socket();
            socketConnection.addEventListener(Event.CONNECT, handleSocketConnection);
            socketConnection.addEventListener(Event.CLOSE, handleSocketDisconnection);
            socketConnection.addEventListener(ErrorEvent.ERROR, handleSocketError);
            socketConnection.addEventListener(IOErrorEvent.IO_ERROR, handleIOError);
            socketConnection.addEventListener(ProgressEvent.SOCKET_DATA, handleSocketData);
            byteBuffer = new ByteArray();
        }

        private function getXmlUserVariable(uVars:Object):String
        {
            var xmlStr:String;
            var val:*;
            var t:String;
            var _local_5:String;
            var key:String;
            xmlStr = "<vars>";
            for (key in uVars)
            {
                val = uVars[key];
                _local_5 = typeof(val);
                if (_local_5 == "boolean")
                {
                    t = "b";
                    val = ((val) ? "1" : "0");
                }
                else
                {
                    if (_local_5 == "number")
                    {
                        t = "n";
                    }
                    else
                    {
                        if (_local_5 == "string")
                        {
                            t = "s";
                        }
                        else
                        {
                            if (_local_5 == "null")
                            {
                                t = "x";
                            };
                        };
                    };
                };
                if (t != null)
                {
                    xmlStr = (xmlStr + (((((("<var n='" + key) + "' t='") + t) + "'><![CDATA[") + val) + "]]></var>"));
                };
            };
            xmlStr = (xmlStr + "</vars>");
            return (xmlStr);
        }

        private function checkBuddyDuplicates(buddyName:String):Boolean
        {
            var res:Boolean;
            var buddy:Object;
            res = false;
            for each (buddy in buddyList)
            {
                if (buddy.name == buddyName)
                {
                    res = true;
                    break;
                };
            };
            return (res);
        }

        public function getBuddyRoom(buddy:Object):void
        {
            if (buddy.id != -1)
            {
                send({
                    "t":"sys",
                    "bid":buddy.id
                }, "roomB", -1, (("<b id='" + buddy.id) + "' />"));
            };
        }

        private function handleSocketData(evt:Event):void
        {
            var bytes:int;
            var b:int;
            bytes = socketConnection.bytesAvailable;
            while (--bytes >= 0)
            {
                b = socketConnection.readByte();
                if (b != 0)
                {
                    byteBuffer.writeByte(b);
                }
                else
                {
                    handleMessage(byteBuffer.toString());
                    byteBuffer = new ByteArray();
                };
            };
        }

        private function handleSocketError(evt:Event):void
        {
            trace("SOCKET ERROR!!!");
        }

        private function getXmlRoomVariable(rVar:Object):String
        {
            var vName:String;
            var vValue:*;
            var vPrivate:String;
            var vPersistent:String;
            var t:String;
            vName = rVar.name.toString();
            vValue = rVar.val.toString();
            vPrivate = ((rVar.priv) ? "1" : "0");
            vPersistent = ((rVar.persistent) ? "1" : "0");
            t = null;
            if (typeof(vValue) == "boolean")
            {
                t = "b";
                vValue = ((vValue) ? "1" : "0");
            }
            else
            {
                if (typeof(vValue) == "number")
                {
                    t = "n";
                }
                else
                {
                    if (typeof(vValue) == "string")
                    {
                        t = "s";
                    }
                    else
                    {
                        if (typeof(vValue) == "null")
                        {
                            t = "x";
                        };
                    };
                };
            };
            if (t != null)
            {
                return (((((((((("<var n='" + vName) + "' t='") + t) + "' pr='") + vPrivate) + "' pe='") + vPersistent) + "'><![CDATA[") + vValue) + "]]></var>");
            };
            return ("");
        }

        private function handleSocketDisconnection(evt:Event):void
        {
            var sfse:SFSEvent;
            initialize();
            sfse = new SFSEvent(SFSEvent.onConnectionLost, {});
            dispatchEvent(sfse);
        }

        private function xmlReceived(msg:String):void
        {
            var xmlData:XML;
            var handlerId:String;
            var action:String;
            var roomId:int;
            var handler:IMessageHandler;
            xmlData = new XML(msg);
            handlerId = xmlData.@t;
            action = xmlData.body.@action;
            roomId = int(xmlData.body.@r);
            handler = messageHandlers[handlerId];
            if (handler != null)
            {
                handler.handleMessage(xmlData, XTMSG_TYPE_XML);
            };
        }

        public function switchSpectator(roomId:int=-1):void
        {
            if (roomId == -1)
            {
                roomId = activeRoomId;
            };
            send({"t":"sys"}, "swSpec", roomId, "");
        }

        public function roundTripBench():void
        {
            this.benchStartTime = getTimer();
            send({"t":"sys"}, "roundTrip", activeRoomId, "");
        }

        public function joinRoom(newRoom:*, pword:String="", isSpectator:Boolean=false, dontLeave:Boolean=false, oldRoom:int=-1):void
        {
            var newRoomId:int;
            var isSpec:int;
            var r:Room;
            var header:Object;
            var leaveCurrRoom:String;
            var roomToLeave:int;
            var message:String;
            newRoomId = -1;
            isSpec = ((isSpectator) ? 1 : 0);
            if (!this.changingRoom)
            {
                if (typeof(newRoom) == "number")
                {
                    newRoomId = int(newRoom);
                }
                else
                {
                    if (typeof(newRoom) == "string")
                    {
                        for each (r in roomList)
                        {
                            if (r.getName() == newRoom)
                            {
                                newRoomId = r.getId();
                                break;
                            };
                        };
                    };
                };
                if (newRoomId != -1)
                {
                    header = {"t":"sys"};
                    leaveCurrRoom = ((dontLeave) ? "0" : "1");
                    roomToLeave = ((oldRoom > -1) ? oldRoom : activeRoomId);
                    if (activeRoomId == -1)
                    {
                        leaveCurrRoom = "0";
                        roomToLeave = -1;
                    };
                    message = (((((((((("<room id='" + newRoomId) + "' pwd='") + pword) + "' spec='") + isSpec) + "' leave='") + leaveCurrRoom) + "' old='") + roomToLeave) + "' />");
                    send(header, "joinRoom", activeRoomId, message);
                    changingRoom = true;
                }
                else
                {
                    trace("SmartFoxError: requested room to join does not exist!");
                };
            };
        }

        public function getActiveRoom():Room
        {
            return (roomList[activeRoomId]);
        }

        private function makeXmlHeader(headerObj:Object):String
        {
            var xmlData:String;
            var item:String;
            xmlData = "<msg";
            for (item in headerObj)
            {
                xmlData = (xmlData + ((((" " + item) + "='") + headerObj[item]) + "'"));
            };
            xmlData = (xmlData + ">");
            return (xmlData);
        }

        private function strReceived(msg:String):void
        {
            var params:Array;
            var handlerId:String;
            var handler:IMessageHandler;
            params = msg.substr(1, (msg.length - 2)).split(MSG_STR);
            handlerId = params[0];
            handler = messageHandlers[handlerId];
            if (handler != null)
            {
                handler.handleMessage(params.splice(1, (params.length - 1)), XTMSG_TYPE_STR);
            };
        }

        public function getRoomByName(roomName:String):Room
        {
            var room:Room;
            var r:Room;
            room = null;
            for each (r in roomList)
            {
                if (r.getName() == roomName)
                {
                    room = r;
                    break;
                };
            };
            return (room);
        }

        public function loadBuddyList():void
        {
            send({"t":"sys"}, "loadB", -1, "");
        }

        public function leaveRoom(roomId:int):void
        {
            var header:Object;
            var xmlMsg:String;
            header = {"t":"sys"};
            xmlMsg = (("<rm id='" + roomId) + "' />");
            send(header, "leaveRoom", roomId, xmlMsg);
        }

        private function addMessageHandler(key:String, handler:IMessageHandler):void
        {
            if (this.messageHandlers[key] == null)
            {
                this.messageHandlers[key] = handler;
            }
            else
            {
                trace((("Warning, message handler called: " + key) + " already exist!"));
            };
        }

        public function getAllRooms():Array
        {
            return (roomList);
        }

        public function setBuddyVariables(varList:Array):void
        {
            var header:Object;
            var xmlMsg:String;
            var vName:String;
            var vValue:String;
            header = {"t":"sys"};
            xmlMsg = "<vars>";
            for (vName in varList)
            {
                vValue = varList[vName];
                if (buddyVars[vName] != vValue)
                {
                    buddyVars[vName] = vValue;
                    xmlMsg = (xmlMsg + (((("<var n='" + vName) + "'><![CDATA[") + vValue) + "]]></var>"));
                };
            };
            xmlMsg = (xmlMsg + "</vars>");
            this.send(header, "setBvars", -1, xmlMsg);
        }

        public function getRoom(rid:int):Room
        {
            return (roomList[rid]);
        }

        private function handleIOError(evt:Event):void
        {
            var sfse:SFSEvent;
            var params:Object;
            if (!connected)
            {
                params = {};
                params.success = false;
                params.error = "I/O Error";
                sfse = new SFSEvent(SFSEvent.onConnection, params);
                dispatchEvent(sfse);
            }
            else
            {
                trace("I/O Error during connected session");
            };
        }

        private function setupMessageHandlers():void
        {
            sysHandler = new SysHandler(this);
            extHandler = new ExtHandler(this);
            addMessageHandler("sys", sysHandler);
            addMessageHandler("xt", extHandler);
        }

        public function login(zone:String, nick:String, pass:String):void
        {
            var header:Object;
            var message:String;
            header = {"t":"sys"};
            message = (((((("<login z='" + zone) + "'><nick><![CDATA[") + nick) + "]]></nick><pword><![CDATA[") + pass) + "]]></pword></login>");
            send(header, "login", 0, message);
        }

        public function autoJoin():void
        {
            var header:Object;
            header = {"t":"sys"};
            this.send(header, "autoJoin", ((this.activeRoomId) ? this.activeRoomId : -1), "");
        }

        private function send(header:Object, action:String, fromRoom:Number, message:String):void
        {
            var xmlMsg:String;
            xmlMsg = makeXmlHeader(header);
            xmlMsg = (xmlMsg + ((((((("<body action='" + action) + "' r='") + fromRoom) + "'>") + message) + "</body>") + closeHeader()));
            if (this.debug)
            {
                trace((("[Sending]: " + xmlMsg) + "\n"));
            };
            writeToSocket(xmlMsg);
        }

        public function getRoomList():void
        {
            var header:Object;
            header = {"t":"sys"};
            send(header, "getRmList", activeRoomId, "");
        }

        private function initialize():void
        {
            this.changingRoom = false;
            this.amIModerator = false;
            this.playerId = -1;
            this.connected = false;
            this.roomList = [];
            this.buddyList = [];
            this.buddyVars = [];
        }

        public function setRoomVariables(varList:Array, roomId:int=-1, setOwnership:Boolean=true):void
        {
            var header:Object;
            var xmlMsg:String;
            var rv:Object;
            if (roomId == -1)
            {
                roomId = activeRoomId;
            };
            header = {"t":"sys"};
            if (setOwnership)
            {
                xmlMsg = "<vars>";
            }
            else
            {
                xmlMsg = "<vars so='0'>";
            };
            for each (rv in varList)
            {
                xmlMsg = (xmlMsg + getXmlRoomVariable(rv));
            };
            xmlMsg = (xmlMsg + "</vars>");
            send(header, "setRvars", roomId, xmlMsg);
        }

        public function disconnect():void
        {
            socketConnection.close();
            connected = false;
            sysHandler.dispatchDisconnection();
        }

        public function sendJson(jsMessage:String):void
        {
            if (this.debug)
            {
                trace((("[Sending - JSON]: " + jsMessage) + "\n"));
            };
            writeToSocket(jsMessage);
        }

        private function closeHeader():String
        {
            return ("</msg>");
        }

        public function getVersion():String
        {
            return ((((this.majVersion + ".") + this.minVersion) + ".") + this.subVersion);
        }

        public function setUserVariables(varObj:Object, roomId:int=-1):void
        {
            var header:Object;
            var currRoom:Room;
            var user:User;
            var xmlMsg:String;
            if (roomId == -1)
            {
                roomId = activeRoomId;
            };
            header = {"t":"sys"};
            currRoom = getActiveRoom();
            user = currRoom.getUser(myUserId);
            xmlMsg = getXmlUserVariable(varObj);
            send(header, "setUvars", roomId, xmlMsg);
        }

        public function addBuddy(buddyName:String):void
        {
            var xmlMsg:String;
            if (((!(buddyName == myUserName)) && (!(checkBuddyDuplicates(buddyName)))))
            {
                xmlMsg = (("<n>" + buddyName) + "</n>");
                send({"t":"sys"}, "addB", -1, xmlMsg);
            };
        }

        public function sendPrivateMessage(message:String, recipientId:int, roomId:int=-1):void
        {
            var header:Object;
            var xmlMsg:String;
            if (roomId == -1)
            {
                roomId = activeRoomId;
            };
            header = {"t":"sys"};
            xmlMsg = (((("<txt rcp='" + recipientId) + "'><![CDATA[") + Entities.encodeEntities(message)) + "]]></txt>");
            send(header, "prvMsg", roomId, xmlMsg);
        }

        public function sendPublicMessage(message:String, roomId:int=-1):void
        {
            var header:Object;
            var xmlMsg:String;
            if (roomId == -1)
            {
                roomId = activeRoomId;
            };
            header = {"t":"sys"};
            xmlMsg = (("<txt><![CDATA[" + Entities.encodeEntities(message)) + "]]></txt>");
            send(header, "pubMsg", roomId, xmlMsg);
        }

        public function clearBuddyList():void
        {
            var params:Object;
            var evt:SFSEvent;
            buddyList = [];
            send({"t":"sys"}, "clearB", -1, "");
            params = {};
            params.list = buddyList;
            evt = new SFSEvent(SFSEvent.onBuddyList, params);
            dispatchEvent(evt);
        }

        public function sendString(strMessage:String):void
        {
            if (this.debug)
            {
                trace((("[Sending - STR]: " + strMessage) + "\n"));
            };
            writeToSocket(strMessage);
        }

        public function removeBuddy(buddyName:String):void
        {
            var found:Boolean;
            var buddy:Object;
            var it:String;
            var header:Object;
            var xmlMsg:String;
            var params:Object;
            var evt:SFSEvent;
            found = false;
            for (it in buddyList)
            {
                buddy = buddyList[it];
                if (buddy.name == buddyName)
                {
                    delete buddyList[it];
                    found = true;
                    break;
                };
            };
            if (found)
            {
                header = {"t":"sys"};
                xmlMsg = (("<n>" + buddyName) + "</n>");
                send(header, "remB", -1, xmlMsg);
                params = {};
                params.list = buddyList;
                evt = new SFSEvent(SFSEvent.onBuddyList, params);
                dispatchEvent(evt);
            };
        }

        private function handleMessage(msg:String):void
        {
            var _local_2:String;
            if (this.debug)
            {
                trace((((("[ RECEIVED ]: " + msg) + ", (len: ") + msg.length) + ")"));
            };
            _local_2 = msg.charAt(0);
            if (_local_2 == MSG_XML)
            {
                xmlReceived(msg);
            }
            else
            {
                if (_local_2 == MSG_STR)
                {
                    strReceived(msg);
                }
                else
                {
                    if (_local_2 == MSG_JSON)
                    {
                        jsonReceived(msg);
                    };
                };
            };
        }

        public function sendXtMessage(xtName:String, cmd:String, paramObj:*, _arg_4:String="xml", roomId:int=-1):void
        {
            var header:Object;
            var xtReq:Object;
            var xmlmsg:String;
            var hdr:String;
            var i:Number;
            var body:Object;
            var obj:Object;
            var msg:String;
            if (roomId == -1)
            {
                roomId = activeRoomId;
            };
            if (_arg_4 == XTMSG_TYPE_XML)
            {
                header = {"t":"xt"};
                xtReq = {
                    "name":xtName,
                    "cmd":cmd,
                    "param":paramObj
                };
                xmlmsg = (("<![CDATA[" + ObjectSerializer.getInstance().serialize(xtReq)) + "]]>");
                send(header, "xtReq", roomId, xmlmsg);
            }
            else
            {
                if (_arg_4 == XTMSG_TYPE_STR)
                {
                    hdr = (((((("%xt%" + xtName) + "%") + cmd) + "%") + roomId) + "%");
                    i = 0;
                    while (i < paramObj.length)
                    {
                        hdr = (hdr + (paramObj[i].toString() + "%"));
                        i++;
                    };
                    sendString(hdr);
                }
                else
                {
                    if (_arg_4 == XTMSG_TYPE_JSON)
                    {
                        body = {};
                        body.x = xtName;
                        body.c = cmd;
                        body.r = roomId;
                        body.p = paramObj;
                        obj = {};
                        obj.t = "xt";
                        obj.b = body;
                        msg = com.adobe.serialization.json.JSON.encode(obj);
                        sendJson(msg);
                    };
                };
            };
        }

        private function writeToSocket(msg:String):void
        {
            var byteBuff:ByteArray;
            byteBuff = new ByteArray();
            byteBuff.writeMultiByte(msg, "utf-8");
            byteBuff.writeByte(0);
            socketConnection.writeBytes(byteBuff);
            socketConnection.flush();
        }

        public function sendObjectToGroup(obj:Object, userList:Array, roomId:int):void
        {
            var strList:String;
            var i:String;
            var header:Object;
            var xmlMsg:String;
            if (roomId == -1)
            {
                roomId = activeRoomId;
            };
            strList = "";
            for (i in userList)
            {
                if (!isNaN(userList[i]))
                {
                    strList = (strList + (userList[i] + ","));
                };
            };
            strList = strList.substr(0, (strList.length - 1));
            obj._$$_ = strList;
            header = {"t":"sys"};
            xmlMsg = (("<![CDATA[" + ObjectSerializer.getInstance().serialize(obj)) + "]]>");
            send(header, "asObjG", roomId, xmlMsg);
        }

        public function getRandomKey():void
        {
            send({"t":"sys"}, "rndK", -1, "");
        }

        public function sendObject(obj:Object, roomId:int=-1):void
        {
            var xmlData:String;
            var header:Object;
            if (roomId == -1)
            {
                roomId = activeRoomId;
            };
            xmlData = (("<![CDATA[" + ObjectSerializer.getInstance().serialize(obj)) + "]]>");
            header = {"t":"sys"};
            send(header, "asObj", roomId, xmlData);
        }

        private function jsonReceived(msg:String):void
        {
            var jso:Object;
            var handlerId:String;
            var handler:IMessageHandler;
            jso = com.adobe.serialization.json.JSON.decode(msg);
            handlerId = jso["t"];
            handler = messageHandlers[handlerId];
            if (handler != null)
            {
                handler.handleMessage(jso["b"], XTMSG_TYPE_JSON);
            };
        }

        public function connect(ipAdr:String, port:int):void
        {
            if (!connected)
            {
                initialize();
                socketConnection.connect(ipAdr, port);
            }
            else
            {
                trace("*** ALREADY CONNECTED ***");
            };
        }

        public function sendModeratorMessage(message:String, _arg_2:int, id:int=-1):void
        {
            var header:Object;
            var xmlMsg:String;
            header = {"t":"sys"};
            xmlMsg = (((((("<txt t='" + _arg_2) + "' id='") + id) + "'><![CDATA[") + Entities.encodeEntities(message)) + "]]></txt>");
            send(header, "modMsg", activeRoomId, xmlMsg);
        }

        public function getBenchStartTime():int
        {
            return (this.benchStartTime);
        }

        public function createRoom(roomObj:Object, roomId:int=-1):void
        {
            var header:Object;
            var isGame:String;
            var exitCurrentRoom:String;
            var maxUsers:String;
            var maxSpectators:String;
            var xmlMsg:String;
            var i:String;
            if (roomId == -1)
            {
                roomId = activeRoomId;
            };
            header = {"t":"sys"};
            isGame = ((roomObj.isGame) ? "1" : "0");
            exitCurrentRoom = "1";
            maxUsers = ((roomObj.maxUsers == null) ? "0" : String(roomObj.maxUsers));
            maxSpectators = ((roomObj.maxSpectators == null) ? "0" : String(roomObj.maxSpectators));
            if (((roomObj.isGame) && (!(roomObj.exitCurrent == null))))
            {
                exitCurrentRoom = ((roomObj.exitCurrent) ? "1" : "0");
            };
            xmlMsg = (((((("<room tmp='1' gam='" + isGame) + "' spec='") + maxSpectators) + "' exit='") + exitCurrentRoom) + "'>");
            xmlMsg = (xmlMsg + (("<name><![CDATA[" + ((roomObj.name == null) ? "" : roomObj.name)) + "]]></name>"));
            xmlMsg = (xmlMsg + (("<pwd><![CDATA[" + ((roomObj.password == null) ? "" : roomObj.password)) + "]]></pwd>"));
            xmlMsg = (xmlMsg + (("<max>" + maxUsers) + "</max>"));
            if (roomObj.uCount != null)
            {
                xmlMsg = (xmlMsg + (("<uCnt>" + ((roomObj.uCount) ? "1" : "0")) + "</uCnt>"));
            };
            if (roomObj.extension != null)
            {
                xmlMsg = (xmlMsg + ("<xt n='" + roomObj.extension.name));
                xmlMsg = (xmlMsg + (("' s='" + roomObj.extension.script) + "' />"));
            };
            if (roomObj.vars == null)
            {
                xmlMsg = (xmlMsg + "<vars></vars>");
            }
            else
            {
                xmlMsg = (xmlMsg + "<vars>");
                for (i in roomObj.vars)
                {
                    xmlMsg = (xmlMsg + getXmlRoomVariable(roomObj.vars[i]));
                };
                xmlMsg = (xmlMsg + "</vars>");
            };
            xmlMsg = (xmlMsg + "</room>");
            send(header, "createRoom", roomId, xmlMsg);
        }

        private function handleSocketConnection(e:Event):void
        {
            var header:Object;
            var xmlMsg:String;
            header = {"t":"sys"};
            xmlMsg = (((("<ver v='" + this.majVersion.toString()) + this.minVersion.toString()) + this.subVersion.toString()) + "' />");
            send(header, "verChk", 0, xmlMsg);
        }

        public function set isConnected(b:Boolean):void
        {
            this.connected = b;
        }

        public function get isConnected():Boolean
        {
            return (this.connected);
        }


    }
}//package it.gotoandplay.smartfoxserver
