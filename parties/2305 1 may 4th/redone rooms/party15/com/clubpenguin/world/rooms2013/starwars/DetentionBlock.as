//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2013.starwars.DetentionBlock extends com.clubpenguin.world.rooms.BaseRoom
    {
        var _stage, _SHELL, _destroyDelegate, localize, setupNavigationButtons, _INTERFACE;
        function DetentionBlock (stageReference) {
            super(stageReference);
            _stage.start_x = 115;
            _stage.start_y = 335;
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
            localize([_stage.background_mc.secretDoor_mc.doorAnim_mc.topDoor_mc.text_mc]);
            checkRoomState();
            _stage.seat_btn.useHandCursor = false;
        }
        function checkRoomState() {
            var _local_2 = "active";
            _stage.background_mc.elevator_mc.gotoAndStop(_local_2);
            _stage.background_mc.elevatorDoor_mc.gotoAndStop(_local_2);
            if ("active" == _local_2) {
                _stage.triggers_mc.exit_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "party10", 165, 340);
                _stage.background_mc.elevator_mc.gotoAndStop(1);
                _stage.background_mc.elevatorDoor_mc.gotoAndStop(1);
                _stage.background_mc.reflectA_mc.gotoAndStop(1);
                _stage.background_mc.reflectB_mc.gotoAndStop(1);
                _stage.background_mc.doorFrame_mc.gotoAndStop(1);
                _stage.background_mc.secretRoom_mc.alarmA_mc.gotoAndPlay(1);
                _stage.background_mc.secretRoom_mc.alarmB_mc.gotoAndPlay(1);
                _stage.background_mc.secretDoor_mc.doorAnim_mc.gotoAndPlay(2);
                _stage.background_mc.sparks_mc.gotoAndPlay(1);
            } else {
                _stage.background_mc.elevator_mc.gotoAndStop(2);
                _stage.background_mc.elevatorDoor_mc.gotoAndStop(2);
                _stage.background_mc.reflectA_mc.gotoAndStop(2);
                _stage.background_mc.reflectB_mc.gotoAndStop(2);
                _stage.background_mc.doorFrame_mc.gotoAndStop(2);
                _stage.background_mc.secretRoom_mc.alarmA_mc.gotoAndStop(1);
                _stage.background_mc.secretRoom_mc.alarmB_mc.gotoAndStop(1);
                _stage.background_mc.secretDoor_mc.doorAnim_mc.gotoAndStop(1);
                _stage.background_mc.sparks_mc.gotoAndStop(1);
            }
        }
        function configureTriggers() {
            _stage.triggers_mc.enter_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "party14", 655, 290);
            _stage.triggers_mc.game_mc.triggerFunction = com.clubpenguin.util.Delegate.create(com.clubpenguin.world.rooms2013.starwars.StarWarsParty, com.clubpenguin.world.rooms2013.starwars.StarWarsParty.instance.launchIcejamGame, 5);
            _stage.background_mc.elevator_mc.elevator_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, exitMouseOver);
            _stage.background_mc.elevator_mc.elevator_btn.onRollOut = com.clubpenguin.util.Delegate.create(this, exitMouseOff);
            _stage.background_mc.elevator_mc.elevator_btn.onReleaseOutside = com.clubpenguin.util.Delegate.create(this, exitMouseOff);
            _stage.enter_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, enterMouseOver);
            _stage.enter_btn.onRollOut = com.clubpenguin.util.Delegate.create(this, enterMouseOff);
            _stage.enter_btn.onReleaseOutside = com.clubpenguin.util.Delegate.create(this, enterMouseOff);
        }
        function configureNavigation() {
            setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.seat_btn, 180, 130), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.enter_btn, 55, 330), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.game_mc.game_btn, 610, 145), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.elevator_mc.elevator_btn, 270, 125)]);
            _stage.seat_btn.useHandCursor = false;
        }
        function configureRoomElements() {
            _stage.game_mc.game_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, consoleRollOver);
            _stage.game_mc.game_btn.onRollOut = com.clubpenguin.util.Delegate.create(this, consoleRollOut);
            _stage.game_mc.game_btn.onReleaseOutside = com.clubpenguin.util.Delegate.create(this, consoleRollOut);
        }
        function consoleRollOver() {
            _stage.game_mc.gotoAndStop(2);
            _INTERFACE.showHint(_stage.game_mc.hintAnchor_mc, "icejam_hint");
        }
        function consoleRollOut() {
            _stage.game_mc.gotoAndStop(1);
            _INTERFACE.closeHint();
        }
        function exitMouseOver() {
            if ((_stage.background_mc.elevatorDoor_mc._currentframe == 1) && (_stage.background_mc.elevatorDoor_mc.doorAnim_mc._currentframe == 1)) {
                _stage.background_mc.elevatorDoor_mc.doorAnim_mc.gotoAndPlay(2);
            }
        }
        function exitMouseOff() {
            if (_stage.background_mc.elevatorDoor_mc._currentframe == 1) {
                _stage.background_mc.elevatorDoor_mc.doorAnim_mc.gotoAndPlay(34);
            }
        }
        function enterMouseOver() {
            if (_stage.background_mc.enterDoor_mc.doorAnim_mc._currentframe == 1) {
                _stage.background_mc.enterDoor_mc.doorAnim_mc.gotoAndPlay(2);
            }
        }
        function enterMouseOff() {
            _stage.background_mc.enterDoor_mc.doorAnim_mc.gotoAndPlay(28);
        }
        function exit(roomName, x, y) {
            _SHELL.sendJoinRoom(roomName, x, y);
        }
        function destroy() {
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
        }
        static var CLASS_NAME = "DetentionBlock";
    }
