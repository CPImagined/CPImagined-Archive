
//Created by Action Script Viewer - http://www.buraks.com/asv
    class com.clubpenguin.util.Log
    {
        function Log () {
        }
        static function info(_arg_1, _arg_2) {
            writeLog(INFO, _arg_1, _arg_2);
        }
        static function debug(_arg_1, _arg_2) {
            writeLog(DEBUG, _arg_1, _arg_2);
        }
        static function warn(_arg_1, _arg_2) {
            writeLog(WARNING, _arg_1, _arg_2);
        }
        static function error(_arg_1, _arg_2) {
            writeLog(ERROR, _arg_1, _arg_2);
        }
        static function fatal(_arg_1, _arg_2) {
            writeLog(FATAL, _arg_1, _arg_2);
        }
        static function writeLog(_arg_4, _arg_5, _arg_2) {
            if (undefined == _arg_2) {
                _arg_2 = DEFAULT;
            }
            if ((_enabled && (_arg_2.__get__bitMask() & getChannelMask())) && (_arg_4 <= _logLevel)) {
                var _local_3 = _global.getCurrentShell().getMyPlayerNickname().substr(0, 4);
            }
        }
        static function generateChannelMask() {
            _channelMask = 0;
            var _local_1 = 0;
            while (_local_1 < _openChannels.length) {
                _channelMask = _channelMask | _openChannels[_local_1].bitMask;
                _local_1++;
            }
        }
        static function getChannelMask() {
            if (_channelMask == undefined) {
                generateChannelMask();
            }
            return(_channelMask);
        }
        static function setLogLevel(_arg_1) {
            _logLevel = _arg_1;
        }
        static function getLevelAsString(_arg_1) {
            switch (_arg_1) {
                case INFO : 
                    return("[INFO]");
                case DEBUG : 
                    return("[DEBUG]");
                case WARNING : 
                    return("[WARNING]");
                case ERROR : 
                    return("[*ERROR*]");
                case FATAL : 
                    return("[***FATAL***]");
            }
            return("[???]");
        }
        static function getTimestamp() {
            var _local_1 = new Date();
            return((((((stringPadNumber(_local_1.getHours() + 1, 2) + ":") + stringPadNumber(_local_1.getMinutes(), 2)) + ":") + stringPadNumber(_local_1.getSeconds(), 2)) + "::") + stringPadNumber(_local_1.getMilliseconds(), 3));
        }
        static function stringPadNumber(_arg_3, _arg_4) {
            var _local_2 = "" + _arg_3;
            var _local_1 = 1;
            while (_local_1 <= (_arg_4 - 1)) {
                if ((_arg_3 / Math.pow(10, _local_1)) < 1) {
                    _local_2 = "0" + _local_2;
                }
                _local_1++;
            }
            return(_local_2);
        }
        static var INFO = 4;
        static var DEBUG = 3;
        static var WARNING = 2;
        static var ERROR = 1;
        static var FATAL = 0;
        static var ALL = new com.clubpenguin.util.LogChannel("all");
        static var DEFAULT = new com.clubpenguin.util.LogChannel("default");
        static var SOCKET = new com.clubpenguin.util.LogChannel("socket");
        static var HTTP = new com.clubpenguin.util.LogChannel("http");
        static var UI = new com.clubpenguin.util.LogChannel("ui");
        static var BRIDGE = new com.clubpenguin.util.LogChannel("bridge");
        static var DEBUGGING = new com.clubpenguin.util.LogChannel("debugging");
        static var PARTY = new com.clubpenguin.util.LogChannel("party");
        static var ENGINE = new com.clubpenguin.util.LogChannel("engine");
        static var PUFFLES = new com.clubpenguin.util.LogChannel("puffles");
        static var TRANSFORMATIONS = new com.clubpenguin.util.LogChannel("transformations");
        static var _logLevel = 4;
        static var _enabled = true;
        static var _openChannels = [ALL];
        static var _channelMask = undefined;
    }
