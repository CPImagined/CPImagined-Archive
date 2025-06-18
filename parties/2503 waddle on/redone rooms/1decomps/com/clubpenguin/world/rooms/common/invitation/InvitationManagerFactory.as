    class com.clubpenguin.world.rooms.common.invitation.InvitationManagerFactory
    {
        static var _clazz;
        function InvitationManagerFactory () {
        }
        static function register(managerClass) {
            var _local_4 = managerClass.split(".");
            var _local_3 = _global;
            var _local_2 = 0;
            while (_local_2 < _local_4.length) {
                _local_3 = _local_3[_local_4[_local_2]];
                _local_2++;
            }
            if (_local_3 instanceof Function) {
                _clazz = Function(_local_3);
            } else {
                (_clazz);// not popped
            }
            return(Boolean(_clazz));
        }
        static function create() {
            var _local_1 = new com.clubpenguin.world.rooms.common.invitation.InvitationManagerFactory._clazz();
            return(_local_1);
        }
    }
