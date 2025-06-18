//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms.hotel.HotelRoof extends com.clubpenguin.world.rooms.BaseRoom
    {
        var _stage, localize, _SHELL, rainbowCannon, _destroyDelegate, _djPlayers, setupEnvironmentTriggers, wem, _triggerWatcher, _triggerWatcherInterval, setupNavigationButtons, _sleepChair1, _sleepChair2, _sleepChairTrigger1, _sleepChairTrigger2, _feedChair1, _feedChair2, _feedChairTrigger1, _feedChairTrigger2, _divingBoard, _divingBoardTrigger, _djBooth, _djBoothTrigger, _INTERFACE, _cannonTrigger, _roomUpdateInterval, _handlePlayerFrameDelegate;
        var _playerUpdateDelegate, _ghostList, _ghostCheckDelegate, _PARTY, ghostsCaught;
		function HotelRoof (stageReference) {
            super(stageReference);
            _stage.start_x = 260;
            _stage.start_y = 300;
            localize([]);
            if (!_SHELL) {
                init();
            }
        }
        function handlePlayerExit(player_id) {
            var _local_3 = _stage.cannon_mc.cannonAnimation_mc;
            var _local_2 = 0;
            while (_local_2 < rainbowCannon.playersOnCannon.length) {
                if (rainbowCannon.playersOnCannon[_local_2] == player_id) {
                    if ((_local_3._currentframe == 1) || (_local_3._currentframe == 140)) {
                        rainbowCannon.playCannonAnimation();
                    }
                    rainbowCannon.playersOnCannon.splice(_local_2, 1);
                    return(undefined);
                }
                _local_2++;
            }
        }
        function init() {
			ghostsCaught = 0;
            var _local_2 = com.clubpenguin.util.Delegate.create(this, handlePlayerExit);
            _SHELL.addListener(_SHELL.REMOVE_PLAYER, _local_2);
            if (_SHELL.getRainbowPuffleQuest().getRainbowQuestCookieVO.isInitialized() == false) {
                _SHELL.getRainbowPuffleQuest().getRainbowQuestCookieVO.requestFromServer();
            }
            _destroyDelegate = com.clubpenguin.util.Delegate.create(this, destroy);
            _SHELL.addListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            _djPlayers = 0;
            configureNavigation();
            configureTriggers();
            configureCannon();
            configureRoomElements();
            _stage.waitingSeat_mc.waitingSeat01_btn.useHandCursor = false;
            _stage.waitingSeat_mc.waitingSeat02_btn.useHandCursor = false;
            _stage.waitingSeat_mc.waitingSeat03_btn.useHandCursor = false;
            _stage.waitingSeat_mc.waitingSeat04_btn.useHandCursor = false;
            _stage.divingBoard_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, divingBoardRollOver);
            _stage.divingBoard_btn.onRollOut = com.clubpenguin.util.Delegate.create(this, divingBoardRollOut);
            _stage.divingBoard_btn.onReleaseOutside = com.clubpenguin.util.Delegate.create(this, divingBoardRollOut);
            _stage.dj_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, djRollOver);
            _stage.dj_btn.onRollOut = com.clubpenguin.util.Delegate.create(this, djRollOut);
            _stage.dj_btn.onReleaseOutside = com.clubpenguin.util.Delegate.create(this, djRollOut);
            _stage.pool_area_mc.environmentType = com.clubpenguin.world.rooms.common.behaviors.RoomBehaviorEnum.EL_WATER_BEHAVIOR;
            _stage.pool_area_mc._visible = false;
            setupEnvironmentTriggers();
            _SHELL.addListener(_SHELL.ROOM_EFFECT_COMPLETE, com.clubpenguin.util.Delegate.create(this, onPuffleSplashComplete));
            wem = new com.clubpenguin.world.rooms.weathereffects.WeatherEffectsManager(_SHELL, _stage.background_mc);
            wem.setupFireAnimationHeight(60);
            wem.setupRainAnimationHeight(85);
            wem.setupSnowAnimationHeight(85);
            wem.setupRainAnimationSpeed(0.5);
            wem.setupSnowAnimationSpeed(1);
            wem.setupRainDelayTime(2);
            wem.setupSnowDelayTime(2);
            wem.startWeatherEffectCheck();
        
			_PARTY = _global.getCurrentParty().BaseParty.CURRENT_PARTY;
			_playerUpdateDelegate = com.clubpenguin.util.Delegate.create(this, checkIfPlayerCanSeeGhosts);
            _SHELL.addListener(_SHELL.UPDATE_PLAYER, _playerUpdateDelegate);
            _SHELL.addListener(_SHELL.PLAYER_AVATAR_TRANSFORMED, _playerUpdateDelegate);
			var _local_2 = _SHELL.getPlayerObjectById(_SHELL.getMyPlayerId());
            checkIfPlayerCanSeeGhosts(_local_2);
			_ghostList = [_stage.foreground_mc.ghostGogglesView.gogglesView_mc.ghost1, _stage.foreground_mc.ghostGogglesView.gogglesView_mc.ghost2, _stage.foreground_mc.ghostGogglesView.gogglesView_mc.ghost3];
            _ghostCheckDelegate = com.clubpenguin.util.Delegate.create(this, checkDestructableIsHit);
            _SHELL.addListener(_SHELL.BALL_LAND, _ghostCheckDelegate);
			//checkGhostCompletion();
			_stage.cannon_mc.cannon_btn.enabled = false;
			if (_PARTY.getTaskComplete(1)) {
				_stage.background_mc.canonStatus_mc._visible = false;
				_stage.cannon_mc.cannon_btn.enabled = true;
			};
        }
		function checkGhostCompletion() {
			var i = 0;
            while (i < _ghostList.length) {
				if (_PARTY.getMessageViewedQC(i + 6)) {
					_ghostList[i]._visible = false;
				};
				i++;
			}
		}
		function checkDestructableIsHit(snowballInfo) {
            var _local_5 = _SHELL.getPlayerObjectById(snowballInfo.player_id);
            if (!com.clubpenguin.world.rooms2012.halloween.Halloween.isGhostHunter(_local_5)) {
                return(undefined);
            }
            var _local_4;
            var _local_2 = 0;
            while (_local_2 < _ghostList.length) {
                if (_ghostList[_local_2].ghost._visible && (_ghostList[_local_2].hitTest(snowballInfo.x, snowballInfo.y, true))) {
                    _local_4 = _ghostList[_local_2];
                    break;
                }
                _local_2++;
            }
            if (_local_4) {
                if (snowballInfo.player_id == _SHELL.getMyPlayerId()) {
                    _local_4.ghost._visible = false;
                    snowballInfo.snowballMC._visible = false;
                    _local_4.effect.gotoAndStop(2);
					_PARTY.sendQCMessage("w.app.p2025.doom.qc.gariwald", 12);
					_stage.background_mc.canonStatus_mc.gotoAndStop(2);
					_stage.cannon_mc.cannon_btn.enabled = true;
					_stage.triggers_mc.cannon2_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "party25", 315, 125);
                    return(undefined);
                }
                if (com.clubpenguin.world.rooms2012.halloween.Halloween.isMyPlayerGhost()) {
                    _local_4.ghost._visible = false;
                    snowballInfo.snowballMC._visible = false;
                    _local_4.effect.gotoAndStop(2);
                    return(undefined);
                }
                snowballInfo.snowballMC._visible = false;
                _local_4.effect.gotoAndStop(3);
            }
        }
		function checkIfPlayerCanSeeGhosts(playerObject) {
            if (playerObject.player_id != _SHELL.getMyPlayerId()) {
                return(undefined);
            }
            var _local_2 = _global.getCurrentShell();
            var _local_3 = _local_2.getPlayerObjectById(_local_2.getMyPlayerId());
            if ((_local_3.face == 93043) || (_local_3.avatar_id == 1917) || _SHELL.isPlayerMascotById(_SHELL.getMyPlayerId())) {
                if (_local_3.avatar_id == 1917) {
                    switchRoomToGhostMode();
                } else {
                    switchRoomToGhostGoggleMode();
                }
                //_stage.foreground_mc.ghostGogglesView.gogglesView_mc.arrows_mc._visible = !_SHELL.isItemInMyInventory(com.clubpenguin.world.rooms2012.halloween.Halloween.GARIWALD_BACKGROUND);
            } else {
                switchRoomToNormalMode();
            }
        }
        function switchRoomToNormalMode() {
            _stage.foreground_mc.ghostGogglesView.gotoAndStop(1);
        }
        function switchRoomToGhostGoggleMode() {
			if (!_PARTY.getMessageViewed(2)) {
				return;
			};
            _stage.foreground_mc.ghostGogglesView.gotoAndStop(2);
            _stage.foreground_mc.ghostGogglesView.gogglesView_mc.goggles_border._visible = true;
        }
        function switchRoomToGhostMode() {
			if (!_PARTY.getMessageViewed(2)) {
				return;
			};
            _stage.foreground_mc.ghostGogglesView.gotoAndStop(2);
            _stage.foreground_mc.ghostGogglesView.gogglesView_mc.goggles_border._visible = false;
        }
        function configureTriggers() {
            _triggerWatcher = new com.clubpenguin.world.rooms.common.triggers.TriggerWatcher(_stage, _SHELL);
            _stage.triggers_mc.elevator_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, elevatorUI);
            configureSleepingChairTriggers();
            configureFeedingChairTriggers();
            configureDjBoothTrigger();
            configureDivingBoardTrigger();
            clearInterval(_triggerWatcherInterval);
            _triggerWatcherInterval = setInterval(_triggerWatcher, "checkAllPlayers", 40);
        }
        function configureNavigation() {
            setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.feedChair01_mc.feedChair01_btn, 113, 185), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.feedChair02_mc.feedChair02_btn, 201, 185), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.elevator_mc.elevator_btn, 33, 275), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.sleepChair01_mc.sleepChair01_btn, 417, 153), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.sleepChair02_mc.sleepChair02_btn, 534, 153), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.waitingSeat_mc.waitingSeat01_btn, 91, 245), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.waitingSeat_mc.waitingSeat02_btn, 130, 245), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.waitingSeat_mc.waitingSeat03_btn, 165, 245), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.waitingSeat_mc.waitingSeat04_btn, 205, 245), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.cannon_mc.cannon_btn, 705, 255), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.divingBoard_btn, 340, 216), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.dj_btn, 659, 346)]);
        }
        function configureRoomElements() {
            _stage.table01_mc.plate01_btn.onPress = com.clubpenguin.util.Delegate.create(this, orderFood, _stage.table01_mc.plate01_mc);
            _stage.table01_mc.plate02_btn.onPress = com.clubpenguin.util.Delegate.create(this, orderFood, _stage.table01_mc.plate02_mc);
            _stage.table02_mc.plate02_btn.onPress = com.clubpenguin.util.Delegate.create(this, orderFood, _stage.table02_mc.plate02_mc);
            _stage.table02_mc.plate01_btn.onPress = com.clubpenguin.util.Delegate.create(this, orderFood, _stage.table02_mc.plate01_mc);
            _stage.elevator_mc.elevator_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, onElevatorRollOver);
            _stage.elevator_mc.elevator_btn.onRollOut = com.clubpenguin.util.Delegate.create(this, onElevatorRollOut);
            _stage.interface_mc.questButton.onRelease = com.clubpenguin.util.Delegate.create(this, showContent, com.clubpenguin.quests.rainbowpuffle.RainbowPuffleQuest.PUFFLE_QUEST_UI);
        }
        function divingBoardRollOver() {
            _stage.divingBoardState_mc.gotoAndStop("rollOver");
        }
        function divingBoardRollOut() {
            _stage.divingBoardState_mc.gotoAndStop("rollOut");
        }
        function djRollOver() {
            _stage.djSpeakerBackState_mc.gotoAndStop("rollOver");
            _stage.djCenterState_mc.gotoAndStop("rollOver");
            _stage.djSpeakerFrontState_mc.gotoAndStop("rollOver");
        }
        function djRollOut() {
            _stage.djSpeakerBackState_mc.gotoAndStop("rollOut");
            _stage.djCenterState_mc.gotoAndStop("rollOut");
            _stage.djSpeakerFrontState_mc.gotoAndStop("rollOut");
        }
        function configureSleepingChairTriggers() {
            _sleepChair1 = new com.clubpenguin.world.rooms.hotel.hotelroof.SleepingChair(_stage.background_mc.sleepChair01_mc, _stage);
            _sleepChair2 = new com.clubpenguin.world.rooms.hotel.hotelroof.SleepingChair(_stage.background_mc.sleepChair02_mc, _stage);
            _sleepChairTrigger1 = new com.clubpenguin.world.rooms.common.triggers.PlayerTrigger(_stage.triggers_mc.sleep01_mc);
            _sleepChairTrigger1.playersAdded.add(com.clubpenguin.util.Delegate.create(_sleepChair1, _sleepChair1.beginSleeping));
            _sleepChairTrigger1.playersRemoved.add(com.clubpenguin.util.Delegate.create(_sleepChair1, _sleepChair1.endSleeping));
            _triggerWatcher.addTrigger(_sleepChairTrigger1);
            _sleepChairTrigger2 = new com.clubpenguin.world.rooms.common.triggers.PlayerTrigger(_stage.triggers_mc.sleep02_mc);
            _sleepChairTrigger2.playersAdded.add(com.clubpenguin.util.Delegate.create(_sleepChair2, _sleepChair2.beginSleeping));
            _sleepChairTrigger2.playersRemoved.add(com.clubpenguin.util.Delegate.create(_sleepChair2, _sleepChair2.endSleeping));
            _triggerWatcher.addTrigger(_sleepChairTrigger2);
        }
        function configureFeedingChairTriggers() {
            _feedChair1 = new com.clubpenguin.world.rooms.hotel.hotelroof.FeedingChair(_stage.feedChair01_mc, _stage.foodBowl01_mc);
            _feedChair2 = new com.clubpenguin.world.rooms.hotel.hotelroof.FeedingChair(_stage.feedChair02_mc, _stage.foodBowl02_mc);
            _feedChairTrigger1 = new com.clubpenguin.world.rooms.common.triggers.PlayerTrigger(_stage.triggers_mc.feed01_mc);
            _feedChairTrigger1.playersAdded.add(com.clubpenguin.util.Delegate.create(_feedChair1, _feedChair1.beginFeeding));
            _feedChairTrigger1.playersRemoved.add(com.clubpenguin.util.Delegate.create(_feedChair1, _feedChair1.endFeeding));
            _triggerWatcher.addTrigger(_feedChairTrigger1);
            _feedChairTrigger2 = new com.clubpenguin.world.rooms.common.triggers.PlayerTrigger(_stage.triggers_mc.feed02_mc);
            _feedChairTrigger2.playersAdded.add(com.clubpenguin.util.Delegate.create(_feedChair2, _feedChair2.beginFeeding));
            _feedChairTrigger2.playersRemoved.add(com.clubpenguin.util.Delegate.create(_feedChair2, _feedChair2.endFeeding));
            _triggerWatcher.addTrigger(_feedChairTrigger2);
        }
        function configureDivingBoardTrigger() {
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
        function configureDjBoothTrigger() {
            var _local_2 = new com.clubpenguin.world.rooms.hotel.hotelcarestations.HotelCareStationVO();
            _local_2.taskEnum = PLAY_TASK;
            _local_2.puffleFrame = DJ_FRAME;
            _djBooth = new com.clubpenguin.world.rooms.hotel.hotelcarestations.HotelCareStation(_local_2);
            _djBooth.stationBIInfo(com.clubpenguin.engine.puffles.pufflecarestations.PuffleCareStationsConstants.DJ_BOOTH_CARESTATION, com.clubpenguin.engine.puffles.pufflecarestations.PuffleCareStationsConstants.PUFFLE_PLAY_STATION);
            _djBoothTrigger = new com.clubpenguin.world.rooms.common.triggers.PlayerTrigger(_stage.triggers_mc.dj_mc);
            _djBoothTrigger.playersAdded.add(com.clubpenguin.util.Delegate.create(this, djStart));
            _djBoothTrigger.playersRemoved.add(com.clubpenguin.util.Delegate.create(this, djFinish));
            _triggerWatcher.addTrigger(_djBoothTrigger);
        }
        function onPuffleSplashComplete(payloadObject) {
            var _local_3 = payloadObject.playerId;
            var _local_4 = payloadObject.effectType;
            if (_SHELL.isMyPlayer(_local_3) && (_local_4 == WATER_SPLASH_EFFECT)) {
                var _local_2 = _SHELL.getRainbowPuffleQuest();
                if (((_local_2.currentPuffleQuestTaskIndex == (GROOMING_TASK_NUM - 1)) && (_local_2.isNextPuffleQuestTaskAvailable())) && (!_local_2.isTaskComplete(GROOMING_TASK_NUM))) {
                    var _local_5 = setTimeout(showQuestUI, 1000);
                }
                _local_2.completePuffleQuestTask(GROOMING_TASK_NUM);
            }
        }
        function showQuestUI() {
            _global.getCurrentInterface().showContent(com.clubpenguin.quests.rainbowpuffle.RainbowPuffleQuest.PUFFLE_QUEST_UI);
        }
        function djStart(players) {
            var _local_2 = 0;
            while (_local_2 < players.length) {
                _djPlayers++;
                _local_2++;
            }
            _stage.djSpeakerFrontState_mc.djSpeakerFront_mc.gotoAndPlay("animation");
            _stage.djCenterState_mc.djCenter_mc.gotoAndPlay("animation");
            _stage.djSpeakerBackState_mc.djSpeakerBack_mc.gotoAndPlay("animation");
            _djBooth.beginActivity(players);
        }
        function djFinish(players) {
            var _local_2 = 0;
            while (_local_2 < players.length) {
                _djPlayers--;
                if (_djPlayers < 0) {
                    _djPlayers = 0;
                }
                _local_2++;
            }
            if (_djPlayers == 0) {
                _stage.djSpeakerFrontState_mc.djSpeakerFront_mc.gotoAndStop("stop");
                _stage.djCenterState_mc.djCenter_mc.gotoAndStop("stop");
                _stage.djSpeakerBackState_mc.djSpeakerBack_mc.gotoAndStop("stop");
            }
            _djBooth.endActivity(players);
        }
        function onElevatorRollOver() {
            _stage.elevator_mc.door_mc.gotoAndPlay("open");
            _stage.elevator_mc.interior_mc.gotoAndPlay("open");
        }
        function onElevatorRollOut() {
            _stage.elevator_mc.door_mc.gotoAndPlay("close");
            _stage.elevator_mc.interior_mc.gotoAndPlay("close");
        }
        function elevatorUI() {
            _INTERFACE.showContent(com.clubpenguin.quests.rainbowpuffle.RainbowPuffleQuest.HOTEL_ELEVATOR_UI);
        }
        function orderFood(plate) {
            var _local_2 = new Sound(_stage);
            _local_2.attachSound("clickPlateSFX");
            _local_2.start();
            plate.nextFrame();
        }
        function configureCannon() {
            rainbowCannon = new com.clubpenguin.world.rooms.hotel.hotelroof.RainbowCannon(_stage.cannon_mc);
            _cannonTrigger = new com.clubpenguin.world.rooms.common.triggers.PlayerTrigger(_stage.triggers_mc.cannon_mc);
            _cannonTrigger.playersAdded.add(com.clubpenguin.util.Delegate.create(rainbowCannon, rainbowCannon.accessCannon));
            _cannonTrigger.playersRemoved.add(com.clubpenguin.util.Delegate.create(rainbowCannon, rainbowCannon.playersRemovedFromCannon));
            _triggerWatcher.addTrigger(_cannonTrigger);
            if (!_SHELL.isMyPlayerMember()) {
                return(undefined);
            }
            if (_SHELL.getRainbowPuffleQuest().getIsCannonAvailable(_SHELL.getMyPlayerId())) {
                _stage.background_mc.cannonStatus_mc.gotoAndStop("available");
            } else {
                _stage.background_mc.cannonStatus_mc.gotoAndStop("unavailable");
            }
        }
        function showContent(content) {
            _INTERFACE.showContent(content);
        }
        function exit(roomName, x, y) {
            _SHELL.sendJoinRoom(roomName, x, y);
        }
        function destroy() {
			_SHELL.removeListener(_SHELL.UPDATE_PLAYER, _playerUpdateDelegate);
            _SHELL.removeListener(_SHELL.PLAYER_AVATAR_TRANSFORMED, _playerUpdateDelegate);
            _SHELL.removeListener(_SHELL.BALL_LAND, _ghostCheckDelegate);
            clearInterval(_roomUpdateInterval);
            clearInterval(_triggerWatcherInterval);
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            _SHELL.removeListener(_SHELL.PLAYER_FRAME, _handlePlayerFrameDelegate);
            _feedChair1.cleanChair();
            _feedChair2.cleanChair();
            _sleepChair1.cleanChair();
            _sleepChair2.cleanChair();
            _djBooth.cleanStation();
            _divingBoard.cleanStation();
        }
        static var CLASS_NAME = "HotelRoof";
        static var WATER_SPLASH_EFFECT = "waterSplashEffect";
        static var GROOMING_TASK_NUM = 2;
        static var PLAY_TASK = com.clubpenguin.world.rooms.hotel.hotelcarestations.HotelCareTaskEnum.PLAYING_TASK;
        static var DJ_FRAME = com.clubpenguin.puffleavatar.PuffleAvatarConstants.PUFFLE_DANCE_FRAME;
        static var DIVING_PATH = com.clubpenguin.world.rooms.hotel.hotelcarestations.HotelCareStationAnimationConstants.PUFFLE_DIVE;
    }
