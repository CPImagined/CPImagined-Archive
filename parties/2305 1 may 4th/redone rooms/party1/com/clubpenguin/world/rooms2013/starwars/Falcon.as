//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2013.starwars.Falcon extends com.clubpenguin.world.rooms.BaseRoom
    {
        var _stage, _SHELL, _destroyDelegate, _triggerWatcher, _chairTrigger, _remoteTrigger, _turretTrigger, setupNavigationButtons, _triggerWatcherInterval, _INTERFACE, _ENGINE;
        function Falcon (stageReference) {
            super(stageReference);
            _stage.start_x = 450;
            _stage.start_y = 370;
            if (!_SHELL) {
                init();
            }
        }
        function init() {
            _destroyDelegate = com.clubpenguin.util.Delegate.create(this, destroy);
            _SHELL.addListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            _triggerWatcher = new com.clubpenguin.world.rooms.common.triggers.TriggerWatcher(_stage, _SHELL);
            _stage.triggers_mc.exit_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, openPartyInterface);
            _chairTrigger = new com.clubpenguin.world.rooms.common.triggers.PlayerTrigger(_stage.triggers_mc.darjerik_mc);
            _chairTrigger.playersAdded.add(com.clubpenguin.util.Delegate.create(this, showGameFigurines));
            _chairTrigger.playersRemoved.add(com.clubpenguin.util.Delegate.create(this, hideGameFigurines));
            _triggerWatcher.addTrigger(_chairTrigger);
            _remoteTrigger = new com.clubpenguin.world.rooms.common.triggers.PlayerTrigger(_stage.triggers_mc.remoteTrigger_mc);
            _remoteTrigger.playersAdded.add(com.clubpenguin.util.Delegate.create(this, playTrainingRemoteAnim));
            _remoteTrigger.playersRemoved.add(com.clubpenguin.util.Delegate.create(this, stopTrainingRemoteAnim));
            _triggerWatcher.addTrigger(_remoteTrigger);
            _turretTrigger = new com.clubpenguin.world.rooms.common.triggers.PlayerTrigger(_stage.triggers_mc.turret_mc);
            _turretTrigger.playersAdded.add(com.clubpenguin.util.Delegate.create(this, playTurretAnim));
            _turretTrigger.playersRemoved.add(com.clubpenguin.util.Delegate.create(this, stopTurretAnim));
            _triggerWatcher.addTrigger(_turretTrigger);
            _stage.boat_mc.art_mc.boat_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, methodToCall);
            _stage.boat_mc.art_mc.boat_btn.onRollOut = com.clubpenguin.util.Delegate.create(this, methodToCall);
            _stage.boat_mc.onRelease = com.clubpenguin.util.Delegate.create(this, methodToCall);
            setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.exit_btn, 718, 427), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.turret_btn, 667, 150)]);
            _stage.interface_mc.catalogue_btn.onRelease = com.clubpenguin.util.Delegate.create(this, showCatalogue);
            clearInterval(_triggerWatcherInterval);
            _triggerWatcherInterval = setInterval(_triggerWatcher, "checkAllPlayers", 40);
        }
		function showCatalogue() {
			_INTERFACE.showContent("party_catalogue");
		}
        function showGameFigurines() {
            _stage.tablegame_mc.gotoAndStop(2);
        }
        function hideGameFigurines() {
            if (_chairTrigger.getPlayerCount() <= 0) {
                _stage.tablegame_mc.gotoAndStop(1);
            }
        }
        function playTrainingRemoteAnim() {
            if (_stage.remote_mc._currentframe == 1) {
                _stage.remote_mc.gotoAndPlay(2);
            }
        }
        function stopTrainingRemoteAnim() {
            if (_remoteTrigger.getPlayerCount() <= 0) {
                _stage.remote_mc.gotoAndStop(1);
            }
        }
        function playTurretAnim() {
            if (_stage.foreground_mc.cannon1_mc._currentframe == 1) {
                var _local_2 = new Sound(_stage);
                _local_2.attachSound("sfx_gunalarm");
                _local_2.start();
                _stage.foreground_mc.cannon1_mc.gotoAndPlay(2);
                _stage.foreground_mc.cannon2_mc.gotoAndPlay(2);
                _stage.foreground_mc.cannon2_mc.innercannon.gotoAndPlay(2);
                _stage.foreground_mc.cannon3_mc.gotoAndPlay(2);
                _stage.foreground_mc.cannon4_mc.gotoAndPlay(2);
                _stage.foreground_mc.cannon4_mc.innercannon.gotoAndPlay(2);
            }
        }
        function stopTurretAnim() {
            if (_turretTrigger.getPlayerCount() <= 0) {
                _stage.foreground_mc.cannon1_mc.gotoAndStop(1);
                _stage.foreground_mc.cannon2_mc.gotoAndStop(1);
                _stage.foreground_mc.cannon2_mc.innercannon.gotoAndStop(1);
                _stage.foreground_mc.cannon3_mc.gotoAndStop(1);
                _stage.foreground_mc.cannon4_mc.gotoAndStop(1);
                _stage.foreground_mc.cannon4_mc.innercannon.gotoAndStop(1);
            }
        }
        function checkRoomState() {
            _INTERFACE.showMapIcon();
            var _local_2 = "cp";
            if (_SHELL.getCurrentRoomId() == SOLO_ROOM_ID) {
                initiateSoloRoomFunctionality();
                _local_2 = "solo_room";
            } else {
                _stage.cadence_MC._visible = false;
                _stage.triggers_mc.princessCadence_mc._visible = false;
            }
            if (com.clubpenguin.world.rooms2013.starwars.StarWarsParty.instance.isPlayerOnTatooine(_SHELL.getLastRoomId()) == true) {
                _local_2 = "tatooine";
            }
            if (com.clubpenguin.world.rooms2013.starwars.StarWarsParty.instance.isPlayerOnDeathStar(_SHELL.getLastRoomId()) == true) {
                _local_2 = "deathstar";
            }
            if (com.clubpenguin.world.rooms2013.starwars.StarWarsParty.instance.isPlayerOnYavin(_SHELL.getLastRoomId()) == true) {
                _local_2 = "yavin";
            }
            if (com.clubpenguin.world.rooms2013.starwars.StarWarsParty.instance.falconAccessedThroughPartyInterface) {
                com.clubpenguin.world.rooms2013.starwars.StarWarsParty.instance.falconAccessedThroughPartyInterface = false;
                _local_2 = "space";
            }
            _stage.background_mc.planet_MC.gotoAndStop(_local_2);
            _SHELL.MUSIC.unMuteMusic();
        }
        function initiateSoloRoomFunctionality() {
            _stage.cadence_MC.gotoAndStop("solo_active");
            com.clubpenguin.world.rooms2013.starwars.StarWarsParty.instance.checkForFirstTimePartyLogin();
            setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.cadence_MC.cadence_btn, 430, 380)]);
            _stage.triggers_mc.princessCadence_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, launchSoloRoomCharacterDialogue);
        }
        function launchSoloRoomCharacterDialogue() {
            if (!com.clubpenguin.world.rooms2013.starwars.StarWarsParty.instance.cinematicViewed) {
                com.clubpenguin.world.rooms2013.starwars.StarWarsParty.instance.sendDialogueViewed(com.clubpenguin.world.rooms2013.starwars.StarWarsParty.CINEMATIC_PATH);
            }
            var _local_2 = _ENGINE.getPlayerMovieClip(_SHELL.getMyPlayerId());
            _INTERFACE.showContent(com.clubpenguin.world.rooms2013.starwars.StarWarsParty.CHARACTER_DIALOGUE_SOLOROOM);
            _stage.cadence_MC.gotoAndStop("solo");
            setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.cadence_MC, 430, 380)]);
            setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.cadence_MC.cadence_btn, 430, 360)]);
        }
        function methodToCall() {
        }
        function openPartyInterface() {
            _INTERFACE.showContent("party_map");
        }
        function exit(roomName, x, y) {
            _SHELL.sendJoinRoom(roomName, x, y);
        }
        function destroy() {
            clearInterval(_triggerWatcherInterval);
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
        }
        static var CLASS_NAME = "Falcon";
        static var SOLO_ROOM_ID = 435;
    }
