//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2015.march.party.MarchParty
    {
        static var _shell, _airtower, _interface, _engine, _party, _partycookieUpdateHandlerDelegate, CLASS_NAME, _questTaskVOs, currentPuffleSelection, _closeUIHandlerDelegate, _allBerriesOnStumpDelegate, _taskItemIndex;
        function MarchParty () {
            pebug("MarchParty: Entering");
        }
        static function init() {
            pebug("MarchParty - INIT");
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
            partyCookie.sendRequestPartyCookie();
            com.clubpenguin.world.rooms2015.march.party.MarchPartySounds.init();
        }
        static function partycookieUpdateHandler() {
            pebug("*** MarchParty.partycookieUpdateHandler()", CLASS_NAME + "()");
            _airtower.removeListener("partycookie", _partycookieUpdateHandlerDelegate);
            com.clubpenguin.party.BaseParty.partyIconState();
            com.clubpenguin.world.rooms2015.march.party.MarchPartyQuestCommunicator.init();
            com.clubpenguin.world.rooms2015.march.party.MarchPartyQuestCommunicator.queuePromptToExploreWilds();
            _engine.getRoomMovieClip().room.initializePartyCookieDependentAssets();
            _engine.getRoomMovieClip().roomFunctionality.initializePartyCookieDependentAssets();
        }
        static function configurePartySettings() {
            pebug("*** MarchParty.configurePartySettings()", CLASS_NAME + "()");
            var _local_4 = CONSTANTS.PARTY_SERVICE.pufflePartyRewards;
            if (_local_4 == undefined) {
                return(undefined);
            }
            _questTaskVOs = new Array();
            var _local_3 = 0;
            while (_local_3 < _local_4.length) {
                var _local_1 = new com.clubpenguin.world.rooms2015.march.vo.PartyQuestTaskVO();
                var _local_2 = _local_4[_local_3];
                _local_1.questItemIndex = _local_2.questItemIndex;
                _local_1.unlockDay = _local_2.unlockDay;
                _local_1.puffleIds = _local_2.puffleIds;
                _local_1.memberItemId = _local_2.memberItemId;
                _local_1.nonMemberItemId = _local_2.nonmemberItemId;
                _questTaskVOs.push(_local_1);
                _local_3++;
            }
            pebug("*** MarchParty.configurePartySettings() - _questTaskVOs.length : " + _questTaskVOs, CLASS_NAME + "()");
            pebug("*** MarchParty.configurePartySettings() - _questTaskVOs[0] : " + _questTaskVOs[0], CLASS_NAME + "()");
        }
        static function getQuestVOByQuestID(questIndex) {
            var _local_1 = 0;
            while (_local_1 < _questTaskVOs.length) {
                var _local_2 = _questTaskVOs[_local_1];
                if (questIndex == _local_2.questItemIndex) {
                    return(_questTaskVOs[_local_1]);
                }
                _local_1++;
            }
            return(undefined);
        }
        static function get partyCookie() {
            return(com.clubpenguin.world.rooms2015.march.vo.MarchPartyCookieVO(com.clubpenguin.party.BaseParty.serverCookie));
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
            pebug("MarchParty.checkForFirstTimeLogin() - playerObj : " + playerObj);
            pebug("MarchParty.checkForFirstTimeLogin() - _shell.getMyPlayerId() : " + _shell.getMyPlayerId());
            if ((_shell.getMyPlayerId() != playerObj.player_id) || (_shell.getRoomObject().room_id == 112)) {
                return(undefined);
            }
            pebug("MarchParty.checkForFirstTimeLogin() - SHOW THE LOGIN PROMPT");
            pebug("MarchParty.checkForFirstTimeLogin() - partyCookie.msgViewedArray : " + partyCookie.msgViewedArray);
            if (partyCookie.msgViewedArray[CONSTANTS.LOGIN_MESSAGE_INDEX] == 0) {
                _interface.showContent(CONSTANTS.LOGIN_PROMPT_PATH);
            }
        }
        static function get partyIconVisible() {
            trace("MarchParty.partyIconVisible() - DISPLAY ICON : " + partyCookie.msgViewedArray[CONSTANTS.LOGIN_MESSAGE_INDEX]);
            if (partyCookie.msgViewedArray[CONSTANTS.LOGIN_MESSAGE_INDEX] == 1) {
                return(true);
            }
            return(undefined);
        }
        static function activateFirstTimeUserPartyFunctionality() {
            com.clubpenguin.world.rooms2015.march.party.MarchPartyQuestCommunicator.clearTimeouts();
        }
        static function partyIconClickHandler() {
            showQuestCommunicatorMessage(CONSTANTS.QC_2_BACKPACK, 5);
        }
        static function showQuestCommunicatorMessage(token, artFrameNum, messageIndex) {
            com.clubpenguin.world.rooms2015.march.party.MarchPartyQuestCommunicator.displayQCMessage(token, artFrameNum, messageIndex);
        }
        static function displayCharacterDialogue(index) {
            _interface.showContent(getDialoguePath(index));
        }
        static function getDialoguePath(dialogueIndex) {
            pebug("MARCH PARTY GET DIALOGUE PATH -- dialogueIndex : " + dialogueIndex);
            var _local_1 = "";
            switch (dialogueIndex) {
                case CONSTANTS.GET_FISHING_ROD_MESSAGE_INDEX : 
                    _local_1 = CONSTANTS.GET_FISHING_ROD_PROMPT_PATH;
                    break;
                case CONSTANTS.CONGRATS_MESSAGE_INDEX : 
                    _local_1 = CONSTANTS.CONGRATS_PROMPT_PATH;
                    break;
                case CONSTANTS.SASQUATCH_MESSAGE_INDEX : 
                    _local_1 = CONSTANTS.SASQUATCH_PROMPT_PATH;
                    break;
                case CONSTANTS.FISH_REACTION_MESSAGE_INDEX : 
                    _local_1 = CONSTANTS.FISH_PROMPT_PATH;
                    break;
                case CONSTANTS.FISHING_ROD_REACTION_MESSAGE_INDEX : 
                    _local_1 = CONSTANTS.FISHING_ROD_PROMPT_PATH;
                    break;
                case CONSTANTS.MARCH_COMIC_INDEX : 
                    _local_1 = CONSTANTS.MARCH_COMIC_PATH;
                    break;
                case CONSTANTS.CHEESE_REACTION_MESSAGE_INDEX : 
                    _local_1 = CONSTANTS.CHEESE_PROMPT_PATH;
                    break;
                case CONSTANTS.ROCK_REACTION_MESSAGE_INDEX : 
                    _local_1 = CONSTANTS.ROCK_PROMPT_PATH;
                    break;
                case CONSTANTS.SANDWICH_REACTION_MESSAGE_INDEX : 
                    _local_1 = CONSTANTS.SANDWICH_PROMPT_PATH;
                    break;
                case CONSTANTS.COFFEE_REACTION_MESSAGE_INDEX : 
                    _local_1 = CONSTANTS.COFFEE_PROMPT_PATH;
                    break;
            }
            pebug("MARCH PARTY GET DIALOGUE PATH -- promptString : " + _local_1);
            return(_local_1);
        }
        static function showGetFishingRodDialoguePopup() {
            if (partyCookie.msgViewedArray[CONSTANTS.GET_FISHING_ROD_MESSAGE_INDEX] == 0) {
                setTimeout(com.clubpenguin.util.Delegate.create(_this, displayCharacterDialogue), 1000, CONSTANTS.GET_FISHING_ROD_MESSAGE_INDEX);
            }
            startFishingRodPromptTimer();
        }
        static function showAwardItemUI(puffleTaskIndex) {
            currentPuffleSelection = puffleTaskIndex;
            if (areBothItemsInInventory(puffleTaskIndex)) {
                return(undefined);
            }
            _interface.showContent(CONSTANTS.AWARDS_COLLECTION_UI);
            if ((checkPuffleTasksCompleted() == true) && (puffleTaskIndex != CONSTANTS.SASQUATCH_TASK_INDEX)) {
                _closeUIHandlerDelegate = com.clubpenguin.util.Delegate.create(_this, onUIClose);
                _shell.addListener(_shell.CONTENT_CLOSED, _closeUIHandlerDelegate);
            }
        }
        static function onUIClose() {
            pebug("MarchParty.onUIClose !!!!!!!!!!!!!!!!");
            _shell.removeListener(_shell.CONTENT_CLOSED, _closeUIHandlerDelegate);
            showGetFishingRodDialoguePopup();
        }
        static function setTaskItemComplete(taskNumber) {
            pebug("MarchParty.setTaskItemComplete() - taskNumber : " + taskNumber, CLASS_NAME + "()");
            if (taskNumber == CONSTANTS.SASQUATCH_TASK_INDEX) {
                setTimeout(com.clubpenguin.util.Delegate.create(_party, displayQuestCompletedPopups), 2500);
            } else {
                setTimeout(com.clubpenguin.util.Delegate.create(_party, showAwardItemUI), 2500, taskNumber);
            }
            sendTaskCompleteBI(taskNumber);
            _allBerriesOnStumpDelegate = com.clubpenguin.util.Delegate.create(_this, checkAllBerriesOnTable);
            _airtower.addListener("partycookie", _allBerriesOnStumpDelegate);
            partyCookie.sendTaskComplete(taskNumber);
        }
        static function checkAllBerriesOnTable() {
            _airtower.removeListener("partycookie", _allBerriesOnStumpDelegate);
            if (checkPuffleTasksCompleted() == true) {
                sendTaskCompleteBI(CONSTANTS.ALL_BERRIES_ON_TABLE_BI_INDEX);
            }
        }
        static function checkPuffleTasksCompleted() {
            var _local_1 = 0;
            while (_local_1 < partyCookie.questItems.length) {
                if (partyCookie.questItems[_local_1] == 0) {
                    return(false);
                }
                _local_1++;
            }
            return(true);
        }
        static function getCurrentTaskItemIndex() {
            if (_taskItemIndex >= 0) {
                return(_taskItemIndex);
            } else {
                return(-1);
            }
        }
        static function areBothItemsInInventory(taskID) {
            var _local_1 = getQuestVOByQuestID(taskID);
            if (_shell.isItemInMyInventory(_local_1.nonMemberItemId) && (_shell.isItemInMyInventory(_local_1.memberItemId))) {
                return(true);
            }
            return(false);
        }
        static function startFishingRodPromptTimer() {
            com.clubpenguin.world.rooms2015.march.party.MarchPartyQuestCommunicator.queuePromptToGetFishingRod();
        }
        static function collectTaskItem(itemType) {
            pebug("MarchParty.pickUpItem() - taskItemIndex : " + _taskItemIndex);
            var _local_1 = 0;
            while (_local_1 < CONSTANTS.QUEST_ITEMS_IDS.length) {
                if (itemType == CONSTANTS.QUEST_ITEMS_IDS[_local_1]) {
                    _taskItemIndex = _local_1;
                    break;
                }
                _local_1++;
            }
            _interface.PARTY_ICON.icon_collected.gotoAndStop(itemType);
            if (itemType == "fishingrod") {
                com.clubpenguin.world.rooms2015.march.party.MarchPartyQuestCommunicator.setMessageAsViewed(CONSTANTS.QC_24_GET_FISHING_ROD_NUM);
                com.clubpenguin.world.rooms2015.march.party.MarchPartySounds.playPartySound("pickup_fishingrod");
            } else if (itemType == "fish") {
                com.clubpenguin.world.rooms2015.march.party.MarchPartySounds.playPartySound("pickup_fish");
            } else if (isBerry(itemType)) {
                com.clubpenguin.world.rooms2015.march.party.MarchPartySounds.playRandomSound("pickup_berry", 1, 2);
            } else {
                com.clubpenguin.world.rooms2015.march.party.MarchPartySounds.playPartySound("pickup_joke_item1");
            }
        }
        static function isBerry(targetString) {
            var _local_1 = ["redBerry", "yellowBerry", "whiteBerry", "greenBerry", "oBerry"];
            return(_local_1.toString().indexOf(targetString) > -1);
        }
        static function itemPlacedOnStump() {
            _taskItemIndex = -1;
            pebug("MarchParty.itemPlacedOnStump() - _taskItemIndex : " + _taskItemIndex);
            _interface.PARTY_ICON.icon_collected.gotoAndStop("none");
        }
        static function displayQuestCompletedPopups() {
            pebug("MarchParty.displayQuestCompletedPopups() -- sasquatchDialoguePopupNum : " + sasquatchDialoguePopupNum, CLASS_NAME + "()");
            switch (sasquatchDialoguePopupNum) {
                case 0 : 
                    displayCharacterDialogue(CONSTANTS.SASQUATCH_MESSAGE_INDEX);
                    break;
                case 1 : 
                    displayCharacterDialogue(CONSTANTS.FISH_REACTION_MESSAGE_INDEX);
                    break;
                case 2 : 
                    displayCharacterDialogue(CONSTANTS.FISHING_ROD_REACTION_MESSAGE_INDEX);
                    break;
                case 3 : 
                    displayCharacterDialogue(CONSTANTS.MARCH_COMIC_INDEX);
                    break;
                case 4 : 
                    displayCharacterDialogue(CONSTANTS.CONGRATS_MESSAGE_INDEX);
                    break;
                case 5 : 
                    setTimeout(com.clubpenguin.util.Delegate.create(_party, showAwardItemUI), 500, CONSTANTS.SASQUATCH_TASK_INDEX);
                    sasquatchDialoguePopupNum = 0;
                    break;
            }
            sasquatchDialoguePopupNum++;
        }
        static function setSasquatchDialogueNum() {
            sasquatchDialoguePopupNum = 0;
        }
        static function showPuffleAdoption(puffleID) {
            pebug("MarchParty.showPuffleAdoption() - puffleID : " + puffleID);
            if (_shell.puffleManager.myPuffles.length >= CONSTANTS.MAX_PUFFLES) {
                _shell.$e("HolidayParty -> Max Puffles Reached", {error_code:_shell.MAX_PUFFLE_LIMIT});
                return(undefined);
            }
            if (_shell.isMyPlayerMember()) {
                _interface.showContent(com.clubpenguin.modules.AS3ModuleConstants.PUFFLE_ADOPTION, null, null, {puffleAdoptionType:puffleID}, true);
            } else {
                _interface.showContent(CONSTANTS.OOPS_MEMBER_ITEM_MESSAGE);
            }
        }
        static function transformPuffle(puffleID) {
            pebug("MarchParty.transformPuffle() - puffleID : " + puffleID);
        }
        static function sendTaskCompleteBI(taskID) {
            var _local_2 = CONSTANTS.TASKID_TO_TASKNAME[taskID];
            var _local_1 = CONSTANTS.TASKID_TO_MOBILE_ID[taskID];
            com.clubpenguin.party.BaseParty.sendTaskCompleteBI(_local_1, _local_2);
        }
        static var CONSTANTS = com.clubpenguin.world.rooms2015.march.party.MarchPartyConstants;
        static var _this = com.clubpenguin.world.rooms2015.march.party.MarchParty;
        static var _isActive = false;
        static var sasquatchDialoguePopupNum = 0;
    }
