//Created by Action Script Viewer - https://www.buraks.com/asv
    class as_files.Mall extends com.clubpenguin.world.rooms.BaseRoom
    {
        var _stage, _SHELL, _INTERFACE, _destroyDelegate, localize, wem;
        function Mall (stageReference) {
            super(stageReference);
            _stage.start_x = 170;
            _stage.start_y = 360;
        }
        function exit(name, x, y) {
            _SHELL.sendJoinRoom(name, x, y);
        }
        function init() {
            _destroyDelegate = com.clubpenguin.util.Delegate.create(this, destroy);
            _SHELL.addListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            localize([_stage.sign_mc.text_mc, _stage.background_mc.elecBox2_mc.text_mc, _stage.background_mc.elecBox1_mc.text_mc, _stage.interface_mc.costume_btn_states]);
            _stage.triggers_mc.plaza_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "plaza", 415, 280);
            _stage.interface_mc.costume_btn.onRelease = com.clubpenguin.util.Delegate.create(this, costumeCatalogue);
			_stage.interface_mc.berry_btn.onRelease = com.clubpenguin.util.Delegate.create(this, mallCatalogue);
        }
        function costumeCatalogue() {
            _INTERFACE.showContent("costume_catalogue");
        }
		function mallCatalogue() {
            _INTERFACE.showContent("mall_catalogue");
        }
        function destroy() {
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            wem.destroy();
        }
        static var CLASS_NAME = "Mall";
    }
