package org.osflash.signals{
    import flash.utils.Dictionary;
    import flash.errors.IllegalOperationError;

    public class Signal implements ISignal, IDispatcher {

        protected var listenersNeedCloning:Boolean = false;
        protected var onceListeners:Dictionary;
        protected var _valueClasses:Array;
        protected var listeners:Array;

        public function Signal(... _args){
            listeners = [];
            onceListeners = new Dictionary();
            if (((_args.length == 1) && (_args[0] is Array))){
                _args = _args[0];
            };
            setValueClasses(_args);
        }

        public function add(_arg_1:Function):Function{
            registerListener(_arg_1);
            return (_arg_1);
        }

        public function addOnce(_arg_1:Function):Function{
            registerListener(_arg_1, true);
            return (_arg_1);
        }

        public function remove(_arg_1:Function):Function{
            var _local_2:int = int(listeners.indexOf(_arg_1));
            if (_local_2 == -1){
                return (_arg_1);
            };
            if (listenersNeedCloning){
                listeners = listeners.slice();
                listenersNeedCloning = false;
            };
            listeners.splice(_local_2, 1);
            delete onceListeners[_arg_1];
            return (_arg_1);
        }

        protected function registerListener(_arg_1:Function, _arg_2:Boolean=false):void{
            var _local_3:String;
            if (_arg_1.length < _valueClasses.length){
                _local_3 = ((_arg_1.length == 1) ? "argument" : "arguments");
                throw (new ArgumentError((((((("Listener has " + _arg_1.length) + " ") + _local_3) + " but it needs at least ") + _valueClasses.length) + " to match the given value classes.")));
            };
            if (!listeners.length){
                listeners[0] = _arg_1;
                if (_arg_2){
                    onceListeners[_arg_1] = true;
                };
                return;
            };
            if (listeners.indexOf(_arg_1) >= 0){
                if (((Boolean(onceListeners[_arg_1])) && (!(_arg_2)))){
                    throw (new IllegalOperationError("You cannot addOnce() then add() the same listener without removing the relationship first."));
                };
                if (((!(onceListeners[_arg_1])) && (Boolean(_arg_2)))){
                    throw (new IllegalOperationError("You cannot add() then addOnce() the same listener without removing the relationship first."));
                };
                return;
            };
            if (listenersNeedCloning){
                listeners = listeners.slice();
                listenersNeedCloning = false;
            };
            listeners[listeners.length] = _arg_1;
            if (_arg_2){
                onceListeners[_arg_1] = true;
            };
        }

        protected function setValueClasses(_arg_1:Array):void{
            _valueClasses = ((_arg_1) || ([]));
            var _local_2:int = int(_valueClasses.length);
            while (_local_2--) {
                if (!(_valueClasses[_local_2] is Class)){
                    throw (new ArgumentError((((("Invalid valueClasses argument: item at index " + _local_2) + " should be a Class but was:<") + _valueClasses[_local_2]) + ">.")));
                };
            };
        }

        public function get numListeners():uint{
            return (listeners.length);
        }

        public function dispatch(... _args):void{
            var _local_2:Object;
            var _local_3:Class;
            var _local_6:Function;
            var _local_4:int = int(_valueClasses.length);
            if (_args.length < _local_4){
                throw (new ArgumentError((((("Incorrect number of arguments. Expected at least " + _local_4) + " but received ") + _args.length) + ".")));
            };
            var _local_5:int;
            while (_local_5 < _local_4) {
                if (!(((_local_2 = _args[_local_5]) === null) || (_local_2 is (_local_3 = _valueClasses[_local_5])))){
                    throw (new ArgumentError((((("Value object <" + _local_2) + "> is not an instance of <") + _local_3) + ">.")));
                };
                _local_5++;
            };
            if (!listeners.length){
                return;
            };
            listenersNeedCloning = true;
            switch (_args.length){
                case 0:
                    for each (_local_6 in listeners) {
                        if (onceListeners[_local_6]){
                            remove(_local_6);
                        };
                        (_local_6());
                    };
                    break;
                case 1:
                    for each (_local_6 in listeners) {
                        if (onceListeners[_local_6]){
                            remove(_local_6);
                        };
                        (_local_6(_args[0]));
                    };
                    break;
                default:
                    for each (_local_6 in listeners) {
                        if (onceListeners[_local_6]){
                            remove(_local_6);
                        };
                        _local_6.apply(null, _args);
                    };
            };
            listenersNeedCloning = false;
        }

        public function get valueClasses():Array{
            return (_valueClasses);
        }

        public function removeAll():void{
            var _local_1:uint = uint(listeners.length);
            while (_local_1--) {
                remove((listeners[_local_1] as Function));
            };
        }


    }
}//package org.osflash.signals
