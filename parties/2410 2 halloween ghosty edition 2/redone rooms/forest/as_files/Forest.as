//Created by Action Script Viewer - https://www.buraks.com/asv
    class as_files.Forest extends as_files.ScavengerHuntRoom
    {
        var _stage, _destroyDelegate, _SHELL, setupNavigationButtons, _INTERFACE;
        function Forest (stageReference) {
            super(stageReference);
            _stage.start_x = 155;
            _stage.start_y = 340;
        }
        function init() {
            _destroyDelegate = com.clubpenguin.util.Delegate.create(this, destroy);
            _SHELL.addListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.shack_btn, 660, 160)]);
            _stage.shack_btn.useHandCursor = false;
            _stage.triggers_mc.plaza_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "plaza", 655, 380);
            _stage.triggers_mc.cove_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "cove", 180, 160);
            _stage.triggers_mc.shack_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "party10", 88, 354);
			_stage.triggers_mc.party11_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "party11", 575, 400);
        }
        function showContent(contentID) {
            _INTERFACE.showContent(contentID);
        }
        function exit(name, x, y) {
            _SHELL.sendJoinRoom(name, x, y);
        }
        function destroy() {
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
        }
        static var CLASS_NAME = "Forest";
        var robotVisible = false;
        var robotDefeated = false;
        var playerHasScareItem = false;
        static var QUEST_TASK_ID = 2;
    }
