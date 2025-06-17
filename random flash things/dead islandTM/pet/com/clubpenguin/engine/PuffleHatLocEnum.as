//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.engine.PuffleHatLocEnum extends com.clubpenguin.util.Enumeration
    {
        var _name;
        function PuffleHatLocEnum (_arg_3) {
            super();
            _name = _arg_3;
        }
        function get name() {
            return(_name);
        }
        function toString() {
            return(("[PuffleHatLocEnum name=\"" + _name) + "\"]");
        }
        static var NULL_HAT_LOC = new com.clubpenguin.engine.PuffleHatLocEnum("none");
        static var WORLD_HAT_LOC = new com.clubpenguin.engine.PuffleHatLocEnum("world");
        static var IGLOO_HAT_LOC = new com.clubpenguin.engine.PuffleHatLocEnum("igloo");
        static var PLAYER_CARD_HAT_LOC = new com.clubpenguin.engine.PuffleHatLocEnum("player_card");
    }
