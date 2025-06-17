//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.lib.event.Event extends Object
    {
        var __eventDispatcher, __eventType, __eventData;
        function Event (_arg_4, _arg_3, _arg_5) {
            super();
            __eventDispatcher = _arg_4;
            __eventType = _arg_3;
            __eventData = _arg_5;
        }
        function get target() {
            return(__eventDispatcher);
        }
        function set target(_arg_2) {
            __eventDispatcher = _arg_2;
            //return(target);
        }
        function get data() {
            return(__eventData);
        }
        function set data(_arg_2) {
            __eventData = _arg_2;
            //return(data);
        }
        function get type() {
            return(__eventType);
        }
        function set type(_arg_2) {
            __eventType = _arg_2;
            //return(type);
        }
        function clone() {
            var _local_2;
            _local_2 = createEvent();
            return(_local_2);
        }
        function createEvent() {
            return(new com.clubpenguin.lib.event.Event(__eventDispatcher, __eventType, __eventData));
        }
        function toString() {
            var _local_1;
            _local_1 = "Event";
            return(_local_1);
        }
    }
