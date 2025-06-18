//Created by Action Script Viewer - https://www.buraks.com/asv
    class as_files.Gala extends com.clubpenguin.world.rooms.BaseRoom
    {
        var _stage, _SHELL, _destroyDelegate, _triggerWatcher, _currentParty, localize, setupNavigationButtons, _triggerWatcherInterval, _sfxDoorOpen, _sfxDoorClose, _INTERFACE;
        function Gala (stageReference) {
            super(stageReference);
            _stage.start_x = 330;
            _stage.start_y = 310;
            if (!_SHELL) {
                init();
            }
        }
        function init() {
            _destroyDelegate = com.clubpenguin.util.Delegate.create(this, destroy);
            _SHELL.addListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            _triggerWatcher = new com.clubpenguin.world.rooms.common.triggers.TriggerWatcher(_stage, _SHELL);
            _currentParty = _global.getCurrentParty().BaseParty.CURRENT_PARTY;
            localize([_stage.interface_mc.costume_btn_states]);
			_stage.triggers_mc.stage_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "stage", 115, 340);
            _stage.interface_mc.costume_btn_states.costume_btn.onRelease = com.clubpenguin.util.Delegate.create(this, showCatalogue);
            setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.nav_plaza, 45, 190)]);
            _stage.triggers_mc.plaza_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "plaza", 470, 255);
            _stage.nav_plaza.onRollOver = com.clubpenguin.util.Delegate.create(this, plazaDoorOver);
            _stage.nav_plaza.onRollOut = com.clubpenguin.util.Delegate.create(this, plazaDoorOut);
            _stage.nav_plaza.onReleaseOutside = com.clubpenguin.util.Delegate.create(this, plazaDoorOut);
            clearInterval(_triggerWatcherInterval);
			_stage.interface_mc.berry_btn.onRelease = com.clubpenguin.util.Delegate.create(this, showMallCatalogue);
            _triggerWatcherInterval = setInterval(_triggerWatcher, "checkAllPlayers", 40);
            _sfxDoorOpen = new Sound(_stage);
            _sfxDoorOpen.attachSound("sfx_DoorOpen");
            _sfxDoorClose = new Sound(_stage);
            _sfxDoorClose.attachSound("sfx_DoorClose");
            configureHidingSpot();
        }
		function showMallCatalogue() {
            _INTERFACE.showContent("mall_catalogue");
        }
        function configureHidingSpot() {
            if (_currentParty.partyCookie.hasPlayerCompletedTask(GoldPuffleTaskId)) {
                _stage.puffle_hidingSpot01_mc.gotoAndStop(2);
                _stage.puffle_hidingSpot01_btn.useHandCursor = false;
                _stage.puffle_hidingSpot01_btn.onRelease = null;
            } else if (!_currentParty.isTaskAvailable(GoldPuffleTaskId)) {
                _stage.puffle_hidingSpot01_mc.gotoAndStop(1);
                _stage.puffle_hidingSpot01_mc.mc.gotoAndStop(1);
                _stage.puffle_hidingSpot01_btn.useHandCursor = false;
                _stage.puffle_hidingSpot01_btn.onRelease = null;
            } else {
                _stage.puffle_hidingSpot01_btn.onRelease = com.clubpenguin.util.Delegate.create(this, hidingSpot01Release);
            }
        }
        function hidingSpot01Release() {
            _stage.puffle_hidingSpot01_mc.gotoAndStop(2);
            setTimeout(com.clubpenguin.util.Delegate.create(this, setTaskComplete), 3000);
            showCheckMark();
            _stage.puffle_hidingSpot01_btn.useHandCursor = false;
            _stage.puffle_hidingSpot01_btn.onRelease = null;
        }
        function setTaskComplete() {
            _currentParty.taskComplete(GoldPuffleTaskId);
            if (_stage.checkmark_mc) {
                _stage.checkmark_mc.removeMovieClip();
            }
        }
        function showCheckMark() {
            if (_stage.checkmark_mc) {
                _stage.checkmark_mc.removeMovieClip();
            }
            var _local_4 = _SHELL.getMyPlayerId();
            var _local_3 = _global.getCurrentEngine().getPlayerMovieClip(_local_4);
            _stage.attachMovie("CheckMarkAnimation", "checkmark_mc", _stage.getNextHighestDepth());
            _stage.checkmark_mc._x = _local_3._x;
            _stage.checkmark_mc._y = _local_3._y + 120;
            _stage.checkmark_mc._xscale = 250;
            _stage.checkmark_mc._yscale = 250;
        }
        function showCatalogue() {
            _INTERFACE.showContent("costume_catalogue");
        }
        function openDoorAudio() {
            _sfxDoorClose.stop();
            _sfxDoorOpen.start();
        }
        function closeDoorAudio() {
            _sfxDoorOpen.stop();
            _sfxDoorClose.start();
        }
        function plazaDoorOver() {
            _stage.door_mc.gotoAndStop("open");
            openDoorAudio();
        }
        function plazaDoorOut() {
            _stage.door_mc.gotoAndStop("close");
            closeDoorAudio();
        }
        function exit(name, x, y) {
            if (_SHELL.isNewPlayerExperienceRunning == false) {
                _SHELL.sendJoinRoom(name, x, y);
            }
        }
        function destroy() {
            clearInterval(_triggerWatcherInterval);
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
        }
        static var CLASS_NAME = "Gala";
        static var GoldPuffleTaskId = 10;
    }
