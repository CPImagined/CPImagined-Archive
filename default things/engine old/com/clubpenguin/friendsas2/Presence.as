class com.clubpenguin.friendsas2.Presence
{
    var status, id, location;
    function Presence(status, id, location)
    {
        this.status = status;
        this.id = id;
        this.location = location;
    } // End of the function
    static function fromRaw(rawPresence)
    {
        var _loc1 = null;
        if (rawPresence.location)
        {
            _loc1 = com.clubpenguin.friendsas2.Location.fromRaw(rawPresence.location);
        } // end if
        return (new com.clubpenguin.friendsas2.Presence(rawPresence.status, rawPresence.id, _loc1));
    } // End of the function
    function toString()
    {
        var _loc2 = "Location:null";
        if (location)
        {
            _loc2 = location.toString();
        } // end if
        return ("Presence{status:" + status + ", ID:" + id + ", location:" + _loc2 + "}");
    } // End of the function
    static var DEFAULT_STATUS = "online";
} // End of Class
