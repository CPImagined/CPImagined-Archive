//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2014.prom.School extends com.clubpenguin.world.rooms.BaseRoom
    {
        var _stage, _destroyDelegate, _SHELL, _liveEvent, _triggerWatcher, localize, setupNavigationButtons, _triggerWatcherInterval, _INTERFACE;
        function School (stageReference) {
            super(stageReference);
            _stage.start_x = 190;
            _stage.start_y = 360;
            init();
        }
        function init() {
            _destroyDelegate = com.clubpenguin.util.Delegate.create(this, destroy);
            _SHELL.addListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            _triggerWatcher = new com.clubpenguin.world.rooms.common.triggers.TriggerWatcher(_stage, _SHELL);
            localize([_stage.background_mc.itemContainer_mc.lang_mc, _stage.wallDivider_mc.cpu_mc]);
            _stage.triggers_mc.shack_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "shack", 250, 240);
            _stage.triggers_mc.rink_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "rink", 640, 150);
            setFreeItems();
            _stage.triggers_mc.itemTrigger_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, getFreeItem);
            _stage.triggers_mc.bgTrigger_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, getFreeBG);
            setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.bob_mc.doorleft_btn, 44, 366), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.bob_mc.doorright_btn, 716, 366), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.foreground_mc.locker1_btn, 70, 412), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.foreground_mc.locker2_btn, 125, 412), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.foreground_mc.locker3_btn, 187, 412), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.foreground_mc.locker4_btn, 248, 412), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.foreground_mc.locker5_btn, 306, 412), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.foreground_mc.locker6_btn, 450, 412), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.foreground_mc.locker7_btn, 506, 412), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.foreground_mc.locker8_btn, 566, 412), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.foreground_mc.locker9_btn, 630, 412), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.foreground_mc.locker10_btn, 682, 412), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.itemContainer_mc.item_btn, 200, 165), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.camera_mc.camerabutton_btn, 660, 170), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.podium_mc.podium_btn, 335, 145)]);
            _stage.foreground_mc.locker1_btn.useHandCursor = false;
            _stage.foreground_mc.locker2_btn.useHandCursor = false;
            _stage.foreground_mc.locker3_btn.useHandCursor = false;
            _stage.foreground_mc.locker4_btn.useHandCursor = false;
            _stage.foreground_mc.locker5_btn.useHandCursor = false;
            _stage.foreground_mc.locker6_btn.useHandCursor = false;
            _stage.foreground_mc.locker7_btn.useHandCursor = false;
            _stage.foreground_mc.locker8_btn.useHandCursor = false;
            _stage.foreground_mc.locker9_btn.useHandCursor = false;
            _stage.foreground_mc.locker10_btn.useHandCursor = false;
            _stage.podium_mc.podium_btn.useHandCursor = false;
            var _local_2 = 1;
            while (_local_2 <= 10) {
                var _local_4 = new com.clubpenguin.world.rooms.school.Locker(_stage.foreground_mc["lockermc_" + _local_2]);
                var _local_3 = new com.clubpenguin.world.rooms.common.triggers.PlayerWalkTrigger(_stage.triggers_mc[("locker" + _local_2) + "_mc"]);
                _local_3.playersAdded.add(com.clubpenguin.util.Delegate.create(this, openLocker, _local_4));
                _local_3.playersRemoved.add(com.clubpenguin.util.Delegate.create(this, closeLocker, _local_3, _local_4));
                _triggerWatcher.addTrigger(_local_3);
                _local_2++;
            }
            clearInterval(_triggerWatcherInterval);
            _triggerWatcherInterval = setInterval(_triggerWatcher, "checkAllPlayers", 40);
			_liveEvent = com.clubpenguin.util.Delegate.create(this, playLiveEvent);
			_global.getCurrentAirtower().addListener("liveevent", _liveEvent);
        }
        function setFreeItems() {
            if (_SHELL.isItemInMyInventory(GRAD_HAT_ID)) {
                _stage.background_mc.itemContainer_mc.gotoAndStop(2);
            }
            if (_SHELL.isItemInMyInventory(PROM_BACKGROUND_ID)) {
                _stage.camera_mc.gotoAndStop(2);
            }
        }
        function getFreeItem() {
            _INTERFACE.buyInventory(GRAD_HAT_ID);
        }
        function getFreeBG() {
            _INTERFACE.buyInventory(PROM_BACKGROUND_ID);
        }
        function openLocker(players, locker) {
            if (players.length > 0) {
                locker.openLocker();
            }
        }
        function closeLocker(players, trigger, locker) {
            if (trigger.getPlayerCount() == 0) {
                locker.closeLocker();
            }
        }
        function exit(roomName, x, y) {
            _SHELL.sendJoinRoom(roomName, x, y);
        }
		function playLiveEvent()
        {
     	   _SHELL.startMusicById(2027);
        }
        function destroy() {
            clearInterval(_triggerWatcherInterval);
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
			_global.getCurrentAirtower().removeListener("liveevent", _liveEvent);
        }
        static var CLASS_NAME = "School";
        static var GRAD_HAT_ID = 1880;
        static var PROM_BACKGROUND_ID = 9266;
    }
