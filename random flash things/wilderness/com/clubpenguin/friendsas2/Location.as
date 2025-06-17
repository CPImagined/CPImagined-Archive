class com.clubpenguin.friendsas2.Location
{
    var land, room, world;
    function Location(land, room, world)
    {
        this.land = land;
        this.room = room;
        this.world = world;
    } // End of the function
    static function fromRaw(rawLocation)
    {
        return (new com.clubpenguin.friendsas2.Location(rawLocation.land, rawLocation.room, rawLocation.world));
    } // End of the function
    function toString()
    {
        return ("Location:{land:" + land + ", room:" + room + ", world:" + world + "}");
    } // End of the function
} // End of Class
