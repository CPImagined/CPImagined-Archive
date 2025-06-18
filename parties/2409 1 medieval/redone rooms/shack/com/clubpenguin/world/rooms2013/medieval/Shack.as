//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2013.medieval.Shack extends com.clubpenguin.world.rooms.BaseRoom
    {
        var _stage, _SHELL, _destroyDelegate, setupNavigationButtons;
        function Shack (stageReference) {
            super(stageReference);
            _stage.start_x = 555;
            _stage.start_y = 280;
            if (!_SHELL) {
                init();
            }
        }
        function init() {
            _destroyDelegate = com.clubpenguin.util.Delegate.create(this, destroy);
            _SHELL.addListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            configureNavigation();
            configureTriggers();
            configureRoomElements();
            _stage.interface_mc.catalogue_Btn.onRelease = com.clubpenguin.util.Delegate.create(com.clubpenguin.world.rooms2013.medieval.MedievalParty.instance, com.clubpenguin.world.rooms2013.medieval.MedievalParty.instance.showPartyCatalogue);
        }
        function configureTriggers() {
            _stage.triggers_mc.dojo_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "dojoext", 390, 375);
            _stage.triggers_mc.school_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "school", 600, 365);
            _stage.triggers_mc.forest_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "forest", 120, 195);
            _stage.triggers_mc.mine_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "mine", 400, 360);
        }
        function configureNavigation() {
            setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.door_mc.school_btn, 335, 265), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.shack_mc.mine_btn, 490, 222)]);
        }
        function configureRoomElements() {
            _stage.block_mc._visible = false;
            _stage.triggers_mc._visible = false;
        }
        function exit(roomName, x, y) {
            _SHELL.sendJoinRoom(roomName, x, y);
        }
        function destroy() {
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
        }
        static var CLASS_NAME = "Shack";
    }
