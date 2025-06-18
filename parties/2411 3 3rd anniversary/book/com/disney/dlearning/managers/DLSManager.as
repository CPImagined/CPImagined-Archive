//Created by Action Script Viewer - https://www.buraks.com/asv
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
            var _local_6 = new Date();
            var _local_4 = Math.round(_local_6.getTime() / 1000);
            var _local_3;
            var _local_8 = __URLLoaderCookieId++;
            if (__learnerID == "") {
                __learnerID = "-1";
            }
            if (opcode == "") {
                opcode = "no_opcode_given";
            }
            _local_3 = ((((((((((((((((("http://" + __host) + "/v1/opcode/pushOpcode/") + opcode) + "/") + __learnerID) + "/") + _local_4) + "/") + guid) + "/") + register1) + "/") + register2) + "/") + register3) + "/") + register4) + "/";
            var _local_7 = (encryptURL(_local_3, _local_4.toString(), __developerID) + "|") + encryptTime(_local_4.toString());
            var _local_2 = new LoadVars();
            _local_2.callback = callback;
            configureListeners(_local_2);
            _local_2.addRequestHeader("DLSNetwork-Developer-ID", __developerID);
            _local_2.addRequestHeader("DLSNetwork-Request-Key", _local_7);
            _local_2.addRequestHeader("DLSNetwork-Sequence-ID", String(__sequenceID++));
            if (__debugMode) {
                __localConnection.sendMessage("API", _local_3);
            }
            try {
                _local_2.sendAndLoad(_local_3, _local_2, "POST");
            } catch(error:Error) {
            }
            return(1);
        }
        function pushOpcodeToHost(host, opcode, guid, callback, register1, register2, register3, register4) {
            if (!isValidOpcode(opcode)) {
                return(0);
            }
            var _local_6 = new Date();
            var _local_4 = Math.round(_local_6.getTime() / 1000);
            var _local_3;
            var _local_9 = __URLLoaderCookieId++;
            if (__learnerID == "") {
                __learnerID = "-1";
            }
            if (opcode == "") {
                opcode = "no_opcode_given";
            }
            if (host == "") {
                host = "k.api.dlsnetwork.com";
            }
            _local_3 = ((((((((((((((((("http://" + host) + "/v1/opcode/pushOpcode/") + opcode) + "/") + __learnerID) + "/") + _local_4) + "/") + guid) + "/") + register1) + "/") + register2) + "/") + register3) + "/") + register4) + "/";
            var _local_7 = (encryptURL(_local_3, _local_4.toString(), __developerID) + "|") + encryptTime(_local_4.toString());
            var _local_2 = new LoadVars();
            _local_2.callback = callback;
            configureListeners(_local_2);
            _local_2.addRequestHeader("DLSNetwork-Developer-ID", __developerID);
            _local_2.addRequestHeader("DLSNetwork-Request-Key", _local_7);
            _local_2.addRequestHeader("DLSNetwork-Sequence-ID", String(__sequenceID++));
            if (__debugMode) {
                __localConnection.sendMessage("API", _local_3);
            }
            try {
                _local_2.sendAndLoad(_local_3, _local_2, "POST");
            } catch(error:Error) {
            }
            return(1);
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
        function isValidOpcode(opcode) {
            var _local_1 = opcode.toLowerCase();
            if ((((((((_local_1 == LEARNER_SCORE.toLowerCase()) || (_local_1 == GAME_SCORE.toLowerCase())) || (_local_1 == START.toLowerCase())) || (_local_1 == STOP.toLowerCase())) || (_local_1 == SELECTED.toLowerCase())) || (_local_1 == PRESENTED.toLowerCase())) || (_local_1 == NOTIFY.toLowerCase())) || (_local_1 == USED.toLowerCase())) {
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
