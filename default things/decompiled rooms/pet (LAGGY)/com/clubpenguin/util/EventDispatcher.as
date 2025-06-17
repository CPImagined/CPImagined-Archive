//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.util.EventDispatcher implements com.clubpenguin.util.IEventDispatcher
    {
        function EventDispatcher () {
        }
        function addEventListener(_arg_2, _arg_5, _arg_6) {
            if (!_arg_2.length) {
            }
            if (!(_arg_5 instanceof Function)) {
            }
            var _local_3 = getListenersArray(this, _arg_2);
            var _local_4 = getListenerIndex(_local_3, _arg_5, _arg_6);
            if (_local_4 == -1) {
                _local_3.push({handler:_arg_5, scope:_arg_6});
                return(true);
            }
            return(false);
        }
        function removeEventListener(_arg_2, _arg_5, _arg_6) {
            if (!_arg_2.length) {
            }
            if (!(_arg_5 instanceof Function)) {
            }
            var _local_3 = getListenersArray(this, _arg_2);
            var _local_4 = getListenerIndex(_local_3, _arg_5, _arg_6);
            if (_local_4 != -1) {
                _local_3.splice(_local_4, 1);
                return(true);
            }
            return(false);
        }
        function updateListeners(_arg_3, _arg_2) {
            if (_arg_2 == undefined) {
                _arg_2 = {};
            }
            _arg_2.type = _arg_3;
            return(dispatchEvent(_arg_2));
        }
        function dispatchEvent(_arg_4) {
            if (!_arg_4.type.length) {
            }
            if (_arg_4.target == undefined) {
                _arg_4.target = this;
            }
            var _local_3 = getListenersArray(this, _arg_4.type).concat();
            var _local_5 = _local_3.length;
            if (_local_5 < 1) {
                return(false);
            }
            var _local_2 = 0;
            while (_local_2 < _local_5) {
                (_local_3[_local_2].scope ? (_local_3[_local_2].handler.call(_local_3[_local_2].scope, _arg_4)) : (_local_3[_local_2].handler(_arg_4)));
                _local_2++;
            }
            return(true);
        }
        static function getListenerIndex(_arg_2, _arg_5, _arg_3) {
            var _local_4 = _arg_2.length;
            var _local_1 = 0;
            while (_local_1 < _local_4) {
                if ((_arg_2[_local_1].handler == _arg_5) && ((_arg_3 == undefined) || (_arg_2[_local_1].scope == _arg_3))) {
                    return(_local_1);
                }
                _local_1++;
            }
            return(-1);
        }
        static function getListenersArray(_arg_1, _arg_2) {
            if (!_arg_1.__listener_obj) {
                _arg_1.__listener_obj = {};
            }
            if (!_arg_1.__listener_obj[_arg_2]) {
                _arg_1.__listener_obj[_arg_2] = [];
            }
            return(_arg_1.__listener_obj[_arg_2]);
        }
        static function initialize(_arg_1) {
            _arg_1.addEventListener = com.clubpenguin.util.EventDispatcher.prototype.addEventListener;
            _arg_1.removeEventListener = com.clubpenguin.util.EventDispatcher.prototype.removeEventListener;
            _arg_1.addListener = com.clubpenguin.util.EventDispatcher.prototype.addEventListener;
            _arg_1.removeListener = com.clubpenguin.util.EventDispatcher.prototype.removeEventListener;
            _arg_1.dispatchEvent = com.clubpenguin.util.EventDispatcher.prototype.dispatchEvent;
            _arg_1.updateListeners = com.clubpenguin.util.EventDispatcher.prototype.updateListeners;
        }
    }
