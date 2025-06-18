//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms.Cove extends com.clubpenguin.world.rooms.BaseRoom
    {
        var _stage, localize, setupNavigationButtons, showContent, setupHint, setupEnvironmentTriggers, _SHELL, _ENGINE, _destroyDelegate, _abductionDelegate, aliendAbduction;
        function Cove (stageReference) {
            super(stageReference);
            _stage = stageReference;
            _stage.start_x = 420;
            _stage.start_y = 240;
            localize([_stage.SurfShack_mc.SurfShackRoof_mc.SurfShackSign_mc]);
            setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.chair_mc, 337, 141), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.waves_mc.waves_btn, 615, 350)]);
            _stage.background_mc.chair_mc.useHandCursor = false;
            showContent([new com.clubpenguin.world.rooms.common.PopupContentVO(_stage.chair_front_mc.binoculars_btn, true, "binoculars", ""), new com.clubpenguin.world.rooms.common.PopupContentVO(_stage.interface_mc.cove_cat_btn, true, "cove_catalogue", ""), new com.clubpenguin.world.rooms.common.PopupContentVO(_stage.cove_cat_obj_mc.cove_cat_obj_btn, true, "cove_catalogue", "")]);
            setupHint([new com.clubpenguin.world.rooms.common.HintVO(_stage.waves_mc.waves_btn, _stage.waves_mc.waves_btn, "waves_hint")]);
            _stage.triggers_mc.forest_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exitForest);
            _stage.triggers_mc.waves_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exitWaves);
            _stage.ocean_water_mc.environmentType = com.clubpenguin.world.rooms.common.behaviors.RoomBehaviorEnum.EL_WATER_BEHAVIOR;
            _stage.ocean_water_mc._visible = false;
            setupEnvironmentTriggers();
        }
        function exitForest() {
            if (_SHELL.isNewPlayerExperienceRunning == false) {
                _SHELL.sendJoinRoom("forest", 595, 375);
            }
        }
        function exitWaves() {
            if (_SHELL.isNewPlayerExperienceRunning == false) {
                _ENGINE.sendJoinGame("waves", true);
            }
        }
        function init() {
            _destroyDelegate = com.clubpenguin.util.Delegate.create(this, destroy);
            _SHELL.addListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            _abductionDelegate = com.clubpenguin.util.Delegate.create(this, abductPenguin);
            _global.getCurrentAirtower().addListener("beamup", _abductionDelegate);
        }
        function abductPenguin(data) {
            var _local_4 = data[1];
            var _local_3 = _global.getCurrentEngine().getPlayerMovieClip(_local_4);
            _stage.attachMovie("TractorBeam", "tractorBeam_mc", _stage.getNextHighestDepth());
            _stage.tractorBeam_mc.swapDepths(_local_3);
            _stage.tractorBeam_mc._x = _local_3._x;
            _stage.tractorBeam_mc._y = _local_3._y - 1;
            aliendAbduction = new com.clubpenguin.world.rooms.aliens.AlienAbduction();
            aliendAbduction.abductPlayer(_local_4, _stage, this);
        }
        function abductedPlayerGoToUFO(player_id) {
            _stage.tractorBeam_mc.removeMovieClip();
            if (_SHELL.isMyPlayer(player_id)) {
                _global.getCurrentAirtower().removeListener("beamup", _abductionDelegate);
                _abductionDelegate = null;
                _SHELL.sendJoinRoom("ufo", 380, 320);
            }
        }
        function destroy() {
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            _global.getCurrentAirtower().removeListener("beamup", _abductionDelegate);
            _abductionDelegate = null;
        }
        static var CLASS_NAME = "Cove";
    }
