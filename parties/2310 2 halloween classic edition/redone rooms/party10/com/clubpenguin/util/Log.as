//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.util.Log
    {
        function Log () {
        }
        static function info(msg, channel) {
            writeLog(INFO, msg, channel);
        }
        static function debug(msg, channel) {
            writeLog(DEBUG, msg, channel);
        }
        static function warn(msg, channel) {
            writeLog(WARNING, msg, channel);
        }
        static function error(msg, channel) {
            writeLog(ERROR, msg, channel);
        }
        static function fatal(msg, channel) {
            writeLog(FATAL, msg, channel);
        }
        static function writeLog(level, msg, channel) {
            if (isNaN(channel)) {
                channel = 1;
            }
            if ((_enabled && (channel | _openChannels)) && (level <= _logLevel)) {
                trace((((((("" + getTimestamp()) + " [AS2] ") + getLevelAsString(level)) + " ") + getChannelAsString(channel)) + " ") + msg);
            }
        }
        static function setLogLevel(newLogLevel) {
            _logLevel = newLogLevel;
        }
        static function getChannelAsString(channel) {
            switch (channel) {
                case DEFAULT : 
                    return("|-DEFAULT-|");
                case SOCKET : 
                    return("|-SOCKET-|");
                case HTTP : 
                    return("|-HTTP-|");
                case UI : 
                    return("|-UI-|");
                case DEBUGGING : 
                    return("|-DEBUGGING-|");
                case ALL : 
                    return("|-ALL-|");
            }
            return("|-???-|");
        }
        static function getLevelAsString(level) {
            switch (level) {
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
        static function stringPadNumber(num, padding) {
            var _local_2 = "" + num;
            var _local_1 = 1;
            while (_local_1 <= (padding - 1)) {
                if ((num / Math.pow(10, _local_1)) < 1) {
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
        static var DEFAULT = 1;
        static var SOCKET = 2;
        static var HTTP = 4;
        static var UI = 8;
        static var BRIDGE = 16;
        static var DEBUGGING = 32;
        static var ALL = 63;
        static var _logLevel = 4;
        static var _enabled = true;
        static var _openChannels = ALL;
    }
