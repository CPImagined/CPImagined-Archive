//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.disney.dlearning.managers.DLSManager
    {
        static var __learnerID, __host, __developerID, __instance;
        var __localConnection;
        function DLSManager () {
            __localConnection = new com.disney.dlearning.debug.DLSLocalConnectionProducer();
        }
        static function init(_arg_1, _arg_3, _arg_2, _arg_4) {
            if (_arg_2 != null) {
                __debugMode = _arg_2;
            }
            __learnerID = _arg_1;
            if (_arg_3 == null) {
                __host = "k.api.dlsnetwork.com";
            } else {
                __host = _arg_3;
            }
            if (_arg_1 == null) {
                __learnerID = "-1";
            } else {
                __learnerID = _arg_1;
            }
            if (_arg_4 == null) {
                __developerID = "ClubPenguin.v1";
            } else {
                __developerID = _arg_1;
            }
        }
        static function get instance() {
            if (__instance == null) {
                __instance = new com.disney.dlearning.managers.DLSManager();
            }
            return(__instance);
        }
        static function set learnerID(_arg_1) {
            __learnerID = _arg_1;
            //return(learnerID);
        }
        static function get learnerID() {
            return(__learnerID);
        }
        static function set host(_arg_1) {
            __host = _arg_1;
            //return(host);
        }
        static function get host() {
            return(__host);
        }
        function pushOpcode(_arg_5, _arg_10, _arg_11, _arg_14, _arg_13, _arg_12, _arg_9) {
            if (!isValidOpcode(_arg_5)) {
                return(0);
            }
            var _local_6 = new Date();
            var _local_4 = Math.round(_local_6.getTime() / 1000);
            var _local_3;
            var _local_8 = __URLLoaderCookieId++;
            if (__learnerID == "") {
                __learnerID = "-1";
            }
            if (_arg_5 == "") {
                _arg_5 = "no_opcode_given";
            }
            _local_3 = ((((((((((((((((("http://" + __host) + "/v1/opcode/pushOpcode/") + _arg_5) + "/") + __learnerID) + "/") + _local_4) + "/") + _arg_10) + "/") + _arg_14) + "/") + _arg_13) + "/") + _arg_12) + "/") + _arg_9) + "/";
            var _local_7 = (encryptURL(_local_3, _local_4.toString(), __developerID) + "|") + encryptTime(_local_4.toString());
            var _local_2 = new LoadVars();
            _local_2.callback = _arg_11;
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
        function pushOpcodeToHost(_arg_8, _arg_5, _arg_11, _arg_12, _arg_15, _arg_14, _arg_13, _arg_10) {
            if (!isValidOpcode(_arg_5)) {
                return(0);
            }
            var _local_6 = new Date();
            var _local_4 = Math.round(_local_6.getTime() / 1000);
            var _local_3;
            var _local_9 = __URLLoaderCookieId++;
            if (__learnerID == "") {
                __learnerID = "-1";
            }
            if (_arg_5 == "") {
                _arg_5 = "no_opcode_given";
            }
            if (_arg_8 == "") {
                _arg_8 = "k.api.dlsnetwork.com";
            }
            _local_3 = ((((((((((((((((("http://" + _arg_8) + "/v1/opcode/pushOpcode/") + _arg_5) + "/") + __learnerID) + "/") + _local_4) + "/") + _arg_11) + "/") + _arg_15) + "/") + _arg_14) + "/") + _arg_13) + "/") + _arg_10) + "/";
            var _local_7 = (encryptURL(_local_3, _local_4.toString(), __developerID) + "|") + encryptTime(_local_4.toString());
            var _local_2 = new LoadVars();
            _local_2.callback = _arg_12;
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
        function getAvailableContent(_arg_5, _arg_6) {
            var _local_3 = __URLLoaderCookieId++;
            __URLCallbacks[_local_3] = _arg_5;
            var _local_4 = ((((("http://" + __host) + "/v1/reports/getAvailableContent/") + __learnerID) + "/") + _arg_6) + "/";
            var _local_2 = new LoadVars();
            _local_2.callback = _arg_5;
            configureListeners(_local_2);
            try {
                _local_2.load(_local_4);
            } catch(error:Error) {
            }
            return(_local_3);
        }
        function getLearnerScores(_arg_5) {
            var _local_2 = __URLLoaderCookieId++;
            __URLCallbacks[_local_2] = _arg_5;
            var _local_4 = ((("http://" + __host) + "/v1/reports/getLearnerScores/") + __learnerID) + "/";
            var _local_3 = new LoadVars();
            _local_3.callback = _arg_5;
            try {
                _local_3.load(_local_4);
            } catch(error:Error) {
            }
            return(_local_2);
        }
        function getLearnerScoreByNode(_arg_6, _arg_5) {
            var _local_3 = __URLLoaderCookieId++;
            __URLCallbacks[_local_3] = _arg_5;
            var _local_4 = ((((("http://" + __host) + "/reports/getLearnerScoreByNode/") + __learnerID) + "/") + _arg_6) + "/";
            var _local_2 = new LoadVars();
            _local_2.callback = _arg_5;
            configureListeners(_local_2);
            _local_2.learner = __learnerID;
            try {
                _local_2.load(_local_4);
            } catch(error:Error) {
            }
            return(_local_3);
        }
        function isContentUnlocked(_arg_6, _arg_5) {
            var _local_3 = __URLLoaderCookieId++;
            __URLCallbacks[_local_3] = _arg_5;
            var _local_4 = ((((("http://" + __host) + "/v1/content/getAvailableContent/") + __learnerID) + "/") + _arg_6) + "/";
            var _local_2 = new LoadVars();
            _local_2.callback = _arg_5;
            configureListeners(_local_2);
            try {
                _local_2.load(_local_4);
            } catch(error:Error) {
            }
            return(_local_3);
        }
        function isValidOpcode(_arg_2) {
            var _local_1 = _arg_2.toLowerCase();
            if ((((((((_local_1 == LEARNER_SCORE.toLowerCase()) || (_local_1 == GAME_SCORE.toLowerCase())) || (_local_1 == START.toLowerCase())) || (_local_1 == STOP.toLowerCase())) || (_local_1 == SELECTED.toLowerCase())) || (_local_1 == PRESENTED.toLowerCase())) || (_local_1 == NOTIFY.toLowerCase())) || (_local_1 == USED.toLowerCase())) {
                return(true);
            }
            return(false);
        }
        function callback() {
        }
        function configureListeners(_arg_2) {
            _arg_2.hostThis = this;
        }
        function encryptURL(_arg_6, _arg_5, _arg_4) {
            var _local_2 = new com.disney.dlearning.security.Md5();
            var _local_1 = ((_arg_6 + _arg_5) + _arg_4) + "_Salt";
            var _local_3 = _local_2.hash(_local_1);
            return(_local_3);
        }
        function encryptTime(_arg_1) {
            return(_arg_1);
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
