import com.clubpenguin.world.rooms2012.halloween.Halloween;
import com.clubpenguin.world.rooms.hotel.hotelspa.Treadmill;
import com.clubpenguin.world.rooms.hotel.hotelspa.GroomingChair;
import com.clubpenguin.world.rooms.hotel.hotelcarestations.HotelCareTaskEnum;
import com.clubpenguin.world.rooms.hotel.hotelcarestations.HotelCareStationVO;
import com.clubpenguin.world.rooms.hotel.hotelcarestations.HotelCareStationAnimationConstants;
import com.clubpenguin.world.rooms.hotel.hotelcarestations.HotelCareStation;
import com.clubpenguin.world.rooms.common.triggers.TriggerWatcher;
import com.clubpenguin.world.rooms.common.triggers.PlayerTrigger;
import com.clubpenguin.world.rooms.common.NavigationButtonVO;
import com.clubpenguin.util.Delegate;
import com.clubpenguin.quests.rainbowpuffle.RainbowPuffleQuest;
import com.clubpenguin.puffleavatar.PuffleAvatarConstants;
import com.clubpenguin.engine.puffles.pufflecarestations.PuffleCareStationsConstants;
class com.clubpenguin.world.rooms2015.october.Spa extends com.clubpenguin.world.rooms.BaseRoom {
	var _puffleCareQuest, _SHELL, _stage, _destroyDelegate, _triggerWatcher, _currentParty, setupNavigationButtons, localize, _triggerWatcherInterval, _treadmill1, _treadmill2, _treadmillTrigger1, _treadmillTrigger2, _groomingChair1, _groomingChair2, _chairTrigger1, _chairTrigger2, _salonChair1, _salonChair2, _salonChairTrigger1, _salonChairTrigger2, _weightStation1, _weightStation2, _weightStationTrigger1, _weightStationTrigger2, _aerobicStation1, _aerobicStation2, _aerobicStationTrigger1, _aerobicStationTrigger2, _INTERFACE;
	var _playerUpdateDelegate, _ghostList, _ghostCheckDelegate, _PARTY;
	function Spa(stageReference) {
		super(stageReference);
		_puffleCareQuest = _SHELL.getRainbowPuffleQuest();
		_stage.start_x = 380;
		_stage.start_y = 295;
		init();
	}
	function init() {
		if (_SHELL.getRainbowPuffleQuest().getRainbowQuestCookieVO.isInitialized() == false) {
			_SHELL.getRainbowPuffleQuest().getRainbowQuestCookieVO.requestFromServer();
		}
		_destroyDelegate = Delegate.create(this, destroy);
		_SHELL.addListener(_SHELL.ROOM_DESTROYED,_destroyDelegate);
		_triggerWatcher = new TriggerWatcher(_stage, _SHELL);
		configureTreadmillTriggers();
		configureGroomingChairTriggers();
		configureSalonChairTriggers();
		configureWeightStationTriggers();
		configureAerobicStationTriggers();
		_stage.triggers_mc.elevator_mc.triggerFunction = Delegate.create(this, elevatorUI);
		_stage.background_mc.elevator_btn.onRollOver = Delegate.create(this, exitMouseOver);
		_stage.background_mc.elevator_btn.onRollOut = Delegate.create(this, exitMouseOff);
		_stage.background_mc.elevator_btn.onReleaseOutside = Delegate.create(this, exitMouseOff);
		_currentParty = _global.getCurrentParty().BaseParty.CURRENT_PARTY;
		var _local_5 = _currentParty.getQuestVOByIndex(QUEST_TASK_ID);
		if ((_currentParty.CONSTANTS.PARTY_DAY >= _local_5.unlockDay) && (!_currentParty.partyCookie.hasPlayerCompletedTask(QUEST_TASK_ID))) {
			_stage.itemCollect_mc.itemCollect_btn.onRollOver = Delegate.create(this, itemCollectRollOver);
			_stage.itemCollect_mc.itemCollect_btn.onRollOut = Delegate.create(this, itemCollectRollOut);
			_stage.itemCollect_mc.itemCollect_btn.onReleaseOutside = Delegate.create(this, itemCollectRollOut);
			_stage.itemCollect_mc.itemCollect_btn.onRelease = Delegate.create(this, itemCollectRelease);
		} else {
			_stage.itemCollect_mc._visible = false;
		}
		_stage.exercise03_mc.exercise03_btn.onRollOver = Delegate.create(this, exercise03RollOver);
		_stage.exercise03_mc.exercise03_btn.onRollOut = Delegate.create(this, exercise03RollOut);
		_stage.exercise03_mc.exercise03_btn.onReleaseOutside = Delegate.create(this, exercise03RollOut);
		_stage.exercise04_mc.exercise04_btn.onRollOver = Delegate.create(this, exercise04RollOver);
		_stage.exercise04_mc.exercise04_btn.onRollOut = Delegate.create(this, exercise04RollOut);
		_stage.exercise04_mc.exercise04_btn.onReleaseOutside = Delegate.create(this, exercise04RollOut);
		_stage.interface_mc.questButton.onRelease = Delegate.create(this, showContent, RainbowPuffleQuest.PUFFLE_QUEST_UI);
		var _local_3 = _SHELL.getMyPlayerObject();
		var _local_4 = _local_3.player_id;
		setupNavigationButtons([new NavigationButtonVO(_stage.background_mc.elevator_btn, 50, 211), new NavigationButtonVO(_stage.washChair1Container_mc, 507, 358), new NavigationButtonVO(_stage.washChair2Container_mc, 652, 357), (((!_puffleCareQuest.isPuffleEquipped(_local_4)) || (_local_3.avatarVO.avatar_id == 1)) ? (new NavigationButtonVO(_stage.Treadmill1_mc, 250, 364)) : (new NavigationButtonVO(_stage.Treadmill1_mc, 215, 364))), (((!_puffleCareQuest.isPuffleEquipped(_local_4)) || (_local_3.avatarVO.avatar_id == 1)) ? (new NavigationButtonVO(_stage.Treadmill2_mc, 118, 364)) : (new NavigationButtonVO(_stage.Treadmill2_mc, 88, 364))), (((!_puffleCareQuest.isPuffleEquipped(_local_4)) || (_local_3.avatarVO.avatar_id == 1)) ? (new NavigationButtonVO(_stage.exercise01_mc.exercise01_btn, 218, 181)) : (new NavigationButtonVO(_stage.exercise01_mc.exercise01_btn, 205, 181))), (((!_puffleCareQuest.isPuffleEquipped(_local_4)) || (_local_3.avatarVO.avatar_id == 1)) ? (new NavigationButtonVO(_stage.exercise02_mc.exercise02_btn, 144, 245)) : (new NavigationButtonVO(_stage.exercise02_mc.exercise02_btn, 130, 245))), (((!_puffleCareQuest.isPuffleEquipped(_local_4)) || (_local_3.avatarVO.avatar_id == 1)) ? (new NavigationButtonVO(_stage.exercise03_mc.exercise03_btn, 278, 246)) : (new NavigationButtonVO(_stage.exercise03_mc.exercise03_btn, 260, 246))), (((!_puffleCareQuest.isPuffleEquipped(_local_4)) || (_local_3.avatarVO.avatar_id == 1)) ? (new NavigationButtonVO(_stage.exercise04_mc.exercise04_btn, 193, 286)) : (new NavigationButtonVO(_stage.exercise04_mc.exercise04_btn, 176, 286))), new NavigationButtonVO(_stage.hairCut01_mc.hairCut01_btn, 517, 192), new NavigationButtonVO(_stage.hairCut02_mc.hairCut02_btn, 616, 192)]);
		localize([_stage.sign_mc.text_mc, _stage.background_mc.elecBox1_mc, _stage.background_mc.elecBox2_mc]);
		clearInterval(_triggerWatcherInterval);
		_triggerWatcherInterval = setInterval(_triggerWatcher, "checkAllPlayers", 40);

		_PARTY = _global.getCurrentParty().BaseParty.CURRENT_PARTY;
		_playerUpdateDelegate = Delegate.create(this, checkIfPlayerCanSeeGhosts);
		_SHELL.addListener(_SHELL.UPDATE_PLAYER,_playerUpdateDelegate);
		_SHELL.addListener(_SHELL.PLAYER_AVATAR_TRANSFORMED,_playerUpdateDelegate);
		var _local_2 = _SHELL.getPlayerObjectById(_SHELL.getMyPlayerId());
		checkIfPlayerCanSeeGhosts(_local_2);
		_ghostList = [_stage.foreground_mc.ghostGogglesView.gogglesView_mc.ghost1, _stage.foreground_mc.ghostGogglesView.gogglesView_mc.ghost2, _stage.foreground_mc.ghostGogglesView.gogglesView_mc.ghost3];
		_ghostCheckDelegate = Delegate.create(this, checkDestructableIsHit);
		_SHELL.addListener(_SHELL.BALL_LAND,_ghostCheckDelegate);
		checkGhostCompletion();
	}
	function checkGhostCompletion() {
		var i = 0;
		while (i < _ghostList.length) {
			if (_PARTY.getMessageViewedQC(i + 3)) {
				_ghostList[i]._visible = false;
			}
			i++;
		}
	}
	function checkDestructableIsHit(snowballInfo) {
		var _local_5 = _SHELL.getPlayerObjectById(snowballInfo.player_id);
		if (!Halloween.isGhostHunter(_local_5)) {
			return undefined;
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
				_PARTY.setMessageViewedQC(_local_2 + 3);
				return undefined;
			}
			if (Halloween.isMyPlayerGhost()) {
				_local_4.ghost._visible = false;
				snowballInfo.snowballMC._visible = false;
				_local_4.effect.gotoAndStop(2);
				return undefined;
			}
			snowballInfo.snowballMC._visible = false;
			_local_4.effect.gotoAndStop(3);
		}
	}
	function checkIfPlayerCanSeeGhosts(playerObject) {
		if (playerObject.player_id != _SHELL.getMyPlayerId()) {
			return undefined;
		}
		setupNavigationButtons([(((!_puffleCareQuest.isPuffleEquipped(_local_2)) || (playerObject.avatarVO.avatar_id == 1)) ? (new NavigationButtonVO(_stage.Treadmill1_mc, 250, 364)) : (new NavigationButtonVO(_stage.Treadmill1_mc, 215, 364))), (((!_puffleCareQuest.isPuffleEquipped(_SHELL.getMyPlayerId())) || (playerObject.avatarVO.avatar_id == 1)) ? (new NavigationButtonVO(_stage.Treadmill2_mc, 118, 364)) : (new NavigationButtonVO(_stage.Treadmill2_mc, 88, 364))), (((!_puffleCareQuest.isPuffleEquipped(_local_2)) || (playerObject.avatarVO.avatar_id == 1)) ? (new NavigationButtonVO(_stage.exercise01_mc.exercise01_btn, 218, 181)) : (new NavigationButtonVO(_stage.exercise01_mc.exercise01_btn, 205, 181))), (((!_puffleCareQuest.isPuffleEquipped(_local_2)) || (playerObject.avatarVO.avatar_id == 1)) ? (new NavigationButtonVO(_stage.exercise02_mc.exercise02_btn, 144, 245)) : (new NavigationButtonVO(_stage.exercise02_mc.exercise02_btn, 130, 245))), (((!_puffleCareQuest.isPuffleEquipped(_local_2)) || (playerObject.avatarVO.avatar_id == 1)) ? (new NavigationButtonVO(_stage.exercise03_mc.exercise03_btn, 278, 246)) : (new NavigationButtonVO(_stage.exercise03_mc.exercise03_btn, 260, 246))), (((!_puffleCareQuest.isPuffleEquipped(_local_2)) || (playerObject.avatarVO.avatar_id == 1)) ? (new NavigationButtonVO(_stage.exercise04_mc.exercise04_btn, 193, 286)) : (new NavigationButtonVO(_stage.exercise04_mc.exercise04_btn, 176, 286)))]);
		var _local_2 = _global.getCurrentShell();
		var _local_3 = _local_2.getPlayerObjectById(_local_2.getMyPlayerId());
		if ((_local_3.face == 93043) || (_local_3.avatar_id == 1917) || _SHELL.isPlayerMascotById(_SHELL.getMyPlayerId())) {
			if (_local_3.avatar_id == 1917) {
				switchRoomToGhostMode();
			} else {
				switchRoomToGhostGoggleMode();
			}
			//_stage.foreground_mc.ghostGogglesView.gogglesView_mc.arrows_mc._visible = !_SHELL.isItemInMyInventory(Halloween.GARIWALD_BACKGROUND);
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
		}
		_stage.foreground_mc.ghostGogglesView.gotoAndStop(2);
		_stage.foreground_mc.ghostGogglesView.gogglesView_mc.goggles_border._visible = true;
	}
	function switchRoomToGhostMode() {
		if (!_PARTY.getMessageViewed(2)) {
			return;
		}
		_stage.foreground_mc.ghostGogglesView.gotoAndStop(2);
		_stage.foreground_mc.ghostGogglesView.gogglesView_mc.goggles_border._visible = false;
	}
	function itemCollectRollOver() {
		_stage.itemCollect_mc.gotoAndStop("over");
	}
	function itemCollectRollOut() {
		_stage.itemCollect_mc.gotoAndStop("idle");
	}
	function itemCollectRelease() {
		var _local_3 = _global.getCurrentParty().BaseParty.CURRENT_PARTY;
		_local_3.pickupItem(_local_3.CONSTANTS.BEARD_TRIMMER,QUEST_TASK_ID);
		_stage.itemCollect_mc.gotoAndStop("click");
		setTimeout(Delegate.create(this, showInstructionsPopup),1000);
	}
	function showInstructionsPopup() {
		_currentParty.displayItemPickupInstructions();
	}
	function configureTreadmillTriggers() {
		_treadmill1 = new Treadmill(_stage.Treadmill1_mc);
		_treadmill2 = new Treadmill(_stage.Treadmill2_mc);
		_treadmillTrigger1 = new PlayerTrigger(_stage.triggers_mc.treadmill_mc1);
		_treadmill1.playerTrigger = _treadmillTrigger1;
		_treadmillTrigger1.playersAdded.add(Delegate.create(_treadmill1, _treadmill1.startTreadmill));
		_treadmillTrigger1.playersRemoved.add(Delegate.create(_treadmill1, _treadmill1.playersRemoved, _treadmillTrigger1));
		_triggerWatcher.addTrigger(_treadmillTrigger1);
		_treadmillTrigger2 = new PlayerTrigger(_stage.triggers_mc.treadmill_mc2);
		_treadmill2.playerTrigger = _treadmillTrigger2;
		_treadmillTrigger2.playersAdded.add(Delegate.create(_treadmill2, _treadmill2.startTreadmill));
		_treadmillTrigger2.playersRemoved.add(Delegate.create(_treadmill2, _treadmill2.playersRemoved, _treadmillTrigger2));
		_triggerWatcher.addTrigger(_treadmillTrigger2);
	}
	function configureGroomingChairTriggers() {
		_groomingChair1 = new GroomingChair(_stage.washChair1Container_mc, _stage.foreground_mc.chairwash_1);
		_groomingChair2 = new GroomingChair(_stage.washChair2Container_mc, _stage.foreground_mc.chairwash_2);
		_chairTrigger1 = new PlayerTrigger(_stage.triggers_mc.chair1_mc);
		_chairTrigger1.playersAdded.add(Delegate.create(_groomingChair1, _groomingChair1.beginGrooming));
		_chairTrigger1.playersRemoved.add(Delegate.create(_groomingChair1, _groomingChair1.endGrooming));
		_triggerWatcher.addTrigger(_chairTrigger1);
		_chairTrigger2 = new PlayerTrigger(_stage.triggers_mc.chair2_mc);
		_chairTrigger2.playersAdded.add(Delegate.create(_groomingChair2, _groomingChair2.beginGrooming));
		_chairTrigger2.playersRemoved.add(Delegate.create(_groomingChair2, _groomingChair2.endGrooming));
		_triggerWatcher.addTrigger(_chairTrigger2);
	}
	function configureSalonChairTriggers() {
		var _local_2 = new HotelCareStationVO();
		_local_2.effectRef = _stage.scissorsEffect01_mc;
		_local_2.taskEnum = CLEAN_TASK;
		_local_2.puffleFrame = LEFT_SIT_FRAME;
		_local_2.hideHat = true;
		_salonChair1 = new HotelCareStation(_local_2);
		_salonChair1.stationBIInfo(PuffleCareStationsConstants.SALON_CHAIR_CARESTATION,PuffleCareStationsConstants.PUFFLE_CLEAN_STATION);
		_local_2.effectRef = _stage.scissorsEffect02_mc;
		_local_2.puffleFrame = RIGHT_SIT_FRAME;
		_salonChair2 = new HotelCareStation(_local_2);
		_salonChair2.stationBIInfo(PuffleCareStationsConstants.SALON_CHAIR_CARESTATION,PuffleCareStationsConstants.PUFFLE_CLEAN_STATION);
		configureStationTrigger(_salonChair1,_salonChairTrigger1,_stage.triggers_mc.salonChair01_mc);
		configureStationTrigger(_salonChair2,_salonChairTrigger2,_stage.triggers_mc.salonChair02_mc);
	}
	function configureWeightStationTriggers() {
		var _local_2 = new HotelCareStationVO();
		_local_2.effectRef = _stage.weightEffect01_mc;
		_local_2.taskEnum = PLAY_TASK;
		_local_2.assetPath = WEIGHTS_PATH;
		_weightStation1 = new HotelCareStation(_local_2);
		_weightStation1.stationBIInfo(PuffleCareStationsConstants.WEIGHT_CARESTATION,PuffleCareStationsConstants.PUFFLE_PLAY_STATION);
		_local_2.effectRef = _stage.weightEffect02_mc;
		_weightStation2 = new HotelCareStation(_local_2);
		_weightStation2.stationBIInfo(PuffleCareStationsConstants.WEIGHT_CARESTATION,PuffleCareStationsConstants.PUFFLE_PLAY_STATION);
		configureStationTrigger(_weightStation1,_weightStationTrigger1,_stage.triggers_mc.weightStation01_mc);
		configureStationTrigger(_weightStation2,_weightStationTrigger2,_stage.triggers_mc.weightStation02_mc);
	}
	function configureAerobicStationTriggers() {
		var _local_2 = new HotelCareStationVO();
		_local_2.taskEnum = PLAY_TASK;
		_local_2.puffleFrame = AEROBICS_FRAME;
		_local_2.hideHat = true;
		_aerobicStation1 = new HotelCareStation(_local_2);
		_aerobicStation1.stationBIInfo(PuffleCareStationsConstants.AEROBIC_CARESTATION,PuffleCareStationsConstants.PUFFLE_PLAY_STATION);
		_aerobicStation2 = new HotelCareStation(_local_2);
		_aerobicStation2.stationBIInfo(PuffleCareStationsConstants.AEROBIC_CARESTATION,PuffleCareStationsConstants.PUFFLE_PLAY_STATION);
		configureStationTrigger(_aerobicStation1,_aerobicStationTrigger1,_stage.triggers_mc.aerobicStation01_mc);
		configureStationTrigger(_aerobicStation2,_aerobicStationTrigger2,_stage.triggers_mc.aerobicStation02_mc);
	}
	function configureStationTrigger(careStation, playerTrigger, triggerClip) {
		playerTrigger = new PlayerTrigger(triggerClip);
		playerTrigger.playersAdded.add(Delegate.create(careStation, careStation.beginActivity));
		playerTrigger.playersRemoved.add(Delegate.create(careStation, careStation.endActivity));
		_triggerWatcher.addTrigger(playerTrigger);
	}
	function elevatorUI() {
		_INTERFACE.showContent(RainbowPuffleQuest.HOTEL_ELEVATOR_UI);
	}
	function exitMouseOver() {
		_stage.background_mc.elevatorDoor_mc.gotoAndPlay(2);
	}
	function exitMouseOff() {
		_stage.background_mc.elevatorDoor_mc.gotoAndPlay(12);
	}
	function exercise03RollOver() {
		_stage.weightEffect01_mc.buttonFrame.gotoAndStop("over");
	}
	function exercise03RollOut() {
		_stage.weightEffect01_mc.buttonFrame.gotoAndStop("up");
	}
	function exercise04RollOver() {
		_stage.weightEffect02_mc.buttonFrame.gotoAndStop("over");
	}
	function exercise04RollOut() {
		_stage.weightEffect02_mc.buttonFrame.gotoAndStop("up");
	}
	function showContent(contentID) {
		_INTERFACE.showContent(contentID);
	}
	function exit(roomName, x, y) {
		_SHELL.sendJoinRoom(roomName,x,y);
	}
	function destroy() {
		_SHELL.removeListener(_SHELL.UPDATE_PLAYER,_playerUpdateDelegate);
		_SHELL.removeListener(_SHELL.PLAYER_AVATAR_TRANSFORMED,_playerUpdateDelegate);
		_SHELL.removeListener(_SHELL.BALL_LAND,_ghostCheckDelegate);
		clearInterval(_triggerWatcherInterval);
		_SHELL.removeListener(_SHELL.ROOM_DESTROYED,_destroyDelegate);
		_treadmill1.cleanTreadmill();
		_treadmill2.cleanTreadmill();
		_groomingChair1.cleanChair();
		_groomingChair2.cleanChair();
		_salonChair1.cleanStation();
		_salonChair2.cleanStation();
		_weightStation1.cleanStation();
		_weightStation2.cleanStation();
		_aerobicStation1.cleanStation();
		_aerobicStation2.cleanStation();
	}
	static var CLASS_NAME = "Spa";
	static var CLEAN_TASK = HotelCareTaskEnum.GROOMING_TASK;
	static var PLAY_TASK = HotelCareTaskEnum.PLAYING_TASK;
	static var WEIGHTS_FRAME = PuffleAvatarConstants.PUFFLE_WALK_SOUTH_FRAME;
	static var AEROBICS_FRAME = PuffleAvatarConstants.PUFFLE_WALK_HOP_SOUTH_FRAME;
	static var LEFT_SIT_FRAME = PuffleAvatarConstants.PUFFLE_SIT_SOUTHWEST_FRAME;
	static var RIGHT_SIT_FRAME = PuffleAvatarConstants.PUFFLE_SIT_SOUTHEAST_FRAME;
	static var WEIGHTS_PATH = HotelCareStationAnimationConstants.PUFFLE_BARBELL;
	static var QUEST_TASK_ID = 5;
}