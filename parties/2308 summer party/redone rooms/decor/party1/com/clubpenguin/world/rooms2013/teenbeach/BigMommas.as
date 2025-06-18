//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2013.teenbeach.BigMommas extends com.clubpenguin.world.rooms.BaseRoom
    {
        var _stage, _SHELL, _triggerWatcher, _showMacBradyIntervalId, localize, _triggerWatcherInterval, _destroyDelegate, _liveEvent, _onBuyInventoryDelegate, _playersOnStage, _stageBlockTrigger, _INTERFACE, setupNavigationButtons, _concert, _concertCountdownTimer, _ENGINE;
        function BigMommas (stageReference) {
            super(stageReference);
            trace(CLASS_NAME + "()");
            _stage.start_x = 350;
            _stage.start_y = 275;
            if (!_SHELL) {
                init();
            }
        }
        function init() {
            trace(CLASS_NAME + ": init()");
			_liveEvent = com.clubpenguin.util.Delegate.create(this, playConcert);
            _triggerWatcher = new com.clubpenguin.world.rooms.common.triggers.TriggerWatcher(_stage, _SHELL);
			_global.getCurrentAirtower().addListener("liveevent", _liveEvent);
            stopMacAndBrady();
            hideMacAndBrady();
            configureNavigation();
            configureTriggers();
            configureRoomElements();
            localize([_stage.foreground_mc.timer_mc.sign_mc.text_mc]);
            _stage.interface_mc.catalogue_btn.onRelease = com.clubpenguin.util.Delegate.create(com.clubpenguin.world.rooms2013.teenbeach.TeenBeachParty, com.clubpenguin.world.rooms2013.teenbeach.TeenBeachParty.instance.showCatalogue);
            clearInterval(_triggerWatcherInterval);
            _triggerWatcherInterval = setInterval(_triggerWatcher, "checkAllPlayers", 40);
            _destroyDelegate = com.clubpenguin.util.Delegate.create(this, destroy);
            _SHELL.addListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            _onBuyInventoryDelegate = com.clubpenguin.util.Delegate.create(this, checkBuyMacBradyGiveAwayItem);
            _SHELL.addListener(_SHELL.BUY_INVENTORY, _onBuyInventoryDelegate);
            _playersOnStage = new Array();
        }
		function playConcert() {
            addBlockLayerToStage();
            removeStageNavigation();
            removePenguinsFromStage();
            playStageShift();
            addMacAndBradyDelay();
		}
		function addMacAndBradyDelay() {
            if (_showMacBradyIntervalId != null) {
                trace("clearInterval");
                clearInterval(_showMacBradyIntervalId);
            }
            _showMacBradyIntervalId = setInterval(this, "addMacAndBrady", _showMacBradyIntervalInMilliseconds);
        }
        function addMacAndBrady() {
            showMacAndBrady();
            clearInterval(_showMacBradyIntervalId);
        }
        function configureTriggers() {
            _stage.triggers_mc.beach_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "forts", 410, 230);
            _stage.triggers_mc.backStage_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, goBackStage);
			_stage.triggers_mc.mascot_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, mascotTrigger);
            _stageBlockTrigger = new com.clubpenguin.world.rooms.common.triggers.PlayerWalkTrigger(_stage.triggers_mc.stageBlock_mc);
            _stageBlockTrigger.playersAdded.add(com.clubpenguin.util.Delegate.create(this, addPlayerToStageBlock));
            _stageBlockTrigger.playersRemoved.add(com.clubpenguin.util.Delegate.create(this, removePlayerFromStageBlock));
            _triggerWatcher.addTrigger(_stageBlockTrigger);
        }
		function mascotTrigger() {
			if(_SHELL.isPlayerMascotById(_SHELL.getMyPlayerId()) || _SHELL.playerModel.isPlayerModerator(_SHELL.getMyPlayerId())) {
				_ENGINE.sendJoinRoom("party2", 250, 100);
			}
		}
        function goBackStage() {
            trace(CLASS_NAME + "::goBackStage()");
            if (!_SHELL.isMyPlayerMember()) {
                _INTERFACE.showContent(com.clubpenguin.world.rooms2013.teenbeach.TeenBeachParty.OOPS_BACKSTAGE);
                com.clubpenguin.world.rooms2013.teenbeach.TeenBeachParty.instance.opcodeJournal.sendOpcode(com.clubpenguin.world.rooms2013.teenbeach.OpcodeJournal.BACK_STAGE_OOPS);
            } else {
                _SHELL.sendJoinRoom("party2", 300, 330);
            }
        }
        function addPlayerToStageBlock(players) {
            var _local_2 = 0;
            while (_local_2 < players.length) {
                _playersOnStage.push(Number(players[_local_2]));
                _local_2++;
            }
        }
        function removePlayerFromStageBlock(players) {
            var _local_3 = 0;
            while (_local_3 < _playersOnStage.length) {
                var _local_2 = 0;
                while (_local_2 < players.length) {
                    if (_playersOnStage[_local_3] == players[_local_2]) {
                        _playersOnStage.splice(_local_3, 1);
                        _local_3--;
                    }
                    _local_2++;
                }
                _local_3++;
            }
        }
        function configureNavigation() {
            setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.beach_btn, 370, 425), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.backStage_btn, 385, 140), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.seatA_btn, 207, 235), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.seatB_btn, 194, 270), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.seatC_btn, 175, 310), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.seatD_btn, 190, 355), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.seatE_btn, 290, 355), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.seatF_btn, 270, 260), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.seatG_btn, 370, 260), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.seatH_btn, 700, 217), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.seatI_btn, 720, 306)]);
        }
        function removeStageNavigation() {
            _stage.seatH_btn._visible = false;
            _stage.seatI_btn._visible = false;
        }
        function addBackStageNavigation() {
            _stage.seatH_btn._visible = true;
            _stage.seatI_btn._visible = true;
        }
        function startRoomMusic() {
            _SHELL.startRoomMusic();
        }
        function stopRoomMusic() {
            _SHELL.stopMusic();
        }
        function configureRoomElements() {
            _stage.block_mc._visible = false;
            _stage.triggers_mc._visible = false;
            _stage.mac_btn.onRelease = com.clubpenguin.util.Delegate.create(com.clubpenguin.world.rooms2013.teenbeach.TeenBeachParty, com.clubpenguin.world.rooms2013.teenbeach.TeenBeachParty.instance.collectMacAndBradyGiveAway);
            _stage.brady_btn.onRelease = com.clubpenguin.util.Delegate.create(com.clubpenguin.world.rooms2013.teenbeach.TeenBeachParty, com.clubpenguin.world.rooms2013.teenbeach.TeenBeachParty.instance.collectMacAndBradyGiveAway);
        }
        function initConcert() {
            trace(CLASS_NAME + "::initConcert()");
            if (_concert != null) {
                return(undefined);
            }
        }
        function playStageShift() {
            _stage.curtain_mc.play();
            _stage.guitar_mc.play();
            _stage.drumA_mc.play();
            _stage.drumB_mc.play();
            _stage.drumBase_mc.play();
            _stage.stoolA_mc.play();
            _stage.stoolB_mc.play();
            _stage.keyboard_mc.play();
            _stage.mic_mc.play();
        }
        function removeItemsFromStage(forceRemove) {
            trace(((CLASS_NAME + "::removeItemsFromStage(") + forceRemove) + ")");
            var _local_2 = 1;
            if (forceRemove) {
                _local_2 = 50;
            }
            trace((CLASS_NAME + "::frameNumber: ") + _local_2);
            _stage.guitar_mc.gotoAndPlay(_local_2);
            _stage.drumA_mc.gotoAndPlay(_local_2);
            _stage.drumB_mc.gotoAndPlay(_local_2);
            _stage.drumBase_mc.gotoAndPlay(_local_2);
            _stage.stoolA_mc.gotoAndPlay(_local_2);
            _stage.stoolB_mc.gotoAndPlay(_local_2);
            _stage.keyboard_mc.gotoAndPlay(_local_2);
            _stage.mic_mc.gotoAndPlay(_local_2);
        }
        function addItemsToStage() {
            trace(CLASS_NAME + "::addItemsToStage()");
            _stage.guitar_mc.gotoAndPlay(51);
            _stage.drumA_mc.gotoAndPlay(51);
            _stage.drumB_mc.gotoAndPlay(51);
            _stage.drumBase_mc.gotoAndPlay(51);
            _stage.stoolA_mc.gotoAndPlay(51);
            _stage.stoolB_mc.gotoAndPlay(51);
            _stage.keyboard_mc.gotoAndPlay(51);
            _stage.mic_mc.gotoAndPlay(51);
        }
        function forceAddInstrumentsToStage() {
            trace(CLASS_NAME + "::forceAddInstrumentsToStage()");
            _stage.guitar_mc.gotoAndStop(1);
            _stage.drumA_mc.gotoAndStop(1);
            _stage.drumB_mc.gotoAndStop(1);
            _stage.drumBase_mc.gotoAndStop(1);
            _stage.stoolA_mc.gotoAndStop(1);
            _stage.stoolB_mc.gotoAndStop(1);
            _stage.keyboard_mc.gotoAndStop(1);
            _stage.mic_mc.gotoAndStop(1);
        }
        function postConcertStageItems() {
            _stage.curtain_mc.play();
            addItemsToStage(false);
        }
        function addBlockLayerToStage() {
            trace(CLASS_NAME + "::addBlockLayerToStage()");
            _stage.block_mc.gotoAndStop("closed");
        }
        function removeBlockLayerFromStage() {
            trace(CLASS_NAME + "::removeBlockLayerFromStage()");
            _stage.block_mc.gotoAndStop("open");
        }
        function removePenguinsFromStage() {
            trace((CLASS_NAME + "::removePenguinsFromStage():_playersOnStage:") + _playersOnStage);
            var _local_5 = _SHELL.playerModel.getPlayerList();
            var _local_2 = 0;
            while (_local_2 < _local_5.length) {
                var _local_4 = _local_5[_local_2].player_id;
                var _local_3 = _ENGINE.getPlayerMovieClip(_local_4);
                if ((_local_3._x > 530) && (_local_3._y > 160)) {
                    _ENGINE.teleportPlayer(_local_4, _stage.start_x, _stage.start_y);
                }
                _local_2++;
            }
        }
        function updateCountdown() {
            trace(CLASS_NAME + "::updateCountdown()");
            com.clubpenguin.world.rooms2013.teenbeach.TeenBeachParty.instance.updateCountdownDisplay(_concertCountdownTimer, _stage.foreground_mc.timer_mc.sign_mc.digit0, _stage.foreground_mc.timer_mc.sign_mc.digit1);
        }
        function resetCountdown() {
            trace(CLASS_NAME + "::resetCountdown()");
            com.clubpenguin.world.rooms2013.teenbeach.TeenBeachParty.instance.resetConcertStartTime();
        }
        function showMacAndBrady() {
            _stage.mac_and_brady_mc._visible = true;
            _stage.mac_btn._visible = !com.clubpenguin.world.rooms2013.teenbeach.TeenBeachParty.instance.hasMacAndBradyGiveAway();
            _stage.brady_btn._visible = _stage.mac_btn._visible;
        }
        function hideMacAndBrady() {
            _stage.mac_and_brady_mc._visible = false;
            _stage.mac_btn._visible = false;
            _stage.brady_btn._visible = false;
        }
        function startMacAndBrady(frameNumber) {
            _stage.mac_and_brady_mc.gotoAndPlay(frameNumber);
        }
        function stopMacAndBrady() {
            _stage.mac_and_brady_mc.gotoAndStop(1);
        }
        function totalMacAndBradyFrames() {
            return(_stage.mac_and_brady_mc._totalframes);
        }
        function checkBuyMacBradyGiveAwayItem(event) {
            if (event.success && (event.item_id == com.clubpenguin.world.rooms2013.teenbeach.TeenBeachParty.MAC_AND_BRADY_GIVEAWAY_ITEM_ID)) {
                _stage.mac_btn._visible = false;
                _stage.brady_btn._visible = false;
            }
        }
        function exit(roomName, x, y) {
            trace(CLASS_NAME + ": exit()");
            _SHELL.sendJoinRoom(roomName, x, y);
        }
        function destroy() {
            trace(CLASS_NAME + ": destroy()");
            _concert.destroy();
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            _SHELL.removeListener(_SHELL.BUY_INVENTORY, _onBuyInventoryDelegate);
			_global.getCurrentAirtower().removeListener("liveevent", _liveEvent);
            com.clubpenguin.world.rooms2013.teenbeach.TeenBeachParty.instance.countdownSignal.remove(initConcert, this);
        }
        static var CLASS_NAME = "BigMommas";
		var _showMacBradyIntervalInMilliseconds = 2000;
    }
