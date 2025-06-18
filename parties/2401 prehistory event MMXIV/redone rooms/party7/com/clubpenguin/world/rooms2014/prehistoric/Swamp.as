//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2014.prehistoric.Swamp extends com.clubpenguin.world.rooms.BaseRoom
    {
        var _stage, _destroyDelegate, _handlePlayerFrameDelegate, _SHELL, _triggerWatcher, setupNavigationButtons, _fireRockTrigger, _stomp1Trigger, _triggerWatcherInterval, _shakingTimeout, _shakeableDelegate, _roomShakeables, _ENGINE, _INTERFACE, _secondCheckIntervalID, _weightStation1, _weightStationTrigger1, feedingTrigger;
        function Swamp (stageReference) {
            super(stageReference);
            _stage.start_x = 250;
            _stage.start_y = 300;
            _stage.customPenguinSize = 85;
        }
        function init() {
            _destroyDelegate = com.clubpenguin.util.Delegate.create(this, destroy);
            _handlePlayerFrameDelegate = com.clubpenguin.util.Delegate.create(this, handlePlayerFrame);
            _SHELL.addListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            _SHELL.addListener(_SHELL.PLAYER_FRAME, _handlePlayerFrameDelegate);
            _triggerWatcher = new com.clubpenguin.world.rooms.common.triggers.TriggerWatcher(_stage, _SHELL);
            _stage.triggers_mc.jungle_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "party8", 660, 265);
            _stage.triggers_mc.nestGrounds_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "party6", 370, 220);
            _stage.triggers_mc.badlands_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "party9", 170, 380);
            _stage.triggers_mc.volcano_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "party15", 685, 330);
            var _local_3 = com.clubpenguin.util.Delegate.create(_global.getCurrentParty().PrehistoricParty, _global.getCurrentParty().PrehistoricParty.launchDinoDigGame);
            _stage.triggers_mc.nest1_mc.triggerFunction = _local_3;
            setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.seat1_btn, 220, 350), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.seat2_btn, 310, 370), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.seat3_btn, 175, 387), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.seat4_btn, 205, 420), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.seat5_btn, 295, 415), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.nest1_mc.nest_btn, 370, 285), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.weightEffect01_mc.buttonFrame, 575, 235), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.treeComp.prehistoricPuffleTreeNav_btn, 190, 170)]);
            _stage.cavemanFire_mc.gotoAndStop(2);
            _stage.seat1_btn.useHandCursor = false;
            _stage.seat2_btn.useHandCursor = false;
            _stage.seat3_btn.useHandCursor = false;
            _stage.seat4_btn.useHandCursor = false;
            _stage.seat5_btn.useHandCursor = false;
            _stage.destructo1_btn.useHandCursor = false;
            _stage.destructo2_btn.useHandCursor = false;
            _stage.destructo3_btn.useHandCursor = false;
            _fireRockTrigger = new com.clubpenguin.world.rooms.common.triggers.PlayerWalkTrigger(_stage.triggers_mc.fireRockTrigger_mc);
            _fireRockTrigger.playersAdded.add(com.clubpenguin.util.Delegate.create(this, startFire));
            _fireRockTrigger.playersRemoved.add(com.clubpenguin.util.Delegate.create(this, stopFire));
            _triggerWatcher.addTrigger(_fireRockTrigger);
            configureWeightStationTriggers();
            _stomp1Trigger = new com.clubpenguin.world.rooms.common.triggers.PlayerWalkTrigger(_stage.triggers_mc.stomp1_mc);
            _stomp1Trigger.playersAdded.add(com.clubpenguin.util.Delegate.create(this, stompOnItem, _stage.stomp1_mc));
            _triggerWatcher.addTrigger(_stomp1Trigger);
            clearInterval(_triggerWatcherInterval);
            _triggerWatcherInterval = setInterval(_triggerWatcher, "checkAllPlayers", 40);
            configurePuffleFeedingStation();
            _stage.nest1_mc.nest_btn.onRollOver = com.clubpenguin.util.Delegate.create(com.clubpenguin.world.rooms2014.prehistoric.PrehistoricParty, com.clubpenguin.world.rooms2014.prehistoric.PrehistoricParty.showDinoDigHint, _stage.nest1_mc);
            _stage.nest1_mc.nest_btn.onRollOut = com.clubpenguin.util.Delegate.create(com.clubpenguin.world.rooms2014.prehistoric.PrehistoricParty, com.clubpenguin.world.rooms2014.prehistoric.PrehistoricParty.hideDinoDigHint);
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
        function update() {
            _triggerWatcher.checkAllPlayers();
        }
        function startFire() {
            if (_stage.cavemanFire_mc._currentframe == 2) {
                _stage.cavemanFire_mc.gotoAndStop(1);
            }
        }
        function stopFire() {
            if (_fireRockTrigger.getPlayerCount() > 0) {
                return(undefined);
            }
            _stage.cavemanFire_mc.gotoAndStop(2);
        }
        function handlePlayerFrame(event) {
            var _local_3 = event.player_id;
            var _local_4 = event.frame;
            var _local_5 = _SHELL.getPlayerObjectById(_local_3);
            if ((_local_4 == com.clubpenguin.world.rooms2013.prehistoric.Prehistoric.DANCE_FRAME) && (com.clubpenguin.world.rooms2013.prehistoric.Prehistoric.isPlayerDinosaur(_local_5.avatar_id))) {
                if (_shakingTimeout == -1) {
                    _shakingTimeout = setTimeout(_shakeableDelegate, com.clubpenguin.world.rooms2013.prehistoric.Prehistoric.ROAR_TIME);
                    var _local_2 = 0;
                    while (_local_2 < _roomShakeables.length) {
                        _roomShakeables[_local_2].gotoAndStop(2);
                        _local_2++;
                    }
                } else {
                    clearTimeout(_shakingTimeout);
                    _shakingTimeout = setTimeout(_shakeableDelegate, com.clubpenguin.world.rooms2013.prehistoric.Prehistoric.ROAR_TIME);
                }
            }
        }
        function resetShakeables() {
            var _local_2 = 0;
            while (_local_2 < _roomShakeables.length) {
                _roomShakeables[_local_2].gotoAndStop(1);
                _local_2++;
            }
            clearTimeout(_shakingTimeout);
            _shakingTimeout = -1;
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
            clearInterval(_secondCheckIntervalID);
            clearTimeout(_shakingTimeout);
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            _SHELL.removeListener(_SHELL.PLAYER_FRAME, _handlePlayerFrameDelegate);
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
        static var CLASS_NAME = "Swamp";
        var _trexDelay = 60000;
        var ONE_SECOND = 1000;
        static var WEIGHTS_FRAME = com.clubpenguin.puffleavatar.PuffleAvatarConstants.PUFFLE_WALK_SOUTH_FRAME;
        static var WEIGHTS_PATH = com.clubpenguin.world.rooms.hotel.hotelcarestations.HotelCareStationAnimationConstants.PUFFLE_BARBELL;
        static var PLAY_TASK = com.clubpenguin.world.rooms.hotel.hotelcarestations.HotelCareTaskEnum.PLAYING_TASK;
    }
