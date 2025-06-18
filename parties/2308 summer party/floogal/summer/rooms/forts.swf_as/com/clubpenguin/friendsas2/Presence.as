dynamic class com.clubpenguin.friendsas2.Presence
{
    static var DEFAULT_STATUS: String = "online";
    var id;
    var location;
    var status;

    function Presence(status, id, location)
    {
        this.status = status;
        this.id = id;
        this.location = location;
    }

    static function fromRaw(rawPresence)
    {
        var __reg1 = null;
        if (rawPresence.location) 
        {
            __reg1 = com.clubpenguin.friendsas2.Location.fromRaw(rawPresence.location);
        }
        return new com.clubpenguin.friendsas2.Presence(rawPresence.status, rawPresence.id, __reg1);
    }

    function toString()
    {
        var __reg2 = "Location:null";
        if (this.location) 
        {
            __reg2 = this.location.toString();
        }
        return "Presence{status:" + this.status + ", ID:" + this.id + ", location:" + __reg2 + "}";
    }

}
