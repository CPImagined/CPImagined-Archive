//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2014.parade.ParadeRoom extends com.clubpenguin.world.rooms.BaseRoom
    {
        var _stage, _SHELL, localize, _destroyDelegate, _engineOverrides, _ENGINE, _newParadeExitCallback, _exitIntervalID, setupNavigationButtons;
        function ParadeRoom (stageReference) {
            super(stageReference);
            trace(CLASS_NAME + "()");
            _stage.start_x = 200;
            _stage.start_y = 300;
            if (!_SHELL) {
                init();
            }
        }
        function init() {
            trace(CLASS_NAME + ": init()");
            localize([_stage.background_mc.snowMain.snowMain50.art.exitSign, _stage.background_mc.snowMain.snowMain200.art.exitSign, _stage.background_mc.snowMain.snowMain200.art.tunnelSign, _stage.foreground_mc.sign05.art, _stage.foreground_mc.mainStation.art.cfcSign.text_mc, _stage.foreground_mc.mainStation.art.cfcSign.shadow_mc, _stage.foreground_mc.mainStation.art.cfcSign.cfcLogo, _stage.background_mc.mainStation.exitFloor.exitPod.exitText, _stage.foreground_mc.mainStation.art.trainLeavesSign.text_mc]);
            _destroyDelegate = com.clubpenguin.util.Delegate.create(this, destroy);
            _SHELL.addListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            configureNavigation();
            configureTriggers();
            configureRoomElements();
            configureGameController();
            activateEngineOverrides();
        }
        function activateEngineOverrides() {
            _engineOverrides = new com.clubpenguin.world.rooms2014.parade.Parade_EngineOverrides();
            _engineOverrides.init();
            _ENGINE.updatePlayerFrame = com.clubpenguin.util.Delegate.create(this, _engineOverrides.updatePlayerFrame);
        }
        function deactivateEngineOverrides() {
            _ENGINE.updatePlayerFrame = _engineOverrides.defaultUpdatePlayerFrame;
        }
        function registerParadeExitCallback(callback) {
            _newParadeExitCallback = callback;
            _exitIntervalID = setInterval(com.clubpenguin.util.Delegate.create(this, createParadeExit), 60000);
        }
        function createParadeExit() {
            _newParadeExitCallback(getNextExitName());
        }
        function getNextExitName() {
            var _local_2 = _paradeExitOrder[_currentExit];
            _currentExit++;
            if (_currentExit > (_paradeExitOrder.length - 1)) {
                _currentExit = 0;
            }
            return(_local_2);
        }
        function configureTriggers() {
        }
        function configureNavigation() {
            setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.mainStationExit_states.mainStationExit_btn, 380, 250)]);
        }
        function configureGameController() {
        }
        function configureRoomElements() {
            _stage.block_mc._visible = false;
            _stage.triggers_mc._visible = false;
            _stage.mainStationExit_states.mainStationExit_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, mainExitStationOver);
            _stage.mainStationExit_states.mainStationExit_btn.onRollOut = com.clubpenguin.util.Delegate.create(this, mainExitStationOut);
            _stage.mainStationExit_states.mainStationExit_btn.onReleaseOutside = com.clubpenguin.util.Delegate.create(this, mainExitStationOut);
        }
        function mainExitStationOver() {
            _stage.background_mc.mainStation.exitFloor.exitPod.exitInside.gotoAndStop("over");
        }
        function mainExitStationOut() {
            _stage.background_mc.mainStation.exitFloor.exitPod.exitInside.gotoAndStop("out");
        }
        function exit(roomName, x, y) {
            trace(CLASS_NAME + ": exit()");
            _SHELL.sendJoinRoom(roomName, x, y);
        }
        function destroy() {
            clearInterval(_exitIntervalID);
            deactivateEngineOverrides();
            trace(CLASS_NAME + ": destroy()");
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            _quality  = "HIGH";
        }
        static var CLASS_NAME = "ParadeRoom";
        var _paradeExitOrder = new Array("OffRampDock", "TunnelForest", "OffRampVillage", "TunnelDock", "OffRampForest", "TunnelVillage");
        var _currentExit = 0;
    }
