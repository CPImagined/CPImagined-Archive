//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms.Skatepark extends com.clubpenguin.world.rooms.BaseRoom
    {
        var _stage, _SHELL, localize, _destroyDelegate, _handlePlayerMoveDelegate, _triggerWatcher, _skateTrickCounts, _triggerWatcherInterval, wem, _joinRoomDelegate, _ENGINE, _abductionDelegate, aliendAbduction, setupNavigationButtons, _lowerSkate, _lowerSkateDelegate, _railSkate, _railSkateDelegate, _railBench, _railBenchDelegate, _railLow, _railLowDelegate, _enterPipe1L, _enterPipe1LDelegate, _enterPipe1R, _enterPipe1RDelegate, _enterPipe2L, _enterPipe2LDelegate, _enterPipe2R, _enterPipe2RDelegate, _enterPipe3L, _enterPipe3LDelegate, _enterPipe3R, _enterPipe3RDelegate, _enterPipe4L, _enterPipe4LDelegate, _enterPipe4R, _enterPipe4RDelegate, _halfpipe1, _halfpipe1Delegate, _halfpipe2, _halfpipe2Delegate, _halfpipe3, _halfpipe3Delegate, _halfpipe4, _halfpipe4Delegate, _penguinSlideDelegate, _lowerSkateTrigger, _railSkateTrigger, _railBenchTrigger, _railLowTrigger, _halfPipe1_LTrigger, _halfPipe1_RTrigger, _halfPipe2_LTrigger, _halfPipe2_RTrigger, _halfPipe3_LTrigger, _halfPipe3_RTrigger, _halfPipe4_LTrigger, _halfPipe4_RTrigger;
        function Skatepark (stageReference) {
            super(stageReference);
            _stage.start_x = 130;
            _stage.start_y = 170;
            if (!_SHELL) {
                init();
            }
            localize([_stage.interface_mc.sports_mc]);
        }
        function init() {
            _destroyDelegate = com.clubpenguin.util.Delegate.create(this, destroy);
            _handlePlayerMoveDelegate = com.clubpenguin.util.Delegate.create(this, handlePlayerMove);
            _SHELL.addListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            _SHELL.addListener(_SHELL.PLAYER_MOVE, _handlePlayerMoveDelegate);
            _triggerWatcher = new com.clubpenguin.world.rooms.common.triggers.TriggerWatcher(_stage, _SHELL);
            _skateTrickCounts = new Object();
            configureNavigation();
            configureTriggers();
            configureRoomElements();
            configureSlideTriggers();
            configureSlideSettings();
            clearInterval(_triggerWatcherInterval);
            _triggerWatcherInterval = setInterval(_triggerWatcher, "checkAllPlayers", 40);
            wem = new com.clubpenguin.world.rooms.weathereffects.WeatherEffectsManager(_SHELL, _stage.background_mc);
            wem.setupFireAnimationHeight(60);
            wem.setupRainAnimationHeight(85);
            wem.setupSnowAnimationHeight(85);
            wem.setupRainAnimationSpeed(0.5);
            wem.setupSnowAnimationSpeed(1);
            wem.setupRainDelayTime(2);
            wem.setupSnowDelayTime(2);
            wem.startWeatherEffectCheck();
            _stage.block_mc.gotoAndStop(2);
            _stage.blockSkyButton.useHandCursor = false;
            _joinRoomDelegate = com.clubpenguin.util.Delegate.create(this, handleJoinRoom);
            _ENGINE.penguinTransformComplete.add(_joinRoomDelegate);
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
        function configureNavigation() {
            setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.shackExit_btn, 80, 150), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.catalog_btn, 155, 130)]);
        }
        function configureTriggers() {
            _stage.triggers_mc.shack_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "shack", 550, 275);
        }
        function configureRoomElements() {
            _stage.block_mc._visible = false;
            _stage.triggers_mc._visible = false;
            _stage.touchTriggers_mc._visible = false;
            _stage.shackExit_btn.useHandCursor = false;
            _stage.catalog_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, catalogRollOver);
            _stage.catalog_btn.onRollOut = com.clubpenguin.util.Delegate.create(this, catalogRollOut);
            _stage.catalog_btn.onReleaseOutside = com.clubpenguin.util.Delegate.create(this, catalogRollOut);
            _stage.catalog_btn.onRelease = com.clubpenguin.util.Delegate.create(this, openPigfarmCatalog);
            _stage.interface_mc.sports_mc.sports_btn.onRelease = com.clubpenguin.util.Delegate.create(this, openPigfarmCatalog);
        }
        function openPigfarmCatalog() {
            var _local_2 = {catalogType:"catalog_sports"};
            _SHELL.sendOpenAS3Module(com.clubpenguin.modules.AS3ModuleConstants.PIGFARM_CATALOG, _local_2, {blockPuffleNotifications:true});
        }
        function configureSlideSettings() {
            _lowerSkate = new com.clubpenguin.world.rooms.common.slide.ConveyorBeltPuffleStay();
            _lowerSkate.registerFrameTrigger(10, com.clubpenguin.util.Delegate.create(this, playSkateSFX_LowerSkate), true);
            _lowerSkateDelegate = com.clubpenguin.util.Delegate.create(this, handleLowerSkate);
            _lowerSkate.endOfConveyorBeltReached.add(_lowerSkateDelegate, this);
            _railSkate = new com.clubpenguin.world.rooms.common.slide.ConveyorBeltPuffleStay();
            _railSkate.registerFrameTrigger(2, com.clubpenguin.util.Delegate.create(this, playSkateSFX_Rail_1), true);
            _railSkateDelegate = com.clubpenguin.util.Delegate.create(this, handleRailSkate);
            _railSkate.endOfConveyorBeltReached.add(_railSkateDelegate, this);
            _railBench = new com.clubpenguin.world.rooms.common.slide.ConveyorBeltPuffleStay();
            _railBench.registerFrameTrigger(2, com.clubpenguin.util.Delegate.create(this, playSkateSFX_Rail_3), true);
            _railBenchDelegate = com.clubpenguin.util.Delegate.create(this, handleRailBench);
            _railBench.endOfConveyorBeltReached.add(_railBenchDelegate, this);
            _railLow = new com.clubpenguin.world.rooms.common.slide.ConveyorBeltPuffleStay();
            _railLow.registerFrameTrigger(2, com.clubpenguin.util.Delegate.create(this, playSkateSFX_Rail_2), true);
            _railLowDelegate = com.clubpenguin.util.Delegate.create(this, handleRailLow);
            _railLow.endOfConveyorBeltReached.add(_railLowDelegate, this);
            _enterPipe1L = new com.clubpenguin.world.rooms.common.slide.ConveyorBeltPuffleStay();
            _enterPipe1L.registerFrameTrigger(2, com.clubpenguin.util.Delegate.create(this, playSkateSFX_Halfpipe_In), true);
            _enterPipe1LDelegate = com.clubpenguin.util.Delegate.create(this, handleEnterRamp1L);
            _enterPipe1L.endOfConveyorBeltReached.add(_enterPipe1LDelegate, this);
            _enterPipe1R = new com.clubpenguin.world.rooms.common.slide.ConveyorBeltPuffleStay();
            _enterPipe1R.registerFrameTrigger(2, com.clubpenguin.util.Delegate.create(this, playSkateSFX_Halfpipe_In), true);
            _enterPipe1RDelegate = com.clubpenguin.util.Delegate.create(this, handleEnterRamp1R);
            _enterPipe1R.endOfConveyorBeltReached.add(_enterPipe1RDelegate, this);
            _enterPipe2L = new com.clubpenguin.world.rooms.common.slide.ConveyorBeltPuffleStay();
            _enterPipe2L.registerFrameTrigger(2, com.clubpenguin.util.Delegate.create(this, playSkateSFX_Halfpipe_In), true);
            _enterPipe2LDelegate = com.clubpenguin.util.Delegate.create(this, handleEnterRamp2L);
            _enterPipe2L.endOfConveyorBeltReached.add(_enterPipe2LDelegate, this);
            _enterPipe2R = new com.clubpenguin.world.rooms.common.slide.ConveyorBeltPuffleStay();
            _enterPipe2R.registerFrameTrigger(2, com.clubpenguin.util.Delegate.create(this, playSkateSFX_Halfpipe_In), true);
            _enterPipe2RDelegate = com.clubpenguin.util.Delegate.create(this, handleEnterRamp2R);
            _enterPipe2R.endOfConveyorBeltReached.add(_enterPipe2RDelegate, this);
            _enterPipe3L = new com.clubpenguin.world.rooms.common.slide.ConveyorBeltPuffleStay();
            _enterPipe3L.registerFrameTrigger(2, com.clubpenguin.util.Delegate.create(this, playSkateSFX_Halfpipe_In), true);
            _enterPipe3LDelegate = com.clubpenguin.util.Delegate.create(this, handleEnterRamp3L);
            _enterPipe3L.endOfConveyorBeltReached.add(_enterPipe3LDelegate, this);
            _enterPipe3R = new com.clubpenguin.world.rooms.common.slide.ConveyorBeltPuffleStay();
            _enterPipe3R.registerFrameTrigger(2, com.clubpenguin.util.Delegate.create(this, playSkateSFX_Halfpipe_In), true);
            _enterPipe3RDelegate = com.clubpenguin.util.Delegate.create(this, handleEnterRamp3R);
            _enterPipe3R.endOfConveyorBeltReached.add(_enterPipe3RDelegate, this);
            _enterPipe4L = new com.clubpenguin.world.rooms.common.slide.ConveyorBeltPuffleStay();
            _enterPipe4L.registerFrameTrigger(2, com.clubpenguin.util.Delegate.create(this, playSkateSFX_Halfpipe_In), true);
            _enterPipe4LDelegate = com.clubpenguin.util.Delegate.create(this, handleEnterRamp4L);
            _enterPipe4L.endOfConveyorBeltReached.add(_enterPipe4LDelegate, this);
            _enterPipe4R = new com.clubpenguin.world.rooms.common.slide.ConveyorBeltPuffleStay();
            _enterPipe4R.registerFrameTrigger(2, com.clubpenguin.util.Delegate.create(this, playSkateSFX_Halfpipe_In), true);
            _enterPipe4RDelegate = com.clubpenguin.util.Delegate.create(this, handleEnterRamp4R);
            _enterPipe4R.endOfConveyorBeltReached.add(_enterPipe4RDelegate, this);
            _halfpipe1 = new com.clubpenguin.world.rooms.common.slide.ConveyorBeltLoop(_stage.slide_container);
            _halfpipe1.registerFrameTrigger(2, com.clubpenguin.util.Delegate.create(this, playSkateSFX_Halfpipe_Roll), true);
            _halfpipe1.registerFrameTrigger(18, com.clubpenguin.util.Delegate.create(this, playSkateSFX_Halfpipe_Jump), true);
            _halfpipe1Delegate = com.clubpenguin.util.Delegate.create(this, handleExitHalfpipe);
            _halfpipe1.endOfConveyorBeltReached.add(_halfpipe1Delegate, this);
            _halfpipe1.addConveyorBelt("skate_slide_2", _stage.triggers_mc.trigger_halfpipe_1l);
            _halfpipe1.addConveyorBelt("skate_slide_3", _stage.triggers_mc.trigger_halfpipe_1r);
            _halfpipe2 = new com.clubpenguin.world.rooms.common.slide.ConveyorBeltLoop(_stage.slide_container);
            _halfpipe2.registerFrameTrigger(2, com.clubpenguin.util.Delegate.create(this, playSkateSFX_Halfpipe_Roll), true);
            _halfpipe2.registerFrameTrigger(18, com.clubpenguin.util.Delegate.create(this, playSkateSFX_Halfpipe_Jump), true);
            _halfpipe2Delegate = com.clubpenguin.util.Delegate.create(this, handleExitHalfpipe);
            _halfpipe2.endOfConveyorBeltReached.add(_halfpipe2Delegate, this);
            _halfpipe2.addConveyorBelt("skate_slide_4", _stage.triggers_mc.trigger_halfpipe_2l);
            _halfpipe2.addConveyorBelt("skate_slide_5", _stage.triggers_mc.trigger_halfpipe_2r);
            _halfpipe3 = new com.clubpenguin.world.rooms.common.slide.ConveyorBeltLoop(_stage.slide_container);
            _halfpipe3.registerFrameTrigger(2, com.clubpenguin.util.Delegate.create(this, playSkateSFX_Halfpipe_Roll), true);
            _halfpipe3.registerFrameTrigger(18, com.clubpenguin.util.Delegate.create(this, playSkateSFX_Halfpipe_Jump), true);
            _halfpipe3Delegate = com.clubpenguin.util.Delegate.create(this, handleExitHalfpipe);
            _halfpipe3.endOfConveyorBeltReached.add(_halfpipe3Delegate, this);
            _halfpipe3.addConveyorBelt("skate_slide_6", _stage.triggers_mc.trigger_halfpipe_3l);
            _halfpipe3.addConveyorBelt("skate_slide_7", _stage.triggers_mc.trigger_halfpipe_3r);
            _halfpipe4 = new com.clubpenguin.world.rooms.common.slide.ConveyorBeltLoop(_stage.slide_container);
            _halfpipe4.registerFrameTrigger(2, com.clubpenguin.util.Delegate.create(this, playSkateSFX_Halfpipe_Roll), true);
            _halfpipe4.registerFrameTrigger(18, com.clubpenguin.util.Delegate.create(this, playSkateSFX_Halfpipe_Jump), true);
            _halfpipe4Delegate = com.clubpenguin.util.Delegate.create(this, handleExitHalfpipe);
            _halfpipe4.endOfConveyorBeltReached.add(_halfpipe4Delegate, this);
            _halfpipe4.addConveyorBelt("skate_slide_8", _stage.triggers_mc.trigger_halfpipe_4l);
            _halfpipe4.addConveyorBelt("skate_slide_9", _stage.triggers_mc.trigger_halfpipe_4r);
        }
        function configureSlideTriggers() {
            _penguinSlideDelegate = com.clubpenguin.util.Delegate.create(this, handlePenguinSlides);
            _global.getCurrentAirtower().addListener(SLIDE_COMMAND, _penguinSlideDelegate);
            _lowerSkateTrigger = new com.clubpenguin.world.rooms.common.triggers.PlayerTrigger(_stage.triggers_mc._lowerSkateTrigger);
            setPlayerTriggerRequirements(_lowerSkateTrigger);
            _lowerSkateTrigger.playersAdded.add(com.clubpenguin.util.Delegate.create(this, sendAddPlayerToLower));
            _triggerWatcher.addTrigger(_lowerSkateTrigger);
            _railSkateTrigger = new com.clubpenguin.world.rooms.common.triggers.PlayerTrigger(_stage.triggers_mc._railSkateTrigger);
            setPlayerTriggerRequirements(_railSkateTrigger);
            _railSkateTrigger.playersAdded.add(com.clubpenguin.util.Delegate.create(this, sendAddPlayerToRail));
            _triggerWatcher.addTrigger(_railSkateTrigger);
            _railBenchTrigger = new com.clubpenguin.world.rooms.common.triggers.PlayerTrigger(_stage.triggers_mc._railBenchTrigger);
            setPlayerTriggerRequirements(_railSkateTrigger);
            _railBenchTrigger.playersAdded.add(com.clubpenguin.util.Delegate.create(this, sendAddPlayerToRailBench));
            _triggerWatcher.addTrigger(_railBenchTrigger);
            _railLowTrigger = new com.clubpenguin.world.rooms.common.triggers.PlayerTrigger(_stage.triggers_mc._railLowTrigger);
            setPlayerTriggerRequirements(_railSkateTrigger);
            _railLowTrigger.playersAdded.add(com.clubpenguin.util.Delegate.create(this, sendAddPlayerToRailLow));
            _halfPipe1_LTrigger = new com.clubpenguin.world.rooms.common.triggers.PlayerTrigger(_stage.triggers_mc.trigger_halfpipe_1l);
            setPlayerTriggerRequirements(_halfPipe1_LTrigger);
            _halfPipe1_LTrigger.playersAdded.add(com.clubpenguin.util.Delegate.create(this, sendAddPlayerToHP1L));
            _triggerWatcher.addTrigger(_halfPipe1_LTrigger);
            _halfPipe1_RTrigger = new com.clubpenguin.world.rooms.common.triggers.PlayerTrigger(_stage.triggers_mc.trigger_halfpipe_1r);
            setPlayerTriggerRequirements(_halfPipe1_RTrigger);
            _halfPipe1_RTrigger.playersAdded.add(com.clubpenguin.util.Delegate.create(this, sendAddPlayerToHP1R));
            _triggerWatcher.addTrigger(_halfPipe1_RTrigger);
            _halfPipe2_LTrigger = new com.clubpenguin.world.rooms.common.triggers.PlayerTrigger(_stage.triggers_mc.trigger_halfpipe_2l);
            setPlayerTriggerRequirements(_halfPipe2_LTrigger);
            _halfPipe2_LTrigger.playersAdded.add(com.clubpenguin.util.Delegate.create(this, sendAddPlayerToHP2L));
            _triggerWatcher.addTrigger(_halfPipe2_LTrigger);
            _halfPipe2_RTrigger = new com.clubpenguin.world.rooms.common.triggers.PlayerTrigger(_stage.triggers_mc.trigger_halfpipe_2r);
            setPlayerTriggerRequirements(_halfPipe2_RTrigger);
            _halfPipe2_RTrigger.playersAdded.add(com.clubpenguin.util.Delegate.create(this, sendAddPlayerToHP2R));
            _triggerWatcher.addTrigger(_halfPipe2_RTrigger);
            _halfPipe3_LTrigger = new com.clubpenguin.world.rooms.common.triggers.PlayerTrigger(_stage.triggers_mc.trigger_halfpipe_3l);
            setPlayerTriggerRequirements(_halfPipe3_LTrigger);
            _halfPipe3_LTrigger.playersAdded.add(com.clubpenguin.util.Delegate.create(this, sendAddPlayerToHP3L));
            _triggerWatcher.addTrigger(_halfPipe3_LTrigger);
            _halfPipe3_RTrigger = new com.clubpenguin.world.rooms.common.triggers.PlayerTrigger(_stage.triggers_mc.trigger_halfpipe_3r);
            setPlayerTriggerRequirements(_halfPipe3_RTrigger);
            _halfPipe3_RTrigger.playersAdded.add(com.clubpenguin.util.Delegate.create(this, sendAddPlayerToHP3R));
            _triggerWatcher.addTrigger(_halfPipe3_RTrigger);
            _halfPipe4_LTrigger = new com.clubpenguin.world.rooms.common.triggers.PlayerTrigger(_stage.triggers_mc.trigger_halfpipe_4l);
            setPlayerTriggerRequirements(_halfPipe4_LTrigger);
            _halfPipe4_LTrigger.playersAdded.add(com.clubpenguin.util.Delegate.create(this, sendAddPlayerToHP4L));
            _triggerWatcher.addTrigger(_halfPipe4_LTrigger);
            _halfPipe4_RTrigger = new com.clubpenguin.world.rooms.common.triggers.PlayerTrigger(_stage.triggers_mc.trigger_halfpipe_4r);
            setPlayerTriggerRequirements(_halfPipe4_RTrigger);
            _halfPipe4_RTrigger.playersAdded.add(com.clubpenguin.util.Delegate.create(this, sendAddPlayerToHP4R));
            _triggerWatcher.addTrigger(_halfPipe4_RTrigger);
        }
        function setPlayerTriggerRequirements(trigger) {
            trigger.addClothingRequirement("hand", com.clubpenguin.world.rooms.common.skateboard.SkateboardConstants.SKATEBOARD_IDS);
        }
        function handlePenguinSlides(data) {
            var _local_2 = Number(data[1]);
            var _local_3 = Number(data[2]);
            if (_local_2 == _SHELL.getMyPlayerId()) {
                trackSkateTrick(_local_3);
            }
            switch (_local_3) {
                case 0 : 
                    _lowerSkate.addPenguintoConveyorPather("skate_slide_" + _local_3, _local_2, _stage.slide_container, true);
                    break;
                case 1 : 
                    _railSkate.addPenguintoConveyorPather("skate_slide_" + _local_3, _local_2, _stage.slide_container, true);
                    break;
                case 2 : 
                    _enterPipe1L.addPenguintoConveyorPather("skate_slide_10", _local_2, _stage.slide_container, false);
                    break;
                case 3 : 
                    _enterPipe1R.addPenguintoConveyorPather("skate_slide_11", _local_2, _stage.slide_container, false);
                    break;
                case 4 : 
                    _enterPipe2L.addPenguintoConveyorPather("skate_slide_12", _local_2, _stage.slide_container, false);
                    break;
                case 5 : 
                    _enterPipe2R.addPenguintoConveyorPather("skate_slide_13", _local_2, _stage.slide_container, false);
                    break;
                case 6 : 
                    _enterPipe3L.addPenguintoConveyorPather("skate_slide_14", _local_2, _stage.slide_container, false);
                    break;
                case 7 : 
                    _enterPipe3R.addPenguintoConveyorPather("skate_slide_15", _local_2, _stage.slide_container, false);
                    break;
                case 8 : 
                    _enterPipe4L.addPenguintoConveyorPather("skate_slide_16", _local_2, _stage.slide_container, false);
                    break;
                case 9 : 
                    _enterPipe4R.addPenguintoConveyorPather("skate_slide_17", _local_2, _stage.slide_container, false);
                    break;
                case 18 : 
                    _railLow.addPenguintoConveyorPather("skate_slide_" + _local_3, _local_2, _stage.slide_container, true);
                    break;
                case 19 : 
                    _railBench.addPenguintoConveyorPather("skate_slide_" + _local_3, _local_2, _stage.slide_container, true);
                    break;
            }
            data = null;
        }
        function catalogRollOver() {
            _stage.catalog_mc.gotoAndStop(2);
        }
        function catalogRollOut() {
            _stage.catalog_mc.gotoAndStop(1);
        }
        function exit(roomName, x, y) {
            _SHELL.sendJoinRoom(roomName, x, y);
        }
        function destroy() {
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            clearInterval(_triggerWatcherInterval);
            _SHELL.removeListener(_SHELL.PLAYER_MOVE, _handlePlayerMoveDelegate);
            _global.getCurrentAirtower().removeListener(SLIDE_COMMAND, _penguinSlideDelegate);
            _ENGINE.penguinTransformComplete.remove(_joinRoomDelegate);
            var _local_3 = _ENGINE.puffleAvatarController.getPuffleAvatar(_SHELL.getPlayerObjectById(_SHELL.getMyPlayerId()).attachedPuffle.id);
            _local_3.startPuffleUpdates();
            _global.getCurrentAirtower().removeListener("beamup", _abductionDelegate);
            _abductionDelegate = null;
        }
        function sendAddPlayerToLower(players) {
            sendAddPlayerToSlide(players, 0);
        }
        function sendAddPlayerToRail(players) {
            sendAddPlayerToSlide(players, 1);
        }
        function sendAddPlayerToRailBench(players) {
            sendAddPlayerToSlide(players, 19);
        }
        function sendAddPlayerToRailLow(players) {
            sendAddPlayerToSlide(players, 18);
        }
        function sendAddPlayerToHP1L(players) {
            sendAddPlayerToSlide(players, 2);
        }
        function sendAddPlayerToHP1R(players) {
            sendAddPlayerToSlide(players, 3);
        }
        function sendAddPlayerToHP2L(players) {
            sendAddPlayerToSlide(players, 4);
        }
        function sendAddPlayerToHP2R(players) {
            sendAddPlayerToSlide(players, 5);
        }
        function sendAddPlayerToHP3L(players) {
            sendAddPlayerToSlide(players, 6);
        }
        function sendAddPlayerToHP3R(players) {
            sendAddPlayerToSlide(players, 7);
        }
        function sendAddPlayerToHP4L(players) {
            sendAddPlayerToSlide(players, 8);
        }
        function sendAddPlayerToHP4R(players) {
            sendAddPlayerToSlide(players, 9);
        }
        function sendAddPlayerToSlide(players, slideNumber) {
            var _local_3 = 0;
            while (_local_3 < players.length) {
                if (players[_local_3] == _SHELL.getMyPlayerId()) {
                    if (isPlayerOnHalfPipe(_SHELL.getMyPlayerId()) == true) {
                        return(undefined);
                    }
                    _SHELL.getPlayerObjectById(players[_local_3]).isUsingSlide = true;
                    var _local_4 = _global.getCurrentAirtower();
                    _local_4.send(_local_4.PLAY_EXT, "u#" + SLIDE_COMMAND, [slideNumber], "str", _SHELL.getCurrentServerRoomId());
                }
                _local_3++;
            }
        }
        function handleLowerSkate(playerID) {
            if (playerID == null) {
                return(undefined);
            }
        }
        function handleRailSkate(playerID) {
            if (playerID == null) {
                return(undefined);
            }
        }
        function handleRailLow(playerID) {
            if (playerID == null) {
                return(undefined);
            }
        }
        function handleRailBench(playerID) {
            if (playerID == null) {
                return(undefined);
            }
        }
        function handleEnterRamp1L(playerID) {
            if (playerID == null) {
                return(undefined);
            }
            _halfpipe1.addPenguintoConveyorPather("skate_slide_2", playerID);
        }
        function handleEnterRamp1R(playerID) {
            if (playerID == null) {
                return(undefined);
            }
            _halfpipe1.addPenguintoConveyorPather("skate_slide_3", playerID);
        }
        function handleEnterRamp2L(playerID) {
            if (playerID == null) {
                return(undefined);
            }
            _halfpipe2.addPenguintoConveyorPather("skate_slide_4", playerID);
        }
        function handleEnterRamp2R(playerID) {
            if (playerID == null) {
                return(undefined);
            }
            _halfpipe2.addPenguintoConveyorPather("skate_slide_5", playerID);
        }
        function handleEnterRamp3L(playerID) {
            if (playerID == null) {
                return(undefined);
            }
            _halfpipe3.addPenguintoConveyorPather("skate_slide_6", playerID);
        }
        function handleEnterRamp3R(playerID) {
            if (playerID == null) {
                return(undefined);
            }
            _halfpipe3.addPenguintoConveyorPather("skate_slide_7", playerID);
        }
        function handleEnterRamp4L(playerID) {
            if (playerID == null) {
                return(undefined);
            }
            _halfpipe4.addPenguintoConveyorPather("skate_slide_8", playerID);
        }
        function handleEnterRamp4R(playerID) {
            if (playerID == null) {
                return(undefined);
            }
            _halfpipe4.addPenguintoConveyorPather("skate_slide_9", playerID);
        }
        function handleExitHalfpipe(playerID) {
            if (playerID == _SHELL.getMyPlayerId()) {
                playSkateSFX_Halfpipe_Out();
            }
            var _local_2 = _ENGINE.getPlayerMovieClip(playerID);
            _local_2._rotation = 0;
        }
        function trackSkateTrick(slideNum) {
            var _local_2 = slideNumToBITrick(slideNum);
        }
        function handlePlayerMove(player_ob) {
            _halfpipe1.removePassenger(player_ob.player_id, player_ob.x, player_ob.y);
            _halfpipe2.removePassenger(player_ob.player_id, player_ob.x, player_ob.y);
            _halfpipe3.removePassenger(player_ob.player_id, player_ob.x, player_ob.y);
            _halfpipe4.removePassenger(player_ob.player_id, player_ob.x, player_ob.y);
        }
        function slideNumToBITrick(slideNum) {
            switch (slideNum) {
                case 0 : 
                    return("spine");
                case 1 : 
                    return("rail_skatepark_1");
                case 2 : 
                case 3 : 
                case 4 : 
                case 5 : 
                case 6 : 
                case 7 : 
                case 8 : 
                case 9 : 
                case 10 : 
                case 11 : 
                case 12 : 
                case 13 : 
                case 14 : 
                case 15 : 
                case 16 : 
                case 17 : 
                    return("halfpipe");
                case 18 : 
                    return("rail_skatepark_2");
                case 19 : 
                    return("rail_skatepark_3");
            }
            return("invalidslidenum");
        }
        function sendSkateTrickBI() {
            for (var _local_3 in _skateTrickCounts) {
                var _local_2 = _skateTrickCounts[_local_3];
            }
        }
        function playSkateSFX_LowerSkate() {
            var _local_2 = new Sound(_root);
            _local_2.attachSound("sfx_lowerskate");
            _local_2.start();
        }
        function playSkateSFX_Rail_1() {
            var _local_2 = new Sound(_stage);
            _local_2.attachSound("sfx_rail_1");
            _local_2.start();
        }
        function playSkateSFX_Rail_2() {
            var _local_2 = new Sound(_stage);
            _local_2.attachSound("sfx_rail_2");
            _local_2.start();
        }
        function playSkateSFX_Rail_3() {
            var _local_2 = new Sound(_stage);
            _local_2.attachSound("sfx_bench");
            _local_2.start();
        }
        function playSkateSFX_Halfpipe_In() {
            var _local_2 = new Sound(_stage);
            _local_2.attachSound("sfx_halfpipe_in_" + Math.ceil(Math.random() * 2));
            _local_2.start();
        }
        function playSkateSFX_Halfpipe_Jump() {
            var _local_2 = new Sound(_stage);
            _local_2.attachSound("sfx_halfpipe_jump_" + Math.ceil(Math.random() * 4));
            _local_2.start();
        }
        function playSkateSFX_Halfpipe_Roll() {
            var _local_2 = new Sound(_stage);
            _local_2.attachSound("sfx_halfpipe_roll_" + Math.ceil(Math.random() * 3));
            _local_2.start();
        }
        function playSkateSFX_Halfpipe_Out() {
            var _local_2 = new Sound(_stage);
            _local_2.attachSound("sfx_halfpipe_out_" + Math.ceil(Math.random() * 2));
            _local_2.start();
        }
        function handleJoinRoom(playerObj) {
            var _local_3 = _ENGINE.getPlayerMovieClip(playerObj.player_id);
            var _local_2 = 1;
            while (_local_2 <= 4) {
                if (_stage.triggers_mc[("trigger_halfpipe_" + _local_2) + "l"].hitTest(_local_3._x, _local_3._y, true)) {
                    handlePenguinSlides([0, playerObj.player_id, Number(_local_2 + 1)]);
                }
                if (_stage.triggers_mc[("trigger_halfpipe_" + _local_2) + "r"].hitTest(_local_3._x, _local_3._y, true)) {
                    handlePenguinSlides([0, playerObj.player_id, Number(_local_2 + 2)]);
                }
                _local_2++;
            }
        }
        function isPlayerOnHalfPipe(playerID) {
            if ((((_halfpipe1.currentPassengersIndex(playerID) != -1) || (_halfpipe2.currentPassengersIndex(playerID) != -1)) || (_halfpipe3.currentPassengersIndex(playerID) != -1)) || (_halfpipe4.currentPassengersIndex(playerID) != -1)) {
                return(true);
            }
            return(false);
        }
        static var CLASS_NAME = "Skatepark";
        static var SLIDE_COMMAND = "followpath";
    }
