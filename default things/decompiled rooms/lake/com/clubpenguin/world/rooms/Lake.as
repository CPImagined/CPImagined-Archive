//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms.Lake extends com.clubpenguin.world.rooms.BaseRoom
    {
        var _stage, setupNavigationButtons, _destroyDelegate, _SHELL, setupEnvironmentTriggers, _INTERFACE;
        function Lake (stageReference) {
            super(stageReference);
            _stage.start_x = 157;
            _stage.start_y = 290;
            setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.squiddoor_mc.pizza_btn, 700, 315), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.chest_mc.chest_btn, 480, 225)]);
			setupHint([new com.clubpenguin.world.rooms.common.HintVO(_stage.chest_mc.chest_btn, _stage.chest_mc.diving_hint, "diving_hint")]);
            _stage.triggers_mc.cavedig_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exitCaveMine);
            _stage.triggers_mc.door_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exitUnderWater);
            _stage.triggers_mc.forest_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exitForest);
			_stage.triggers_mc.diving_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, playDiving);
        }
        function init() {
            _destroyDelegate = com.clubpenguin.util.Delegate.create(this, destroy);
            _SHELL.addListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            if (_SHELL.isItemInMyInventory(MOSS_KEY_ID)) {
                _stage.background_mc.squiddoor_mc.gotoAndStop(11);
            } else {
                _stage.background_mc.squiddoor_mc.gotoAndStop(1);
            }
            _stage.background_mc.squiddoor_mc.keyclue_btn.onRelease = com.clubpenguin.util.Delegate.create(this, showContent, "underwater_note");
            _stage.background_mc.bg_mc.scubasign_mc.scubasign_btn.onRelease = com.clubpenguin.util.Delegate.create(this, showContent, "lake_catalogue");
            _stage.puffle_water_mc.environmentType = com.clubpenguin.world.rooms.common.behaviors.RoomBehaviorEnum.EL_WATER_BEHAVIOR;
            _stage.puffle_water_mc._visible = false;
            setupEnvironmentTriggers();
        }
		function playDiving() {
			var _loc1_ = new Object();
			_loc1_.isAS3 = true;
			_loc1_.hasBrownPuffle = _SHELL.isItemOnMyPlayer(759);
			_ENGINE.sendJoinGame("diving", true, {gameStartParams:_loc1_});
		}
        function exitCaveMine() {
            _SHELL.sendJoinRoom("cavemine", 659, 280);
        }
        function exitUnderWater() {
            if (_SHELL.isItemInMyInventory(MOSS_KEY_ID)) {
                _SHELL.sendJoinRoom("underwater", 270, 237);
            } else {
                _INTERFACE.showContent("underwater_note");
            }
        }
        function exitForest() {
            _SHELL.sendJoinRoom("forest", 235, 345);
        }
        function showContent(contentID) {
            _INTERFACE.showContent(contentID);
        }
        function destroy() {
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
        }
        static var CLASS_NAME = "Lake";
        static var MOSS_KEY_ID = 7016;
    }
