//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.services.DimgBiService
    {
        var _swfBridge;
        function DimgBiService () {
        }
        function setSwfBridge(swfBridge) {
            _swfBridge = swfBridge;
        }
        function logTimingEvent(location, elapsedTime, optionalResult) {
            var _local_2 = {};
            _local_2.tag = TAG_TIMING;
            _local_2.location = location;
            _local_2.elapsed_time = elapsedTime;
            if (optionalResult != null) {
                _local_2.result = optionalResult;
            }
            sendLogEvent(_local_2);
        }
        function logStepTimingEvent(context, location, optionalPathName, optionalElapsedTime, optionalResult) {
            var _local_2 = {};
            _local_2.tag = TAG_STEP_TIMING;
            _local_2.context = context;
            _local_2.location = location;
            if (optionalPathName != null) {
                _local_2.path_name = optionalPathName;
            }
            if (optionalElapsedTime != null) {
                _local_2.elapsed_time_ms = optionalElapsedTime;
            }
            if (optionalResult != null) {
                _local_2.result = optionalResult;
            }
            sendLogEvent(_local_2);
        }
        function logMoneyEvent(itemID, cost, name) {
            var _local_3 = {};
            _local_3.tag = TAG_MONEY;
            _local_3.currency = "coins";
            _local_3.balance = _global.getCurrentShell().getMyPlayerTotalCoins();
            _local_3.amount = cost;
            _local_3.subtype = name;
            _local_3.type = itemID + "_Clothing";
            sendLogEvent(_local_3);
        }
        function sendLogEvent(params) {
            _swfBridge.send(_global.getCurrentShell().AS3_GATEWAY_METHOD, {type:MSG_LOG_DIMG_BI_EVENT, params:params});
        }
        static var MSG_LOG_DIMG_BI_EVENT = "logDimgBiEvent";
        static var TAG_TIMING = "timing";
        static var TAG_STEP_TIMING = "step_timing";
        static var TAG_ERROR = "error";
        static var TAG_WARNING = "warning";
        static var TAG_ACTION = "action";
        static var TAG_MONEY = "money";
    }
