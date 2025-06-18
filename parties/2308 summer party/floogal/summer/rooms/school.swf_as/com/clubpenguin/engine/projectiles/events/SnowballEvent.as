dynamic class com.clubpenguin.engine.projectiles.events.SnowballEvent
{
    static var SNOWBALL_HIT: String = "snowballHit";
    static var SNOWBALL_MISS: String = "snowballMiss";
    static var SNOWBALL_BOUNCE: String = "snowballBounce";
    var hit_player_id;
    var id;
    var player_id;
    var snowballMC;
    var snowballType;
    var type;

    function SnowballEvent(_type, _id, _snowballMC, _player_id, _snowballType, _hit_player_id)
    {
        this.type = _type;
        this.id = _id;
        this.snowballMC = _snowballMC;
        this.player_id = _player_id;
        this.snowballType = _snowballType;
        this.hit_player_id = _hit_player_id;
    }

    function get x()
    {
        return this.snowballMC._x;
    }

    function get y()
    {
        return this.snowballMC._y;
    }

    function clone()
    {
        return new com.clubpenguin.engine.projectiles.events.SnowballEvent(this.type, this.id, this.snowballMC, this.player_id, this.snowballType, this.hit_player_id);
    }

    function toString()
    {
        return "[" + this.type + " | " + this.id + " | " + this.snowballMC + " | " + this.player_id + " | " + this.snowballType + " | " + this.hit_player_id + " ]";
    }

}
