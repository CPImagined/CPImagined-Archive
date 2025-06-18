dynamic class com.clubpenguin.friendsas2.Location
{
    var land;
    var room;
    var world;

    function Location(land, room, world)
    {
        this.land = land;
        this.room = room;
        this.world = world;
    }

    static function fromRaw(rawLocation)
    {
        return new com.clubpenguin.friendsas2.Location(rawLocation.land, rawLocation.room, rawLocation.world);
    }

    function toString()
    {
        return "Location:{land:" + this.land + ", room:" + this.room + ", world:" + this.world + "}";
    }

}
