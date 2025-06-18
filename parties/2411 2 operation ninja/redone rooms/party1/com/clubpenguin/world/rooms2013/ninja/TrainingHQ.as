    class com.clubpenguin.world.rooms2013.ninja.TrainingHQ extends com.clubpenguin.world.rooms.BaseRoom
    {
        var _stage, _INTERFACE, _SHELL, _destroyDelegate, _triggerWatcher;
        function TrainingHQ (stageReference) {
            super(stageReference);
            _stage = stageReference;
            _stage.start_x = 360;
            _stage.start_y = 150;
            _stage.triggers_mc.forest_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "forest", 330, 185);
            _stage.triggers_mc.mtn_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "mtn", 440, 244);
            _stage.triggers_mc.dock_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "dock", 395, 170);
            _stage.interface_mc.party_cat_btn.onRelease = com.clubpenguin.util.Delegate.create(_INTERFACE, _INTERFACE.showContent, "party_catalogue");
        }
        function exit(name, x, y) {
            _SHELL.sendJoinRoom(name, x, y);
        }
        function init() {
            _destroyDelegate = com.clubpenguin.util.Delegate.create(this, destroy);
            _SHELL.addListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
        }
        function update() {
            _triggerWatcher.checkAllPlayers();
        }
        function destroy() {
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
        }
        static var CLASS_NAME = "TrainingHQ";
    }
