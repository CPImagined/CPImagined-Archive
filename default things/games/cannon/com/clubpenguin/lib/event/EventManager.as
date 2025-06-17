//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.lib.event.EventManager implements com.clubpenguin.lib.event.IEventDispatcher
    {
        static var $_instance;
        var __uid, __listenerObjects;
        function EventManager () {
            __uid = $_instanceCount++;
            __listenerObjects = new Array();
        }
        static function get instance() {
            if ($_instance == null) {
                $_instance = new com.clubpenguin.lib.event.EventManager();
            }
            return($_instance);
        }
        static function addEventListener(_arg_3, _arg_5, _arg_4, _arg_2) {
            var _local_1;
            _local_1 = instance.addInternalEventListener(_arg_3, _arg_5, _arg_4, _arg_2);
            return(_local_1);
        }
        function addInternalEventListener(_arg_4, _arg_6, _arg_9, _arg_8) {
            var _local_2;
            _local_2 = false;
            if (!_arg_4.length) {
                trace("## ERROR ## EventManager.addEventListener(): eventType missing. eventType: " + _arg_4);
            }
            if (!(_arg_6 instanceof Function)) {
                trace((("## ERROR ## EventManager.addEventListener(): handler missing. eventType: " + _arg_4) + ", handler: ") + _arg_6);
            }
            var _local_3;
            var _local_7;
            var _local_5;
            if (_arg_8 == null) {
                _local_5 = this;
            } else {
                _local_5 = _arg_8;
            }
            _local_3 = getListenersArray(_local_5, _arg_4);
            _local_7 = getListenerIndex(_local_3, _arg_6, _arg_9);
            if (_local_7 == -1) {
                _local_3.push(new com.clubpenguin.lib.event.EventListener(_arg_6, _arg_9));
                _local_2 = true;
            }
            return(_local_2);
        }
        static function removeEventListener(_arg_2, _arg_4, _arg_3) {
            var _local_1;
            _local_1 = instance.removeInternalEventListener(_arg_2, _arg_4, _arg_3);
            return(_local_1);
        }
        function removeInternalEventListener(_arg_4, _arg_6, _arg_7) {
            var _local_2;
            _local_2 = false;
            if (!_arg_4.length) {
                trace("## ERROR ## EventManager.removeEventListener(): eventType missing. eventType: " + _arg_4);
            }
            if (!(_arg_6 instanceof Function)) {
                trace((("## ERROR ## EventManager.removeEventListener(): handler missing. eventType: " + _arg_4) + ", handler: ") + _arg_6);
            }
            var _local_3;
            var _local_5;
            _local_3 = getListenersArray(this, _arg_4);
            _local_5 = getListenerIndex(_local_3, _arg_6, _arg_7);
            if (_local_5 != -1) {
                _local_3.splice(_local_5, 1);
                _local_2 = true;
            }
            return(_local_2);
        }
        static function dispatchEvent(_arg_2) {
            var _local_1;
            _local_1 = instance.dispatchInternalEvent(_arg_2);
            return(_local_1);
        }
        function dispatchInternalEvent(_arg_4) {
            var _local_8;
            var _local_7;
            _local_8 = false;
            if (!_arg_4.type.length) {
                trace("## ERROR ## EventManager.dispatchEvent(): event.type missing. event.type: " + _arg_4.type);
            }
            _local_7 = _arg_4.target.getUniqueName();
            if ((_local_7 == undefined) || (_local_7 == "")) {
                _arg_4.target = this;
            }
            var _local_6;
            var _local_5;
            var _local_9;
            var _local_3;
            var _local_2;
            _local_6 = getListenersArray(this, _arg_4.type).concat();
            if (_arg_4.target.getUniqueName() == getUniqueName()) {
                _local_5 = new Array();
            } else {
                _local_5 = getListenersArray(_arg_4.target, _arg_4.type).concat();
            }
            _local_9 = _local_6.length + _local_5.length;
            if (_local_9 > 0) {
                _local_8 = true;
                _local_3 = 0;
                while (_local_3 < _local_6.length) {
                    _local_2 = _local_6[_local_3];
                    (_local_2.scope ? (_local_2.handler.call(_local_2.scope, _arg_4)) : (_local_2.handler(_arg_4)));
                    _local_3++;
                }
                _local_3 = 0;
                while (_local_3 < _local_5.length) {
                    _local_2 = _local_5[_local_3];
                    (_local_2.scope ? (_local_2.handler.call(_local_2.scope, _arg_4)) : (_local_2.handler(_arg_4)));
                    _local_3++;
                }
            }
            return(_local_8);
        }
        static function getListenerIndex(_arg_6, _arg_7, _arg_3) {
            var _local_5 = _arg_6.length;
            var _local_1 = 0;
            var _local_2;
            var _local_4;
            _local_4 = -1;
            _local_1 = 0;
            while (_local_1 < _local_5) {
                _local_2 = _arg_6[_local_1];
                if ((_local_2.handler == _arg_7) && ((_arg_3 == undefined) || (_local_2.scope == _arg_3))) {
                    _local_4 = _local_1;
                }
                _local_1++;
            }
            return(_local_4);
        }
        static function getListenersArray(_arg_3, _arg_2) {
            var _local_1;
            _local_1 = instance.listenerObject(_arg_3.getUniqueName());
            if (!_local_1[_arg_2]) {
                _local_1[_arg_2] = new Array();
            }
            return(_local_1[_arg_2]);
        }
        function listenerObject(_arg_2) {
            if (__listenerObjects[_arg_2] == null) {
                __listenerObjects[_arg_2] = new Array();
            }
            return(__listenerObjects[_arg_2]);
        }
        function getUniqueName() {
            return(("[EventManager<" + __uid) + ">]");
        }
        static function dispose() {
            instance.__listenerObjects = new Array();
            instance.dispatchInternalEvent(new com.clubpenguin.game.net.event.NetClientEvent(new com.clubpenguin.lib.event.IEventDispatcher(), com.clubpenguin.game.net.event.NetClientEvent.NET_REQUEST));
        }
        static var $_instanceCount = 0;
    }
