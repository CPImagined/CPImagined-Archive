//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2012.blackout.Light extends com.clubpenguin.world.rooms.BaseRoom
    {
        var _stage, _SHELL, _destroyDelegate, _triggerWatcher, showContent, setupNavigationButtons, localize, _xrayTrigger, _triggerWatcherInterval;
        function Light (stageReference) {
            super(stageReference);
            _stage.start_x = 254;
            _stage.start_y = 254;
            if (!_SHELL) {
                init();
            }
        }
        function init() {
            _destroyDelegate = com.clubpenguin.util.Delegate.create(this, destroy);
            _SHELL.addListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            _triggerWatcher = new com.clubpenguin.world.rooms2012.common.triggers.TriggerWatcher(_stage, _SHELL);
            _stage.triggers_mc.beacon_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "beacon", 212, 335);
            _stage.triggers_mc.beach_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "beach", 242, 284);
            showContent([new com.clubpenguin.world.rooms.common.PopupContentVO(_stage.partyCatalog.partyCat_btn, true, "party_catalogue", ""), new com.clubpenguin.world.rooms.common.PopupContentVO(_stage.interface_mc.music_cat_btn, true, "light_catalogue", "")]);
            setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.beach_btn, 233, 251)]);
            localize([_stage.background_mc.chunk2_mc.painting_mc, _stage.background_mc.TopArrow_mc]);
            _stage.background_mc.TopArrow_mc.totop_btn.onRelease = com.clubpenguin.util.Delegate.create(this, exit, "beacon", 212, 335);
            _xrayTrigger = new com.clubpenguin.world.rooms2012.common.triggers.PlayerWalkTrigger(_stage.triggers_mc.xray_mc);
            _xrayTrigger.playersAdded.add(com.clubpenguin.util.Delegate.create(this, turnOnXRayMachine));
            _xrayTrigger.playersRemoved.add(com.clubpenguin.util.Delegate.create(this, turnOffXRayMachine));
            _triggerWatcher.addTrigger(_xrayTrigger);
            clearInterval(_triggerWatcherInterval);
            _triggerWatcherInterval = setInterval(_triggerWatcher, "checkAllPlayers", 40);
        }
        function turnOnXRayMachine(playerList) {
            if (_stage.xray_mc._currentframe == 1) {
                _stage.xray_mc.gotoAndStop(2);
            }
        }
        function turnOffXRayMachine(playerList) {
            if (_xrayTrigger.getPlayerCount() <= 0) {
                _stage.xray_mc.gotoAndStop(1);
            }
        }
        function exit(roomName, x, y) {
            _SHELL.sendJoinRoom(roomName, x, y);
        }
        function destroy() {
            clearInterval(_triggerWatcherInterval);
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
        }
        static var CLASS_NAME = "Light";
    }
