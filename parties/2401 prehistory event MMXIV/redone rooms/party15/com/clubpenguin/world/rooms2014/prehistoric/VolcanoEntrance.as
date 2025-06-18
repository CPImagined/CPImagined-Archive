//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2014.prehistoric.VolcanoEntrance extends com.clubpenguin.world.rooms.BaseRoom
    {
        var _stage, _SHELL, _destroyDelegate, _airtower, _triggerWatcherInterval, _triggerWatcher, _lavaTrigger, _tileATrigger, _tileBTrigger, _tileCTrigger, _tileDTrigger, _tileETrigger, setupNavigationButtons, _sfxLavaRumble, _flareTimeoutId, _lavaRiseTimeoutId, _lavaLowerTimeoutId, _eruptionTimeoutId, handleVolcanoStatusBroadcastReceivedDelegate;
        function VolcanoEntrance (stageReference) {
            super(stageReference);
            trace(CLASS_NAME + "()");
            _stage.start_x = 685;
            _stage.start_y = 330;
            _stage.customPenguinSize = 85;
            if (!_SHELL) {
                init();
            }
        }
        function init() {
            _destroyDelegate = com.clubpenguin.util.Delegate.create(this, destroy);
            _SHELL.addListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            _airtower = _global.getCurrentAirtower();
            activateVolcanoStatusBroadcastReceiver();
            configureNavigation();
            configureTriggers();
            configureRoomElements();
            clearInterval(_triggerWatcherInterval);
            _triggerWatcherInterval = setInterval(_triggerWatcher, "checkAllPlayers", 40);
        }
        function configureTriggers() {
            _stage.triggers_mc.caveA_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "party16", 370, 390);
            _stage.triggers_mc.caveB_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "party17", 370, 390);
            _stage.triggers_mc.swamp_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "party7", 0, 0);
            _lavaTrigger = new com.clubpenguin.world.rooms.common.triggers.PlayerWalkTrigger(_stage.triggers_mc.lavaTrigger_mc);
            _lavaTrigger.playersAdded.add(com.clubpenguin.util.Delegate.create(this, hitLava));
            _triggerWatcher.addTrigger(_lavaTrigger);
            _tileATrigger = new com.clubpenguin.world.rooms.common.triggers.PlayerWalkTrigger(_stage.triggers_mc.tileA_mc);
            _tileBTrigger = new com.clubpenguin.world.rooms.common.triggers.PlayerWalkTrigger(_stage.triggers_mc.tileB_mc);
            _tileCTrigger = new com.clubpenguin.world.rooms.common.triggers.PlayerWalkTrigger(_stage.triggers_mc.tileC_mc);
            _tileDTrigger = new com.clubpenguin.world.rooms.common.triggers.PlayerWalkTrigger(_stage.triggers_mc.tileD_mc);
            _tileETrigger = new com.clubpenguin.world.rooms.common.triggers.PlayerWalkTrigger(_stage.triggers_mc.tileE_mc);
        }
        function configureNavigation() {
            setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.exitA_btn, 390, 120), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.exitB_btn, 570, 155), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.foreground_mc.exitSwamp_btn, 640, 420)]);
        }
        function configureRoomElements() {
            _sfxLavaRumble = new Sound(_stage);
            _sfxLavaRumble.attachSound("lavaFillRumble_sfx");
        }
        function playRumble() {
            _sfxLavaRumble.start();
            if (_flareTimeoutId != null) {
                clearTimeout(_flareTimeoutId);
            }
            _flareTimeoutId = setTimeout(com.clubpenguin.util.Delegate.create(this, playFlares), DELAY_FLARES_AFTER_RUMBLE);
        }
        function playFlares() {
            clearTimeout(_flareTimeoutId);
            _stage.flareA_mc.gotoAndPlay(2);
            _stage.flareB_mc.gotoAndPlay(2);
            _stage.flareC_mc.gotoAndPlay(2);
            if (_lavaRiseTimeoutId != null) {
                clearTimeout(_lavaRiseTimeoutId);
            }
            _lavaRiseTimeoutId = setTimeout(com.clubpenguin.util.Delegate.create(this, lavaRise), DELAY_LAVA_RISE_AFTER_FLARES);
        }
        function lavaRise() {
            clearTimeout(_lavaRiseTimeoutId);
            _stage.background_mc.lava_mc.gotoAndPlay("riseFrame");
            if (_lavaLowerTimeoutId != null) {
                clearTimeout(_lavaLowerTimeoutId);
            }
            _lavaLowerTimeoutId = setTimeout(com.clubpenguin.util.Delegate.create(this, lavaLower), DELAY_LAVA_LOWER_AFTER_RISE);
        }
        function lavaLower() {
            clearTimeout(_lavaLowerTimeoutId);
            _stage.background_mc.lava_mc.gotoAndPlay("lowerFrame");
            if (_eruptionTimeoutId != null) {
                clearTimeout(_eruptionTimeoutId);
            }
        }
        function setLavaTriggerActive() {
            _stage.triggers_mc.gotoAndStop(2);
        }
        function setLavaTriggerDisabled() {
            _stage.triggers_mc.gotoAndStop(1);
        }
        function setLavaEmpty() {
            _stage.background_mc.lava_mc.gotoAndStop("emptyFrame");
        }
        function setLavaFull() {
            _stage.background_mc.lava_mc.gotoAndStop("fullFrame");
        }
        function hitLava() {
        }
        function startEruption() {
            clearTimeout(_eruptionTimeoutId);
            playRumble();
        }
        function activateVolcanoStatusBroadcastReceiver() {
            handleVolcanoStatusBroadcastReceivedDelegate = com.clubpenguin.util.Delegate.create(this, startEruption);
            _airtower.addListener(_global.getCurrentParty().PrehistoricParty.CONSTANTS.VOLCANO_STATUS_COMMAND, handleVolcanoStatusBroadcastReceivedDelegate);
        }
        function deactivateVolcanoStatusBroadcastReceiver() {
            _airtower.removeListener(_global.getCurrentParty().PrehistoricParty.CONSTANTS.VOLCANO_STATUS_COMMAND, handleVolcanoStatusBroadcastReceivedDelegate);
        }
        function exit(roomName, x, y) {
            trace(CLASS_NAME + ": exit()");
            _SHELL.sendJoinRoom(roomName, x, y);
            deactivateVolcanoStatusBroadcastReceiver();
        }
        function destroy() {
            trace(CLASS_NAME + ": destroy()");
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
        }
        static var CLASS_NAME = "VolcanoEntrance";
        var DELAY_FLARES_AFTER_RUMBLE = 2000;
        var DELAY_LAVA_RISE_AFTER_FLARES = 2000;
        var DELAY_LAVA_LOWER_AFTER_RISE = 10000;
        var DELAY_BETWEEN_ERUPTIONS = 10000;
    }
