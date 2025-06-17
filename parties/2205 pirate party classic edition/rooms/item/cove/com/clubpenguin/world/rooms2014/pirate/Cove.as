//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2014.pirate.Cove extends com.clubpenguin.world.rooms.BaseRoom
    {
        var _stage, _SHELL, localize, setupHint, _INTERFACE, _destroyDelegate, _triggerWatcher, showContent, _triggerWatcherInterval, setupNavigationButtons, _ENGINE, _roomUpdateInterval;
        function Cove (stageReference) {
            super(stageReference);
            _stage.start_x = 130;
            _stage.start_y = 237;
            _lastSfxTime = getTimer();
            if (!_SHELL) {
                init();
            }
            localize([_stage.background_mc.mineSign_mc, _stage.cpuEntrance_mc.cpuText_mc]);
            setupHint([new com.clubpenguin.world.rooms.common.HintVO(_stage.waves_mc.waves_btn, _stage.waves_mc.waves_btn, "waves_hint")]);
        }
        function init() {
            _destroyDelegate = com.clubpenguin.util.Delegate.create(this, destroy);
            _SHELL.addListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            _triggerWatcher = new com.clubpenguin.world.rooms.common.triggers.TriggerWatcher(_stage, _SHELL);
            configureNavigation();
            configureTriggers();
            configureRoomElements();
            showContent([new com.clubpenguin.world.rooms.common.PopupContentVO(_stage.interface_mc.cove_cat_btn, true, "cove_catalogue", "")]);
            clearInterval(_triggerWatcherInterval);
			showContent([new com.clubpenguin.world.rooms.common.PopupContentVO(_stage.interface_mc.party_cat_btn, true, "party_catalogue", "")]);
            _triggerWatcherInterval = setInterval(_triggerWatcher, "checkAllPlayers", 40);
            _global.getCurrentParty().PirateParty.configureTreasureChestState(_stage.chest_mc, _stage.crabs_mc, _stage.treasure_btn);
        }
        function initializePartyCookieDependentAssets() {
            _global.getCurrentParty().PirateParty.configureTreasureChestState(_stage.chest_mc, _stage.crabs_mc, _stage.treasure_btn);
        }
        function playSound(sfxName, trigger_mc) {
            var _local_5 = trigger_mc.player_mc;
            var _local_4 = getTimer();
            var _local_6 = _local_4 - _lastSfxTime;
            var _local_3 = _SHELL.isMyPlayer(_local_5.player_id);
            if ((_local_6 > 3000) || (_local_3)) {
                var _local_2 = new Sound(trigger_mc);
                _local_2.attachSound(sfxName);
                if (!_local_3) {
                    _local_2.setVolume(20);
                }
                _local_2.start();
                _lastSfxTime = _local_4;
            }
        }
        function configureTriggers() {
            _stage.triggers_mc.forestTrigger_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "forest", 463, 323);
            _stage.triggers_mc.wavesTrigger_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, launchWavesGame);
			_stage.triggers_mc.chestTrigger_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, chest);
        }
		function chest() {
			_INTERFACE.showContent("piratechestcove");
        }
        function configureNavigation() {
            setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.forestNav_btn, 130, 178), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.treasure_btn, 266, 189), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.chestNav_btn, 287, 207), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.waves_mc.waves_btn, 187, 347)]);
            _stage.forestNav_btn.useHandCursor = false;
            _stage.chestNav_btn.useHandCursor = false;
        }
        function configureRoomElements() {
        }
        function launchWavesGame() {
            if (_SHELL.isNewPlayerExperienceRunning == false) {
                _ENGINE.sendJoinGame("waves", true);
            }
        }
        function exit(roomName, x, y) {
            _SHELL.sendJoinRoom(roomName, x, y);
        }
        function destroy() {
            clearInterval(_roomUpdateInterval);
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
        }
        static var CLASS_NAME = "Cove";
        var _lastSfxTime = 0;
    }
