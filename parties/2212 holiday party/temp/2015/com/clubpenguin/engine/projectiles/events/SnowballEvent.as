class com.clubpenguin.engine.projectiles.events.SnowballEvent
{
   static var SNOWBALL_HIT = "snowballHit";
   static var SNOWBALL_MISS = "snowballMiss";
   static var SNOWBALL_BOUNCE = "snowballBounce";
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
      return new com.clubpenguin.engine.projectiles.events.SnowballEvent(this.type,this.id,this.snowballMC,this.player_id,this.snowballType,this.hit_player_id);
   }
   function toString()
   {
      return "[" + this.type + " | " + this.id + " | " + this.snowballMC + " | " + this.player_id + " | " + this.snowballType + " | " + this.hit_player_id + " ]";
   }
}
