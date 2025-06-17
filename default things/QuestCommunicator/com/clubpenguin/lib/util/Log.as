//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.lib.util
{
    import flash.system.Capabilities;

    public class Log 
    {

        public static const INFO:int = 4;
        public static const DEBUG:int = 3;
        public static const WARNING:int = 2;
        public static const ERROR:int = 1;
        public static const FATAL:int = 0;
        public static const DEFAULT:int = 1;
        public static const SOCKET:int = 2;
        public static const HTTP:int = 4;
        public static const UI:int = 8;
        public static const BRIDGE:int = 16;
        public static const DEBUGGING:int = 32;
        public static var PARTY:Number = 64;
        public static var ALL:Number = 127;
        private static var _logLevel:int = 4;
        private static var _enabled:Boolean = true;
        private static var _openChannels:int = ALL;


        public static function info(msg:String, channel:int=1):void
        {
            writeLog(INFO, msg, channel);
        }

        public static function debug(msg:String, channel:int=1):void
        {
            writeLog(DEBUG, msg, channel);
        }

        public static function warn(msg:String, channel:int=1):void
        {
            writeLog(WARNING, msg, channel);
        }

        public static function error(msg:String, channel:int=1):void
        {
            writeLog(ERROR, msg, channel);
        }

        public static function fatal(msg:String, channel:int=1):void
        {
            writeLog(FATAL, msg, channel);
        }

        private static function writeLog(level:int, msg:String, channel:int):void
        {
            var stack_str:String;
            var stackArray:Array;
            var lineCall:String;
            var callArray:Array;
            var classAndMethod:String;
            var classAndMethodArray:Array;
            var className:String;
            var colonsPosition:Number;
            var methodName:String;
            var filenameAndLineNumber:String;
            var packagePath:String;
            if ((((_enabled) && (channel | _openChannels)) && (level <= _logLevel)))
            {
                if ((!(Capabilities.isDebugger)))
                {
                    trace(((((((("" + getTimestamp()) + " [AS3] ") + getLevelAsString(level)) + " ") + getChannelAsString(channel)) + " ") + msg));
                    return;
                };
                try
                {
                    throw (new Error("Error to trap call stack."));
                }
                catch(e:Error)
                {
                    stack_str = e.getStackTrace();
                    stackArray = stack_str.split("\n");
                    lineCall = stackArray[3].slice(4, stackArray[3].length);
                    callArray = lineCall.split("[");
                    classAndMethod = (callArray[0] as String);
                    classAndMethodArray = classAndMethod.split("/");
                    className = (classAndMethodArray[0] as String);
                    colonsPosition = className.indexOf("::");
                    className = className.substr((colonsPosition + 2));
                    className = className.replace("$", "");
                    className = className.replace("()", "");
                    methodName = (classAndMethodArray[1] as String);
                    filenameAndLineNumber = (callArray[1] as String).substr(0, ((callArray[1] as String).length - 1));
                    packagePath = (classAndMethodArray[0] as String).split("::").join(".");
                    packagePath = packagePath.replace("$", "");
                    packagePath = packagePath.replace("()", "");
                    methodName = ((methodName) ? methodName : (className + "()"));
                }
                finally
                {
                    trace(((((((((((("" + getTimestamp()) + " [AS3] ") + getLevelAsString(level)) + " ") + getChannelAsString(channel)) + " ") + packagePath) + " ") + methodName) + "-->") + msg));
                };
            };
        }

        public static function setLogLevel(newLogLevel:int):void
        {
            _logLevel = newLogLevel;
        }

        private static function getChannelAsString(channel:int):String
        {
            switch (channel)
            {
                case DEFAULT:
                    return ("|-DEFAULT-|");
                case SOCKET:
                    return ("|-SOCKET-|");
                case HTTP:
                    return ("|-HTTP-|");
                case UI:
                    return ("|-UI-|");
                case DEBUGGING:
                    return ("|-DEBUG-|");
                case PARTY:
                    return ("|-PARTY-|");
                case PARTY:
                    return ("|-PARTY-|");
                case ALL:
                    return ("|-ALL-|");
                default:
                    return ("|-???-|");
            };
        }

        private static function getLevelAsString(level:int):String
        {
            switch (level)
            {
                case INFO:
                    return ("[INFO]");
                case DEBUG:
                    return ("[DEBUG]");
                case WARNING:
                    return ("[WARNING]");
                case ERROR:
                    return ("[*ERROR*]");
                case FATAL:
                    return ("[***FATAL***]");
                default:
                    return ("[???]");
            };
        }

        private static function getTimestamp():String
        {
            var d:Date = new Date();
            return ((((((stringPadNumber(d.hours, 2) + ":") + stringPadNumber(d.minutes, 2)) + ":") + stringPadNumber(d.seconds, 2)) + "::") + stringPadNumber(d.milliseconds, 3));
        }

        private static function stringPadNumber(num:int, padding:int):String
        {
            var numStr:String = ("" + num);
            var i:int = 1;
            while (i <= (padding - 1))
            {
                if ((num / Math.pow(10, i)) < 1)
                {
                    numStr = ("0" + numStr);
                };
                i++;
            };
            return (numStr);
        }


    }
}//package com.clubpenguin.lib.util
