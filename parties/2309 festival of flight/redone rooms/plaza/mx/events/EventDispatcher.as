//Created by Action Script Viewer - https://www.buraks.com/asv
    class mx.events.EventDispatcher
    {
        function EventDispatcher () {
        }
        static function _removeEventListener(queue, event, handler) {
            if (queue != undefined) {
                var _local_4 = queue.length;
                var _local_1;
                _local_1 = 0;
                while (_local_1 < _local_4) {
                    var _local_2 = queue[_local_1];
                    if (_local_2 == handler) {
                        queue.splice(_local_1, 1);
                        return(undefined);
                    }
                    _local_1++;
                }
            }
        }
        static function initialize(object) {
            if (_fEventDispatcher == undefined) {
                _fEventDispatcher = new mx.events.EventDispatcher();
            }
            object.addEventListener = _fEventDispatcher.addEventListener;
            object.removeEventListener = _fEventDispatcher.removeEventListener;
            object.dispatchEvent = _fEventDispatcher.dispatchEvent;
            object.dispatchQueue = _fEventDispatcher.dispatchQueue;
        }
        function dispatchQueue(queueObj, eventObj) {
            var _local_7 = "__q_" + eventObj.type;
            var _local_4 = queueObj[_local_7];
            if (_local_4 != undefined) {
                var _local_5;
                for (_local_5 in _local_4) {
                    var _local_1 = _local_4[_local_5];
                    var _local_3 = typeof(_local_1);
                    if ((_local_3 == "object") || (_local_3 == "movieclip")) {
                        if (_local_1.handleEvent != undefined) {
                            _local_1.handleEvent(eventObj);
                        }
                        if (_local_1[eventObj.type] != undefined) {
                            if (exceptions[eventObj.type] == undefined) {
                                _local_1[eventObj.type](eventObj);
                            }
                        }
                    } else {
                        _local_1.apply(queueObj, [eventObj]);
                    }
                }
            }
        }
        function dispatchEvent(eventObj) {
            if (eventObj.target == undefined) {
                eventObj.target = this;
            }
            this[eventObj.type + "Handler"](eventObj);
            dispatchQueue(this, eventObj);
        }
        function addEventListener(event, handler) {
            var _local_3 = "__q_" + event;
            if (this[_local_3] == undefined) {
                this[_local_3] = new Array();
            }
            _global.ASSetPropFlags(this, _local_3, 1);
            _removeEventListener(this[_local_3], event, handler);
            this[_local_3].push(handler);
        }
        function removeEventListener(event, handler) {
            var _local_2 = "__q_" + event;
            _removeEventListener(this[_local_2], event, handler);
        }
        static var _fEventDispatcher = undefined;
        static var exceptions = {move:1, draw:1, load:1};
    }
