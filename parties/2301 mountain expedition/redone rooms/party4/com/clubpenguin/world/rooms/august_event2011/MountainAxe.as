//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms.august_event2011.MountainAxe extends com.clubpenguin.world.rooms.BaseRoom
    {
        var _stage, localize, setupNavigationButtons, showContent, _SHELL, _INTERFACE, _destroyDelegate;
        function MountainAxe (stageReference) {
            super(stageReference);
            _stage = stageReference;
            _stage.start_x = 330;
            _stage.start_y = 375;
            localize([_stage.background_mc.epfOnlySignStates.epfOnlySignNoOver, _stage.background_mc.epfOnlySignStates.epfOnlySign]);
            setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.epfOnlySignStates.epfOnlySign.herbFight_btn, 720, 425)]);
            showContent([new com.clubpenguin.world.rooms.common.PopupContentVO(_stage.background_mc.epfOnlySignStates.epfOnlySignNoOver, true, "party_note01", "")]);
            _stage.triggers_mc.topmountain_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exitForward);
            _stage.triggers_mc.camp_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exitBack);
            if (!_SHELL) {
                init();
            }
        }
        function exitForward() {
            _SHELL.sendJoinRoom("party5", 400, 325);
        }
        function exitBack() {
            _SHELL.sendJoinRoom("party3", 175, 190);
        }
        function exitCave() {
            _SHELL.sendJoinRoom("party6", 90, 430);
        }
        function init() {
            if (_SHELL.isEPFAgent()) {
                _stage.triggers_mc.cave_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exitCave);
                _stage.background_mc.epfOnlySignStates.gotoAndStop("agent");
				if (!_SHELL.isItemInMyInventory(14574)) {
					_INTERFACE.showContent("epfFirst");
				}
            }
            _destroyDelegate = com.clubpenguin.util.Delegate.create(this, destroy);
            _SHELL.addListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
        }
        function destroy() {
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            for (var _local_2 in this) {
                var _local_2 = null;
            }
        }
        var CLASS_NAME = "MountainAxe";
    }
