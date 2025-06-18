//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2014.muppets.performance.states.PerformanceStateEnum
    {
        var _id, _name;
        function PerformanceStateEnum (name) {
            _id = NEXT_ID++;
            _name = name;
        }
        function get id() {
            return(_id);
        }
        function get name() {
            return(_name);
        }
        function toString() {
            return(((("PerformanceStateEnum{ id=" + id) + ", name=") + name) + "}");
        }
        static var NEXT_ID = 0;
        static var PERFORMING = new com.clubpenguin.world.rooms2014.muppets.performance.states.PerformanceStateEnum("performing");
        static var BOARDING = new com.clubpenguin.world.rooms2014.muppets.performance.states.PerformanceStateEnum("boarding");
    }
