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
            if (undefined == channel) {
                channel = DEFAULT;
            }
            if ((_enabled && (channel.bitMask & getChannelMask())) && (level <= _logLevel)) {
                var userName = _global.getCurrentShell().getMyPlayerNickname().substr(0, 4);
            }
        }
        static function generateChannelMask() {
            _channelMask = 0;
            var i = 0;
            while (i < _openChannels.length) {
                _channelMask = _channelMask | _openChannels[i].bitMask;
                i++;
            }
        }
        static function getChannelMask() {
            if (_channelMask == undefined) {
                generateChannelMask();
            }
            return(_channelMask);
        }
        static function setLogLevel(newLogLevel) {
            _logLevel = newLogLevel;
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
            var d = new Date();
            return((((((stringPadNumber(d.getHours() + 1, 2) + ":") + stringPadNumber(d.getMinutes(), 2)) + ":") + stringPadNumber(d.getSeconds(), 2)) + "::") + stringPadNumber(d.getMilliseconds(), 3));
        }
        static function stringPadNumber(num, padding) {
            var numStr = ("" + num);
            var i = 1;
            while (i <= (padding - 1)) {
                if ((num / Math.pow(10, i)) < 1) {
                    numStr = "0" + numStr;
                }
                i++;
            }
            return(numStr);
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
