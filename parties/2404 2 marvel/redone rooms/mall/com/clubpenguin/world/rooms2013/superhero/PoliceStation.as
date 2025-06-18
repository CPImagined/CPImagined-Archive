//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2013.superhero.PoliceStation extends com.clubpenguin.world.rooms.BaseRoom
    {
        var _stage, _destroyDelegate, _SHELL, _triggerWatcher, setupNavigationButtons, _triggerWatcherInterval, _ENGINE, _INTERFACE;
        function PoliceStation (stageReference) {
            super(stageReference);
            _stage.start_x = 142;
            _stage.start_y = 219;
        }
        function init() {
            _destroyDelegate = com.clubpenguin.util.Delegate.create(this, destroy);
            _SHELL.addListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            _triggerWatcher = new com.clubpenguin.world.rooms.common.triggers.TriggerWatcher(_stage, _SHELL);
            _stage.desk_btns.Lever2.onRelease = com.clubpenguin.util.Delegate.create(this, openLaserDoors);
            _stage.desk_btns.bigOrange_btn.onRelease = com.clubpenguin.util.Delegate.create(this, turnOnWarningLights);
            _stage.triggers_mc.party3_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "stage", 115, 340);
            _stage.triggers_mc.plaza_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "plaza", 380, 300);
            _stage.triggers_mc.triggercamera_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, getFreeItem);
            _stage.camera_mc.camerabutton_btn.onRelease = com.clubpenguin.util.Delegate.create(this, cameraPressed);
            setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.ladder_mc.party3_btn, 358, 100), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.door_btn, 79, 275)]);
            _stage.foreground_mc.hero_cat_btn.onRelease = com.clubpenguin.util.Delegate.create(com.clubpenguin.world.rooms2013.superhero.SuperHeroParty, com.clubpenguin.world.rooms2013.superhero.SuperHeroParty.launchCatalog);
            clearInterval(_triggerWatcherInterval);
            _triggerWatcherInterval = setInterval(_triggerWatcher, "checkAllPlayers", 40);
        }
        function turnOnWarningLights() {
            if (_stage.desk_btns.bigOrange_btn._currentframe == 1) {
                _stage.desk_btns.bigOrange_btn.play();
                _stage.backrail_mc.alarm1_mc.gotoAndPlay(2);
                _stage.laserdoor_mc.alarm2_mc.gotoAndPlay(2);
                _stage.laserdoor_mc.alarm3_mc.gotoAndPlay(2);
            }
        }
        function openLaserDoors() {
            if (_stage.desk_btns.Lever2._currentframe == 1) {
                _stage.desk_btns.Lever2.play();
                _stage.laserdoor_mc.play();
                _stage.laserdoor_mc.laserlights_mc.play();
            }
        }
        function cameraPressed() {
            _stage.camera_mc.mainbutton_mc.gotoAndStop(2);
            _ENGINE.sendPlayerMove(300, 380);
        }
        function getFreeItem() {
            if ((_stage.camera_mc.mainbutton_mc._currentframe == 2) && (_stage.camera_foreground_mc._currentframe == 1)) {
                _stage.camera_mc.flash_mc.gotoAndPlay(2);
                _stage.camera_foreground_mc.gotoAndPlay(2);
                _stage.camera_mc.mainbutton_mc.gotoAndStop(1);
            }
            if (!_SHELL.isItemInMyInventory(com.clubpenguin.world.rooms2013.superhero.SuperHeroParty.MUGSHOT)) {
                _INTERFACE.buyInventory(com.clubpenguin.world.rooms2013.superhero.SuperHeroParty.MUGSHOT);
            }
        }
        function exit(roomName, x, y) {
            _SHELL.sendJoinRoom(roomName, x, y);
        }
        function destroy() {
            clearInterval(_triggerWatcherInterval);
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
        }
        static var CLASS_NAME = "PoliceStation";
    }
