//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms.common.invitation.InvitationManagerFactory
    {
        static var _clazz;
        function InvitationManagerFactory () {
        }
        static function register(managerClass) {
            var parts = managerClass.split(".");
            var clzz = _global;
            var i = 0;
            while (i < parts.length) {
                clzz = clzz[parts[i]];
                i++;
            }
            if (clzz instanceof Function) {
                _clazz = Function(clzz);
            } else {
                (_clazz);// not popped
            }
            return(Boolean(_clazz));
        }
        static function create() {
            var obj = (new com.clubpenguin.world.rooms.common.invitation.InvitationManagerFactory._clazz());
            return(obj);
        }
    }
