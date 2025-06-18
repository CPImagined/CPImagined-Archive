//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2014.prehistoric.PrehistoricHub extends com.clubpenguin.world.rooms.BaseRoom
    {
        var _stage, _SHELL, _triggerWatcher, localize, _destroyDelegate, setupNavigationButtons, _stomp1Trigger, _stomp2Trigger, _triggerWatcherInterval, _INTERFACE, _weightStation1, _weightStationTrigger1;
        function PrehistoricHub (stageReference) {
            super(stageReference);
            _stage.start_x = 420;
            _stage.start_y = 200;
            _stage.customPenguinSize = 85;
            if (!_SHELL) {
                init();
            }
        }
        function init() {
            _triggerWatcher = new com.clubpenguin.world.rooms.common.triggers.TriggerWatcher(_stage, _SHELL);
            localize([_stage.hut_mc.lang_PrehistoricIgloos, _stage.background_mc.message_mc]);
            _destroyDelegate = com.clubpenguin.util.Delegate.create(this, destroy);
            _SHELL.addListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            _stage.triggers_mc.party1_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "party1", 550, 370);
            _stage.triggers_mc.party6_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "party6", 150, 365);
            _stage.triggers_mc.party3_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "party3", 653, 218);
            _stage.triggers_mc.party8_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "party8", 400, 375);
            _stage.triggers_mc.prehistoricIgloosTrigger_mc.triggerFunction = com.clubpenguin.util.Delegate.create(com.clubpenguin.world.rooms2014.prehistoric.PrehistoricParty, com.clubpenguin.world.rooms2014.prehistoric.PrehistoricParty.showDinoDigIglooList);
            var _local_3 = com.clubpenguin.util.Delegate.create(com.clubpenguin.world.rooms2014.prehistoric.PrehistoricParty, com.clubpenguin.world.rooms2014.prehistoric.PrehistoricParty.launchDinoDigGame);
            var _local_2 = com.clubpenguin.util.Delegate.create(this, showContent, com.clubpenguin.world.rooms.common.RoomConstants.PARTY_CATALOGUE_1);
            _stage.triggers_mc.game1_mc.triggerFunction = _local_3;
            _stage.triggers_mc.game2_mc.triggerFunction = _local_3;
            _stage.triggers_mc.prehistoricIgloosTrigger_mc.triggerFunction = com.clubpenguin.util.Delegate.create(com.clubpenguin.world.rooms2014.prehistoric.PrehistoricParty, com.clubpenguin.world.rooms2014.prehistoric.PrehistoricParty.showDinoDigIglooList);
            _stage.desk_mc.prehistoric_cat_btn.onRelease = _local_2;
            _stage.foreground_mc.partyCat_btn.onRelease = _local_2;
            setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.nest1_mc.nest1_btn, 268, 268), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.nest2_mc.nest2_btn, 585, 335), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.timeMachine_mc.timeMachine_btn, 400, 400), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.weightEffect01_mc, 590, 225)]);
            _stomp1Trigger = new com.clubpenguin.world.rooms.common.triggers.PlayerWalkTrigger(_stage.triggers_mc.stomp1_mc);
            _stomp1Trigger.playersAdded.add(com.clubpenguin.util.Delegate.create(this, stompOnItem, _stage.stomp1_mc));
            _triggerWatcher.addTrigger(_stomp1Trigger);
            _stomp2Trigger = new com.clubpenguin.world.rooms.common.triggers.PlayerWalkTrigger(_stage.triggers_mc.stomp2_mc);
            _stomp2Trigger.playersAdded.add(com.clubpenguin.util.Delegate.create(this, stompOnItem, _stage.stomp2_mc));
            _triggerWatcher.addTrigger(_stomp2Trigger);
            _stage.nest2_mc.nest2_btn.onRollOver = com.clubpenguin.util.Delegate.create(com.clubpenguin.world.rooms2014.prehistoric.PrehistoricParty, com.clubpenguin.world.rooms2014.prehistoric.PrehistoricParty.showDinoDigHint, _stage.nest2_mc);
            _stage.nest2_mc.nest2_btn.onRollOut = com.clubpenguin.util.Delegate.create(com.clubpenguin.world.rooms2014.prehistoric.PrehistoricParty, com.clubpenguin.world.rooms2014.prehistoric.PrehistoricParty.hideDinoDigHint);
            configureWeightStationTriggers();
            clearInterval(_triggerWatcherInterval);
            _triggerWatcherInterval = setInterval(_triggerWatcher, "checkAllPlayers", 40);
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
            _weightStation1.cleanStation();
        }
        function configureWeightStationTriggers() {
            _weightStation1 = new com.clubpenguin.world.rooms.hotel.hotelcarestations.HotelCareStation(_stage.weightEffect01_mc, PLAY_TASK, null, WEIGHTS_PATH);
            _weightStation1.stationBIInfo("prehistoric_weights", com.clubpenguin.engine.puffles.pufflecarestations.PuffleCareStationsConstants.PUFFLE_PLAY_STATION);
            configureStationTrigger(_weightStation1, _weightStationTrigger1, _stage.triggers_mc.weightStation01_mc);
        }
        function configureStationTrigger(careStation, playerTrigger, triggerClip) {
            playerTrigger = new com.clubpenguin.world.rooms.common.triggers.PlayerTrigger(triggerClip);
            playerTrigger.playersAdded.add(com.clubpenguin.util.Delegate.create(careStation, careStation.beginActivity));
            playerTrigger.playersRemoved.add(com.clubpenguin.util.Delegate.create(careStation, careStation.endActivity));
            _triggerWatcher.addTrigger(playerTrigger);
        }
        static var CLASS_NAME = "PrehistoricHub";
        static var WEIGHTS_FRAME = com.clubpenguin.puffleavatar.PuffleAvatarConstants.PUFFLE_WALK_SOUTH_FRAME;
        static var WEIGHTS_PATH = com.clubpenguin.world.rooms.hotel.hotelcarestations.HotelCareStationAnimationConstants.PUFFLE_BARBELL;
        static var PLAY_TASK = com.clubpenguin.world.rooms.hotel.hotelcarestations.HotelCareTaskEnum.PLAYING_TASK;
    }
