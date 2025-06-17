//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.util.Reporting
    {
        static var output;
        function Reporting () {
        }
        static function addDebugOutput(debugText) {
            if (output == undefined) {
                output = new Array();
            }
            output.push(debugText);
        }
        static function setDebugLevel(level) {
            if ((debugLevel > DEBUGLEVEL_ERROR) || (debugLevel < DEBUGLEVEL_VERBOSE)) {
                debugTrace("(Reporting) incorrect debug level given in setDebugLevel: " + level, DEBUGLEVEL_WARNING);
            } else {
                debugLevel = level;
            }
        }
        static function debugTrace(message, priority) {
            if (priority == undefined) {
                priority = DEBUGLEVEL_VERBOSE;
            }
            if (DEBUG) {
                if (debugLevel <= priority) {
                    var _local_1;
                    switch (priority) {
                        case DEBUGLEVEL_ERROR : 
                            _local_1 = "ERROR! " + message;
                            break;
                        case DEBUGLEVEL_WARNING : 
                            _local_1 = "WARNING: " + message;
                            break;
                        case DEBUGLEVEL_MESSAGE : 
                            _local_1 = "MESSAGE: " + message;
                            break;
                        case DEBUGLEVEL_VERBOSE : 
                        default : 
                            _local_1 = "VERBOSE: " + message;
                            break;
                    }
                    for (var _local_2 in output) {
                        output[_local_2].text = (_local_1 + newline) + output[_local_2].text;
                    }
                }
            }
        }
        static var DEBUG = true;
        static var DEBUG_FPS = DEBUG && true;
        static var DEBUG_SOUNDS = DEBUG && true;
        static var DEBUG_LOCALE = DEBUG && true;
        static var DEBUG_SECURITY = DEBUG && true;
        static var DEBUGLEVEL_VERBOSE = 0;
        static var DEBUGLEVEL_MESSAGE = 1;
        static var DEBUGLEVEL_WARNING = 2;
        static var DEBUGLEVEL_ERROR = 3;
        static var debugLevel = DEBUGLEVEL_MESSAGE;
    }
