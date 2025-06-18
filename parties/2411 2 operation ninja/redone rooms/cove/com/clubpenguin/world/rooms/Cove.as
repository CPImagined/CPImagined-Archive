//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms.Cove extends com.clubpenguin.world.rooms.BaseRoom
    {
        var _stage, localize, setupNavigationButtons, showContent, setupHint, _SHELL, _ENGINE, _destroyDelegate;
        function Cove (stageReference) {
            super(stageReference);
            _stage = stageReference;
            _stage.start_x = 420;
            _stage.start_y = 240;
            localize([_stage.foreground_mc.foreground.surfsign_states]);
            setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.chair_mc, 337, 141), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.hut_mc.waves_btn, 630, 250)]);
            _stage.background_mc.chair_mc.useHandCursor = false;
            showContent([new com.clubpenguin.world.rooms.common.PopupContentVO(_stage.chair_front_mc.binoculars_btn, true, "binoculars", ""), new com.clubpenguin.world.rooms.common.PopupContentVO(_stage.interface_mc.cove_cat_btn, true, "cove_catalogue", ""), new com.clubpenguin.world.rooms.common.PopupContentVO(_stage.cove_cat_obj_mc.cove_cat_obj_btn, true, "cove_catalogue", "")]);
            setupHint([new com.clubpenguin.world.rooms.common.HintVO(_stage.hut_mc.waves_btn, _stage.hut_mc.waves_btn, "waves_hint")]);
            _stage.triggers_mc.forest_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exitForest);
            _stage.triggers_mc.waves_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exitWaves);
        }
        function exitForest() {
            _SHELL.sendJoinRoom("forest", 595, 375);
        }
        function exitWaves() {
            _ENGINE.sendJoinGame("waves", true);
        }
        function init() {
            _destroyDelegate = com.clubpenguin.util.Delegate.create(this, destroy);
            _SHELL.addListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
        }
        function destroy() {
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            for (var _local_2 in this) {
                var _local_2 = null;
            }
        }
        static var CLASS_NAME = "Cove";
    }
