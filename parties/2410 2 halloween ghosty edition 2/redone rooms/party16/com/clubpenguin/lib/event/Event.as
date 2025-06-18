//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.lib.event.Event extends Object
    {
        var __eventDispatcher, __eventType, __eventData;
        function Event (_source, _type, _data) {
            super();
            __eventDispatcher = _source;
            __eventType = _type;
            __eventData = _data;
        }
        function get target() {
            return(__eventDispatcher);
        }
        function set target(_val) {
            __eventDispatcher = _val;
            //return(target);
        }
        function get data() {
            return(__eventData);
        }
        function set data(_val) {
            __eventData = _val;
            //return(data);
        }
        function get type() {
            return(__eventType);
        }
        function set type(_val) {
            __eventType = _val;
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
