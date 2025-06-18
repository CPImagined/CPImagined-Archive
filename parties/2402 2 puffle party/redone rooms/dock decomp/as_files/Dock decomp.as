//Created by Action Script Viewer - https://www.buraks.com/asv
    class as_files.Dock extends com.clubpenguin.world.rooms.BaseRoom
    {
        var _stage, _SHELL, _abductionDelegate, aliendAbduction, _destroyDelegate, _triggerWatcher, _currentParty, setupNavigationButtons, localize, _triggerWatcherInterval, _INTERFACE, _ENGINE, _feedStation_meat, _feedStation_carrots, _feedStationTrigger_meat, _feedStationTrigger_carrots;
        function Dock (stageReference) {
            super(stageReference);
            _stage.start_x = 320;
            _stage.start_y = 270;
            if (!_SHELL) {
                init();
            }
            _abductionDelegate = com.clubpenguin.util.Delegate.create(this, abductPenguin);
            _global.getCurrentAirtower().addListener("beamup", _abductionDelegate);
        }
        function abductPenguin(data) {
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
            _stage.tractorBeam_mc.removeMovieClip();
            if (_SHELL.isMyPlayer(player_id)) {
                _global.getCurrentAirtower().removeListener("beamup", _abductionDelegate);
                _abductionDelegate = null;
                _SHELL.sendJoinRoom("ufo", 380, 320);
            }
        }
        function init() {
            _destroyDelegate = com.clubpenguin.util.Delegate.create(this, destroy);
            _SHELL.addListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            _triggerWatcher = new com.clubpenguin.world.rooms.common.triggers.TriggerWatcher(_stage, _SHELL);
            _currentParty = _global.getCurrentParty().BaseParty.CURRENT_PARTY;
            _stage.triggers_mc.town_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "town", 175, 325);
            _stage.triggers_mc.beach_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "beach", 600, 180);
            setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.nav_town, 618, 137), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.nav_beach, 160, 140), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.boat_btn, 72, 390)]);
            _stage.triggers_mc.hydro_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, launchHydroGame);
            _stage.nav_town.useHandCursor = false;
            _stage.nav_beach.useHandCursor = false;
            _stage.background_mc.ticketbooth_btn.useHandCursor = false;
            _stage.foodveggies_btn.useHandCursor = false;
            _stage.foodveggies_btn.useHandCursor = false;
            _stage.interface_mc.dock_cat_btn.onRelease = com.clubpenguin.util.Delegate.create(this, showContent, "dock_catalogue");
            _stage.boat_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, showHydroHintRollOver);
            _stage.boat_btn.onRollOut = com.clubpenguin.util.Delegate.create(this, hideHydroHintRollOut);
            localize([_stage.foreground_mc.parktitle_mc]);
            clearInterval(_triggerWatcherInterval);
            _triggerWatcherInterval = setInterval(_triggerWatcher, "checkAllPlayers", 40);
            configureFeedingStationTriggers();
            configureHidingSpot();
        }
        function configureHidingSpot() {
            if (_currentParty.partyCookie.hasPlayerCompletedTask(BrownPuffleTaskId)) {
                _stage.puffle_hidingSpot01_mc.gotoAndStop(2);
                _stage.puffle_hidingSpot01_btn.useHandCursor = false;
                _stage.puffle_hidingSpot01_btn.onRelease = null;
            } else if (!_currentParty.isTaskAvailable(BrownPuffleTaskId)) {
                _stage.puffle_hidingSpot01_mc.gotoAndStop(1);
                _stage.puffle_hidingSpot01_mc.mc.gotoAndStop(1);
                _stage.puffle_hidingSpot01_btn.useHandCursor = false;
                _stage.puffle_hidingSpot01_btn.onRelease = null;
            } else {
                _stage.puffle_hidingSpot01_btn.onRelease = com.clubpenguin.util.Delegate.create(this, hidingSpot01Release);
            }
        }
        function showContent(contentID) {
            _INTERFACE.showContent(contentID);
        }
        function hidingSpot01Release() {
            _stage.puffle_hidingSpot01_mc.gotoAndStop(2);
            setTimeout(com.clubpenguin.util.Delegate.create(this, setTaskComplete), 3000);
            showCheckMark();
            _stage.puffle_hidingSpot01_btn.useHandCursor = false;
            _stage.puffle_hidingSpot01_btn.onRelease = null;
        }
        function setTaskComplete() {
            _currentParty.taskComplete(BrownPuffleTaskId);
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
        function showHydroHintRollOver() {
            _INTERFACE.showHint(_stage.hinthydro_mc, "hydro_hint");
            _stage.dock_mc.boat_mc.boathover_mc.gotoAndStop(2);
        }
        function hideHydroHintRollOut() {
            _INTERFACE.closeHint();
            _stage.dock_mc.boat_mc.boathover_mc.gotoAndStop(1);
        }
        function launchHydroGame() {
            _ENGINE.sendJoinGame("hydro", true);
        }
        function exit(roomName, x, y) {
            _SHELL.sendJoinRoom(roomName, x, y);
        }
        function destroy() {
            clearInterval(_triggerWatcherInterval);
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            _feedStation_meat.cleanStation();
            _feedStation_carrots.cleanStation();
            _global.getCurrentAirtower().removeListener("beamup", _abductionDelegate);
            _abductionDelegate = null;
        }
        function updateItemBoothState() {
            _global.getCurrentParty().PuffleParty.configureItemBooth(_stage.boothContainer_mc);
        }
        function configureFeedingStationTriggers() {
            _feedStation_meat = new com.clubpenguin.world.rooms.common.carestations.FeedingBowl(_stage.pufflefeeding_meat);
            _feedStation_carrots = new com.clubpenguin.world.rooms.common.carestations.FeedingBowl(_stage.pufflefeeding_carrots);
            _feedStationTrigger_meat = new com.clubpenguin.world.rooms.common.triggers.PlayerTrigger(_stage.triggers_mc.feedStation_meat_mc);
            _feedStationTrigger_meat.playersAdded.add(com.clubpenguin.util.Delegate.create(_feedStation_meat, _feedStation_meat.beginFeeding));
            _feedStationTrigger_meat.playersRemoved.add(com.clubpenguin.util.Delegate.create(_feedStation_meat, _feedStation_meat.endFeeding));
            _triggerWatcher.addTrigger(_feedStationTrigger_meat);
            _feedStationTrigger_carrots = new com.clubpenguin.world.rooms.common.triggers.PlayerTrigger(_stage.triggers_mc.feedStation_carrot_mc);
            _feedStationTrigger_carrots.playersAdded.add(com.clubpenguin.util.Delegate.create(_feedStation_carrots, _feedStation_carrots.beginFeeding));
            _feedStationTrigger_carrots.playersRemoved.add(com.clubpenguin.util.Delegate.create(_feedStation_carrots, _feedStation_carrots.endFeeding));
            _triggerWatcher.addTrigger(_feedStationTrigger_carrots);
        }
        static var CLASS_NAME = "Dock";
        static var BrownPuffleTaskId = 6;
    }
