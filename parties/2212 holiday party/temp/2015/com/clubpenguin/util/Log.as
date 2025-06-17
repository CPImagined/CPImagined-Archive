class com.clubpenguin.util.Log
{
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
   static var _openChannels = [com.clubpenguin.util.Log.ALL];
   static var _channelMask = undefined;
   function Log()
   {
   }
   static function info(msg, channel)
   {
      com.clubpenguin.util.Log.writeLog(com.clubpenguin.util.Log.INFO,msg,channel);
   }
   static function debug(msg, channel)
   {
      com.clubpenguin.util.Log.writeLog(com.clubpenguin.util.Log.DEBUG,msg,channel);
   }
   static function warn(msg, channel)
   {
      com.clubpenguin.util.Log.writeLog(com.clubpenguin.util.Log.WARNING,msg,channel);
   }
   static function error(msg, channel)
   {
      com.clubpenguin.util.Log.writeLog(com.clubpenguin.util.Log.ERROR,msg,channel);
   }
   static function fatal(msg, channel)
   {
      com.clubpenguin.util.Log.writeLog(com.clubpenguin.util.Log.FATAL,msg,channel);
   }
   static function writeLog(level, msg, channel)
   {
      if(undefined == channel)
      {
         channel = com.clubpenguin.util.Log.DEFAULT;
      }
      if(com.clubpenguin.util.Log._enabled && channel.__get__bitMask() & com.clubpenguin.util.Log.getChannelMask() && level <= com.clubpenguin.util.Log._logLevel)
      {
         var _loc3_ = _global.getCurrentShell().getMyPlayerNickname().substr(0,4);
      }
   }
   static function generateChannelMask()
   {
      com.clubpenguin.util.Log._channelMask = 0;
      var _loc1_ = 0;
      while(_loc1_ < com.clubpenguin.util.Log._openChannels.length)
      {
         com.clubpenguin.util.Log._channelMask |= com.clubpenguin.util.Log._openChannels[_loc1_].bitMask;
         _loc1_ = _loc1_ + 1;
      }
   }
   static function getChannelMask()
   {
      if(com.clubpenguin.util.Log._channelMask == undefined)
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
      switch(level)
      {
         case com.clubpenguin.util.Log.INFO:
            return "[INFO]";
         case com.clubpenguin.util.Log.DEBUG:
            return "[DEBUG]";
         case com.clubpenguin.util.Log.WARNING:
            return "[WARNING]";
         case com.clubpenguin.util.Log.ERROR:
            return "[*ERROR*]";
         case com.clubpenguin.util.Log.FATAL:
            return "[***FATAL***]";
         default:
            return "[???]";
      }
   }
   static function getTimestamp()
   {
      var _loc1_ = new Date();
      return com.clubpenguin.util.Log.stringPadNumber(_loc1_.getHours() + 1,2) + ":" + com.clubpenguin.util.Log.stringPadNumber(_loc1_.getMinutes(),2) + ":" + com.clubpenguin.util.Log.stringPadNumber(_loc1_.getSeconds(),2) + "::" + com.clubpenguin.util.Log.stringPadNumber(_loc1_.getMilliseconds(),3);
   }
   static function stringPadNumber(num, padding)
   {
      var _loc2_ = "" + num;
      var _loc1_ = 1;
      while(_loc1_ <= padding - 1)
      {
         if(num / Math.pow(10,_loc1_) < 1)
         {
            _loc2_ = "0" + _loc2_;
         }
         _loc1_ = _loc1_ + 1;
      }
      return _loc2_;
   }
}
