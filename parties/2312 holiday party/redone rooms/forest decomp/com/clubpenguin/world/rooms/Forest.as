//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms.Forest extends com.clubpenguin.world.rooms.BaseRoom
    {
        var _stage, _SHELL, _destroyDelegate;
        function Forest (stageReference) {
            super(stageReference);
            _stage = stageReference;
            _stage.start_x = 380;
            _stage.start_y = 215;
            _stage.triggers_mc.plaza_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exitPlaza);
            _stage.triggers_mc.cove_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exitCove);
            _stage.triggers_mc.shack_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exitShack);
            _stage.triggers_mc.what_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exitLake);
        }
        function exitPlaza() {
            _SHELL.sendJoinRoom("plaza", 620, 330);
        }
        function exitCove() {
            _SHELL.sendJoinRoom("cove", 260, 208);
        }
        function exitShack() {
            _SHELL.sendJoinRoom("shack", 250, 400);
        }
        function exitLake() {
            _SHELL.sendJoinRoom("lake", 220, 160);
        }
        function init() {
            _destroyDelegate = com.clubpenguin.util.Delegate.create(this, destroy);
            _SHELL.addListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
        }
        function destroy() {
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            for (var _local_2 in this) {
                this[_local_2] = null;
            }
        }
        static var CLASS_NAME = "Forest";
    }
