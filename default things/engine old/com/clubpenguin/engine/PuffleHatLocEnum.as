class com.clubpenguin.engine.PuffleHatLocEnum extends com.clubpenguin.util.Enumeration
{
    var _name, __get__name;
    function PuffleHatLocEnum(name)
    {
        super();
        _name = name;
    } // End of the function
    function get name()
    {
        return (_name);
    } // End of the function
    function toString()
    {
        return ("[PuffleHatLocEnum name=\"" + _name + "\"]");
    } // End of the function
    static var NULL_HAT_LOC = new com.clubpenguin.engine.PuffleHatLocEnum("none");
    static var WORLD_HAT_LOC = new com.clubpenguin.engine.PuffleHatLocEnum("world");
    static var IGLOO_HAT_LOC = new com.clubpenguin.engine.PuffleHatLocEnum("igloo");
    static var PLAYER_CARD_HAT_LOC = new com.clubpenguin.engine.PuffleHatLocEnum("player_card");
} // End of Class
