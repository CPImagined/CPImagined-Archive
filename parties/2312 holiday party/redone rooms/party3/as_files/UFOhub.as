//Created by Action Script Viewer - https://www.buraks.com/asv
    class as_files.UFOhub extends com.clubpenguin.world.rooms.BaseRoom
    {
        var _stage, _SHELL, _destroyDelegate, localize, setupNavigationButtons, _triggerWatcher, _triggerWatcherInterval, _INTERFACE, _waterSlideHandlerDelegate, _slide1Trigger, _divingBoard, _divingBoardTrigger;
        function UFOhub (stageReference) {
            super(stageReference);
            trace(CLASS_NAME + "()");
            _stage.start_x = 219;
            _stage.start_y = 142;
            if (!_SHELL) {
                init();
            }
        }
        function init() {
            trace(CLASS_NAME + ": init()");
            _destroyDelegate = com.clubpenguin.util.Delegate.create(this, destroy);
            _SHELL.addListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            localize([_stage.engineRoomStairs.art, _stage.langAdopt, _stage.langEscapePod, _stage.observatoryDoor]);
            setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.navEngineRoom, 60, 341), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.navAdopt, 97, 172), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.navParty2, 240, 141), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.navObservatory, 680, 180), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.navSlide, 309, 225), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.navSeat1, 607, 295), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.navSeat2, 620, 332), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.navSeat3, 635, 369)]);
            _stage.navSeat1.useHandCursor = false;
            _stage.navSeat2.useHandCursor = false;
            _stage.navSeat3.useHandCursor = false;
            _stage.navSeat4.useHandCursor = false;
            _stage.navSlide.useHandCursor = false;
            _triggerWatcher = new com.clubpenguin.world.rooms.common.triggers.TriggerWatcher(_stage, _SHELL);
            clearInterval(_triggerWatcherInterval);
            _triggerWatcherInterval = setInterval(_triggerWatcher, "checkAllPlayers", 40);
            configureWaterSlideFunctionality();
            configureDivingBoardTrigger();
            _stage.navEngineRoom.onRollOver = com.clubpenguin.util.Delegate.create(this, engineRoomRollOver);
            _stage.navEngineRoom.onRollOut = com.clubpenguin.util.Delegate.create(this, engineRoomRollOut);
            _stage.navEngineRoom.onReleaseOutside = com.clubpenguin.util.Delegate.create(this, engineRoomRollOut);
            _stage.navAdopt.onRollOver = com.clubpenguin.util.Delegate.create(this, adoptRollOver);
            _stage.navAdopt.onRollOut = com.clubpenguin.util.Delegate.create(this, adoptRollOut);
            _stage.navAdopt.onReleaseOutside = com.clubpenguin.util.Delegate.create(this, adoptRollOut);
            _stage.navObservatory.onRollOver = com.clubpenguin.util.Delegate.create(this, observatoryRollOver);
            _stage.navObservatory.onRollOut = com.clubpenguin.util.Delegate.create(this, observatoryRollOut);
            _stage.navObservatory.onReleaseOutside = com.clubpenguin.util.Delegate.create(this, observatoryRollOut);
            _stage.triggers_mc.adopt_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, showContent, "alienpuffle");
            _stage.triggers_mc.area5001_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "party2", 276, 264);
            _stage.triggers_mc.party12_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "party4", 174, 332);
        }
        function engineRoomRollOver() {
            _stage.engineRoomStairs.art.artInside.gotoAndStop(2);
        }
        function engineRoomRollOut() {
            _stage.engineRoomStairs.art.artInside.gotoAndStop(1);
        }
        function adoptRollOver() {
            _stage.AdoptLight.gotoAndStop(2);
        }
        function adoptRollOut() {
            _stage.AdoptLight.gotoAndStop(1);
        }
        function observatoryRollOver() {
            _stage.observatoryDoor.art.gotoAndPlay("open");
        }
        function observatoryRollOut() {
            _stage.observatoryDoor.art.gotoAndPlay("close");
        }
        function showContent(contentID) {
            trace("show contnet");
            _INTERFACE.showContent(contentID);
        }
        function exit(name, x, y) {
            trace(CLASS_NAME + ": exit()");
            _SHELL.sendJoinRoom(name, x, y);
        }
        function configureWaterSlideFunctionality() {
            var _local_3 = 1;
            while (_local_3 <= 2) {
                this["_slide" + _local_3] = new com.clubpenguin.world.rooms.common.slide.ConveyorBelt();
                this[("_slide" + _local_3) + "EndDelegate"] = com.clubpenguin.util.Delegate.create(this, handleSlideEnd, _local_3);
                this["_slide" + _local_3].endOfConveyorBeltReached.add(this[("_slide" + _local_3) + "EndDelegate"], this);
                _local_3++;
            }
            _waterSlideHandlerDelegate = com.clubpenguin.util.Delegate.create(this, handlePenguinOnSlide);
            _global.getCurrentAirtower().addListener(SLIDE_COMMAND, _waterSlideHandlerDelegate);
            configureSlideTriggers();
        }
        function playSlideTeleport() {
            _global.getCurrentParty().BaseParty.playSound(_stage, "sfx_transport");
        }
        function playSlideSFX() {
            var _local_3 = Math.floor(Math.random() * 3) + 1;
            _global.getCurrentParty().BaseParty.playSound(_stage, "sfx_slide_" + _local_3);
        }
        function playTrumpet() {
            _stage.trumpet_mc.key1_mc.gotoAndPlay(2);
            _stage.trumpet_mc.key2_mc.gotoAndPlay(2);
            _stage.trumpet_mc.key3_mc.gotoAndPlay(2);
        }
        function configureSlideTriggers() {
            _slide1Trigger = new com.clubpenguin.world.rooms.common.triggers.PlayerTrigger(_stage.triggers_mc.slide1Trigger);
            _slide1Trigger.playersAdded.add(com.clubpenguin.util.Delegate.create(this, sendAddPlayerToSlide, 1));
            _triggerWatcher.addTrigger(_slide1Trigger);
        }
        function sendAddPlayerToSlide(players, slideNum) {
            playSlideSFX();
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
            var _local_3 = Number(data[1]);
            var _local_2 = Number(data[2]);
            this["_slide" + _local_2].addPenguintoConveyorPather("Waterslide_Path_" + _local_2, _local_3, _stage.waterSlideContainerMC);
            data = null;
        }
        function handleSlideEnd(player_id, slideNum) {
            if (_stage["slideSplash_" + slideNum]._currentframe == 1) {
                _stage["slideSplash_" + slideNum].gotoAndPlay(2);
            }
        }
        function divingBoardRollOver() {
            _stage.background_mc.divingBoardState_mc.gotoAndStop("rollOver");
        }
        function divingBoardRollOut() {
            _stage.background_mc.divingBoardState_mc.gotoAndStop("rollOut");
        }
        function configureDivingBoardTrigger() {
            _stage.divingBoard_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, divingBoardRollOver);
            _stage.divingBoard_btn.onRollOut = com.clubpenguin.util.Delegate.create(this, divingBoardRollOut);
            _stage.divingBoard_btn.onReleaseOutside = com.clubpenguin.util.Delegate.create(this, divingBoardRollOut);
            _stage.divingBoard_btn.useHandCursor = false;
            var _local_2 = new com.clubpenguin.world.rooms.hotel.hotelcarestations.HotelCareStationVO();
            _local_2.effectRef = _stage.background_mc.divingBoardState_mc.divingBoard_mc;
            _local_2.taskEnum = PLAY_TASK;
            _local_2.assetPath = DIVING_PATH;
            _divingBoard = new com.clubpenguin.world.rooms.hotel.hotelcarestations.HotelCareStation(_local_2);
            _divingBoard.stationBIInfo("cruise_deck", com.clubpenguin.engine.puffles.pufflecarestations.PuffleCareStationsConstants.PUFFLE_PLAY_STATION);
            configureStationTrigger(_divingBoard, _divingBoardTrigger, _stage.triggers_mc.divingBoard_mc);
        }
        function configureStationTrigger(careStation, playerTrigger, triggerClip) {
            trace("configureStationTrigger");
            playerTrigger = new com.clubpenguin.world.rooms.common.triggers.PlayerTrigger(triggerClip);
            playerTrigger.playersAdded.add(com.clubpenguin.util.Delegate.create(careStation, careStation.beginActivity));
            playerTrigger.playersRemoved.add(com.clubpenguin.util.Delegate.create(careStation, careStation.endActivity));
            _triggerWatcher.addTrigger(playerTrigger);
        }
        function destroy() {
            trace(CLASS_NAME + ": destroy()");
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
        }
        function showClassDialog1() {
            _stage.interface_mc.dialog1.gotoAndStop("on");
        }
        function showClassDialog2() {
            _stage.interface_mc.dialog2.gotoAndStop("on");
        }
        function showClassDialog3() {
            _stage.interface_mc.dialog3.gotoAndStop("on");
        }
        function showClassDialog4() {
            _stage.interface_mc.dialog4.gotoAndStop("on");
        }
        function dialog1Finished() {
            _stage.interface_mc.dialog1.gotoAndStop("off");
            _stage.DirectorIntro2.gotoAndPlay("action");
        }
        function dialog2Finished() {
            _stage.interface_mc.dialog2.gotoAndStop("off");
            _stage.DirectorIntro3.gotoAndPlay("action");
        }
        function dialog3Finished() {
            _stage.interface_mc.dialog3.gotoAndStop("off");
            _stage.DirectorIntro4.gotoAndPlay("action");
        }
        function dialog4Finished() {
            _stage.interface_mc.dialog4.gotoAndStop("off");
            _stage.block_mc.blockSoloPlayerSnatcher.gotoAndStop("off");
            hasAlreadySeenIntro = true;
        }
        static var CLASS_NAME = "UFOhub";
        var ufoRedAlert = false;
        var hasAlreadySeenIntro = true;
        static var SLIDE_COMMAND = "followpath";
        static var WATER_SPLASH_EFFECT = "waterSplashEffect";
        static var DIVING_PATH = com.clubpenguin.world.rooms.hotel.hotelcarestations.HotelCareStationAnimationConstants.PUFFLE_DIVE;
        static var PLAY_TASK = com.clubpenguin.world.rooms.hotel.hotelcarestations.HotelCareTaskEnum.PLAYING_TASK;
    }
