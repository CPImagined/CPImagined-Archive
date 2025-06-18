//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2014.prehistoric.TriceratopsHQ extends com.clubpenguin.world.rooms.BaseRoom
    {
        var _stage, _destroyDelegate, _SHELL, _triggerWatcher, setupNavigationButtons, _triggerWatcherInterval, _ENGINE, _INTERFACE, feedingTrigger, _bedStation1, _bedStationTrigger1;
        function TriceratopsHQ (stageReference) {
            super(stageReference);
            _stage.start_x = 370;
            _stage.start_y = 245;
            _stage.customPenguinSize = 85;
        }
        function init() {
            _destroyDelegate = com.clubpenguin.util.Delegate.create(this, destroy);
            _SHELL.addListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            _triggerWatcher = new com.clubpenguin.world.rooms.common.triggers.TriggerWatcher(_stage, _SHELL);
            _stage.triggers_mc.coffee_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "party4", 620, 260);
            _stage.triggers_mc.forts_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "party2", 325, 180);
            _stage.triggers_mc.swamp_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "party7", 175, 250);
            var _local_2 = com.clubpenguin.util.Delegate.create(this, joinGame, com.clubpenguin.world.rooms2013.prehistoric.Prehistoric.DINO_HUNT_GAME, true);
            _stage.triggers_mc.nest1_mc.triggerFunction = _local_2;
            _stage.triggers_mc.nest2_mc.triggerFunction = _local_2;
            _stage.foreground_mc.partyCat_btn.onRelease = com.clubpenguin.util.Delegate.create(this, showContent, com.clubpenguin.world.rooms.common.RoomConstants.PARTY_CATALOGUE_1);
            setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.coffee_mc.coffee_btn, 190, 190), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.nest1_mc.nest_btn, 585, 395), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.nest2_mc.nest_btn, 675, 345), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.pufflebed.puffleRockBedSmallNav_btn, 595, 121), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.treeComp.prehistoricPuffleTreeNav_btn, 481, 159)]);
            clearInterval(_triggerWatcherInterval);
            _triggerWatcherInterval = setInterval(_triggerWatcher, "checkAllPlayers", 40);
            _stage.nest1_mc.nest_btn.onRollOver = com.clubpenguin.util.Delegate.create(com.clubpenguin.world.rooms2014.prehistoric.PrehistoricParty, com.clubpenguin.world.rooms2014.prehistoric.PrehistoricParty.showDinoDigHint, _stage.nest1_mc);
            _stage.nest1_mc.nest_btn.onRollOut = com.clubpenguin.util.Delegate.create(com.clubpenguin.world.rooms2014.prehistoric.PrehistoricParty, com.clubpenguin.world.rooms2014.prehistoric.PrehistoricParty.hideDinoDigHint);
            _stage.nest2_mc.nest_btn.onRollOver = com.clubpenguin.util.Delegate.create(com.clubpenguin.world.rooms2014.prehistoric.PrehistoricParty, com.clubpenguin.world.rooms2014.prehistoric.PrehistoricParty.showDinoDigHint, _stage.nest2_mc);
            _stage.nest2_mc.nest_btn.onRollOut = com.clubpenguin.util.Delegate.create(com.clubpenguin.world.rooms2014.prehistoric.PrehistoricParty, com.clubpenguin.world.rooms2014.prehistoric.PrehistoricParty.hideDinoDigHint);
            configureBedStationTriggers();
            configurePuffleFeedingStation();
        }
        function exit(roomName, x, y) {
            _SHELL.sendJoinRoom(roomName, x, y);
        }
        function joinGame(gameName, is_prompt) {
            _ENGINE.sendJoinGame(gameName, is_prompt);
        }
        function showContent(content) {
            _INTERFACE.showContent(content);
        }
        function destroy() {
            clearInterval(_triggerWatcherInterval);
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
        }
        function configurePuffleFeedingStation() {
            feedingTrigger = new com.clubpenguin.world.rooms.common.triggers.PlayerTrigger(_stage.triggers_mc.tree_mc);
            feedingTrigger.playersAdded.add(com.clubpenguin.util.Delegate.create(this, playPuffleFeeding));
            _triggerWatcher.addTrigger(feedingTrigger);
        }
        function playPuffleFeeding(playerList) {
            var _local_2 = 0;
            while (_local_2 < playerList.length) {
                _global.getCurrentParty().PrehistoricParty.onPuffleCareStationFeed(playerList[_local_2]);
                _local_2++;
            }
        }
        function configureBedStationTriggers() {
            var _local_2 = new com.clubpenguin.world.rooms.hotel.hotelcarestations.HotelCareSound("snoringLoopSFX", _stage.pufflebed);
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
        static var CLASS_NAME = "TriceratopsHQ";
        static var EATING_TASK = com.clubpenguin.world.rooms.hotel.hotelcarestations.HotelCareTaskEnum.EATING_TASK;
        static var EATING_FRAME = com.clubpenguin.puffleavatar.PuffleAvatarConstants.PUFFLE_STAND_SOUTH_FRAME;
        static var SLEEPING_TASK = com.clubpenguin.world.rooms.hotel.hotelcarestations.HotelCareTaskEnum.SLEEPING_TASK;
        static var SLEEP_FRAME = com.clubpenguin.puffleavatar.PuffleAvatarConstants.PUFFLE_SLEEP_FRAME;
    }
