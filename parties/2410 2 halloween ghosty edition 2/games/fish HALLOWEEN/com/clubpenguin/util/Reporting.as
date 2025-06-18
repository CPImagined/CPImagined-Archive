class com.clubpenguin.util.Reporting
{
   static var output;
   static var DEBUG = true;
   static var DEBUG_FPS = com.clubpenguin.util.Reporting.DEBUG;
   static var DEBUG_SOUNDS = com.clubpenguin.util.Reporting.DEBUG;
   static var DEBUG_LOCALE = com.clubpenguin.util.Reporting.DEBUG;
   static var DEBUG_SECURITY = com.clubpenguin.util.Reporting.DEBUG;
   static var DEBUGLEVEL_VERBOSE = 0;
   static var DEBUGLEVEL_MESSAGE = 1;
   static var DEBUGLEVEL_WARNING = 2;
   static var DEBUGLEVEL_ERROR = 3;
   static var debugLevel = com.clubpenguin.util.Reporting.DEBUGLEVEL_MESSAGE;
   function Reporting()
   {
   }
   static function addDebugOutput(debugText)
   {
      if(com.clubpenguin.util.Reporting.output == undefined)
      {
         com.clubpenguin.util.Reporting.output = new Array();
      }
      com.clubpenguin.util.Reporting.output.push(debugText);
   }
   static function setDebugLevel(level)
   {
      if(com.clubpenguin.util.Reporting.debugLevel > com.clubpenguin.util.Reporting.DEBUGLEVEL_ERROR || com.clubpenguin.util.Reporting.debugLevel < com.clubpenguin.util.Reporting.DEBUGLEVEL_VERBOSE)
      {
         com.clubpenguin.util.Reporting.debugTrace("(Reporting) incorrect debug level given in setDebugLevel: " + level,com.clubpenguin.util.Reporting.DEBUGLEVEL_WARNING);
      }
      else
      {
         com.clubpenguin.util.Reporting.debugLevel = level;
      }
   }
   static function debugTrace(message, priority)
   {
      if(priority == undefined)
      {
         priority = com.clubpenguin.util.Reporting.DEBUGLEVEL_VERBOSE;
      }
      if(com.clubpenguin.util.Reporting.DEBUG)
      {
         if(com.clubpenguin.util.Reporting.debugLevel <= priority)
         {
            var _loc1_ = undefined;
            switch(priority)
            {
               case com.clubpenguin.util.Reporting.DEBUGLEVEL_ERROR:
                  _loc1_ = "ERROR! " + message;
                  break;
               case com.clubpenguin.util.Reporting.DEBUGLEVEL_WARNING:
                  _loc1_ = "WARNING: " + message;
                  break;
               case com.clubpenguin.util.Reporting.DEBUGLEVEL_MESSAGE:
                  _loc1_ = "MESSAGE: " + message;
                  break;
               case com.clubpenguin.util.Reporting.DEBUGLEVEL_VERBOSE:
               default:
                  _loc1_ = "VERBOSE: " + message;
            }
            for(var _loc2_ in com.clubpenguin.util.Reporting.output)
            {
               com.clubpenguin.util.Reporting.output[_loc2_].text = _loc1_ + "\n" + com.clubpenguin.util.Reporting.output[_loc2_].text;
            }
         }
      }
   }
}
