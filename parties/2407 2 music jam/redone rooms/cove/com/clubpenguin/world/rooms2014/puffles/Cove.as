//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2014.puffles.Cove extends com.clubpenguin.world.rooms.BaseRoom
    {
        var _stage, _SHELL, localize, _INTERFACE, _triggerWatcher, setupNavigationButtons, showContent, setupHint, _triggerWatcherInterval, _waterSlideHandlerDelegate, _slide1Trigger, _slide2Trigger, _slide3Trigger, _ENGINE, _destroyDelegate, _divingBoard, _divingBoardTrigger;
        function Cove (stageReference) {
            super(stageReference);
            _stage.start_x = 450;
            _stage.start_y = 350;
            if (!_SHELL) {
                init();
            }
            localize([_stage.interface_mc.interface_mc.SurfShack2_mc.SurfShackSign2_mc]);
            _triggerWatcher = new com.clubpenguin.world.rooms.common.triggers.TriggerWatcher(_stage, _SHELL);
            _stage.triggers_mc.booth_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, openQuestInterface);
            setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.chair_mc, 337, 141), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.boothContainer_mc.booth_btn, 350, 310), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.entrance1_mc.entrance1_btn, 400, 170), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.entrance2_mc.entrance2_btn, 305, 205), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.forest_btn, 430, 130), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.waves_mc.waves_btn, 500, 370), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.divingBoard_btn, 494, 130)]);
            _stage.background_mc.chair_mc.useHandCursor = false;
            _stage.boothContainer_mc.booth_btn.useHandCursor = false;
            _stage.background_mc.forest_btn.useHandCursor = false;
            showContent([new com.clubpenguin.world.rooms.common.PopupContentVO(_stage.chair_front_mc.binoculars_btn, true, "binoculars", ""), new com.clubpenguin.world.rooms.common.PopupContentVO(_stage.interface_mc.cove_cat_btn, true, "cove_catalogue", ""), new com.clubpenguin.world.rooms.common.PopupContentVO(_stage.cove_cat_obj_mc.cove_cat_obj_btn, true, "cove_catalogue", "")]);
            setupHint([new com.clubpenguin.world.rooms.common.HintVO(_stage.waves_mc.waves_btn, _stage.waves_mc.waves_btn, "waves_hint")]);
            _stage.triggers_mc.forest_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exitForest);
            _stage.triggers_mc.waves_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exitWaves);
            clearInterval(_triggerWatcherInterval);
            _triggerWatcherInterval = setInterval(_triggerWatcher, "checkAllPlayers", 40);
            configureWaterSlideFunctionality();
            configureDivingBoardTrigger();
        }
		function openQuestInterface() {
			_INTERFACE.showContent("w.app.p2014.itembooth");
		}
        function configureWaterSlideFunctionality() {
            var _local_3 = 1;
            while (_local_3 <= 3) {
                this["_slide" + _local_3] = new com.clubpenguin.world.rooms.common.slide.ConveyorBelt();
                this[("_slide" + _local_3) + "EndDelegate"] = com.clubpenguin.util.Delegate.create(this, handleSlideEnd, _local_3);
                this["_slide" + _local_3].endOfConveyorBeltReached.add(this[("_slide" + _local_3) + "EndDelegate"], this);
                this["_slide" + _local_3].registerFrameTrigger(((_local_3 == 2) ? 7 : 2), com.clubpenguin.util.Delegate.create(this, playSlideSFX, _local_3), true);
                _local_3++;
            }
            _waterSlideHandlerDelegate = com.clubpenguin.util.Delegate.create(this, handlePenguinOnSlide);
            _global.getCurrentAirtower().addListener(SLIDE_COMMAND, _waterSlideHandlerDelegate);
            configureSlideTriggers();
        }
        function playSlideSFX(slideNum) {
            _global.getCurrentParty().BaseParty.playSound(_stage, "sfx_slide" + slideNum);
        }
        function configureSlideTriggers() {
            _slide1Trigger = new com.clubpenguin.world.rooms.common.triggers.PlayerTrigger(_stage.triggers_mc.slide1Trigger);
            _slide1Trigger.playersAdded.add(com.clubpenguin.util.Delegate.create(this, sendAddPlayerToSlide, 1));
            _triggerWatcher.addTrigger(_slide1Trigger);
            _slide2Trigger = new com.clubpenguin.world.rooms.common.triggers.PlayerTrigger(_stage.triggers_mc.slide2Trigger);
            _slide2Trigger.playersAdded.add(com.clubpenguin.util.Delegate.create(this, sendAddPlayerToSlide, 2));
            _triggerWatcher.addTrigger(_slide2Trigger);
            _slide3Trigger = new com.clubpenguin.world.rooms.common.triggers.PlayerTrigger(_stage.triggers_mc.slide3Trigger);
            _slide3Trigger.playersAdded.add(com.clubpenguin.util.Delegate.create(this, sendAddPlayerToSlide, 3));
            _triggerWatcher.addTrigger(_slide3Trigger);
        }
        function sendAddPlayerToSlide(players, slideNum) {
            var _local_3 = 0;
            while (_local_3 < players.length) {
                if (players[_local_3] == _SHELL.getMyPlayerId()) {
                    var _local_4 = _global.getCurrentAirtower();
                    _local_4.send(_local_4.PLAY_EXT, "u#" + SLIDE_COMMAND, [slideNum], "str", _SHELL.getCurrentServerRoomId());
                }
                _local_3++;
            }
        }
        function handlePenguinOnSlide(data) {
            var _local_4 = Number(data[1]);
            var _local_3 = Number(data[2]);
            this["_slide" + _local_3].addPenguintoConveyorPather("Waterslide_Path_" + _local_3, _local_4, _stage.waterSlideContainerMC);
            if ((_local_3 != 3) && (_local_4 == _SHELL.getMyPlayerId())) {
                _global.getCurrentParty().BaseParty.playSound(_stage, "sfx_Transport" + random(2));
            }
            data = null;
        }
        function handleSlideEnd(player_id, slideNum) {
            if (_stage["slideSplash_" + slideNum]._currentframe == 1) {
                _stage["slideSplash_" + slideNum].gotoAndPlay(2);
            }
        }
        function exitForest() {
            if (_SHELL.isNewPlayerExperienceRunning == false) {
                _SHELL.sendJoinRoom("forest", 620, 375);
            }
        }
        function exitWaves() {
            if (_SHELL.isNewPlayerExperienceRunning == false) {
                _ENGINE.sendJoinGame("waves", true);
            }
        }
        function init() {
            _destroyDelegate = com.clubpenguin.util.Delegate.create(this, destroy);
            _SHELL.addListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
        }
        function destroy() {
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
        }
        function divingBoardRollOver() {
            _stage.divingBoardState_mc.gotoAndStop("rollOver");
        }
        function divingBoardRollOut() {
            _stage.divingBoardState_mc.gotoAndStop("rollOut");
        }
        function configureDivingBoardTrigger() {
            _stage.divingBoard_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, divingBoardRollOver);
            _stage.divingBoard_btn.onRollOut = com.clubpenguin.util.Delegate.create(this, divingBoardRollOut);
            _stage.divingBoard_btn.onReleaseOutside = com.clubpenguin.util.Delegate.create(this, divingBoardRollOut);
            _stage.divingBoard_btn.useHandCursor = false;
            var _local_2 = new com.clubpenguin.world.rooms.hotel.hotelcarestations.HotelCareStationVO();
            _local_2.effectRef = _stage.divingBoardState_mc.divingBoard_mc;
            _local_2.taskEnum = PLAY_TASK;
            _local_2.assetPath = DIVING_PATH;
            _divingBoard = new com.clubpenguin.world.rooms.hotel.hotelcarestations.HotelCareStation(_local_2);
            _divingBoard.stationBIInfo(com.clubpenguin.engine.puffles.pufflecarestations.PuffleCareStationsConstants.DIVING_BOARD_CARESTATION, com.clubpenguin.engine.puffles.pufflecarestations.PuffleCareStationsConstants.PUFFLE_PLAY_STATION);
            configureStationTrigger(_divingBoard, _divingBoardTrigger, _stage.triggers_mc.divingBoard_mc);
        }
        function configureStationTrigger(careStation, playerTrigger, triggerClip) {
            playerTrigger = new com.clubpenguin.world.rooms.common.triggers.PlayerTrigger(triggerClip);
            playerTrigger.playersAdded.add(com.clubpenguin.util.Delegate.create(careStation, careStation.beginActivity));
            playerTrigger.playersRemoved.add(com.clubpenguin.util.Delegate.create(careStation, careStation.endActivity));
            _triggerWatcher.addTrigger(playerTrigger);
        }
        function updateItemBoothState() {
            _global.getCurrentParty().PuffleParty.configureItemBooth(_stage.boothContainer_mc);
        }
        static var CLASS_NAME = "Cove";
        static var SLIDE_COMMAND = "followpath";
        var UNDERGROUND_STAMP_ID = 10;
        static var WATER_SPLASH_EFFECT = "waterSplashEffect";
        static var DIVING_PATH = com.clubpenguin.world.rooms.hotel.hotelcarestations.HotelCareStationAnimationConstants.PUFFLE_DIVE;
        static var PLAY_TASK = com.clubpenguin.world.rooms.hotel.hotelcarestations.HotelCareTaskEnum.PLAYING_TASK;
    }
