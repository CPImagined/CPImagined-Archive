//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2014.halloween.SittingRoom extends com.clubpenguin.world.rooms.BaseRoom
    {
        var _stage, _SHELL, _destroyDelegate, _triggerWatcher, _ENGINE, _triggerWatcherInterval, fireLoopSFX, setupNavigationButtons, _INTERFACE;
        function SittingRoom (stageReference) {
            super(stageReference);
            _stage.start_x = 150;
            _stage.start_y = 275;
            if (!_SHELL) {
                init();
            }
        }
        function init() {
            _destroyDelegate = com.clubpenguin.util.Delegate.create(this, destroy);
            _SHELL.addListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            _triggerWatcher = new com.clubpenguin.world.rooms.common.triggers.TriggerWatcher(_stage, _SHELL);
            configureNavigation();
            configureTriggers();
            configureRoomElements();
            clearInterval(_triggerWatcherInterval);
            _triggerWatcherInterval = setInterval(_triggerWatcher, "checkAllPlayers", 40);
            fireLoopSFX = new Sound(_stage.fire_mc);
            fireLoopSFX.attachSound("sfx_FireplaceLoop");
        }
        function configureNavigation() {
            setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.elevator_btn, 60, 235)]);
        }
        function configureTriggers() {
            _stage.triggers_mc.elevator_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, elevatorUI);
        }
        function configureRoomElements() {
            _stage.block_mc._visible = false;
            _stage.triggers_mc._visible = false;
            _stage.elevator_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, elevatorRollOver);
            _stage.elevator_btn.onRollOut = com.clubpenguin.util.Delegate.create(this, elevatorRollOut);
            _stage.elevator_btn.onReleaseOutside = com.clubpenguin.util.Delegate.create(this, elevatorRollOut);
        }
        function elevatorRollOver() {
            if (_stage.elevator_mc._currentFrame == 1) {
                _stage.elevator_mc.gotoAndPlay("open");
            } else {
                _stage.elevator_mc.gotoAndPlay(11 - (_stage.background_mc.door_mc._currentFrame - 1));
            }
        }
        function elevatorRollOut() {
            if (_stage.elevator_mc._currentFrame > 9) {
                _stage.elevator_mc.gotoAndPlay("close");
            } else {
                _stage.elevator_mc.gotoAndPlay(1 + (11 - _stage.background_mc.door_mc._currentFrame));
            }
        }
        function elevatorUI() {
            _INTERFACE.showContent(com.clubpenguin.world.rooms2014.halloween.party.HalloweenParty.CONSTANTS.ELEVATOR_UI_PATH);
        }
        function showContentPopup(contentID, data) {
            _INTERFACE.showContent(contentID, null, null, data, null);
        }
        function exit(roomName, x, y) {
            _SHELL.sendJoinRoom(roomName, x, y);
        }
        function destroy() {
            clearInterval(_triggerWatcherInterval);
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
        }
        static var CLASS_NAME = "SittingRoom";
    }
