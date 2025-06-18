//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2014.prehistoric.CaveManVillage extends com.clubpenguin.world.rooms.BaseRoom
    {
        var _stage, _destroyDelegate, _SHELL, _triggerWatcher, _stomp1Trigger, _triggerWatcherInterval, setupNavigationButtons, _INTERFACE, _bedStation1, _bedStationTrigger1;
        function CaveManVillage (stageReference) {
            super(stageReference);
            _stage.start_x = 545;
            _stage.start_y = 200;
            _stage.customPenguinSize = 85;
        }
        function init() {
            _destroyDelegate = com.clubpenguin.util.Delegate.create(this, destroy);
            _SHELL.addListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            _triggerWatcher = new com.clubpenguin.world.rooms.common.triggers.TriggerWatcher(_stage, _SHELL);
            _stage.foreground_mc.partyCat_btn.onRelease = com.clubpenguin.util.Delegate.create(this, showContent, com.clubpenguin.world.rooms.common.RoomConstants.PARTY_CATALOGUE_1);
            _stage.triggers_mc.town_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "party3", 215, 320);
            _stomp1Trigger = new com.clubpenguin.world.rooms.common.triggers.PlayerWalkTrigger(_stage.triggers_mc.stomp1_mc);
            _stomp1Trigger.playersAdded.add(com.clubpenguin.util.Delegate.create(this, stompOnItem, _stage.stomp1_mc));
            _triggerWatcher.addTrigger(_stomp1Trigger);
            clearInterval(_triggerWatcherInterval);
            _triggerWatcherInterval = setInterval(_triggerWatcher, "checkAllPlayers", 40);
            setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.bed.puffleRockBedSmallNav_btn, 215, 198)]);
            configureBedStationTriggers();
        }
        function stompOnItem(players, itemMC) {
            var _local_5;
            var _local_2 = 0;
            while (_local_2 < players.length) {
                var _local_3 = _SHELL.getPlayerObjectById(players[_local_2]);
                if (com.clubpenguin.world.rooms2014.prehistoric.PrehistoricParty.canPlayerStomp(_local_3.avatar_id)) {
                    _local_5 = true;
                    break;
                }
                _local_2++;
            }
            if ((itemMC._currentframe == 1) && (_local_5)) {
                itemMC.gotoAndStop(2);
            }
        }
        function exit(roomName, x, y) {
            _SHELL.sendJoinRoom(roomName, x, y);
        }
        function showContent(content) {
            _INTERFACE.showContent(content);
        }
        function destroy() {
            clearInterval(_triggerWatcherInterval);
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
        }
        function configureBedStationTriggers() {
            var _local_2 = new com.clubpenguin.world.rooms.hotel.hotelcarestations.HotelCareSound("snoringLoopSFX", _stage.bed);
            _bedStation1 = new com.clubpenguin.world.rooms.hotel.hotelcarestations.HotelCareStation(null, SLEEPING_TASK, SLEEP_FRAME, null, _local_2);
            _bedStation1.stationBIInfo("prehistoric_bed", com.clubpenguin.engine.puffles.pufflecarestations.PuffleCareStationsConstants.PUFFLE_SLEEP_STATION);
            configureStationTrigger(_bedStation1, _bedStationTrigger1, _stage.triggers_mc.bedStation01_mc);
        }
        function configureStationTrigger(careStation, playerTrigger, triggerClip) {
            playerTrigger = new com.clubpenguin.world.rooms.common.triggers.PlayerTrigger(triggerClip);
            playerTrigger.playersAdded.add(com.clubpenguin.util.Delegate.create(careStation, careStation.beginActivity));
            playerTrigger.playersRemoved.add(com.clubpenguin.util.Delegate.create(careStation, careStation.endActivity));
            _triggerWatcher.addTrigger(playerTrigger);
        }
        static var CLASS_NAME = "CaveManVillage";
        static var SLEEPING_TASK = com.clubpenguin.world.rooms.hotel.hotelcarestations.HotelCareTaskEnum.SLEEPING_TASK;
        static var SLEEP_FRAME = com.clubpenguin.puffleavatar.PuffleAvatarConstants.PUFFLE_SLEEP_FRAME;
    }
