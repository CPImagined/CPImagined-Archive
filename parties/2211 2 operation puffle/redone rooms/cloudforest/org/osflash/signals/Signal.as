//Created by Action Script Viewer - https://www.buraks.com/asv
    class org.osflash.signals.Signal implements org.osflash.signals.ISignal, org.osflash.signals.IDispatcher
    {
        var listenerBoxes, _valueClasses;
        function Signal () {
            listenerBoxes = [];
            setValueClasses(arguments);
        }
        function getNumListeners() {
            return(listenerBoxes.length);
        }
        function getValueClasses() {
            return(_valueClasses);
        }
        function add(listener, scope) {
            registerListener(listener, scope, false);
        }
        function addOnce(listener, scope) {
            registerListener(listener, scope, true);
        }
        function remove(listener, scope) {
            if (listenersNeedCloning) {
                listenerBoxes = listenerBoxes.slice();
                listenersNeedCloning = false;
            }
            var _local_2 = listenerBoxes.length;
            while (_local_2--) {
                if ((listenerBoxes[_local_2].listener == listener) && (listenerBoxes[_local_2].scope == scope)) {
                    listenerBoxes.splice(_local_2, 1);
                    return(undefined);
                }
            }
        }
        function removeAll() {
            var _local_2 = listenerBoxes.length;
            while (_local_2--) {
                remove(listenerBoxes[_local_2].listener, listenerBoxes[_local_2].scope);
            }
        }
        function dispatch() {
            var _local_6;
            var _local_3 = 0;
            while (_local_3 < _valueClasses.length) {
                if (primitiveMatchesValueClass(arguments[_local_3], _valueClasses[_local_3])) {
                } else {
                    _local_6 = arguments[_local_3];
                    if ((_local_6 == null) || (_local_6 instanceof _valueClasses[_local_3])) {
                    } else {
                        throw new Error(((("Value object <" + _local_6) + "> is not an instance of <") + _valueClasses[_local_3]) + ">.");
                    }
                }
                _local_3++;
            }
            var _local_7 = listenerBoxes;
            var _local_8 = _local_7.length;
            var _local_4;
            var _local_9;
            listenersNeedCloning = true;
            var _local_5 = 0;
            while (_local_5 < _local_8) {
                _local_4 = _local_7[_local_5];
                if (_local_4.once) {
                    remove(_local_4.listener, _local_4.scope);
                }
                _local_4.listener.apply(_local_4.scope, arguments);
                _local_5++;
            }
            listenersNeedCloning = false;
        }
        function primitiveMatchesValueClass(primitive, valueClass) {
            if ((((typeof(primitive) == "string") && (valueClass == String)) || ((typeof(primitive) == "number") && (valueClass == Number))) || ((typeof(primitive) == "boolean") && (valueClass == Boolean))) {
                return(true);
            }
            return(false);
        }
        function setValueClasses(valueClasses) {
            _valueClasses = valueClasses || ([]);
            var _local_2 = _valueClasses.length;
            while (_local_2--) {
                if (!(_valueClasses[_local_2] instanceof Function)) {
                    throw new Error(((("Invalid valueClasses argument: item at index " + _local_2) + " should be a Class but was:<") + _valueClasses[_local_2]) + ">.");
                }
            }
        }
        function registerListener(listener, scope, once) {
            var _local_2 = 0;
            while (_local_2 < listenerBoxes.length) {
                if ((listenerBoxes[_local_2].listener == listener) && (listenerBoxes[_local_2].scope == scope)) {
                    if (listenerBoxes[_local_2].once && (!once)) {
                        throw new Error("You cannot addOnce() then try to add() the same listener without removing the relationship first.");
                    } else if (once && (!listenerBoxes[_local_2].once)) {
                        throw new Error("You cannot add() then addOnce() the same listener without removing the relationship first.");
                    }
                    return(undefined);
                }
                _local_2++;
            }
            if (listenersNeedCloning) {
                listenerBoxes = listenerBoxes.slice();
            }
            listenerBoxes.push({listener:listener, scope:scope, once:once});
        }
        var listenersNeedCloning = false;
    }
