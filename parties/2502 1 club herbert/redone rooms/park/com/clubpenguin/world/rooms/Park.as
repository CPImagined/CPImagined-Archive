//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms.Park extends com.clubpenguin.world.rooms.BaseRoom
    {
        var _stage, _SHELL, _destroyDelegate, wem, _triggerWatcher, _triggerWatcherInterval, setupNavigationButtons, _foodStation1, _foodStation2, _foodStationTrigger1, _foodStationTrigger2, _sleepStation, _sleepStationTrigger, _hydrantStation, _hydrantStationTrigger, _postStation, _postStationTrigger, _swingStation, _swingStationTrigger, localize, _ENGINE, _INTERFACE, _penguinOnSlideOrZipline, _slide, _slideEndDelegate, _zipline, _ziplineEndDelegate, _puffleZipline, _puffleZiplineEndDelegate, _slideTrigger, _ziplineTrigger, _slideSound, _ziplineSound;
        function Park (stageReference) {
            super(stageReference);
            _stage.start_x = 380;
            _stage.start_y = 350;
            if (!_SHELL) {
                init();
            }
        }
        function init() {
            _destroyDelegate = com.clubpenguin.util.Delegate.create(this, destroy);
            _SHELL.addListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            configureNavigation();
            configureTriggers();
            configureRoomElements();
            configureSlideSettings();
            configureSlideTriggers();
            wem = new com.clubpenguin.world.rooms.weathereffects.WeatherEffectsManager(_SHELL, _stage.background_mc);
            wem.setupFireAnimationHeight(45);
            wem.setupRainAnimationHeight(70);
            wem.setupSnowAnimationHeight(70);
            wem.setupRainAnimationSpeed(0.4);
            wem.setupSnowAnimationSpeed(0.8);
            wem.setupRainDelayTime(2);
            wem.setupSnowDelayTime(2);
            wem.startWeatherEffectCheck();
            _stage.zipSeatAnimation._visible = false;
        }
        function configureTriggers() {
            _stage.triggers_mc.plazaTrigger.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "plaza", 100, 300);
            _stage.triggers_mc.petShopTrigger.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "pet", 608, 312);
            _stage.triggers_mc.puffleRoundupTrigger.triggerFunction = com.clubpenguin.util.Delegate.create(this, gameRoundup);
            _triggerWatcher = new com.clubpenguin.world.rooms.common.triggers.TriggerWatcher(_stage, _SHELL);
            clearInterval(_triggerWatcherInterval);
            _triggerWatcherInterval = setInterval(_triggerWatcher, "checkAllPlayers", 40);
            configureCareStationTriggers();
        }
        function configureNavigation() {
            setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.slideNav_btn, 53, 250), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.petshopDoor.door_btn, 84, 173), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.puffleOStation01Nav_btn, 190, 147), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.puffleOStation02Nav_btn, 243, 135), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.gateNav_btn, 324, 126), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.ziplineNav_btn, 237, 222), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.hydrantNav_btn, 353, 180), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.puffleToyNav_btn, 569, 144), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.insideTreeNav_btn, 551, 267), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.tireSwingNav_btn, 593, 307), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.puffleRoundupNav_btn, 712, 430)]);
        }
        function configureCareStationTriggers() {
            configureFoodStationTriggers();
            configureSleepStationTrigger();
            configureCleanStationTrigger();
            configureScratchPostStationTrigger();
            configureTireSwingTrigger();
        }
        function configureFoodStationTriggers() {
            var _local_2 = new com.clubpenguin.world.rooms.hotel.hotelcarestations.HotelCareStationVO();
            _local_2.effectRef = _stage.foodBowl01_mc;
            _local_2.taskEnum = EATING_TASK;
            _local_2.puffleFrame = STAND_FRAME;
            _foodStation1 = new com.clubpenguin.world.rooms.hotel.hotelcarestations.HotelCareStation(_local_2);
            _foodStation1.stationBIInfo(com.clubpenguin.engine.puffles.pufflecarestations.PuffleCareStationsConstants.PARK_FEED_CARESTATION, com.clubpenguin.engine.puffles.pufflecarestations.PuffleCareStationsConstants.PUFFLE_FOOD_STATION);
            _local_2.effectRef = _stage.foodBowl02_mc;
            _foodStation2 = new com.clubpenguin.world.rooms.hotel.hotelcarestations.HotelCareStation(_local_2);
            _foodStation2.stationBIInfo(com.clubpenguin.engine.puffles.pufflecarestations.PuffleCareStationsConstants.PARK_FEED_CARESTATION, com.clubpenguin.engine.puffles.pufflecarestations.PuffleCareStationsConstants.PUFFLE_FOOD_STATION);
            configureStationTrigger(_foodStation1, _foodStationTrigger1, _stage.triggers_mc.feedPuffle01Trigger);
            configureStationTrigger(_foodStation2, _foodStationTrigger2, _stage.triggers_mc.feedPuffle02Trigger);
        }
        function configureSleepStationTrigger() {
            var _local_2 = new com.clubpenguin.world.rooms.hotel.hotelcarestations.HotelCareStationVO();
            _local_2.careSound = new com.clubpenguin.world.rooms.hotel.hotelcarestations.HotelCareSound("snoringLoopSFX", _stage.puffleTreeFront);
            _local_2.taskEnum = SLEEPING_TASK;
            _local_2.puffleFrame = SLEEP_FRAME;
            _sleepStation = new com.clubpenguin.world.rooms.hotel.hotelcarestations.HotelCareStation(_local_2);
            _sleepStation.stationBIInfo(com.clubpenguin.engine.puffles.pufflecarestations.PuffleCareStationsConstants.PARK_BED_CARESTATION, com.clubpenguin.engine.puffles.pufflecarestations.PuffleCareStationsConstants.PUFFLE_SLEEP_STATION);
            configureStationTrigger(_sleepStation, _sleepStationTrigger, _stage.triggers_mc.puffleRestTrigger);
        }
        function configureCleanStationTrigger() {
            var _local_2 = new com.clubpenguin.world.rooms.hotel.hotelcarestations.HotelCareStationVO();
            _local_2.taskEnum = GROOM_TASK;
            _local_2.assetPath = HYDRANT_PATH;
            _local_2.playerLocation = new flash.geom.Point(353, 180);
            _hydrantStation = new com.clubpenguin.world.rooms.hotel.hotelcarestations.HotelCareStation(_local_2);
            _hydrantStation.stationBIInfo(com.clubpenguin.engine.puffles.pufflecarestations.PuffleCareStationsConstants.PARK_HYDRANT_CARESTATION, com.clubpenguin.engine.puffles.pufflecarestations.PuffleCareStationsConstants.PUFFLE_CLEAN_STATION);
            configureStationTrigger(_hydrantStation, _hydrantStationTrigger, _stage.triggers_mc.hydrantTrigger);
        }
        function configureScratchPostStationTrigger() {
            _postStation = new com.clubpenguin.world.rooms.common.carestations.EnvironmentPropCareStation(PLAY_TASK, POST_PATH, _stage.puffleToyComp, new flash.geom.Point(566, 146));
            _postStation.stationBIInfo(com.clubpenguin.engine.puffles.pufflecarestations.PuffleCareStationsConstants.PARK_POST_CARESTATION, com.clubpenguin.engine.puffles.pufflecarestations.PuffleCareStationsConstants.PUFFLE_PLAY_STATION);
            _postStationTrigger = new com.clubpenguin.world.rooms.common.triggers.PlayerTrigger(_stage.triggers_mc.puffleToyTrigger);
            _postStationTrigger.playersAdded.add(com.clubpenguin.util.Delegate.create(_postStation, _postStation.beginActivity));
            _postStationTrigger.playersRemoved.add(com.clubpenguin.util.Delegate.create(_postStation, _postStation.endActivity));
            _triggerWatcher.addTrigger(_postStationTrigger);
        }
        function configureTireSwingTrigger() {
            _swingStation = new com.clubpenguin.world.rooms.common.carestations.EnvironmentPropCareStation(PLAY_TASK, SWING_PATH, _stage.tireSwing, new flash.geom.Point(593, 307));
            _swingStation.stationBIInfo(com.clubpenguin.engine.puffles.pufflecarestations.PuffleCareStationsConstants.PARK_SWING_CARESTATION, com.clubpenguin.engine.puffles.pufflecarestations.PuffleCareStationsConstants.PUFFLE_PLAY_STATION);
            _swingStationTrigger = new com.clubpenguin.world.rooms.common.triggers.PlayerTrigger(_stage.triggers_mc.tireSwingTrigger);
            _swingStationTrigger.playersAdded.add(com.clubpenguin.util.Delegate.create(_swingStation, _swingStation.beginActivity));
            _swingStationTrigger.playersRemoved.add(com.clubpenguin.util.Delegate.create(_swingStation, _swingStation.endActivity));
            _triggerWatcher.addTrigger(_swingStationTrigger);
        }
        function configureStationTrigger(careStation, playerTrigger, triggerClip) {
            playerTrigger = new com.clubpenguin.world.rooms.common.triggers.PlayerTrigger(triggerClip);
            playerTrigger.playersAdded.add(com.clubpenguin.util.Delegate.create(careStation, careStation.beginActivity));
            playerTrigger.playersRemoved.add(com.clubpenguin.util.Delegate.create(careStation, careStation.endActivity));
            _triggerWatcher.addTrigger(playerTrigger);
        }
        function configureRoomElements() {
            localize([_stage.background_mc.gate_mc.park_mc]);
            _stage.block_mc._visible = false;
            _stage.triggers_mc._visible = false;
            _stage.puffleOStation01Nav_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, feedPuffleOver);
            _stage.puffleOStation01Nav_btn.onRollOut = com.clubpenguin.util.Delegate.create(this, feedPuffleOut);
            _stage.puffleOStation02Nav_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, feedPuffleOver);
            _stage.puffleOStation02Nav_btn.onRollOut = com.clubpenguin.util.Delegate.create(this, feedPuffleOut);
            _stage.tireSwingNav_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, tireSwingOver);
            _stage.tireSwingNav_btn.onRollOut = com.clubpenguin.util.Delegate.create(this, tireSwingOut);
            _stage.insideTreeNav_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, restingTreeOver);
            _stage.insideTreeNav_btn.onRollOut = com.clubpenguin.util.Delegate.create(this, restingTreeOut);
            _stage.puffleToyNav_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, puffleToyOver);
            _stage.puffleToyNav_btn.onRollOut = com.clubpenguin.util.Delegate.create(this, puffleToyOut);
            _stage.slideNav_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, slideOver);
            _stage.slideNav_btn.onRollOut = com.clubpenguin.util.Delegate.create(this, slideOut);
            _stage.hydrantNav_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, hydrantOver);
            _stage.hydrantNav_btn.onRollOut = com.clubpenguin.util.Delegate.create(this, hydrantOut);
            _stage.gateNav_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, gateOver);
            _stage.gateNav_btn.onRollOut = com.clubpenguin.util.Delegate.create(this, gateOut);
            _stage.puffleRoundupNav_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, puffleRoundupOver);
            _stage.puffleRoundupNav_btn.onRollOut = com.clubpenguin.util.Delegate.create(this, puffleRoundupOut);
            setupZiplineRollOver();
        }
        function setupZiplineRollOver() {
            _stage.ziplineNav_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, ziplineOver);
            _stage.ziplineNav_btn.onRollOut = com.clubpenguin.util.Delegate.create(this, ziplineOut);
        }
        function removeZiplineRollOver() {
            _stage.ziplineNav_btn.onRollOver = null;
            _stage.ziplineNav_btn.onRollOut = null;
        }
        function gameRoundup() {
            _ENGINE.sendJoinGame("roundup", true);
        }
        function feedPuffleOver() {
            _stage.background_mc.puffleOtrough.gotoAndStop(2);
        }
        function feedPuffleOut() {
            _stage.background_mc.puffleOtrough.gotoAndStop(1);
        }
        function tireSwingOver() {
            _stage.tireSwing.gotoAndStop(2);
            _stage.puffleTreeFront.playSignComp.playSign.gotoAndStop(2);
        }
        function tireSwingOut() {
            _stage.tireSwing.gotoAndStop(1);
            _stage.puffleTreeFront.playSignComp.playSign.gotoAndStop(1);
        }
        function restingTreeOver() {
            _stage.puffleTreeFront.restingTree.gotoAndStop(2);
            _stage.puffleTreeFront.pole.gotoAndStop(2);
            _stage.puffleTreeBack.gotoAndStop(2);
            _stage.puffleToyComp.gotoAndStop(3);
            _stage.tireSwing.gotoAndStop(3);
        }
        function restingTreeOut() {
            _stage.puffleTreeFront.restingTree.gotoAndStop(1);
            _stage.puffleTreeFront.pole.gotoAndStop(1);
            _stage.puffleTreeBack.gotoAndStop(1);
            _stage.puffleToyComp.gotoAndStop(1);
            _stage.tireSwing.gotoAndStop(1);
        }
        function puffleToyOver() {
            _stage.puffleToyComp.gotoAndStop(2);
        }
        function puffleToyOut() {
            _stage.puffleToyComp.gotoAndStop(1);
        }
        function slideOver() {
            _stage.slideComp.slide.gotoAndStop(2);
            _stage.slideSidePost.gotoAndStop(2);
        }
        function slideOut() {
            _stage.slideComp.slide.gotoAndStop(1);
            _stage.slideSidePost.gotoAndStop(1);
        }
        function hydrantOver() {
            _stage.hydrant.gotoAndStop(2);
        }
        function hydrantOut() {
            _stage.hydrant.gotoAndStop(1);
        }
        function gateOver() {
            _stage.background_mc.gate_mc.gotoAndStop(2);
        }
        function gateOut() {
            _stage.background_mc.gate_mc.gotoAndStop(1);
        }
        function puffleRoundupOver() {
            _stage.foreground_mc.puffleRoundupSign.gotoAndStop(2);
            _stage.puffleRoundupPost.gotoAndStop(2);
            _INTERFACE.showHint(_stage.foreground_mc.hint_mc, "roundup_hint");
        }
        function puffleRoundupOut() {
            _stage.foreground_mc.puffleRoundupSign.gotoAndStop(1);
            _stage.puffleRoundupPost.gotoAndStop(1);
            _INTERFACE.closeHint();
        }
        function ziplineOver() {
            _stage.ziplineComp.zipConnection01Top.gotoAndStop(2);
            _stage.ziplineComp.zipConnection02Top.gotoAndStop(2);
            _stage.ziplineComp.zipConnection01Bottom.gotoAndStop(2);
            _stage.ziplineComp.zipConnection02Bottom.gotoAndStop(2);
        }
        function ziplineOut() {
            _stage.ziplineComp.zipConnection01Top.gotoAndStop(1);
            _stage.ziplineComp.zipConnection02Top.gotoAndStop(1);
            _stage.ziplineComp.zipConnection01Bottom.gotoAndStop(1);
            _stage.ziplineComp.zipConnection02Bottom.gotoAndStop(1);
        }
        function exit(roomName, x, y) {
            _SHELL.sendJoinRoom(roomName, x, y);
        }
        function destroy() {
            clearInterval(_triggerWatcherInterval);
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            _global.getCurrentAirtower().removeListener(SLIDE_COMMAND, _penguinOnSlideOrZipline);
            _foodStation1.cleanStation();
            _foodStation2.cleanStation();
            _sleepStation.cleanStation();
            _hydrantStation.cleanStation();
            _postStation.cleanStation();
            _swingStation.cleanStation();
        }
        function configureSlideSettings() {
            _slide = new com.clubpenguin.world.rooms.common.slide.ConveyorBeltWithPuffle();
            _slideEndDelegate = com.clubpenguin.util.Delegate.create(this, handleSlideEnd);
            _slide.endOfConveyorBeltReached.add(_slideEndDelegate, this);
            _zipline = new com.clubpenguin.world.rooms.common.slide.ConveyorBelt();
            _ziplineEndDelegate = com.clubpenguin.util.Delegate.create(this, handleZiplineEnd);
            _zipline.endOfConveyorBeltReached.add(_ziplineEndDelegate, this);
            _puffleZipline = new com.clubpenguin.world.rooms.common.slide.PuffleConveyorBelt();
            _puffleZiplineEndDelegate = com.clubpenguin.util.Delegate.create(this, handlePuffleEndZipline);
            _puffleZipline.endOfConveyorBeltReached.add(_puffleZiplineEndDelegate, this);
        }
        function configureSlideTriggers() {
            _penguinOnSlideOrZipline = com.clubpenguin.util.Delegate.create(this, handlePenguinOnSlideOrZipline);
            _global.getCurrentAirtower().addListener(SLIDE_COMMAND, _penguinOnSlideOrZipline);
            _slideTrigger = new com.clubpenguin.world.rooms.common.triggers.PlayerTrigger(_stage.triggers_mc.slideTrigger);
            _slideTrigger.playersAdded.add(com.clubpenguin.util.Delegate.create(this, sendAddPlayerToSlide));
            _triggerWatcher.addTrigger(_slideTrigger);
            _ziplineTrigger = new com.clubpenguin.world.rooms.common.triggers.PlayerTrigger(_stage.triggers_mc.ziplineTrigger);
            _ziplineTrigger.playersAdded.add(com.clubpenguin.util.Delegate.create(this, sendAddPlayerToZipline));
            _triggerWatcher.addTrigger(_ziplineTrigger);
        }
        function sendAddPlayerToSlide(players) {
            var _local_3 = 0;
            while (_local_3 < players.length) {
                if (players[_local_3] == _SHELL.getMyPlayerId()) {
                    _SHELL.getPlayerObjectById(players[_local_3]).isUsingSlide = true;
                    var _local_4 = _global.getCurrentAirtower();
                    _local_4.send(_local_4.PLAY_EXT, "u#" + SLIDE_COMMAND, [SLIDE_SERVER_NUMBER], "str", _SHELL.getCurrentServerRoomId());
                }
                _local_3++;
            }
        }
        function sendAddPlayerToZipline(players) {
            var _local_3 = 0;
            while (_local_3 < players.length) {
                if (players[_local_3] == _SHELL.getMyPlayerId()) {
                    _SHELL.getPlayerObjectById(players[_local_3]).isUsingSlide = true;
                    var _local_4 = _global.getCurrentAirtower();
                    _local_4.send(_local_4.PLAY_EXT, "u#" + SLIDE_COMMAND, [ZIPLINE_SERVER_NUMBER], "str", _SHELL.getCurrentServerRoomId());
                }
                _local_3++;
            }
        }
        function handlePenguinOnSlideOrZipline(data) {
            var _local_2;
            var _local_3;
            _local_2 = Number(data[1]);
            _local_3 = Number(data[2]);
            if (_local_3 == SLIDE_SERVER_NUMBER) {
                handleSlideStart(_local_2);
            } else if (_local_3 == ZIPLINE_SERVER_NUMBER) {
                handleZiplineStart(_local_2);
            }
            data = null;
        }
        function handleSlideStart(playerID) {
            var _local_2 = _SHELL.getPlayerObjectById(playerID);
            if (com.clubpenguin.world.rooms.common.triggers.PlayerAction.isPlayer(_local_2, com.clubpenguin.world.rooms.common.triggers.PlayerAction.WALKING_PUFFLE)) {
                if (playerID == _SHELL.getMyPlayerId()) {
                    _SHELL.sendAS3DisablePuffleTricksHUD();
                }
                _slide.registerFrameTrigger(3, com.clubpenguin.util.Delegate.create(this, playSlideSound, _local_2), true);
                _slide.startPuffleToPenguinAnimation(SLIDE_PATH_LINK_NAME, playerID, _stage.slideContainerMC);
            } else {
                playSlideSound(_local_2);
                _slide.addPenguintoConveyorPather(SLIDE_PATH_LINK_NAME, playerID, _stage.slideContainerMC);
            }
        }
        function handleSlideEnd(playerID) {
            if (playerID == null) {
                return(undefined);
            }
            playSnowPuff(playerID);
            if (com.clubpenguin.world.rooms.common.triggers.PlayerAction.isPlayer(_SHELL.getPlayerObjectById(playerID), com.clubpenguin.world.rooms.common.triggers.PlayerAction.WALKING_PUFFLE)) {
                _slide.startPuffleOffPenguinAnimation(playerID);
                if (playerID == _SHELL.getMyPlayerId()) {
                    com.clubpenguin.engine.puffles.pufflecarestations.PuffleCareStationLogging.sendPuffleCareStationBI(com.clubpenguin.engine.puffles.pufflecarestations.PuffleCareStationsConstants.PARK_SLIDE_CARESTATION, com.clubpenguin.engine.puffles.pufflecarestations.PuffleCareStationsConstants.PUFFLE_PLAY_STATION);
                }
            }
        }
        function handleZiplineStart(playerID) {
            var _local_2 = _SHELL.getPlayerObjectById(playerID);
            _zipline.addPenguintoConveyorPather(ZIPLINE_PATH_LINK_NAME, playerID, _stage.slideContainerMC);
            startZiplineMC(_local_2);
            playZiplineSound(_local_2);
            if (com.clubpenguin.world.rooms.common.triggers.PlayerAction.isPlayer(_local_2, com.clubpenguin.world.rooms.common.triggers.PlayerAction.WALKING_PUFFLE)) {
                if (playerID == _SHELL.getMyPlayerId()) {
                    _SHELL.sendAS3DisablePuffleTricksHUD();
                }
                var _local_4 = _ENGINE.puffleAvatarController.getPuffleAvatar(_local_2.attachedPuffle.id);
                _puffleZipline.startPufflePathFollow(P_ZIPLINE_PATH_LINK_NAME, _local_4, _stage.slideContainerMC, playerID);
            }
        }
        function handleZiplineEnd(playerID) {
            if (playerID == null) {
                return(undefined);
            }
            if (_stage.ziplineComp._currentframe == 2) {
                setupZiplineRollOver();
                _stage.ziplineComp.gotoAndStop(1);
            }
            _stage.zipSeatAnimation._visible = false;
            _stage.zipSeatAnimation.gotoAndStop(40);
        }
        function handlePuffleEndZipline(playerID) {
            if (playerID == null) {
                return(undefined);
            }
            if (com.clubpenguin.world.rooms.common.triggers.PlayerAction.isPlayer(_SHELL.getPlayerObjectById(playerID), com.clubpenguin.world.rooms.common.triggers.PlayerAction.WALKING_PUFFLE)) {
                _puffleZipline.onPathComplete(playerID);
                if (playerID == _SHELL.getMyPlayerId()) {
                    com.clubpenguin.engine.puffles.pufflecarestations.PuffleCareStationLogging.sendPuffleCareStationBI(com.clubpenguin.engine.puffles.pufflecarestations.PuffleCareStationsConstants.PARK_ZIPLINE_CARESTATION, com.clubpenguin.engine.puffles.pufflecarestations.PuffleCareStationsConstants.PUFFLE_PLAY_STATION);
                }
            }
        }
        function playSnowPuff(playerID) {
            var puffMC = _stage.background_mc.slideSnowPuff_mc;
            var previousX = puffMC._x;
            var previousY = puffMC._y;
            puffMC._x = _SHELL.getPlayerObjectById(playerID).x;
            puffMC._y = _SHELL.getPlayerObjectById(playerID).y;
            puffMC.gotoAndPlay(2);
            puffMC.onEnterFrame = function () {
                if (puffMC._currentframe >= puffMC._totalframes) {
                    puffMC.onEnterFrame = null;
                    puffMC._x = previousX;
                    puffMC._y = previousY;
                }
            };
        }
        function startZiplineMC(playerVO) {
            var _local_2 = _stage.ziplineComp;
            if (_local_2._currentframe != 2) {
                removeZiplineRollOver();
                _stage.ziplineComp.gotoAndStop(2);
            }
            var playerZiplineFront = _stage.ziplineComp.zipConnection01TopAnimation;
            var playerZiplineBack = _stage.zipSeatAnimation;
            playerZiplineBack.gotoAndStop(1);
            playerZiplineBack.onEnterFrame = function () {
                if (playerZiplineBack._currentframe == 1) {
                    playerZiplineBack._visible = true;
                    playerZiplineFront.gotoAndPlay(2);
                    playerZiplineBack.gotoAndPlay(2);
                }
                if (playerZiplineBack._currentframe == playerZiplineBack._totalframes) {
                    playerZiplineFront.gotoAndStop(1);
                    playerZiplineBack.gotoAndStop(1);
                    playerZiplineBack._visible = true;
                    playerZiplineBack.onEnterFrame = null;
                }
            };
            if (com.clubpenguin.world.rooms.common.triggers.PlayerAction.isPlayer(playerVO, com.clubpenguin.world.rooms.common.triggers.PlayerAction.WALKING_PUFFLE)) {
                var puffleZiplineBall = _stage.ziplineComp.zipConnection02BottomAnimation;
                var puffleZiplineFront = _stage.ziplineComp.zipConnection02TopAnimation;
                puffleZiplineBall.onEnterFrame = function () {
                    if (puffleZiplineBall._currentframe == 1) {
                        puffleZiplineBall.gotoAndPlay(2);
                        puffleZiplineFront.gotoAndPlay(2);
                    }
                    if (puffleZiplineBall._currentframe >= puffleZiplineBall._totalframes) {
                        puffleZiplineBall.gotoAndStop(1);
                        puffleZiplineFront.gotoAndStop(1);
                        puffleZiplineBall.onEnterFrame = null;
                    }
                };
            }
        }
        function playSlideSound(playerVO) {
            if (_isSlideSoundPlaying == true) {
                return(undefined);
            }
            _isSlideSoundPlaying = true;
            _slideSound = new Sound(_stage);
            _slideSound.onSoundComplete = com.clubpenguin.util.Delegate.create(this, onSoundComplete, "slide");
            var _local_2;
            if (playerVO.attachedPuffle.subTypeID == 1006) {
                _local_2 = "slideDogPuffle";
            } else if (playerVO.attachedPuffle.subTypeID == 1007) {
                _local_2 = "slideCatPuffle";
            } else if (Boolean(Math.round(Math.random() * 2))) {
                _local_2 = "slideGeneric01";
            } else {
                _local_2 = "slideGeneric02";
            }
            _slideSound.attachSound(_local_2);
            _slideSound.start();
        }
        function playZiplineSound(playerVO) {
            if (_isZiplineSoundPlaying == true) {
                return(undefined);
            }
            _isZiplineSoundPlaying = true;
            _ziplineSound = new Sound(_stage);
            _ziplineSound.onSoundComplete = com.clubpenguin.util.Delegate.create(this, onSoundComplete, "zipline");
            var _local_2;
            if (playerVO.attachedPuffle.subTypeID == 1006) {
                _local_2 = "ziplineDogPuffle";
            } else if (playerVO.attachedPuffle.subTypeID == 1007) {
                _local_2 = "ziplineCatPuffle";
            } else if (Boolean(Math.round(Math.random() * 2))) {
                _local_2 = "ziplineGeneric01";
            } else {
                _local_2 = "ziplineGeneric02";
            }
            _ziplineSound.attachSound(_local_2);
            _ziplineSound.start();
        }
        function onSoundComplete(slideID) {
            switch (slideID) {
                case "slide" : 
                    _isSlideSoundPlaying = false;
                    _slideSound = null;
                    break;
                case "zipline" : 
                    _isZiplineSoundPlaying = false;
                    _ziplineSound = null;
                    break;
            }
        }
        static var CLASS_NAME = "Park";
        static var SLIDE_COMMAND = "followpath";
        static var SLIDE_PATH_LINK_NAME = "Slide_Path";
        static var ZIPLINE_PATH_LINK_NAME = "Zipline_Path_Penguin";
        static var P_ZIPLINE_PATH_LINK_NAME = "Zipline_Path_Puffle";
        static var SLIDE_SERVER_NUMBER = 1;
        static var ZIPLINE_SERVER_NUMBER = 2;
        var _isSlideSoundPlaying = false;
        var _isZiplineSoundPlaying = false;
        static var EATING_TASK = com.clubpenguin.world.rooms.hotel.hotelcarestations.HotelCareTaskEnum.EATING_TASK;
        static var SLEEPING_TASK = com.clubpenguin.world.rooms.hotel.hotelcarestations.HotelCareTaskEnum.SLEEPING_TASK;
        static var PLAY_TASK = com.clubpenguin.world.rooms.hotel.hotelcarestations.HotelCareTaskEnum.PLAYING_TASK;
        static var GROOM_TASK = com.clubpenguin.world.rooms.hotel.hotelcarestations.HotelCareTaskEnum.GROOMING_TASK;
        static var STAND_FRAME = com.clubpenguin.puffleavatar.PuffleAvatarConstants.PUFFLE_STAND_SOUTH_FRAME;
        static var SLEEP_FRAME = com.clubpenguin.puffleavatar.PuffleAvatarConstants.PUFFLE_SLEEP_FRAME;
        static var HYDRANT_PATH = com.clubpenguin.world.rooms.hotel.hotelcarestations.HotelCareStationAnimationConstants.HYDRANT;
        static var POST_PATH = com.clubpenguin.world.rooms.hotel.hotelcarestations.HotelCareStationAnimationConstants.SCRATCHING_POST;
        static var SWING_PATH = com.clubpenguin.world.rooms.hotel.hotelcarestations.HotelCareStationAnimationConstants.TIRE_SWING;
    }
