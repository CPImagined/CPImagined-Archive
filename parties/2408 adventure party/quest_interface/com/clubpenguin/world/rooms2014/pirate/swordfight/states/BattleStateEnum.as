//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2014.pirate.swordfight.states.BattleStateEnum
    {
        var _id, _name;
        function BattleStateEnum (name) {
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
            return(((("BattleStateEnum{ id=" + id) + ", name=") + name) + "}");
        }
        static var NEXT_ID = 0;
        static var ENDING = new com.clubpenguin.world.rooms2014.pirate.swordfight.states.BattleStateEnum("ending");
        static var STARTED = new com.clubpenguin.world.rooms2014.pirate.swordfight.states.BattleStateEnum("started");
        static var OPEN = new com.clubpenguin.world.rooms2014.pirate.swordfight.states.BattleStateEnum("open");
        static var REMOVED = new com.clubpenguin.world.rooms2014.pirate.swordfight.states.BattleStateEnum("removed");
    }
