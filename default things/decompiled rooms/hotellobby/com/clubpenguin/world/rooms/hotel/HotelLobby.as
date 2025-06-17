//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms.hotel.HotelLobby extends com.clubpenguin.world.rooms.BaseRoom
    {
        var _stage, _SHELL, _destroyDelegate, _triggerWatcher, _triggerWatcherInterval, localize, setupNavigationButtons, showContent, _INTERFACE, _smoothieChair1, _smoothieChair2, _smoothieChairTrigger1, _smoothieChairTrigger2, _bedStation1, _bedStation2, _bedStationTrigger1, _bedStationTrigger2;
        function HotelLobby (stageReference) {
            super(stageReference);
            _stage.start_x = 390;
            _stage.start_y = 170;
            if (!_SHELL) {
                init();
            }
        }
        function init() {
            if (_SHELL.getRainbowPuffleQuest().getRainbowQuestCookieVO.isInitialized() == false) {
                _SHELL.getRainbowPuffleQuest().getRainbowQuestCookieVO.requestFromServer();
            }
            _destroyDelegate = com.clubpenguin.util.Delegate.create(this, destroy);
            _SHELL.addListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            _triggerWatcher = new com.clubpenguin.world.rooms.common.triggers.TriggerWatcher(_stage, _SHELL);
            clearInterval(_triggerWatcherInterval);
            _triggerWatcherInterval = setInterval(_triggerWatcher, "checkAllPlayers", 40);
            configureSmoothieChairTriggers();
            configureBedStationTriggers();
            localize([_stage.leftWall.sign, _stage.rightWall.sign, _stage.petShopEntrance, _stage.interface_mc]);
            setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.plaza_btn, 390, 150), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.elevator.elevator_btn, 45, 255), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.petPillar1_mc.pet_btn, 715, 230), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.smoothieChair01_mc.chair01_btn, 148, 329), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.smoothieChair02_mc.chair02_btn, 183, 387), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.bedStation01_mc.bed01_btn, 608, 396), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.bedStation02_mc.bed02_btn, 680, 339)]);
            _stage.interface_mc.questButton.onRelease = com.clubpenguin.util.Delegate.create(this, showContentPopup, com.clubpenguin.quests.rainbowpuffle.RainbowPuffleQuest.PUFFLE_QUEST_UI);
            showContent([new com.clubpenguin.world.rooms.common.PopupContentVO(_stage.interface_mc.catalogueButton, true, "catalog_viewer", "", _INTERFACE.getFilePath("pets_catalogue"))]);
            _stage.petPillar1_mc.pet_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, petDoorRollOver);
            _stage.petPillar1_mc.pet_btn.onRollOut = com.clubpenguin.util.Delegate.create(this, petDoorRollOut);
            _stage.petPillar1_mc.pet_btn.onReleaseOutside = com.clubpenguin.util.Delegate.create(this, petDoorRollOut);
            _stage.background_mc.plaza_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, plazaDoorRollOver);
            _stage.background_mc.plaza_btn.onRollOut = com.clubpenguin.util.Delegate.create(this, plazaDoorRollOut);
            _stage.background_mc.plaza_btn.onReleaseOutside = com.clubpenguin.util.Delegate.create(this, plazaDoorRollOut);
            _stage.elevator.elevator_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, elevatorRollOver);
            _stage.elevator.elevator_btn.onRollOut = com.clubpenguin.util.Delegate.create(this, elevatorRollOut);
            _stage.elevator.elevator_btn.onReleaseOutside = com.clubpenguin.util.Delegate.create(this, elevatorRollOut);
            _stage.questBoard.quest_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, questBoardRollOver);
            _stage.questBoard.quest_btn.onRollOut = com.clubpenguin.util.Delegate.create(this, questBoardRollOut);
            _stage.questBoard.quest_btn.onReleaseOutside = com.clubpenguin.util.Delegate.create(this, questBoardRollOut);
            _stage.questBoard.quest_btn.onRelease = com.clubpenguin.util.Delegate.create(this, showContentPopup, com.clubpenguin.quests.rainbowpuffle.RainbowPuffleQuest.PUFFLE_QUEST_UI);
            _stage.smoothieChair01_mc.chair01_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, chair01RollOver);
            _stage.smoothieChair01_mc.chair01_btn.onRollOut = com.clubpenguin.util.Delegate.create(this, chair01RollOut);
            _stage.smoothieChair01_mc.chair01_btn.onReleaseOutside = com.clubpenguin.util.Delegate.create(this, chair01RollOut);
            _stage.smoothieChair02_mc.chair02_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, chair02RollOver);
            _stage.smoothieChair02_mc.chair02_btn.onRollOut = com.clubpenguin.util.Delegate.create(this, chair02RollOut);
            _stage.smoothieChair02_mc.chair02_btn.onReleaseOutside = com.clubpenguin.util.Delegate.create(this, chair02RollOut);
            _stage.triggers_mc.elevator_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, elevatorUI);
            _stage.triggers_mc.plaza_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "plaza", 285, 260);
            _stage.triggers_mc.pet_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "pet", 105, 360);
        }
        function configureSmoothieChairTriggers() {
            var _local_2 = new com.clubpenguin.world.rooms.hotel.hotelcarestations.HotelCareStationVO();
            _local_2.effectRef = _stage.table01_mc.smoothieEffect01_mc;
            _local_2.taskEnum = EATING_TASK;
            _local_2.puffleFrame = STAND_FRAME;
            _smoothieChair1 = new com.clubpenguin.world.rooms.hotel.hotelcarestations.HotelCareStation(_local_2);
            _smoothieChair1.stationBIInfo(com.clubpenguin.engine.puffles.pufflecarestations.PuffleCareStationsConstants.SMOOTHIE_CARESTATION, com.clubpenguin.engine.puffles.pufflecarestations.PuffleCareStationsConstants.PUFFLE_FOOD_STATION);
            _local_2.effectRef = _stage.table02_mc.smoothieEffect02_mc;
            _smoothieChair2 = new com.clubpenguin.world.rooms.hotel.hotelcarestations.HotelCareStation(_local_2);
            _smoothieChair2.stationBIInfo(com.clubpenguin.engine.puffles.pufflecarestations.PuffleCareStationsConstants.SMOOTHIE_CARESTATION, com.clubpenguin.engine.puffles.pufflecarestations.PuffleCareStationsConstants.PUFFLE_FOOD_STATION);
            configureStationTrigger(_smoothieChair1, _smoothieChairTrigger1, _stage.triggers_mc.smoothieChair01_mc);
            configureStationTrigger(_smoothieChair2, _smoothieChairTrigger2, _stage.triggers_mc.smoothieChair02_mc);
        }
        function configureBedStationTriggers() {
            var _local_2 = new com.clubpenguin.world.rooms.hotel.hotelcarestations.HotelCareStationVO();
            _local_2.careSound = new com.clubpenguin.world.rooms.hotel.hotelcarestations.HotelCareSound("snoringLoopSFX", _stage.bedStation01_mc, false);
            _local_2.taskEnum = SLEEPING_TASK;
            _local_2.puffleFrame = SLEEP_FRAME;
            _bedStation1 = new com.clubpenguin.world.rooms.hotel.hotelcarestations.HotelCareStation(_local_2);
            _bedStation1.stationBIInfo(com.clubpenguin.engine.puffles.pufflecarestations.PuffleCareStationsConstants.LOBBY_BED_CARESTATION, com.clubpenguin.engine.puffles.pufflecarestations.PuffleCareStationsConstants.PUFFLE_SLEEP_STATION);
            _local_2.careSound = new com.clubpenguin.world.rooms.hotel.hotelcarestations.HotelCareSound("snoringLoopSFX", _stage.bedStation02_mc, false);
            _bedStation2 = new com.clubpenguin.world.rooms.hotel.hotelcarestations.HotelCareStation(_local_2);
            _bedStation2.stationBIInfo(com.clubpenguin.engine.puffles.pufflecarestations.PuffleCareStationsConstants.LOBBY_BED_CARESTATION, com.clubpenguin.engine.puffles.pufflecarestations.PuffleCareStationsConstants.PUFFLE_SLEEP_STATION);
            configureStationTrigger(_bedStation1, _bedStationTrigger1, _stage.triggers_mc.bedStation01_mc);
            configureStationTrigger(_bedStation2, _bedStationTrigger2, _stage.triggers_mc.bedStation02_mc);
        }
        function configureStationTrigger(careStation, playerTrigger, triggerClip) {
            playerTrigger = new com.clubpenguin.world.rooms.common.triggers.PlayerTrigger(triggerClip);
            playerTrigger.playersAdded.add(com.clubpenguin.util.Delegate.create(careStation, careStation.beginActivity));
            playerTrigger.playersRemoved.add(com.clubpenguin.util.Delegate.create(careStation, careStation.endActivity));
            _triggerWatcher.addTrigger(playerTrigger);
        }
        function elevatorUI() {
            _INTERFACE.showContent(com.clubpenguin.quests.rainbowpuffle.RainbowPuffleQuest.HOTEL_ELEVATOR_UI);
        }
        function petDoorRollOver() {
            var _local_2 = new Sound(_stage);
            _local_2.attachSound("sfxPetDoorOpen");
            _local_2.start();
        }
        function petDoorRollOut() {
            var _local_2 = new Sound(_stage);
            _local_2.attachSound("sfxPetDoorClose");
            _local_2.start();
        }
        function plazaDoorRollOver() {
            var _local_2 = new Sound(_stage);
            _local_2.attachSound("sfxPlazaDoorOpen");
            _local_2.start();
        }
        function plazaDoorRollOut() {
            var _local_2 = new Sound(_stage);
            _local_2.attachSound("sfxPlazaDoorClose");
            _local_2.start();
        }
        function elevatorRollOver() {
            if (_stage.elevator._currentFrame == 1) {
                _stage.elevator.gotoAndPlay("open");
            } else {
                _stage.elevator.gotoAndPlay(43 - (_stage.elevator._currentFrame - 9));
            }
        }
        function elevatorRollOut() {
            if (_stage.elevator._currentFrame > 22) {
                _stage.elevator.gotoAndPlay("close");
            } else {
                _stage.elevator.gotoAndPlay(9 + (43 - _stage.elevator._currentFrame));
            }
        }
        function chair01RollOver() {
            _stage.table01_mc.table01state_mc.gotoAndStop("rollOver");
        }
        function chair01RollOut() {
            _stage.table01_mc.table01state_mc.gotoAndStop("rollOut");
        }
        function chair02RollOver() {
            _stage.table02_mc.table02state_mc.gotoAndStop("rollOver");
        }
        function chair02RollOut() {
            _stage.table02_mc.table02state_mc.gotoAndStop("rollOut");
        }
        function questBoardRollOver() {
            _stage.questBoard.gotoAndPlay("rollOver");
        }
        function questBoardRollOut() {
            _stage.questBoard.gotoAndStop(1);
        }
        function exit(name, x, y) {
            _SHELL.sendJoinRoom(name, x, y);
        }
        function showContentPopup(contentID, data) {
            _INTERFACE.showContent(contentID, null, null, data, null);
        }
        function destroy() {
            clearInterval(_triggerWatcherInterval);
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            _smoothieChair1.cleanStation();
            _smoothieChair2.cleanStation();
            _bedStation1.cleanStation();
            _bedStation2.cleanStation();
        }
        static var CLASS_NAME = "HotelLobby";
        static var EATING_TASK = com.clubpenguin.world.rooms.hotel.hotelcarestations.HotelCareTaskEnum.EATING_TASK;
        static var SLEEPING_TASK = com.clubpenguin.world.rooms.hotel.hotelcarestations.HotelCareTaskEnum.SLEEPING_TASK;
        static var STAND_FRAME = com.clubpenguin.puffleavatar.PuffleAvatarConstants.PUFFLE_STAND_SOUTH_FRAME;
        static var SLEEP_FRAME = com.clubpenguin.puffleavatar.PuffleAvatarConstants.PUFFLE_SLEEP_FRAME;
    }
