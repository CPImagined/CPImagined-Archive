class com.clubpenguin.world.rooms.common.invitation.InvitationManagerFactory
{
    static var _clazz;
    function InvitationManagerFactory()
    {
    } // End of the function
    static function register(managerClass)
    {
        var _loc4 = managerClass.split(".");
        var _loc3 = _global;
        for (var _loc2 = 0; _loc2 < _loc4.length; ++_loc2)
        {
            _loc3 = _loc3[_loc4[_loc2]];
        } // end of for
        if (_loc3 instanceof Function)
        {
            _clazz = Function(_loc3);
        }
        else
        {
        } // end else if
        return (Boolean(com.clubpenguin.world.rooms.common.invitation.InvitationManagerFactory._clazz));
    } // End of the function
    static function create()
    {
        var _loc1 = new com.clubpenguin.world.rooms.common.invitation.InvitationManagerFactory._clazz();
        return (_loc1);
    } // End of the function
} // End of Class
