//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.services.RawBiService
    {
        var _swfBridge;
        function RawBiService () {
        }
        function setSwfBridge(swfBridge) {
            _swfBridge = swfBridge;
        }
        function logErrorEvent(message) {
            var _local_2 = {};
            _local_2.c = "15e";
            _local_2.b = message;
            sendLogEvent(_local_2);
        }
        function logWarningEvent(message) {
            var _local_2 = {};
            _local_2.c = "15w";
            _local_2.b = message;
            sendLogEvent(_local_2);
        }
        function logInfoEvent(message) {
            var _local_2 = {};
            _local_2.c = "15i";
            _local_2.b = message;
            sendLogEvent(_local_2);
        }
        function logFrameRate(fps, currentRoomId) {
            var _local_2 = {};
            _local_2.c = "16w";
            _local_2.b = (currentRoomId + "|") + fps;
            sendLogEvent(_local_2);
        }
        function sendLogEvent(params) {
            _swfBridge.send(_global.getCurrentShell().AS3_GATEWAY_METHOD, {type:MSG_LOG_RAW_BI_EVENT, params:params});
        }
        static var MSG_LOG_RAW_BI_EVENT = "logRawBiEvent";
    }
