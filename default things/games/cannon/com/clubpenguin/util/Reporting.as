//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.util.Reporting
    {
        static var output;
        function Reporting () {
        }
        static function addDebugOutput(_arg_1) {
            if (output == undefined) {
                output = new Array();
            }
            output.push(_arg_1);
        }
        static function setDebugLevel(_arg_1) {
            if ((debugLevel > DEBUGLEVEL_ERROR) || (debugLevel < DEBUGLEVEL_VERBOSE)) {
                debugTrace("(Reporting) incorrect debug level given in setDebugLevel: " + _arg_1, DEBUGLEVEL_WARNING);
            } else {
                debugLevel = _arg_1;
            }
        }
        static function debugTrace(_arg_3, _arg_4) {
            if (_arg_4 == undefined) {
                _arg_4 = DEBUGLEVEL_VERBOSE;
            }
            if (DEBUG) {
                if (debugLevel <= _arg_4) {
                    var _local_1;
                    switch (_arg_4) {
                        case DEBUGLEVEL_ERROR : 
                            _local_1 = "ERROR! " + _arg_3;
                            break;
                        case DEBUGLEVEL_WARNING : 
                            _local_1 = "WARNING: " + _arg_3;
                            break;
                        case DEBUGLEVEL_MESSAGE : 
                            _local_1 = "MESSAGE: " + _arg_3;
                            break;
                        case DEBUGLEVEL_VERBOSE : 
                        default : 
                            _local_1 = "VERBOSE: " + _arg_3;
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
