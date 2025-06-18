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
            var i = listenerBoxes.length;
            while (i--) {
                if ((listenerBoxes[i].listener == listener) && (listenerBoxes[i].scope == scope)) {
                    listenerBoxes.splice(i, 1);
                    return(undefined);
                }
            }
        }
        function removeAll() {
            var i = listenerBoxes.length;
            while (i--) {
                remove(listenerBoxes[i].listener, listenerBoxes[i].scope);
            }
        }
        function dispatch() {
            var valueObject;
            var n = 0;
            while (n < _valueClasses.length) {
                if (primitiveMatchesValueClass(arguments[n], _valueClasses[n])) {
                } else if ((((valueObject = arguments[n])) == null) || (valueObject instanceof _valueClasses[n])) {
                } else {
                    throw new Error(((("Value object <" + valueObject) + "> is not an instance of <") + _valueClasses[n]) + ">.");
                }
                n++;
            }
            var listenerBoxes = listenerBoxes;
            var len = listenerBoxes.length;
            var listenerBox;
            var scope;
            listenersNeedCloning = true;
            var i = 0;
            while (i < len) {
                listenerBox = listenerBoxes[i];
                if (listenerBox.once) {
                    remove(listenerBox.listener, listenerBox.scope);
                }
                listenerBox.listener.apply(listenerBox.scope, arguments);
                i++;
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
            var i = _valueClasses.length;
            while (i--) {
                if (!(_valueClasses[i] instanceof Function)) {
                    throw new Error(((("Invalid valueClasses argument: item at index " + i) + " should be a Class but was:<") + _valueClasses[i]) + ">.");
                }
            }
        }
        function registerListener(listener, scope, once) {
            var i = 0;
            while (i < listenerBoxes.length) {
                if ((listenerBoxes[i].listener == listener) && (listenerBoxes[i].scope == scope)) {
                    if (listenerBoxes[i].once && (!once)) {
                        throw new Error("You cannot addOnce() then try to add() the same listener without removing the relationship first.");
                    } else if (once && (!listenerBoxes[i].once)) {
                        throw new Error("You cannot add() then addOnce() the same listener without removing the relationship first.");
                    }
                    return(undefined);
                }
                i++;
            }
            if (listenersNeedCloning) {
                listenerBoxes = listenerBoxes.slice();
            }
            listenerBoxes.push({listener:listener, scope:scope, once:once});
        }
        var listenersNeedCloning = false;
    }
