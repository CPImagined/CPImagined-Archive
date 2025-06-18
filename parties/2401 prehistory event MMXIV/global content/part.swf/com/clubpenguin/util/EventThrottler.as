
//Created by Action Script Viewer - http://www.buraks.com/asv
    class com.clubpenguin.util.EventThrottler
    {
        var _eventQueue, _delayBetweenEvents, __get__delayBetweenEvents, __get__maxQueueSize;
        function EventThrottler () {
            _eventQueue = [];
            delayBetweenEvents = (0);
        }
        function set delayBetweenEvents(_arg_2) {
            _delayBetweenEvents = _arg_2;
            if (_delayBetweenEvents < 0) {
                _delayBetweenEvents = 0;
            }
            if (_intervalId != -1) {
                disableInterval();
                if (_delayBetweenEvents > 0) {
                    enableInterval();
                }
            }
            if ((_delayBetweenEvents == 0) && (_eventQueue.length > 0)) {
                processNextEvent();
            }
            //return(__get__delayBetweenEvents());
        }
        function set maxQueueSize(_arg_2) {
            _maxQueueSize = ((_arg_2 != undefined) ? (_arg_2) : 0);
            //return(__get__maxQueueSize());
        }
        function queueFunction(_arg_2) {
            if ((_maxQueueSize > 0) && (_eventQueue.length >= _maxQueueSize)) {
                return(undefined);
            }
            _eventQueue.push({type:EVENT_TYPE_FUNCTION, callback:_arg_2});
            if (_delayBetweenEvents <= 0) {
                processNextEvent();
            } else if (_intervalId == -1) {
                enableInterval();
                if (_eventQueue.length == 1) {
                    processNextEvent();
                }
            }
        }
        function clearQueue() {
            _eventQueue.length = 0;
            disableInterval();
        }
        function processNextEvent() {
            if (_eventQueue.length > 0) {
                var _local_2 = _eventQueue.shift();
                invokeEvent(_local_2);
                if (_delayBetweenEvents <= 0) {
                    processNextEvent();
                }
            } else {
                disableInterval();
            }
        }
        function invokeEvent(_arg_1) {
            if (_arg_1.type == EVENT_TYPE_FUNCTION) {
                _arg_1.callback();
            }
        }
        function enableInterval() {
            clearInterval(_intervalId);
            _intervalId = setInterval(this, "processNextEvent", _delayBetweenEvents);
        }
        function disableInterval() {
            clearInterval(_intervalId);
            _intervalId = -1;
        }
        static var EVENT_TYPE_FUNCTION = 0;
        var _maxQueueSize = 0;
        var _intervalId = -1;
    }
