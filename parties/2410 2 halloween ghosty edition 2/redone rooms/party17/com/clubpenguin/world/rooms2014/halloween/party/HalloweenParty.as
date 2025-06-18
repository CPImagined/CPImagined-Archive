//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2014.halloween.party.HalloweenParty
    {
        static var _shell, _airtower, _interface, _engine, _party, _partycookieUpdateHandlerDelegate, _questVOs, _rewardVOs, _handleCollectIglooItemDelegate, _handlePuzzleCompleteDelegate;
        function HalloweenParty () {
            trace("HalloweenParty: Entering");
        }
        static function init() {
            pebug("HALLOWEEN PARTY - INIT");
            trace("HalloweenParty.init");
            com.clubpenguin.party.BaseParty.CLASS_NAME = _this.CLASS_NAME;
            com.clubpenguin.party.BaseParty.CURRENT_PARTY = _this;
            com.clubpenguin.party.BaseParty.setConditionalPartyIconVisibility();
            com.clubpenguin.party.BaseParty.addListenerForPartySettings(CONSTANTS.PARTY_SETTINGS_RESPONSE_NAME);
            _isActive = true;
            _shell = _global.getCurrentShell();
            _airtower = _global.getCurrentAirtower();
            _interface = _global.getCurrentInterface();
            _engine = _global.getCurrentEngine();
            _party = _global.getCurrentParty();
            _partycookieUpdateHandlerDelegate = com.clubpenguin.util.Delegate.create(_this, partycookieUpdateHandler);
            _airtower.addListener("partycookie", _partycookieUpdateHandlerDelegate);
            sendRequestPartyCookie();
        }
        static function partycookieUpdateHandler() {
            _airtower.removeListener("partycookie", _partycookieUpdateHandlerDelegate);
            pebug("partycookieUpdateHandler update icon state ");
            com.clubpenguin.party.BaseParty.partyIconState();
            com.clubpenguin.world.rooms2014.halloween.party.HalloweenPartyQuestCommunicator.init();
        }
        static function configurePartySettings() {
            var _local_6 = CONSTANTS.PARTY_SERVICE.questSettingList;
            var _local_7 = CONSTANTS.PARTY_SERVICE.rewardList;
            if ((_local_6 == undefined) || (_local_7 == undefined)) {
                return(undefined);
            }
            _questVOs = new Array();
            _rewardVOs = new Array();
            var _local_5 = 0;
            while (_local_5 < _local_6.length) {
                var _local_3 = new com.clubpenguin.world.rooms2014.halloween.vo.HalloweenPartyQuestVO();
                var _local_4 = _local_6[_local_5];
                _local_3.roomID = _local_4.roomId;
                _local_3.questIndex = _local_4.questItemIndex;
                _local_3.unlockDay = _local_4.unlockDay;
                _questVOs.push(_local_3);
                _local_5++;
            }
            _local_5 = 0;
            while (_local_5 < _local_7.length) {
                var _local_1 = new com.clubpenguin.world.rooms2014.halloween.vo.HalloweenPartyRewardVO();
                var _local_2 = _local_7[_local_5];
                _local_1.rewardID = _local_2.rewardId;
                _local_1.unlockDay = _local_2.unlockDay;
                _local_1.memberItemId = _local_2.memberItemId;
                _local_1.nonMemberItemId = _local_2.nonmemberItemId;
                _local_1.roomID = _local_2.roomId;
                _local_1.createItemVOs();
                _rewardVOs.push(_local_1);
                _local_5++;
            }
        }
        static function get partyCookie() {
            return(com.clubpenguin.world.rooms2014.halloween.vo.HalloweenPartyCookieVO(com.clubpenguin.party.BaseParty.serverCookie));
        }
        static function get isActive() {
            return(_isActive);
        }
        static function pebug(msg, prefix) {
            com.clubpenguin.party.BaseParty.pebug(msg, prefix);
        }
        static function playSound(ui, soundId, volume) {
            com.clubpenguin.party.BaseParty.playSound(ui, soundId, volume);
        }
        static function checkForFirstTimeLogin(playerObj) {
            if ((_shell.getMyPlayerId() != playerObj.player_id) || (_shell.getRoomObject().room_id == 112)) {
                return(undefined);
            }
            if (partyCookie.msgViewedArray[CONSTANTS.LOGIN_MESSAGE_NUMBER] == 0) {
                _interface.showContent(CONSTANTS.LOGIN_PROMPT_PATH);
            }
        }
        static function get partyIconVisible() {
            if (partyCookie.msgViewedArray[CONSTANTS.LOGIN_MESSAGE_NUMBER] == 1) {
                return(true);
            }
            return(false);
        }
        static function activateFirstTimeUserPartyFunctionality() {
            pebug("activateFirstTimeUserPartyFunctionality");
            _engine.getRoomMovieClip().room.configureRoomElements();
            _airtower.addListener("partycookie", _partycookieUpdateHandlerDelegate);
            sendRequestPartyCookie();
        }
        static function getQuestVOByRoomID(roomID) {
            pebug("getQuestVOByRoomID roomID " + roomID);
            var _local_1 = 0;
            while (_local_1 < _questVOs.length) {
                var _local_2 = _questVOs[_local_1];
                if (roomID == _local_2.roomID) {
                    return(_local_2);
                }
                _local_1++;
            }
            return(undefined);
        }
        static function getRewardVOByID(rewardID) {
            var _local_1 = 0;
            while (_local_1 < _rewardVOs.length) {
                var _local_2 = _rewardVOs[_local_1];
                if (rewardID == _local_2.rewardID) {
                    return(_local_2);
                }
                _local_1++;
            }
            return(undefined);
        }
        static function getQuestItem(itemIndex) {
            return(partyCookie.questItems[itemIndex] == 1);
        }
        static function getTaskStatus(questVO) {
            return(partyCookie.questItems[questVO.questIndex] == 1);
        }
        static function setQuestItemCollected(itemIndex) {
            sendItemCollected(itemIndex);
            if (partyCookie.msgViewedArray[CONSTANTS.LOGIN_MESSAGE_NUMBER] == 0) {
                _interface.showContent(CONSTANTS.LOGIN_PROMPT_PATH);
            } else if ((partyCookie.msgViewedArray[CONSTANTS.HUNT_COMPLETE_MESSAGE_NUMBER] == 0) && (partyCookie.areItemsCollected())) {
                _interface.showContent(CONSTANTS.LOGIN_PROMPT_PATH);
            }
            if ((itemIndex <= 0) || (itemIndex >= 7)) {
                return(undefined);
            }
            if ((!partyCookie.areItemsCollected()) && (partyCookie.numItemsCollected < 6)) {
                com.clubpenguin.world.rooms2014.halloween.party.HalloweenPartyQuestCommunicator.displayCollectMachinePiece(partyCookie.hasPlayerVisitedFloor12);
            } else {
                com.clubpenguin.world.rooms2014.halloween.party.HalloweenPartyQuestCommunicator.displayCollectedAllMachinePieces(partyCookie.hasPlayerVisitedFloor12);
            }
        }
        static function playPartyIconSparkles() {
            _interface.PARTY_ICON._visible = true;
            if (_interface.PARTY_ICON.collectedSparkles._currentframe == 1) {
                _interface.PARTY_ICON.collectedSparkles.gotoAndStop(2);
            }
        }
        static function collectIglooItem(collectionButton) {
            sendCollectIglooItem();
            handleCollectIglooItem(null, collectionButton);
        }
        static function handleCollectIglooItem(data, collectButton) {
            trace("SchoolParty.handleCollectIglooItem");
            _airtower.removeListener(CONSTANTS.COLLECT_IGLOO_ITEM_COMMAND, _handleCollectIglooItemDelegate);
            collectButton.gotoAndStop(2);
        }
        static function checkForBellhopDialogue() {
            if (partyCookie.msgViewedArray[CONSTANTS.BELLHOP_MESSAGE_NUMBER] == 0) {
                _interface.showContent(CONSTANTS.BELLHOP_PROMPT_PATH);
            }
        }
        static function showGhostIntroDialogue() {
            _interface.showContent(CONSTANTS.GHOST_INTRO_PROMPT_PATH);
        }
        static function showGhostDefeatedDialogue() {
            _interface.showContent(CONSTANTS.GHOST_DEFEATED_PROMPT_PATH);
        }
        static function showGariwaldDialogue() {
            _interface.showContent(CONSTANTS.GARIWALD_PROMPT_PATH);
        }
        static function showGhostPuffleAdoption() {
            if (_global.getCurrentShell().puffleManager.myPuffles.length >= CONSTANTS.MAX_PUFFLES) {
                _global.getCurrentShell().$e("HalloweenParty -> Max Puffles Reached", {error_code:_global.getCurrentShell().MAX_PUFFLE_LIMIT});
                return(undefined);
            }
            if (_shell.isMyPlayerMember()) {
                _interface.showContent(com.clubpenguin.modules.AS3ModuleConstants.PUFFLE_ADOPTION, null, null, {puffleAdoptionType:"1022"}, true);
            } else {
                _interface.showContent(CONSTANTS.OOPS_MEMBER_PUFFLE_MESSAGE);
            }
        }
        static function sendMessageViewed(message) {
            _airtower.send(_airtower.PLAY_EXT, (com.clubpenguin.world.rooms2014.halloween.vo.HalloweenPartyCookieVO.HALLOWEEN_COOKIE_HANDLER_NAME + "#") + CONSTANTS.MESSAGE_VIEWED_COMMAND, [message], "str", _shell.getCurrentServerRoomId());
        }
        static function sendCollectIglooItem() {
            _airtower.send(_airtower.PLAY_EXT, (com.clubpenguin.world.rooms2014.halloween.vo.HalloweenPartyCookieVO.HALLOWEEN_COOKIE_HANDLER_NAME + "#") + CONSTANTS.COLLECT_IGLOO_ITEM_COMMAND, [0], "str", _shell.getCurrentServerRoomId());
        }
        static function sendRequestPartyCookie() {
            _airtower.send(_airtower.PLAY_EXT, com.clubpenguin.world.rooms2014.halloween.vo.HalloweenPartyCookieVO.HALLOWEEN_COOKIE_HANDLER_NAME + "#partycookie", [0], "str", _shell.getCurrentServerRoomId());
        }
        static function sendItemCollected(itemIndex) {
            trace("HalloweenParty.sendItemCollected index: " + itemIndex);
            _airtower.send(_airtower.PLAY_EXT, (com.clubpenguin.world.rooms2014.halloween.vo.HalloweenPartyCookieVO.HALLOWEEN_COOKIE_HANDLER_NAME + "#") + CONSTANTS.COLLECT_QUEST_ITEM_COMMAND, [itemIndex.toString()], "str", _shell.getCurrentServerRoomId());
            sendTaskCompleteBI(itemIndex);
        }
        static function sendCollectCoinReward(itemIndex) {
            _airtower.send(_airtower.PLAY_EXT, (com.clubpenguin.world.rooms2014.halloween.vo.HalloweenPartyCookieVO.HALLOWEEN_COOKIE_HANDLER_NAME + "#") + CONSTANTS.PUZZLE_COMPLETE_COMMAND, [], "str", _shell.getCurrentServerRoomId());
            _handlePuzzleCompleteDelegate = com.clubpenguin.util.Delegate.create(_this, handlePuzzleComplete);
            _airtower.addListener(CONSTANTS.PUZZLE_COMPLETE_COMMAND, _handlePuzzleCompleteDelegate);
            sendTaskRepeatedBI(itemIndex);
        }
        static function handlePuzzleComplete(data) {
            _airtower.removeListener(CONSTANTS.PUZZLE_COMPLETE_COMMAND, _handlePuzzleCompleteDelegate);
            var _local_1 = data[1];
            _shell.setMyPlayerTotalCoins(_local_1);
        }
        static function sendVisitedFloor12() {
            _airtower.send(_airtower.PLAY_EXT, (com.clubpenguin.world.rooms2014.halloween.vo.HalloweenPartyCookieVO.HALLOWEEN_COOKIE_HANDLER_NAME + "#") + CONSTANTS.VISITED_FLOOR_12_COMMAND, [0], "str", _shell.getCurrentServerRoomId());
        }
        static function sendGoThereBI(room) {
            com.clubpenguin.util.TrackerAS2.getInstance().trackGameAction(room, "quest_go_there");
        }
        static function sendOpenQuestBI() {
            com.clubpenguin.util.TrackerAS2.getInstance().trackGameAction(null, "quest_open");
        }
        static function sendScrollQuestBI() {
            com.clubpenguin.util.TrackerAS2.getInstance().trackGameAction(null, "quest_ui_end");
        }
        static function sendTaskCompleteBI(taskID) {
            var _local_1 = CONSTANTS.TASKID_TO_TASKNAME[taskID];
            com.clubpenguin.party.BaseParty.sendTaskCompleteBI(taskID, _local_1);
        }
        static function sendTaskRepeatedBI(taskID) {
            var _local_1 = CONSTANTS.TASKID_TO_TASKNAME[taskID] + "_repeat";
            com.clubpenguin.party.BaseParty.sendTaskCompleteBI(taskID, _local_1);
        }
        static function sendActivatedMachine() {
            com.clubpenguin.util.TrackerAS2.getInstance().trackGameAction("activate_machine", "halloween_2014");
        }
        static function sendClicked13thFloorNotice() {
            com.clubpenguin.world.rooms2014.halloween.party.HalloweenPartyQuestCommunicator.displayNothingOnFloor13();
            com.clubpenguin.util.TrackerAS2.getInstance().trackGameAction("thirteenth_floor_notice", "halloween_2014");
        }
        static function sendHitPowerSource() {
            com.clubpenguin.util.TrackerAS2.getInstance().trackGameAction("boss_battle", "halloween_2014", {message:"hit_power_source"});
        }
        static function sendHitDebris() {
            com.clubpenguin.util.TrackerAS2.getInstance().trackGameAction("boss_battle", "halloween_2014", {message:"hit_debris"});
        }
        static function sendHitPressurePlate() {
            com.clubpenguin.util.TrackerAS2.getInstance().trackGameAction("boss_battle", "halloween_2014", {message:"hit_pressure_plate"});
        }
        static function sendQuestCommunicatorBI(taskIndex, hint) {
            com.clubpenguin.util.TrackerAS2.getInstance().trackGameAction(String(taskIndex), "quest_hint", {message:hint});
        }
        static var CONSTANTS = com.clubpenguin.world.rooms2014.halloween.party.HalloweenPartyConstants;
        static var CLASS_NAME = "HalloweenParty";
        static var PARTY_COOKIE_ID = "20141002";
        static var _this = com.clubpenguin.world.rooms2014.halloween.party.HalloweenParty;
        static var _isActive = false;
        static var suitcaseClicked = 0;
    }
