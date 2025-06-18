//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.util.EventDispatcher implements com.clubpenguin.util.IEventDispatcher
    {
        function EventDispatcher () {
        }
        function addEventListener(eventType, handler, scope) {
            if (!eventType.length) {
                trace("## ERROR ## EventDispatcher.addEventListener(): eventType missing. eventType: " + eventType);
            }
            if (!(handler instanceof Function)) {
                trace((("## ERROR ## EventDispatcher.addEventListener(): handler missing. eventType: " + eventType) + ", handler: ") + handler);
            }
            var _local_3 = getListenersArray(this, eventType);
            var _local_4 = getListenerIndex(_local_3, handler, scope);
            if (_local_4 == -1) {
                _local_3.push({handler:handler, scope:scope});
                return(true);
            }
            return(false);
        }
        function removeEventListener(eventType, handler, scope) {
            if (!eventType.length) {
                trace("## ERROR ## EventDispatcher.removeEventListener(): eventType missing. eventType: " + eventType);
            }
            if (!(handler instanceof Function)) {
                trace((("## ERROR ## EventDispatcher.removeEventListener(): handler missing. eventType: " + eventType) + ", handler: ") + handler);
            }
            var _local_3 = getListenersArray(this, eventType);
            var _local_4 = getListenerIndex(_local_3, handler, scope);
            if (_local_4 != -1) {
                _local_3.splice(_local_4, 1);
                return(true);
            }
            return(false);
        }
        function updateListeners(eventType, event) {
            if (event == undefined) {
                event = {};
            }
            event.type = eventType;
            return(dispatchEvent(event));
        }
        function dispatchEvent(event) {
            if (!event.type.length) {
                trace("## ERROR ## EventDispatcher.dispatchEvent(): event.type missing. event.type: " + event.type);
            }
            if (event.target == undefined) {
                event.target = this;
            }
            var _local_3 = getListenersArray(this, event.type).concat();
            var _local_5 = _local_3.length;
            if (_local_5 < 1) {
                return(false);
            }
            var _local_2 = 0;
            while (_local_2 < _local_5) {
                (_local_3[_local_2].scope ? (_local_3[_local_2].handler.call(_local_3[_local_2].scope, event)) : (_local_3[_local_2].handler(event)));
                _local_2++;
            }
            return(true);
        }
        static function getListenerIndex(listeners, handler, scope) {
            var _local_4 = listeners.length;
            var _local_1 = 0;
            while (_local_1 < _local_4) {
                if ((listeners[_local_1].handler == handler) && ((scope == undefined) || (listeners[_local_1].scope == scope))) {
                    return(_local_1);
                }
                _local_1++;
            }
            return(-1);
        }
        static function getListenersArray(eventSource, eventType) {
            if (!eventSource.__listener_obj) {
                eventSource.__listener_obj = {};
            }
            if (!eventSource.__listener_obj[eventType]) {
                eventSource.__listener_obj[eventType] = [];
            }
            return(eventSource.__listener_obj[eventType]);
        }
        static function initialize(eventSource) {
            eventSource.addEventListener = com.clubpenguin.util.EventDispatcher.prototype.addEventListener;
            eventSource.removeEventListener = com.clubpenguin.util.EventDispatcher.prototype.removeEventListener;
            eventSource.addListener = com.clubpenguin.util.EventDispatcher.prototype.addEventListener;
            eventSource.removeListener = com.clubpenguin.util.EventDispatcher.prototype.removeEventListener;
            eventSource.dispatchEvent = com.clubpenguin.util.EventDispatcher.prototype.dispatchEvent;
            eventSource.updateListeners = com.clubpenguin.util.EventDispatcher.prototype.updateListeners;
        }
    }
