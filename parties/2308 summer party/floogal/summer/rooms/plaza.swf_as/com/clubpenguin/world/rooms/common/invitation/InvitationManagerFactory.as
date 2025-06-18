dynamic class com.clubpenguin.world.rooms.common.invitation.InvitationManagerFactory
{

    function InvitationManagerFactory()
    {
    }

    static function register(managerClass)
    {
        var __reg4 = managerClass.split(".");
        var __reg3 = _global;
        var __reg2 = 0;
        while (__reg2 < __reg4.length) 
        {
            __reg3 = __reg3[__reg4[__reg2]];
            ++__reg2;
        }
        if (__reg3 instanceof Function) 
        {
            com.clubpenguin.world.rooms.common.invitation.InvitationManagerFactory._clazz = Function(__reg3);
        }
        return Boolean(com.clubpenguin.world.rooms.common.invitation.InvitationManagerFactory._clazz);
    }

    static function create()
    {
        var __reg1 = new com.clubpenguin.world.rooms.common.invitation.InvitationManagerFactory._clazz();
        return __reg1;
    }

}
