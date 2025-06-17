//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2013.starwars.DeathStarTractorBeam extends com.clubpenguin.world.rooms.BaseRoom
    {
        var _stage, localize, _SHELL, _destroyDelegate, setupNavigationButtons, _ENGINE, _INTERFACE;
        function DeathStarTractorBeam (stageReference) {
            super(stageReference);
            _stage.start_x = 200;
            _stage.start_y = 135;
            localize([_stage.background_mc.hexDoorBorder.toShip]);
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
            _stage.background_mc.hexDoor.gotoAndStop(_local_2);
            _stage.background_mc.hexDoorBorder.hexDoor.gotoAndStop(_local_2);
            _stage.hexDoorFront.gotoAndStop(_local_2);
            _stage.background_mc.hexDoorBorder.gotoAndStop(_local_2);
            if ("active" == _local_2) {
                _stage.triggers_mc.party15_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "party15", 165, 340);
            }
        }
        function configureTriggers() {
            _stage.triggers_mc.party13_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "party13", 570, 110);
            _stage.triggers_mc.game_mc.triggerFunction = com.clubpenguin.util.Delegate.create(com.clubpenguin.world.rooms2013.starwars.StarWarsParty, com.clubpenguin.world.rooms2013.starwars.StarWarsParty.instance.launchIcejamGame, 4);
        }
        function configureNavigation() {
            setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.console_mc.console_btn, 403, 143)]);
        }
        function configureRoomElements() {
            _stage.block_mc._visible = false;
            _stage.triggers_mc._visible = false;
            _stage.testOn_btn.onRelease = com.clubpenguin.util.Delegate.create(this, hexDoorUnlocked);
            _stage.testOff_btn.onRelease = com.clubpenguin.util.Delegate.create(this, hexDoorLocked);
            _stage.background_mc.door13.door_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, party13DoorRollOver);
            _stage.background_mc.door13.door_btn.onRollOut = com.clubpenguin.util.Delegate.create(this, party13DoorRollOut);
            _stage.background_mc.door13.door_btn.onReleaseOutside = com.clubpenguin.util.Delegate.create(this, party13DoorRollOut);
            _stage.background_mc.door13.door_btn.onRelease = com.clubpenguin.util.Delegate.create(this, party13DoorRelease);
            _stage.background_mc.hexDoor.door.door_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, party15RollOver);
            _stage.background_mc.hexDoor.door.door_btn.onRollOut = com.clubpenguin.util.Delegate.create(this, party15RollOut);
            _stage.background_mc.hexDoor.door.door_btn.onReleaseOutside = com.clubpenguin.util.Delegate.create(this, party15RollOut);
            _stage.background_mc.hexDoor.door.door_btn.onRelease = com.clubpenguin.util.Delegate.create(this, party15Release);
            _stage.console_mc.console_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, consoleRollOver);
            _stage.console_mc.console_btn.onRollOut = com.clubpenguin.util.Delegate.create(this, consoleRollOut);
            _stage.console_mc.console_btn.onReleaseOutside = com.clubpenguin.util.Delegate.create(this, consoleRollOut);
            _stage.sound_btn.onRelease = com.clubpenguin.util.Delegate.create(this, tractorBeamSound);
            _stage.sound_btn.useHandCursor = false;
        }
        function hexDoorUnlocked() {
            _stage.background_mc.hexDoorBorder.gotoAndStop(2);
            _stage.background_mc.hexDoorBorder.hexDoor.gotoAndStop(2);
            _stage.background_mc.hexDoor.gotoAndStop(2);
            _stage.hexDoorFront.gotoAndStop(2);
        }
        function hexDoorLocked() {
            _stage.background_mc.hexDoorBorder.gotoAndStop(1);
            _stage.background_mc.hexDoorBorder.hexDoor.gotoAndStop(1);
            _stage.background_mc.hexDoor.gotoAndStop(1);
            _stage.hexDoorFront.gotoAndStop(1);
        }
        function party13DoorRollOver() {
            if ((_stage.background_mc.door13._currentframe == 1) || (_stage.background_mc.door13._currentframe >= 50)) {
                _stage.background_mc.door13.gotoAndPlay(10);
            }
            _stage.background_mc.door13.doorTimer.gotoAndStop(1);
        }
        function party13DoorRollOut() {
            if ((_stage.background_mc.door13.doorTimer._currentframe == 1) && (_stage.background_mc.door13._currentframe < 50)) {
                _stage.background_mc.door13.gotoAndPlay(50);
            }
        }
        function party13DoorRelease() {
            _stage.background_mc.door13.doorTimer.gotoAndPlay(2);
            _ENGINE.sendPlayerMove(140, 133);
        }
        function party15RollOver() {
            if ((_stage.background_mc.hexDoor.door._currentframe == 1) || (_stage.background_mc.hexDoor.door._currentframe >= 50)) {
                _stage.background_mc.hexDoor.door.gotoAndPlay(10);
            }
            _stage.background_mc.hexDoor.door.doorTimer.gotoAndStop(1);
        }
        function party15RollOut() {
            if ((_stage.background_mc.hexDoor.door.doorTimer._currentframe == 1) && (_stage.background_mc.hexDoor.door._currentframe < 50)) {
                _stage.background_mc.hexDoor.door.gotoAndPlay(50);
            }
        }
        function party15Release() {
            _stage.background_mc.hexDoor.door.doorTimer.gotoAndPlay(2);
            _ENGINE.sendPlayerMove(708, 288);
        }
        function consoleRollOver() {
            _stage.console_mc.gotoAndStop(2);
            _INTERFACE.showHint(_stage.console_mc.hintAnchor_mc, "icejam_hint");
        }
        function consoleRollOut() {
            _stage.console_mc.gotoAndStop(1);
            _INTERFACE.closeHint();
        }
        function tractorBeamSound() {
            _stage.tractorBeamSound.gotoAndPlay("sound");
        }
        function launchBlasterGame() {
            _INTERFACE.showContent(com.clubpenguin.world.rooms2013.starwars.StarWarsParty.BLASTER_GAME_UI);
        }
        function exit(roomName, x, y) {
            _SHELL.sendJoinRoom(roomName, x, y);
        }
        function destroy() {
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
        }
        static var CLASS_NAME = "DeathStarTractorBeam";
    }
