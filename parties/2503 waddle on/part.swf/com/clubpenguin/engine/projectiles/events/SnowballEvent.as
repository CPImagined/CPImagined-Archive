
//Created by Action Script Viewer - http://www.buraks.com/asv
    class com.clubpenguin.engine.projectiles.events.SnowballEvent
    {
        var type, id, snowballMC, player_id, snowballType, hit_player_id;
        function SnowballEvent (_arg_4, _arg_5, _arg_7, _arg_6, _arg_2, _arg_3) {
            type = _arg_4;
            id = _arg_5;
            snowballMC = _arg_7;
            player_id = _arg_6;
            snowballType = _arg_2;
            hit_player_id = _arg_3;
        }
        function get x() {
            return(snowballMC._x);
        }
        function get y() {
            return(snowballMC._y);
        }
        function clone() {
            return(new com.clubpenguin.engine.projectiles.events.SnowballEvent(type, id, snowballMC, player_id, snowballType, hit_player_id));
        }
        function toString() {
            return(((((((((((("[" + type) + " | ") + id) + " | ") + snowballMC) + " | ") + player_id) + " | ") + snowballType) + " | ") + hit_player_id) + " ]");
        }
        static var SNOWBALL_HIT = "snowballHit";
        static var SNOWBALL_MISS = "snowballMiss";
        static var SNOWBALL_BOUNCE = "snowballBounce";
    }
