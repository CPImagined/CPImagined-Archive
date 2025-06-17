//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.disney.dlearning.managers.DLSManager
    {
        static var __learnerID, __host, __developerID, __instance;
        var __localConnection;
        function DLSManager () {
            __localConnection = new com.disney.dlearning.debug.DLSLocalConnectionProducer();
        }
        static function init(_arg_1, _arg_2, _arg_3) {
            __learnerID = _arg_1;
            if (_arg_2 == null) {
                __host = "k.api.dlsnetwork.com";
            } else {
                __host = _arg_2;
            }
            if (_arg_1 == null) {
                __learnerID = "-1";
            } else {
                __learnerID = _arg_1;
            }
            if (_arg_3 == null) {
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
        function pushOpcode2(opcode, guid, callback, register1) {
        }
        function pushOpcode2Params(_arg_7, _arg_9, _arg_10, _arg_12, _arg_11) {
            trace("pushing opcode");
            var _local_5 = new Date();
            var _local_3 = Math.round(_local_5.getTime() / 1000);
            var _local_4;
            var _local_8 = __URLLoaderCookieId++;
            if (__learnerID == "") {
                __learnerID = "-1";
            }
            if (_arg_7 == "") {
                _arg_7 = "no_opcode_given";
            }
            _local_4 = ((((((((((((("http://" + __host) + "/v1/opcode/pushOpcode/") + _arg_7) + "/") + __learnerID) + "/") + _local_3) + "/") + _arg_9) + "/") + _arg_12) + "/") + _arg_11) + "/";
            var _local_6 = (encryptURL(_local_4, _local_3.toString(), __developerID) + "|") + encryptTime(_local_3.toString());
            var _local_2 = new LoadVars();
            _local_2.callback = _arg_10;
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
        function pushOpcode(_arg_7, _arg_9, _arg_10, _arg_13, _arg_12, _arg_11) {
            trace("pushing opcode");
            var _local_5 = new Date();
            var _local_4 = Math.round(_local_5.getTime() / 1000);
            var _local_3;
            var _local_8 = __URLLoaderCookieId++;
            if (__learnerID == "") {
                __learnerID = "-1";
            }
            if (_arg_7 == "") {
                _arg_7 = "no_opcode_given";
            }
            _local_3 = ((((((((((((((("http://" + __host) + "/v1/opcode/pushOpcode/") + _arg_7) + "/") + __learnerID) + "/") + _local_4) + "/") + _arg_9) + "/") + _arg_13) + "/") + _arg_12) + "/") + _arg_11) + "/";
            var _local_6 = (encryptURL(_local_3, _local_4.toString(), __developerID) + "|") + encryptTime(_local_4.toString());
            var _local_2 = new LoadVars();
            _local_2.callback = _arg_10;
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
        function pushOpcodeToHost(_arg_9, _arg_7, _arg_10, _arg_11, _arg_14, _arg_13, _arg_12) {
            trace("pushing opcode");
            var _local_5 = new Date();
            var _local_4 = Math.round(_local_5.getTime() / 1000);
            var _local_3;
            var _local_8 = __URLLoaderCookieId++;
            if (__learnerID == "") {
                __learnerID = "-1";
            }
            if (_arg_7 == "") {
                _arg_7 = "no_opcode_given";
            }
            if (_arg_9 == "") {
                _arg_9 = "k.api.dlsnetwork.com";
            }
            _local_3 = ((((((((((((((("http://" + _arg_9) + "/v1/opcode/pushOpcode/") + _arg_7) + "/") + __learnerID) + "/") + _local_4) + "/") + _arg_10) + "/") + _arg_14) + "/") + _arg_13) + "/") + _arg_12) + "/";
            var _local_6 = (encryptURL(_local_3, _local_4.toString(), __developerID) + "|") + encryptTime(_local_4.toString());
            var _local_2 = new LoadVars();
            _local_2.callback = _arg_11;
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
    }
