dynamic class com.clubpenguin.util.Log
{
    static var INFO: Number = 4;
    static var DEBUG: Number = 3;
    static var WARNING: Number = 2;
    static var ERROR: Number = 1;
    static var FATAL: Number = 0;
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
    static var _logLevel: Number = 4;
    static var _enabled: Boolean = true;
    static var _openChannels = [com.clubpenguin.util.Log.ALL];
    static var _channelMask = undefined;

    function Log()
    {
    }

    static function info(msg, channel)
    {
        com.clubpenguin.util.Log.writeLog(com.clubpenguin.util.Log.INFO, msg, channel);
    }

    static function debug(msg, channel)
    {
        com.clubpenguin.util.Log.writeLog(com.clubpenguin.util.Log.DEBUG, msg, channel);
    }

    static function warn(msg, channel)
    {
        com.clubpenguin.util.Log.writeLog(com.clubpenguin.util.Log.WARNING, msg, channel);
    }

    static function error(msg, channel)
    {
        com.clubpenguin.util.Log.writeLog(com.clubpenguin.util.Log.ERROR, msg, channel);
    }

    static function fatal(msg, channel)
    {
        com.clubpenguin.util.Log.writeLog(com.clubpenguin.util.Log.FATAL, msg, channel);
    }

    static function writeLog(level, msg, channel)
    {
        if (undefined == channel) 
        {
            channel = com.clubpenguin.util.Log.DEFAULT;
        }
        if (com.clubpenguin.util.Log._enabled && channel.__get__bitMask() & com.clubpenguin.util.Log.getChannelMask() && level <= com.clubpenguin.util.Log._logLevel) 
        {
            var __reg3 = _global.getCurrentShell().getMyPlayerNickname().substr(0, 4);
        }
    }

    static function generateChannelMask()
    {
        com.clubpenguin.util.Log._channelMask = 0;
        var __reg1 = 0;
        for (;;) 
        {
            if (__reg1 >= com.clubpenguin.util.Log._openChannels.length) 
            {
                return;
            }
            com.clubpenguin.util.Log._channelMask = com.clubpenguin.util.Log._channelMask | com.clubpenguin.util.Log._openChannels[__reg1].bitMask;
            ++__reg1;
        }
    }

    static function getChannelMask()
    {
        if (com.clubpenguin.util.Log._channelMask == undefined) 
        {
            com.clubpenguin.util.Log.generateChannelMask();
        }
        return com.clubpenguin.util.Log._channelMask;
    }

    static function setLogLevel(newLogLevel)
    {
        com.clubpenguin.util.Log._logLevel = newLogLevel;
    }

    static function getLevelAsString(level)
    {
        if ((__reg0 = level) === com.clubpenguin.util.Log.INFO) 
        {
            return "[INFO]";
        }
        else if (__reg0 === com.clubpenguin.util.Log.DEBUG) 
        {
            return "[DEBUG]";
        }
        else if (__reg0 === com.clubpenguin.util.Log.WARNING) 
        {
            return "[WARNING]";
        }
        else if (__reg0 === com.clubpenguin.util.Log.ERROR) 
        {
            return "[*ERROR*]";
        }
        else if (__reg0 === com.clubpenguin.util.Log.FATAL) 
        {
            return "[***FATAL***]";
        }
        return "[???]";
    }

    static function getTimestamp()
    {
        var __reg1 = new Date();
        return com.clubpenguin.util.Log.stringPadNumber(__reg1.getHours() + 1, 2) + ":" + com.clubpenguin.util.Log.stringPadNumber(__reg1.getMinutes(), 2) + ":" + com.clubpenguin.util.Log.stringPadNumber(__reg1.getSeconds(), 2) + "::" + com.clubpenguin.util.Log.stringPadNumber(__reg1.getMilliseconds(), 3);
    }

    static function stringPadNumber(num, padding)
    {
        var __reg2 = "" + num;
        var __reg1 = 1;
        while (__reg1 <= padding - 1) 
        {
            if (num / Math.pow(10, __reg1) < 1) 
            {
                __reg2 = "0" + __reg2;
            }
            ++__reg1;
        }
        return __reg2;
    }

}
