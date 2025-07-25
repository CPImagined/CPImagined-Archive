dynamic class com.disney.dlearning.managers.DLSManager
{
    var __URLLoaderCookieId: Number = 0;
    var __URLCallbacks = new Array();
    var __sequenceID: Number = 0;
    var __localConnection;

    function DLSManager()
    {
        this.__localConnection = new com.disney.dlearning.debug.DLSLocalConnectionProducer();
    }

    static function init(learnerId, host, developerId)
    {
        com.disney.dlearning.managers.DLSManager.__learnerID = learnerId;
        if (host == null) 
        {
            com.disney.dlearning.managers.DLSManager.__host = "k.api.dlsnetwork.com";
        }
        else 
        {
            com.disney.dlearning.managers.DLSManager.__host = host;
        }
        if (learnerId == null) 
        {
            com.disney.dlearning.managers.DLSManager.__learnerID = "-1";
        }
        else 
        {
            com.disney.dlearning.managers.DLSManager.__learnerID = learnerId;
        }
        if (developerId == null) 
        {
            com.disney.dlearning.managers.DLSManager.__developerID = "ClubPenguin.v1";
            return;
        }
        com.disney.dlearning.managers.DLSManager.__developerID = learnerId;
    }

    static function get instance()
    {
        if (com.disney.dlearning.managers.DLSManager.__instance == null) 
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
        var __reg5 = new Date();
        var __reg3 = Math.round(__reg5.getTime() / 1000);
        var __reg4 = undefined;
        var __reg8 = this.__URLLoaderCookieId++;
        if (com.disney.dlearning.managers.DLSManager.__learnerID == "") 
        {
            com.disney.dlearning.managers.DLSManager.__learnerID = "-1";
        }
        if (opcode == "") 
        {
            opcode = "no_opcode_given";
        }
        __reg4 = "http://" + com.disney.dlearning.managers.DLSManager.__host + "/v1/opcode/pushOpcode/" + opcode + "/" + com.disney.dlearning.managers.DLSManager.__learnerID + "/" + __reg3 + "/" + guid + "/" + register1 + "/" + register2 + "/";
        var __reg6 = this.encryptURL(__reg4, __reg3.toString(), com.disney.dlearning.managers.DLSManager.__developerID) + "|" + this.encryptTime(__reg3.toString());
        var __reg2 = new LoadVars();
        __reg2.callback = callback;
        this.configureListeners(__reg2);
        __reg2.addRequestHeader("DLSNetwork-Developer-ID", com.disney.dlearning.managers.DLSManager.__developerID);
        __reg2.addRequestHeader("DLSNetwork-Request-Key", __reg6);
        __reg2.addRequestHeader("DLSNetwork-Sequence-ID", String(this.__sequenceID++));
        __reg2.sendAndLoad(__reg4, __reg2, "POST");
        return __reg8;
    }

    function pushOpcode(opcode, guid, callback, register1, register2, register3)
    {
        var __reg5 = new Date();
        var __reg4 = Math.round(__reg5.getTime() / 1000);
        var __reg3 = undefined;
        var __reg8 = this.__URLLoaderCookieId++;
        if (com.disney.dlearning.managers.DLSManager.__learnerID == "") 
        {
            com.disney.dlearning.managers.DLSManager.__learnerID = "-1";
        }
        if (opcode == "") 
        {
            opcode = "no_opcode_given";
        }
        __reg3 = "http://" + com.disney.dlearning.managers.DLSManager.__host + "/v1/opcode/pushOpcode/" + opcode + "/" + com.disney.dlearning.managers.DLSManager.__learnerID + "/" + __reg4 + "/" + guid + "/" + register1 + "/" + register2 + "/" + register3 + "/";
        var __reg6 = this.encryptURL(__reg3, __reg4.toString(), com.disney.dlearning.managers.DLSManager.__developerID) + "|" + this.encryptTime(__reg4.toString());
        var __reg2 = new LoadVars();
        __reg2.callback = callback;
        this.configureListeners(__reg2);
        __reg2.addRequestHeader("DLSNetwork-Developer-ID", com.disney.dlearning.managers.DLSManager.__developerID);
        __reg2.addRequestHeader("DLSNetwork-Request-Key", __reg6);
        __reg2.addRequestHeader("DLSNetwork-Sequence-ID", String(this.__sequenceID++));
        if (com.disney.dlearning.managers.DLSManager.__learnerID == "-1") 
        {
            this.__localConnection.sendMessage("API", __reg3);
        }
        __reg2.sendAndLoad(__reg3, __reg2, "POST");
        return __reg8;
    }

    function pushOpcodeToHost(host, opcode, guid, callback, register1, register2, register3)
    {
        var __reg5 = new Date();
        var __reg4 = Math.round(__reg5.getTime() / 1000);
        var __reg3 = undefined;
        var __reg8 = this.__URLLoaderCookieId++;
        if (com.disney.dlearning.managers.DLSManager.__learnerID == "") 
        {
            com.disney.dlearning.managers.DLSManager.__learnerID = "-1";
        }
        if (opcode == "") 
        {
            opcode = "no_opcode_given";
        }
        if (host == "") 
        {
            host = "k.api.dlsnetwork.com";
        }
        __reg3 = "http://" + host + "/v1/opcode/pushOpcode/" + opcode + "/" + com.disney.dlearning.managers.DLSManager.__learnerID + "/" + __reg4 + "/" + guid + "/" + register1 + "/" + register2 + "/" + register3 + "/";
        var __reg6 = this.encryptURL(__reg3, __reg4.toString(), com.disney.dlearning.managers.DLSManager.__developerID) + "|" + this.encryptTime(__reg4.toString());
        var __reg2 = new LoadVars();
        __reg2.callback = callback;
        this.configureListeners(__reg2);
        __reg2.addRequestHeader("DLSNetwork-Developer-ID", com.disney.dlearning.managers.DLSManager.__developerID);
        __reg2.addRequestHeader("DLSNetwork-Request-Key", __reg6);
        __reg2.addRequestHeader("DLSNetwork-Sequence-ID", String(this.__sequenceID++));
        if (com.disney.dlearning.managers.DLSManager.__learnerID == "-1") 
        {
            this.__localConnection.sendMessage("API", __reg3);
        }
        __reg2.sendAndLoad(__reg3, __reg2, "POST");
        return __reg8;
    }

    function getAvailableContent(callback, sortingOrder)
    {
        var __reg3 = this.__URLLoaderCookieId++;
        this.__URLCallbacks[__reg3] = callback;
        var __reg4 = "http://" + com.disney.dlearning.managers.DLSManager.__host + "/v1/reports/getAvailableContent/" + com.disney.dlearning.managers.DLSManager.__learnerID + "/" + sortingOrder + "/";
        var __reg2 = new LoadVars();
        __reg2.callback = callback;
        this.configureListeners(__reg2);
        __reg2.load(__reg4);
        return __reg3;
    }

    function getLearnerScores(callback)
    {
        var __reg2 = this.__URLLoaderCookieId++;
        this.__URLCallbacks[__reg2] = callback;
        var __reg4 = "http://" + com.disney.dlearning.managers.DLSManager.__host + "/v1/reports/getLearnerScores/" + com.disney.dlearning.managers.DLSManager.__learnerID + "/";
        var __reg3 = new LoadVars();
        __reg3.callback = callback;
        __reg3.load(__reg4);
        return __reg2;
    }

    function getLearnerScoreByNode(guid, callback)
    {
        var __reg3 = this.__URLLoaderCookieId++;
        this.__URLCallbacks[__reg3] = callback;
        var __reg4 = "http://" + com.disney.dlearning.managers.DLSManager.__host + "/reports/getLearnerScoreByNode/" + com.disney.dlearning.managers.DLSManager.__learnerID + "/" + guid + "/";
        var __reg2 = new LoadVars();
        __reg2.callback = callback;
        this.configureListeners(__reg2);
        __reg2.learner = com.disney.dlearning.managers.DLSManager.__learnerID;
        __reg2.load(__reg4);
        return __reg3;
    }

    function isContentUnlocked(guid, callback)
    {
        var __reg3 = this.__URLLoaderCookieId++;
        this.__URLCallbacks[__reg3] = callback;
        var __reg4 = "http://" + com.disney.dlearning.managers.DLSManager.__host + "/v1/content/getAvailableContent/" + com.disney.dlearning.managers.DLSManager.__learnerID + "/" + guid + "/";
        var __reg2 = new LoadVars();
        __reg2.callback = callback;
        this.configureListeners(__reg2);
        __reg2.load(__reg4);
        return __reg3;
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
        var __reg2 = new com.disney.dlearning.security.Md5();
        var __reg1 = url + timestamp + developerId + "_Salt";
        var __reg3 = __reg2.hash(__reg1);
        return __reg3;
    }

    function encryptTime(time)
    {
        return time;
    }

}
