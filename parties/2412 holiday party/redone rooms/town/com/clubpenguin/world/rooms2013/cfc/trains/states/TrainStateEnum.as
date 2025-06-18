//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2013.cfc.trains.states.TrainStateEnum
    {
        var _id, _name;
        function TrainStateEnum (name) {
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
            return(((("TrainStateEnum{ id=" + id) + ", name=") + name) + "}");
        }
        static var NEXT_ID = 0;
        static var DRIVING = new com.clubpenguin.world.rooms2013.cfc.trains.states.TrainStateEnum("driving");
        static var BOARDING = new com.clubpenguin.world.rooms2013.cfc.trains.states.TrainStateEnum("boarding");
    }
