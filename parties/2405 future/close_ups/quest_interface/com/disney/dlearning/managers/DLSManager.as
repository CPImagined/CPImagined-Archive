//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.disney.dlearning.managers.DLSManager
    {
        static var __learnerID, __host, __developerID, __instance;
        var __localConnection;
        function DLSManager () {
            __localConnection = new com.disney.dlearning.debug.DLSLocalConnectionProducer();
        }
        static function init(learnerId, host, developerId) {
            __learnerID = learnerId;
            if (host == null) {
                __host = "k.api.dlsnetwork.com";
            } else {
                __host = host;
            }
            if (learnerId == null) {
                __learnerID = "-1";
            } else {
                __learnerID = learnerId;
            }
            if (developerId == null) {
                __developerID = "ClubPenguin.v1";
            } else {
                __developerID = learnerId;
            }
        }
        static function get instance() {
            if (__instance == null) {
                __instance = new com.disney.dlearning.managers.DLSManager();
            }
            return(__instance);
        }
        static function set learnerID(id) {
            __learnerID = id;
            //return(learnerID);
        }
        static function get learnerID() {
            return(__learnerID);
        }
        static function set host(host) {
            __host = host;
            //return(com.disney.dlearning.managers.DLSManager.host);
        }
        static function get host() {
            return(__host);
        }
        function pushOpcode2(opcode, guid, callback, register1) {
        }
        function pushOpcode2Params(opcode, guid, callback, register1, register2) {
            trace("pushing opcode");
            var _local_5 = new Date();
            var _local_3 = Math.round(_local_5.getTime() / 1000);
            var _local_4;
            var _local_8 = __URLLoaderCookieId++;
            if (__learnerID == "") {
                __learnerID = "-1";
            }
            if (opcode == "") {
                opcode = "no_opcode_given";
            }
            _local_4 = ((((((((((((("http://" + __host) + "/v1/opcode/pushOpcode/") + opcode) + "/") + __learnerID) + "/") + _local_3) + "/") + guid) + "/") + register1) + "/") + register2) + "/";
            var _local_6 = (encryptURL(_local_4, _local_3.toString(), __developerID) + "|") + encryptTime(_local_3.toString());
            var _local_2 = new LoadVars();
            _local_2.callback = callback;
            configureListeners(_local_2);
            _local_2.addRequestHeader("DLSNetwork-Developer-ID", __developerID);
            _local_2.addRequestHeader("DLSNetwork-Request-Key", _local_6);
            _local_2.addRequestHeader("DLSNetwork-Sequence-ID", String(__sequenceID++));
            try {
                trace("loading DLS url" + _local_4);
                _local_2.sendAndLoad(_local_4, _local_2, "POST");
            } catch(error:Error) {
            }
            return(_local_8);
        }
        function pushOpcode(opcode, guid, callback, register1, register2, register3) {
            trace("pushing opcode");
            var _local_5 = new Date();
            var _local_4 = Math.round(_local_5.getTime() / 1000);
            var _local_3;
            var _local_8 = __URLLoaderCookieId++;
            if (__learnerID == "") {
                __learnerID = "-1";
            }
            if (opcode == "") {
                opcode = "no_opcode_given";
            }
            _local_3 = ((((((((((((((("http://" + __host) + "/v1/opcode/pushOpcode/") + opcode) + "/") + __learnerID) + "/") + _local_4) + "/") + guid) + "/") + register1) + "/") + register2) + "/") + register3) + "/";
            var _local_6 = (encryptURL(_local_3, _local_4.toString(), __developerID) + "|") + encryptTime(_local_4.toString());
            var _local_2 = new LoadVars();
            _local_2.callback = callback;
            configureListeners(_local_2);
            _local_2.addRequestHeader("DLSNetwork-Developer-ID", __developerID);
            _local_2.addRequestHeader("DLSNetwork-Request-Key", _local_6);
            _local_2.addRequestHeader("DLSNetwork-Sequence-ID", String(__sequenceID++));
            if (__learnerID == "-1") {
                __localConnection.sendMessage("API", _local_3);
            }
            try {
                trace("loading DLS url" + _local_3);
                _local_2.sendAndLoad(_local_3, _local_2, "POST");
            } catch(error:Error) {
            }
            return(_local_8);
        }
        function pushOpcodeToHost(host, opcode, guid, callback, register1, register2, register3) {
            trace("pushing opcode");
            var _local_5 = new Date();
            var _local_4 = Math.round(_local_5.getTime() / 1000);
            var _local_3;
            var _local_8 = __URLLoaderCookieId++;
            if (__learnerID == "") {
                __learnerID = "-1";
            }
            if (opcode == "") {
                opcode = "no_opcode_given";
            }
            if (host == "") {
                host = "k.api.dlsnetwork.com";
            }
            _local_3 = ((((((((((((((("http://" + host) + "/v1/opcode/pushOpcode/") + opcode) + "/") + __learnerID) + "/") + _local_4) + "/") + guid) + "/") + register1) + "/") + register2) + "/") + register3) + "/";
            var _local_6 = (encryptURL(_local_3, _local_4.toString(), __developerID) + "|") + encryptTime(_local_4.toString());
            var _local_2 = new LoadVars();
            _local_2.callback = callback;
            configureListeners(_local_2);
            _local_2.addRequestHeader("DLSNetwork-Developer-ID", __developerID);
            _local_2.addRequestHeader("DLSNetwork-Request-Key", _local_6);
            _local_2.addRequestHeader("DLSNetwork-Sequence-ID", String(__sequenceID++));
            if (__learnerID == "-1") {
                __localConnection.sendMessage("API", _local_3);
            }
            try {
                trace("loading DLS url" + _local_3);
                _local_2.sendAndLoad(_local_3, _local_2, "POST");
            } catch(error:Error) {
            }
            return(_local_8);
        }
        function getAvailableContent(callback, sortingOrder) {
            var _local_3 = __URLLoaderCookieId++;
            __URLCallbacks[_local_3] = callback;
            var _local_4 = ((((("http://" + __host) + "/v1/reports/getAvailableContent/") + __learnerID) + "/") + sortingOrder) + "/";
            var _local_2 = new LoadVars();
            _local_2.callback = callback;
            configureListeners(_local_2);
            try {
                _local_2.load(_local_4);
            } catch(error:Error) {
            }
            return(_local_3);
        }
        function getLearnerScores(callback) {
            var _local_2 = __URLLoaderCookieId++;
            __URLCallbacks[_local_2] = callback;
            var _local_4 = ((("http://" + __host) + "/v1/reports/getLearnerScores/") + __learnerID) + "/";
            var _local_3 = new LoadVars();
            _local_3.callback = callback;
            try {
                _local_3.load(_local_4);
            } catch(error:Error) {
            }
            return(_local_2);
        }
        function getLearnerScoreByNode(guid, callback) {
            var _local_3 = __URLLoaderCookieId++;
            __URLCallbacks[_local_3] = callback;
            var _local_4 = ((((("http://" + __host) + "/reports/getLearnerScoreByNode/") + __learnerID) + "/") + guid) + "/";
            var _local_2 = new LoadVars();
            _local_2.callback = callback;
            configureListeners(_local_2);
            _local_2.learner = __learnerID;
            try {
                _local_2.load(_local_4);
            } catch(error:Error) {
            }
            return(_local_3);
        }
        function isContentUnlocked(guid, callback) {
            var _local_3 = __URLLoaderCookieId++;
            __URLCallbacks[_local_3] = callback;
            var _local_4 = ((((("http://" + __host) + "/v1/content/getAvailableContent/") + __learnerID) + "/") + guid) + "/";
            var _local_2 = new LoadVars();
            _local_2.callback = callback;
            configureListeners(_local_2);
            try {
                _local_2.load(_local_4);
            } catch(error:Error) {
            }
            return(_local_3);
        }
        function callback() {
        }
        function configureListeners(target) {
            target.hostThis = this;
        }
        function encryptURL(url, timestamp, developerId) {
            var _local_2 = new com.disney.dlearning.security.Md5();
            var _local_1 = ((url + timestamp) + developerId) + "_Salt";
            var _local_3 = _local_2.hash(_local_1);
            return(_local_3);
        }
        function encryptTime(time) {
            return(time);
        }
        var __URLLoaderCookieId = 0;
        var __URLCallbacks = new Array();
        var __sequenceID = 0;
    }
