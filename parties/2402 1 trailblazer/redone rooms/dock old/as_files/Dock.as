//Created by Action Script Viewer - https://www.buraks.com/asv
    class as_files.Dock extends com.clubpenguin.world.rooms.BaseRoom
    {
        var _stage, localize, setupNavigationButtons, _INTERFACE, _bbqTrigger, _ENGINE, _SHELL, _destroyDelegate, _triggerWatcher, _currentParty, wem, _abductionDelegate, _bellTrigger, _triggerWatcherInterval, aliendAbduction;
        function Dock (stageReference) {
            super(stageReference);
            trace(CLASS_NAME + "()");
            _stage.start_x = 380;
            _stage.start_y = 220;
            localize([]);
            setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.nav_beach, 180, 145), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.nav_village, 340, 145), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.nav_town, 696, 142), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.nav_party1, 742, 303), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.boat_btn, 110, 320)]);
            _stage.nav_beach.useHandCursor = false;
            _stage.nav_village.useHandCursor = false;
            _stage.nav_town.useHandCursor = false;
			_stage.nav_party1.useHandCursor = false;
            _stage.tubes_mc.tubes_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, tubesAnimate);
            _stage.tubes_mc.tubes_btn.useHandCursor = false;
            _stage.interface_mc.dock_cat_btn.onRelease = com.clubpenguin.util.Delegate.create(this, showContent, "dock_catalogue");
            _stage.hydrocatalog_mc.hydrocatalog_btn.onRelease = com.clubpenguin.util.Delegate.create(this, showContent, "dock_catalogue");
            _stage.boat_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, showHydroHintRollOver);
            _stage.boat_btn.onRollOut = com.clubpenguin.util.Delegate.create(this, hideHydroHintRollOut);
            _stage.triggers_mc.beach_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "beach", 565, 205);
            _stage.triggers_mc.village_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "village", 665, 350);
            _stage.triggers_mc.town_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "town", 95, 320);
            _stage.triggers_mc.maze_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "party1", 100, 330);
            _stage.triggers_mc.hydro_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, launchHydroGame);
        }
        function tubesAnimate() {
            _stage.tubes_mc.gotoAndPlay(2);
        }
        function showContent(contentID) {
            trace("show contnet");
            _INTERFACE.showContent(contentID);
        }
        function turnOnBbq() {
            _stage.bbq_mc.gotoAndStop(2);
        }
        function turnOffBbq() {
            if ((_bbqTrigger.getPlayersWhoAre(com.clubpenguin.world.rooms.common.triggers.PlayerTrigger.STOPPED).length + _bbqTrigger.getPlayersWhoAre(com.clubpenguin.world.rooms.common.triggers.PlayerTrigger.STANDING).length) == 0) {
                _stage.bbq_mc.gotoAndStop(1);
            }
        }
        function ringBell() {
            _stage.bell_mc.gotoAndPlay(2);
        }
        function showHydroHintRollOver() {
            trace("show hint");
            _INTERFACE.showHint(_stage.hinthydro_mc, "hydro_hint");
            _stage.dock_mc.boat_mc.boathover_mc.gotoAndStop(2);
        }
        function hideHydroHintRollOut() {
            trace("hide hint");
            _INTERFACE.closeHint();
            _stage.dock_mc.boat_mc.boathover_mc.gotoAndStop(1);
        }
        function launchHydroGame() {
            _ENGINE.sendJoinGame("hydro", true);
        }
        function exit(name, x, y) {
            trace(CLASS_NAME + ": exit()");
            _SHELL.sendJoinRoom(name, x, y);
        }
        function init() {
            trace(CLASS_NAME + ": init()");
            _destroyDelegate = com.clubpenguin.util.Delegate.create(this, destroy);
            _SHELL.addListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            _triggerWatcher = new com.clubpenguin.world.rooms.common.triggers.TriggerWatcher(_stage, _SHELL);
            _currentParty = _global.getCurrentParty().BaseParty.CURRENT_PARTY;
            wem = new com.clubpenguin.world.rooms.weathereffects.WeatherEffectsManager(_SHELL, _stage.background_mc);
            wem.setupFireAnimationHeight(45);
            wem.setupRainAnimationHeight(70);
            wem.setupSnowAnimationHeight(70);
            wem.setupRainAnimationSpeed(0.4);
            wem.setupSnowAnimationSpeed(0.8);
            wem.setupRainDelayTime(2);
            wem.setupSnowDelayTime(2);
            wem.startWeatherEffectCheck();
            _abductionDelegate = com.clubpenguin.util.Delegate.create(this, abductPenguin);
            _global.getCurrentAirtower().addListener("beamup", _abductionDelegate);
            _bellTrigger = new com.clubpenguin.world.rooms.common.triggers.PlayerTrigger(_stage.triggers_mc.bellTrigger_mc);
            _bellTrigger.playersAdded.add(com.clubpenguin.util.Delegate.create(this, ringBell));
            _triggerWatcher.addTrigger(_bellTrigger);
            _bbqTrigger = new com.clubpenguin.world.rooms.common.triggers.PlayerTrigger(_stage.triggers_mc.bbqTrigger_mc);
            _bbqTrigger.playersAdded.add(com.clubpenguin.util.Delegate.create(this, turnOnBbq));
            _bbqTrigger.playersRemoved.add(com.clubpenguin.util.Delegate.create(this, turnOffBbq));
            _triggerWatcher.addTrigger(_bbqTrigger);
            clearInterval(_triggerWatcherInterval);
            _triggerWatcherInterval = setInterval(_triggerWatcher, "checkAllPlayers", 40);
        }
        function abductPenguin(data) {
            trace((CLASS_NAME + "abductPenguin() - data : ") + data);
            var _local_4 = data[1];
            var _local_3 = _global.getCurrentEngine().getPlayerMovieClip(_local_4);
            _stage.attachMovie("TractorBeam", "tractorBeam_mc", _stage.getNextHighestDepth());
            _stage.tractorBeam_mc.swapDepths(_local_3);
            _stage.tractorBeam_mc._x = _local_3._x;
            _stage.tractorBeam_mc._y = _local_3._y - 1;
            aliendAbduction = new com.clubpenguin.world.rooms.aliens.AlienAbduction();
            aliendAbduction.abductPlayer(_local_4, _stage, this);
        }
        function abductedPlayerGoToUFO(player_id) {
            trace((CLASS_NAME + "abductedPlayerGoToUFO() - player_id !!!!!! : ") + player_id);
            _stage.tractorBeam_mc.removeMovieClip();
            if (_SHELL.isMyPlayer(player_id)) {
                trace("IS MY PLAYER - SEND JOIN ROOM");
                _global.getCurrentAirtower().removeListener("beamup", _abductionDelegate);
                _abductionDelegate = null;
                _SHELL.sendJoinRoom("ufo", 380, 320);
            }
        }
        function destroy() {
            trace(CLASS_NAME + ": destroy()");
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            clearInterval(_triggerWatcherInterval);
            wem.destroy();
            _global.getCurrentAirtower().removeListener("beamup", _abductionDelegate);
            _abductionDelegate = null;
        }
        static var CLASS_NAME = "Dock";
    }
