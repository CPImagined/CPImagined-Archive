//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2014.prehistoric.Restaurant extends com.clubpenguin.world.rooms.BaseRoom
    {
        var _stage, localize, _destroyDelegate, _SHELL, setupNavigationButtons, _triggerWatcher, _triggerWatcherInterval, _INTERFACE, _bedStation1, _bedStation2, _bedStationTrigger1, _bedStationTrigger2;
        function Restaurant (stageReference) {
            super(stageReference);
            trace(CLASS_NAME + "()");
            _stage.start_x = 200;
            _stage.start_y = 300;
            _stage.customPenguinSize = 85;
        }
        function init() {
            trace(CLASS_NAME + ": init()");
            localize([]);
            _destroyDelegate = com.clubpenguin.util.Delegate.create(this, destroy);
            _SHELL.addListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            _stage.foreground_mc.partyCat_btn.onRelease = com.clubpenguin.util.Delegate.create(this, showContent, com.clubpenguin.world.rooms.common.RoomConstants.PARTY_CATALOGUE_1);
            _stage.triggers_mc.party8_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "party8", 270, 260);
            _stage.triggers_mc.party3_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "party3", 275, 290);
            setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.forest_mc.forest_btn, 720, 215), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.forest_mc.forest_btn, 720, 215), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.bedStation01_mc.puffleRockBedSmallNav_btn, 625, 352), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.bedStation02_mc.puffleRockBedSmallNav_btn, 680, 329), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.town_mc.town_btn, 50, 450)]);
            _triggerWatcher = new com.clubpenguin.world.rooms.common.triggers.TriggerWatcher(_stage, _SHELL);
            clearInterval(_triggerWatcherInterval);
            _triggerWatcherInterval = setInterval(_triggerWatcher, "checkAllPlayers", 40);
            configureBedStationTriggers();
        }
        function exit(roomName, x, y) {
            trace(CLASS_NAME + ": exit()");
            _SHELL.sendJoinRoom(roomName, x, y);
        }
        function showContent(content) {
            _INTERFACE.showContent(content);
        }
        function destroy() {
            trace(CLASS_NAME + ": destroy()");
            clearInterval(_triggerWatcherInterval);
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            _bedStation1.cleanStation();
            _bedStation2.cleanStation();
        }
        function configureBedStationTriggers() {
            var _local_2 = new com.clubpenguin.world.rooms.hotel.hotelcarestations.HotelCareSound("snoringLoopSFX", _stage.bedStation01_mc);
            var _local_3 = new com.clubpenguin.world.rooms.hotel.hotelcarestations.HotelCareSound("snoringLoopSFX", _stage.bedStation02_mc);
            _bedStation1 = new com.clubpenguin.world.rooms.hotel.hotelcarestations.HotelCareStation(null, SLEEPING_TASK, SLEEP_FRAME, null, _local_2);
            _bedStation2 = new com.clubpenguin.world.rooms.hotel.hotelcarestations.HotelCareStation(null, SLEEPING_TASK, SLEEP_FRAME, null, _local_3);
            _bedStation1.stationBIInfo("prehistoric_bed", com.clubpenguin.engine.puffles.pufflecarestations.PuffleCareStationsConstants.PUFFLE_SLEEP_STATION);
            _bedStation2.stationBIInfo("prehistoric_bed", com.clubpenguin.engine.puffles.pufflecarestations.PuffleCareStationsConstants.PUFFLE_SLEEP_STATION);
            configureStationTrigger(_bedStation1, _bedStationTrigger1, _stage.triggers_mc.bedStation01_mc);
            configureStationTrigger(_bedStation2, _bedStationTrigger2, _stage.triggers_mc.bedStation02_mc);
        }
        function configureStationTrigger(careStation, playerTrigger, triggerClip) {
            playerTrigger = new com.clubpenguin.world.rooms.common.triggers.PlayerTrigger(triggerClip);
            playerTrigger.playersAdded.add(com.clubpenguin.util.Delegate.create(careStation, careStation.beginActivity));
            playerTrigger.playersRemoved.add(com.clubpenguin.util.Delegate.create(careStation, careStation.endActivity));
            _triggerWatcher.addTrigger(playerTrigger);
        }
        static var CLASS_NAME = "Restaurant";
        static var SLEEPING_TASK = com.clubpenguin.world.rooms.hotel.hotelcarestations.HotelCareTaskEnum.SLEEPING_TASK;
        static var SLEEP_FRAME = com.clubpenguin.puffleavatar.PuffleAvatarConstants.PUFFLE_SLEEP_FRAME;
    }
