//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2013.ninja.Forest extends com.clubpenguin.world.rooms.BaseRoom
    {
        var _stage, _SHELL, setupNavigationButtons, _destroyDelegate, _INTERFACE;
        function Forest (stageReference) {
            super(stageReference);
            _stage.start_x = 380;
            _stage.start_y = 215;
            if (!_SHELL) {
                init();
            }
            _stage.triggers_mc.plaza_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exitPlaza);
            _stage.triggers_mc.cove_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exitCove);
            _stage.triggers_mc.shack_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exitShack);
            _stage.triggers_mc.what_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exitLake);
            _stage.triggers_mc.party1_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exitParty1);
            setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.exit_btn, 285, 160)]);
        }
        function exitPlaza() {
            _SHELL.sendJoinRoom("plaza", 620, 330);
        }
        function exitCove() {
            _SHELL.sendJoinRoom("cove", 300, 210);
        }
        function exitShack() {
            _SHELL.sendJoinRoom("shack", 250, 400);
        }
        function exitLake() {
            _SHELL.sendJoinRoom("lake", 220, 160);
        }
        function exitParty1() {
            _SHELL.sendJoinRoom("party1", 655, 355);
        }
        function init() {
            _destroyDelegate = com.clubpenguin.util.Delegate.create(this, destroy);
            _SHELL.addListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            _stage.interface_mc.party_cat_btn.onRelease = com.clubpenguin.util.Delegate.create(_INTERFACE, _INTERFACE.showContent, "party_catalogue");
        }
        function destroy() {
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            for (var _local_2 in this) {
                this[_local_2] = null;
            }
        }
        static var CLASS_NAME = "Forest";
    }
