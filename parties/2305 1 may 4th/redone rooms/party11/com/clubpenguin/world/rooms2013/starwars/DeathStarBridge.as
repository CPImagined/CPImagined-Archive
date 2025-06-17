//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2013.starwars.DeathStarBridge extends com.clubpenguin.world.rooms.BaseRoom
    {
        var _stage, _SHELL, _destroyDelegate, setupNavigationButtons, _ENGINE, _INTERFACE;
        function DeathStarBridge (stageReference) {
            super(stageReference);
            _stage.start_x = 630;
            _stage.start_y = 340;
            if (!_SHELL) {
                init();
            }
            com.clubpenguin.world.rooms2013.starwars.StarWarsParty.instance.waitForPlayerLoadComplete("DeathStar");
        }
        function init() {
            _destroyDelegate = com.clubpenguin.util.Delegate.create(this, destroy);
            _SHELL.addListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            configureNavigation();
            configureTriggers();
            configureRoomElements();
            _stage.interface_mc.catalogue_btn.onRelease = com.clubpenguin.util.Delegate.create(com.clubpenguin.world.rooms2013.starwars.StarWarsParty, com.clubpenguin.world.rooms2013.starwars.StarWarsParty.launchCatalogue);
            checkRoomState();
        }
        function checkRoomState() {
            var _local_2 = "active";
            _stage.background_mc.bridge_mc.gotoAndStop(_local_2);
            _stage.block_mc.gotoAndStop(_local_2);
            _stage.background_mc.doorLights_mc.gotoAndStop(_local_2);
            _stage.background_mc.door3_mc.gotoAndStop(_local_2);
        }
        function configureTriggers() {
            _stage.triggers_mc.party10_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "party10", 155, 260);
            _stage.triggers_mc.party12_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "party12", 560, 200);
            _stage.triggers_mc.party9_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "party9", 200, 340);
            _stage.triggers_mc.game_mc.triggerFunction = com.clubpenguin.util.Delegate.create(com.clubpenguin.world.rooms2013.starwars.StarWarsParty, com.clubpenguin.world.rooms2013.starwars.StarWarsParty.instance.launchIcejamGame, 1);
        }
        function configureNavigation() {
            setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.door_mc.door_btn, 695, 330), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.console_mc.console_btn, 575, 335), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.door2_mc.door_btn, 303, 114)]);
        }
        function configureRoomElements() {
            _stage.block_mc._visible = false;
            _stage.triggers_mc._visible = false;
            _stage.background_mc.door_mc.door_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, doorRollOver);
            _stage.background_mc.door_mc.door_btn.onRollOut = com.clubpenguin.util.Delegate.create(this, doorRollOut);
            _stage.background_mc.door_mc.door_btn.onReleaseOutside = com.clubpenguin.util.Delegate.create(this, doorRollOut);
            _stage.background_mc.door2_mc.door_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, door2RollOver);
            _stage.background_mc.door2_mc.door_btn.onRollOut = com.clubpenguin.util.Delegate.create(this, door2RollOut);
            _stage.background_mc.door2_mc.door_btn.onReleaseOutside = com.clubpenguin.util.Delegate.create(this, door2RollOut);
            _stage.background_mc.door2_mc.door_btn.onRelease = com.clubpenguin.util.Delegate.create(this, door2Release);
            _stage.background_mc.door3_mc.door3Unlocked_mc.door_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, door3RollOver);
            _stage.background_mc.door3_mc.door3Unlocked_mc.door_btn.onRollOut = com.clubpenguin.util.Delegate.create(this, door3RollOut);
            _stage.background_mc.door3_mc.door3Unlocked_mc.door_btn.onReleaseOutside = com.clubpenguin.util.Delegate.create(this, door3RollOut);
            _stage.background_mc.door3_mc.door3Unlocked_mc.door_btn.onRelease = com.clubpenguin.util.Delegate.create(this, door3Release);
            _stage.testOn_btn.onRelease = com.clubpenguin.util.Delegate.create(this, doorUnlocked);
            _stage.testOff_btn.onRelease = com.clubpenguin.util.Delegate.create(this, doorLocked);
            _stage.console_mc.console_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, consoleRollOver);
            _stage.console_mc.console_btn.onRollOut = com.clubpenguin.util.Delegate.create(this, consoleRollOut);
            _stage.console_mc.console_btn.onReleaseOutside = com.clubpenguin.util.Delegate.create(this, consoleRollOut);
        }
        function doorRollOver() {
            _stage.background_mc.door_mc.gotoAndPlay(10);
        }
        function doorRollOut() {
            _stage.background_mc.door_mc.gotoAndPlay(50);
        }
        function door2RollOver() {
            _stage.background_mc.door2_mc.gotoAndPlay(10);
        }
        function door2RollOut() {
            _stage.background_mc.door2_mc.gotoAndPlay(50);
        }
        function door2Release() {
            _ENGINE.sendPlayerMove(303, 113);
        }
        function door3RollOver() {
            _stage.background_mc.door3_mc.door3Unlocked_mc.gotoAndPlay(10);
        }
        function door3RollOut() {
            _stage.background_mc.door3_mc.door3Unlocked_mc.gotoAndPlay(50);
        }
        function door3Release() {
            _ENGINE.sendPlayerMove(58, 333);
        }
        function doorUnlocked() {
            _stage.background_mc.door3_mc.gotoAndStop(2);
            _stage.background_mc.doorLights_mc.gotoAndStop(2);
            _stage.background_mc.bridge_mc.gotoAndStop(2);
            _stage.block_mc.gotoAndStop(2);
        }
        function doorLocked() {
            _stage.background_mc.door3_mc.gotoAndStop(1);
            _stage.background_mc.doorLights_mc.gotoAndStop(1);
            _stage.background_mc.bridge_mc.gotoAndStop(1);
            _stage.block_mc.gotoAndStop(1);
        }
        function consoleRollOver() {
            _stage.console_mc.gotoAndStop(2);
            _INTERFACE.showHint(_stage.console_mc.hintAnchor_mc, "icejam_hint");
        }
        function consoleRollOut() {
            _stage.console_mc.gotoAndStop(1);
            _INTERFACE.closeHint();
        }
        function exit(roomName, x, y) {
            _SHELL.sendJoinRoom(roomName, x, y);
        }
        function destroy() {
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
        }
        static var CLASS_NAME = "DeathStarBridge";
    }
