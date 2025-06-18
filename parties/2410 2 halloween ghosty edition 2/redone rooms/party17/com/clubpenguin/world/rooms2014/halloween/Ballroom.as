//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2014.halloween.Ballroom extends com.clubpenguin.world.rooms.BaseRoom
    {
        var _stage, _SHELL, _destroyDelegate, _triggerWatcher, setupNavigationButtons, _triggerWatcherInterval, _INTERFACE;
        function Ballroom (stageReference) {
            super(stageReference);
            trace(CLASS_NAME + "()");
            _stage.start_x = 386;
            _stage.start_y = 290;
            if (!_SHELL) {
                init();
            }
        }
        function init() {
            trace(CLASS_NAME + ": init()");
            _destroyDelegate = com.clubpenguin.util.Delegate.create(this, destroy);
            _SHELL.addListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            _triggerWatcher = new com.clubpenguin.world.rooms.common.triggers.TriggerWatcher(_stage, _SHELL);
            _stage.triggers_mc.elevator_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, elevatorUI);
            _stage.triggers_mc.redTrigger_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, teleport, 664, 440, 580, 372);
            _stage.triggers_mc.blueTrigger_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, teleport, 82, 440, 200, 372);
            _stage.triggers_mc.purpleTrigger_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, teleport, 181, 177, 240, 207);
            _stage.triggers_mc.greenTrigger_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, teleport, 598, 177, 536, 207);
            _stage.triggers_mc.pianoTrigger_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, playPiano);
            setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.elevator_btn, 60, 235), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.reddoor_btn, 148, 166), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.bluedoor_btn, 633, 170), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.greendoor_btn, 35, 449), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.purpledoor_btn, 725, 449)]);
            _stage.reddoor_btn.useHandCursor = false;
            _stage.bluedoor_btn.useHandCursor = false;
            _stage.greendoor_btn.useHandCursor = false;
            _stage.purpledoor_btn.useHandCursor = false;
            _stage.elevator_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, elevatorRollOver);
            _stage.elevator_btn.onRollOut = com.clubpenguin.util.Delegate.create(this, elevatorRollOut);
            _stage.elevator_btn.onReleaseOutside = com.clubpenguin.util.Delegate.create(this, elevatorRollOut);
            clearInterval(_triggerWatcherInterval);
            _triggerWatcherInterval = setInterval(_triggerWatcher, "checkAllPlayers", 40);
        }
        function elevatorRollOver() {
            if (_stage.elevator_mc._currentFrame == 1) {
                _stage.elevator_mc.gotoAndPlay("open");
            } else if (_stage.elevator_mc._currentFrame == 10) {
            } else {
                _stage.elevator_mc.gotoAndPlay(20 - (_stage.elevator_mc._currentFrame - 2));
            }
        }
        function elevatorRollOut() {
            if (_stage.elevator_mc._currentFrame > 9) {
                _stage.elevator_mc.gotoAndPlay("close");
            } else {
                _stage.elevator_mc.gotoAndPlay(2 + (20 - _stage.elevator_mc._currentFrame));
            }
        }
        function elevatorUI() {
            _INTERFACE.showContent(com.clubpenguin.world.rooms2014.halloween.party.HalloweenParty.CONSTANTS.ELEVATOR_UI_PATH);
        }
        function playPiano() {
            var _local_2 = random(3);
            if ((_local_2 == 0) || (_local_2 == 1)) {
                com.clubpenguin.world.rooms2014.halloween.party.HalloweenParty.playSound(_stage.piano, "sfx_PianoSting" + _local_2);
            }
        }
        function teleport(teleportX, teleportY, moveX, moveY) {
            _ENGINE.sendPlayerTeleportAndMove(teleportX, teleportY, moveX, moveY)
        }
        function destroy() {
            trace(CLASS_NAME + ": destroy()");
            clearInterval(_triggerWatcherInterval);
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
        }
        static var CLASS_NAME = "Ballroom";
    }
