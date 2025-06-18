    class com.disney.dlearning.managers.DLSManager
    {
        static var __learnerID, __host, __developerID, __instance;
        var __localConnection;
        function DLSManager () {
            __localConnection = new com.disney.dlearning.debug.DLSLocalConnectionProducer();
        }
        static function init(learnerId, host, debug, developerId) {
            if (debug != null) {
                __debugMode = debug;
            }
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
        function pushOpcode(opcode, guid, callback, register1, register2, register3, register4) {
            if (!isValidOpcode(opcode)) {
                return(0);
            }
            var _local6 = new Date();
            var _local4 = Math.round(_local6.getTime() / 1000);
            var _local3;
            var _local8 = __URLLoaderCookieId++;
            if (__learnerID == "") {
                __learnerID = "-1";
            }
            if (opcode == "") {
                opcode = "no_opcode_given";
            }
            _local3 = ((((((((((((((((("http://" + __host) + "/v1/opcode/pushOpcode/") + opcode) + "/") + __learnerID) + "/") + _local4) + "/") + guid) + "/") + register1) + "/") + register2) + "/") + register3) + "/") + register4) + "/";
            var _local7 = (encryptURL(_local3, _local4.toString(), __developerID) + "|") + encryptTime(_local4.toString());
            var _local2 = new LoadVars();
            _local2.callback = callback;
            configureListeners(_local2);
            _local2.addRequestHeader("DLSNetwork-Developer-ID", __developerID);
            _local2.addRequestHeader("DLSNetwork-Request-Key", _local7);
            _local2.addRequestHeader("DLSNetwork-Sequence-ID", String(__sequenceID++));
            if (__debugMode) {
                __localConnection.sendMessage("API", _local3);
            }
            try {
                _local2.sendAndLoad(_local3, _local2, "POST");
            } catch(error:Error) {
            }
            return(1);
        }
        function pushOpcodeToHost(host, opcode, guid, callback, register1, register2, register3, register4) {
            if (!isValidOpcode(opcode)) {
                return(0);
            }
            var _local6 = new Date();
            var _local4 = Math.round(_local6.getTime() / 1000);
            var _local3;
            var _local9 = __URLLoaderCookieId++;
            if (__learnerID == "") {
                __learnerID = "-1";
            }
            if (opcode == "") {
                opcode = "no_opcode_given";
            }
            if (host == "") {
                host = "k.api.dlsnetwork.com";
            }
            _local3 = ((((((((((((((((("http://" + host) + "/v1/opcode/pushOpcode/") + opcode) + "/") + __learnerID) + "/") + _local4) + "/") + guid) + "/") + register1) + "/") + register2) + "/") + register3) + "/") + register4) + "/";
            var _local7 = (encryptURL(_local3, _local4.toString(), __developerID) + "|") + encryptTime(_local4.toString());
            var _local2 = new LoadVars();
            _local2.callback = callback;
            configureListeners(_local2);
            _local2.addRequestHeader("DLSNetwork-Developer-ID", __developerID);
            _local2.addRequestHeader("DLSNetwork-Request-Key", _local7);
            _local2.addRequestHeader("DLSNetwork-Sequence-ID", String(__sequenceID++));
            if (__debugMode) {
                __localConnection.sendMessage("API", _local3);
            }
            try {
                _local2.sendAndLoad(_local3, _local2, "POST");
            } catch(error:Error) {
            }
            return(1);
        }
        function getAvailableContent(callback, sortingOrder) {
            var _local3 = __URLLoaderCookieId++;
            __URLCallbacks[_local3] = callback;
            var _local4 = ((((("http://" + __host) + "/v1/reports/getAvailableContent/") + __learnerID) + "/") + sortingOrder) + "/";
            var _local2 = new LoadVars();
            _local2.callback = callback;
            configureListeners(_local2);
            try {
                _local2.load(_local4);
            } catch(error:Error) {
            }
            return(_local3);
        }
        function getLearnerScores(callback) {
            var _local2 = __URLLoaderCookieId++;
            __URLCallbacks[_local2] = callback;
            var _local4 = ((("http://" + __host) + "/v1/reports/getLearnerScores/") + __learnerID) + "/";
            var _local3 = new LoadVars();
            _local3.callback = callback;
            try {
                _local3.load(_local4);
            } catch(error:Error) {
            }
            return(_local2);
        }
        function getLearnerScoreByNode(guid, callback) {
            var _local3 = __URLLoaderCookieId++;
            __URLCallbacks[_local3] = callback;
            var _local4 = ((((("http://" + __host) + "/reports/getLearnerScoreByNode/") + __learnerID) + "/") + guid) + "/";
            var _local2 = new LoadVars();
            _local2.callback = callback;
            configureListeners(_local2);
            _local2.learner = __learnerID;
            try {
                _local2.load(_local4);
            } catch(error:Error) {
            }
            return(_local3);
        }
        function isContentUnlocked(guid, callback) {
            var _local3 = __URLLoaderCookieId++;
            __URLCallbacks[_local3] = callback;
            var _local4 = ((((("http://" + __host) + "/v1/content/getAvailableContent/") + __learnerID) + "/") + guid) + "/";
            var _local2 = new LoadVars();
            _local2.callback = callback;
            configureListeners(_local2);
            try {
                _local2.load(_local4);
            } catch(error:Error) {
            }
            return(_local3);
        }
        function isValidOpcode(opcode) {
            var _local1 = opcode.toLowerCase();
            if ((((((((_local1 == LEARNER_SCORE.toLowerCase()) || (_local1 == GAME_SCORE.toLowerCase())) || (_local1 == START.toLowerCase())) || (_local1 == STOP.toLowerCase())) || (_local1 == SELECTED.toLowerCase())) || (_local1 == PRESENTED.toLowerCase())) || (_local1 == NOTIFY.toLowerCase())) || (_local1 == USED.toLowerCase())) {
                return(true);
            } else {
                return(false);
            }
        }
        function callback() {
        }
        function configureListeners(target) {
            target.hostThis = this;
        }
        function encryptURL(url, timestamp, developerId) {
            var _local2 = new com.disney.dlearning.security.Md5();
            var _local1 = ((url + timestamp) + developerId) + "_Salt";
            var _local3 = _local2.hash(_local1);
            return(_local3);
        }
        function encryptTime(time) {
            return(time);
        }
        var __URLLoaderCookieId = 0;
        var __URLCallbacks = new Array();
        var __sequenceID = 0;
        static var __debugMode = false;
        static var LEARNER_SCORE = "Learnerscore";
        static var GAME_SCORE = "Gamescore";
        static var START = "Start";
        static var STOP = "Stop";
        static var SELECTED = "Selected";
        static var NOTIFY = "Notify";
        static var PRESENTED = "Presented";
        static var USED = "Used";
    }
