//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.engine.projectiles.events.SnowballEvent
    {
        var type, id, snowballMC, player_id, snowballType, hit_player_id;
        function SnowballEvent (_type, _id, _snowballMC, _player_id, _snowballType, _hit_player_id) {
            type = _type;
            id = _id;
            snowballMC = _snowballMC;
            player_id = _player_id;
            snowballType = _snowballType;
            hit_player_id = _hit_player_id;
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
