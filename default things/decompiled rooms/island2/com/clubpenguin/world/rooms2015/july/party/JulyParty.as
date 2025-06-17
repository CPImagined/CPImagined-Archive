//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2015.july.party.JulyParty
    {
        static var _shell, _airtower, _interface, _engine, _partycookieUpdateHandlerDelegate, _questTaskVOs, _interfaceOverrides, _engineOverrides, _puffleIDBeingWalked, _questInterfaceJoinHQDelegate, _totalCoinsUpdateDelegate, _closeQuestPopupDelegate, _joinRoomDelegate, _snowballCoolDownExpirationDate;
        function JulyParty () {
        }
        static function init() {
            pebug("JULY PARTY - INIT");
            com.clubpenguin.party.BaseParty.CLASS_NAME = _this.CLASS_NAME;
            com.clubpenguin.party.BaseParty.CURRENT_PARTY = _this;
            com.clubpenguin.party.BaseParty.setConditionalPartyIconVisibility();
            com.clubpenguin.party.BaseParty.addListenerForPartySettings(CONSTANTS.PARTY_SETTINGS_RESPONSE_NAME);
            _isActive = true;
            _shell = _global.getCurrentShell();
            _airtower = _global.getCurrentAirtower();
            _interface = _global.getCurrentInterface();
            _engine = _global.getCurrentEngine();
            initPartyAvatars();
            activateInterfaceOverrides();
            activateEngineOverrides();
            activateSnowballOverrides();
            com.clubpenguin.world.rooms2015.july.party.JulyPartySounds.init();
            _partycookieUpdateHandlerDelegate = com.clubpenguin.util.Delegate.create(_this, partycookieUpdateHandler);
            _airtower.addListener("partycookie", _partycookieUpdateHandlerDelegate);
            partyCookie.sendRequestPartyCookie();
            loadLoginPrompt();
        }
        static function loadLoginPrompt() {
            pebug("PRELOADING LOGIN PROMPT!!!!!!");
            _interface.showContent(CONSTANTS.LOGIN_PROMPT_PATH);
        }
        static function removePartyCookieListener() {
            pebug("*** JulyParty.removePartyCookieListener()", CLASS_NAME + "()");
            _airtower.removeListener("partycookie", _partycookieUpdateHandlerDelegate);
        }
        static function partycookieUpdateHandler() {
            pebug("*** JulyParty.partycookieUpdateHandler() - partyCookie : " + partyCookie, CLASS_NAME + "()");
            com.clubpenguin.party.BaseParty.partyIconState();
            partyTaskUpdate();
            com.clubpenguin.world.rooms2015.july.party.JulyPartyQuestCommunicator.init();
            _engine.getRoomMovieClip().room.initializePartyCookieDependentAssets();
            _engine.getRoomMovieClip().roomFunctionality.initializePartyCookieDependentAssets();
        }
        static function configurePartySettings() {
            pebug("JulyParty.configurePartySettings()");
            var _local_5 = CONSTANTS.PARTY_SERVICE.questSettingList;
            if (_local_5 == undefined) {
                return(undefined);
            }
            _questTaskVOs = new Array();
            var _local_4 = 0;
            while (_local_4 < _local_5.length) {
                var _local_3 = new com.clubpenguin.world.rooms2015.july.vo.JulyPartyQuestTaskVO();
                var _local_2 = _local_5[_local_4];
                _local_3.questTaskIndex = _local_2.questTaskIndex;
                _local_3.emotion = _local_2.emotion;
                var _local_1 = 0;
                while (_local_1 < _local_2.memberItems.length) {
                    _local_3.setMemberItemId(_local_2.memberItems[_local_1], com.clubpenguin.party.items.PaperItem.TYPE);
                    _local_1++;
                }
                _local_3.setNonMemberItemId(_local_2.nonMemberItem, com.clubpenguin.party.items.PaperItem.TYPE);
                _questTaskVOs.push(_local_3);
                pebug("Quest Task VO " + _local_3.toString);
                _local_4++;
            }
            pebug("_questTaskVOs.length " + _questTaskVOs.length);
        }
        static function get partyCookie() {
            return(com.clubpenguin.world.rooms2015.july.vo.JulyPartyCookieVO(com.clubpenguin.party.BaseParty.serverCookie));
        }
        static function get isActive() {
            return(_isActive);
        }
        static function get isWeek2() {
            return(((CONSTANTS.PARTY_DAY < 7) ? false : true));
        }
        static function pebug(msg, prefix) {
            com.clubpenguin.party.BaseParty.pebug(msg, prefix);
        }
        static function playSound(ui, soundId, volume) {
            com.clubpenguin.party.BaseParty.playSound(ui, soundId, volume);
        }
        static function checkForFirstTimeLogin(playerObj) {
        }
        static function showPartyCatalogue() {
            _global.getCurrentInterface().showContent(CONSTANTS.PARTY_CATALOGUE);
        }
        static function showMemberContentOopsMessage() {
            _global.getCurrentInterface().showContent(CONSTANTS.OOPS_CATALOGUE_MESSAGE);
        }
        static function get interfaceOverrides() {
            if (_interfaceOverrides == null) {
                _interfaceOverrides = new com.clubpenguin.world.rooms2015.july.party.JulyParty_InterfaceOverrides();
            }
            return(_interfaceOverrides);
        }
        static function get engineOverrides() {
            if (_engineOverrides == null) {
                _engineOverrides = new com.clubpenguin.world.rooms2015.july.party.JulyParty_EngineOverrides();
            }
            return(_engineOverrides);
        }
        static function get partyIconVisible() {
            if (partyCookie.msgViewedArray[0] == 1) {
                return(true);
            }
            return(false);
        }
        static function set puffleIDBeingWalked(id) {
            _puffleIDBeingWalked = id;
            //return(puffleIDBeingWalked);
        }
        static function get puffleIDBeingWalked() {
            return(_puffleIDBeingWalked);
        }
        static function get uiSelectionNum() {
            return(_uiSelectionNum);
        }
        static function set uiSelectionNum(num) {
            _uiSelectionNum = num;
            //return(uiSelectionNum);
        }
        static function get currentQuestTaskId() {
            return(_currentQuestTaskId);
        }
        static function setCurrentQuestTaskId() {
            _currentQuestTaskId = uiSelectionNum;
            _engine.getRoomMovieClip().room.configureRoom();
            pebug("JulyParty - currentQuestTaskId() - SET BY CLICKING START BUTTON IN POPUP : " + currentQuestTaskId, CLASS_NAME + "()");
        }
        static function setOrbCollected(num) {
            pebug("JulyParty - currentOrbNum() - num : " + num, CLASS_NAME + "()");
            setPartyIconFrame(getPartyIconFrame(num + 5));
            _currentOrbNum = num;
            setTimeout(com.clubpenguin.util.Delegate.create(_this, showItemCollectPopup, num), 1200);
        }
        static function get currentOrbNum() {
            return(_currentOrbNum);
        }
        static function getQuestVOByQuestID(questIndex) {
            pebug("JulyParty - getQuestVOByQuestID() - _questTaskVOs.length: " + _questTaskVOs.length, CLASS_NAME + "()");
            pebug("JulyParty - getQuestVOByQuestID() - _questTaskVOs.length: " + _questTaskVOs.length, CLASS_NAME + "()");
            var _local_1 = 0;
            while (_local_1 < _questTaskVOs.length) {
                var _local_2 = _questTaskVOs[_local_1];
                if (questIndex == _local_2.questTaskIndex) {
                    return(_questTaskVOs[_local_1]);
                }
                _local_1++;
            }
            return(undefined);
        }
        static function partyIconClickHandler() {
            _interface.showContent(CONSTANTS.QUEST_UI_PATH);
        }
        static function setPartyIconFrame(frameLabel) {
            _interface.PARTY_ICON.partyIcon.gotoAndStop(frameLabel);
            pebug("setPartyIconFrame() - frameLabel : " + frameLabel, CLASS_NAME + "()");
            pebug("setPartyIconFrame() - CURRENT FRAME ??? : " + getCurrentPartyIconFrame(), CLASS_NAME + "()");
        }
        static function isOrbInPartyIcon() {
            return(((getCurrentPartyIconFrame() > 6) ? true : false));
        }
        static function getCurrentPartyIconFrame() {
            return(_interface.PARTY_ICON.partyIcon._currentframe);
        }
        static function showQuestCommunicatorMessage(index) {
            com.clubpenguin.world.rooms2015.july.party.JulyPartyQuestCommunicator.displayQCMessage(index);
        }
        static function requestNewTaskSelection(requestId) {
            pebug("QUEST UI TASK SELECTION - requestNewTaskSelection() - requestId : " + requestId, CLASS_NAME + "()");
            uiSelectionNum = (requestId);
            if (_shell.getRoomObject().room_id != CONSTANTS.PARTY_ROOM_1_ID) {
                _questInterfaceJoinHQDelegate = com.clubpenguin.util.Delegate.create(_this, onLoadPartyRoom1);
                _shell.addListener(_shell.JOIN_ROOM, _questInterfaceJoinHQDelegate);
                _shell.sendJoinRoom("party1");
            } else {
                showTaskStartPopup(uiSelectionNum);
            }
        }
        static function onLoadPartyRoom1() {
            _shell.removeListener(_shell.JOIN_ROOM, _questInterfaceJoinHQDelegate);
            _questInterfaceJoinHQDelegate = null;
            if (partyCookie.hasPlayerViewedMessage(CONSTANTS.WELCOME_MESSAGE_INDEX)) {
                displayStartTaskPopup();
            }
        }
        static function showHeadquartersPopup() {
            pebug("JulyParty.showHeadquartersPopup()");
            if (!partyCookie.hasPlayerViewedMessage(CONSTANTS.WELCOME_MESSAGE_INDEX)) {
                _interface.showContent(CONSTANTS.WELCOME_PROMPT_PATH);
            } else {
                displayStartTaskPopup();
            }
        }
        static function displayStartTaskPopup() {
            pebug("JulyParty.displayStartTaskPopup()");
            if (partyCookie.isQuestComplete()) {
                return(undefined);
            }
            showTaskStartPopup(uiSelectionNum);
        }
        static function partyTaskUpdate() {
            _uiSelectionNum = partyCookie.nextAvailableTask;
            _currentQuestTaskId = partyCookie.nextAvailableTask;
            setPartyIconFrame(getPartyIconFrame(currentQuestTaskId));
            if (_shell.getRoomObject().room_id == CONSTANTS.PARTY_ROOM_1_ID) {
                _engine.getRoomMovieClip().room.configureRoom();
            }
            pebug("partyTaskUpdate() - currentQuestTaskId : " + currentQuestTaskId);
            pebug("partyTaskUpdate() - current icon frame : " + getCurrentPartyIconFrame());
        }
        static function listenForCoinsUpdate() {
            _totalCoinsUpdateDelegate = com.clubpenguin.util.Delegate.create(_this, getPlayerTotalCoins);
            _airtower.addListener("totalcoins", _totalCoinsUpdateDelegate);
        }
        static function getPlayerTotalCoins(data) {
            _airtower.removeListener("totalcoins", _totalCoinsUpdateDelegate);
            _totalCoinsUpdateDelegate = null;
            _shell.setMyPlayerTotalCoins(data[1]);
            pebug("!!!JulyParty.getPlayerTotalCoins() : " + _shell.getMyPlayerObject().coins);
            com.clubpenguin.util.TrackerAS2.getInstance().trackRewardEarned(com.clubpenguin.util.TrackerAS2.CURRENCY_ITEMS, -1, "quest complete", "Quest Complete Reward", _shell.getMyPlayerTotalCoins());
        }
        static function showTaskStartPopup(taskNum) {
            pebug("showTaskStartPopup() - taskNum : " + taskNum);
            _interface.showContent(getTaskStartPopup(taskNum));
            uiSelectionNum = (taskNum);
            _closeQuestPopupDelegate = com.clubpenguin.util.Delegate.create(_this, taskStartPopupClosed);
            _shell.addListener(_shell.CONTENT_CLOSED, _closeQuestPopupDelegate);
        }
        static function taskStartPopupClosed() {
            if (currentQuestTaskId == uiSelectionNum) {
                setPartyIconFrame(getPartyIconFrame(currentQuestTaskId));
            }
            if (_shell.getRoomObject().room_id == CONSTANTS.PARTY_ROOM_1_ID) {
                _engine.getRoomMovieClip().room.configureRoom();
            }
            _shell.removeListener(_shell.CONTENT_CLOSED, _closeQuestPopupDelegate);
            _closeQuestPopupDelegate = null;
        }
        static function showItemCollectPopup(taskNum) {
            _interface.showContent(getItemCollectPopup(taskNum));
        }
        static function questMinigameCompleted(isWin, taskId) {
            pebug((("questMinigameCompleted() - isWin : " + isWin) + " / taskId : ") + taskId, CLASS_NAME + "()");
            if (isWin) {
                _interface.showContent(getMemoryPopup(taskId));
                partyCookie.sendTaskComplete(taskId);
            }
        }
        static function showTaskCompletePopup(taskId) {
            _interface.closeContent();
            _interface.showContent(getTaskCompletePopup(taskId));
        }
        static function setTaskCompleteFunctionality() {
            _interface.closeContent();
            if ((partyCookie.nextAvailableTask == -1) || (partyCookie.isQuestComplete())) {
                showQuestCompletePopup();
            } else {
                showTaskStartPopup(partyCookie.nextAvailableTask);
            }
            partyTaskUpdate();
            pebug("setTaskCompleteFunctionality() - partyCookie.nextAvailableTask: " + partyCookie.nextAvailableTask, CLASS_NAME + "()");
            pebug("setTaskCompleteFunctionality() - currentQuestTaskId : " + currentQuestTaskId, CLASS_NAME + "()");
        }
        static function showQuestCompletePopup() {
            pebug("showQuestCompletePopup() - IS QUEST COMPLETE?? " + partyCookie.isQuestComplete, CLASS_NAME + "()");
            if (!partyCookie.hasPlayerViewedMessage(CONSTANTS.JOY_THANKS_MESSAGE_INDEX)) {
                _interface.showContent(CONSTANTS.JOY_THANKS_PROMPT_PATH);
                partyCookie.sendMessageViewed(CONSTANTS.JOY_THANKS_MESSAGE_INDEX);
            }
        }
        static function showGaryThanksPopup() {
            _interface.closeContent();
            _interface.showContent(CONSTANTS.GARY_THANKS_PROMPT_PATH);
        }
        static function showRockhopperThankyouPopup() {
            pebug("showRockhopperThankyouPopup() - is quest complete: " + partyCookie.isQuestComplete());
            pebug("showRockhopperThankyouPopup() - RH message viewed? " + partyCookie.hasPlayerViewedMessage(CONSTANTS.ROCKHOPPER_THANKS_MESSAGE_INDEX), CLASS_NAME + "()");
            _interface.showContent(CONSTANTS.ROCKHOPPER_THANKS_PROMPT_PATH);
        }
        static function getTaskStartPopup(taskNum) {
            switch (taskNum) {
                case 0 : 
                    return(CONSTANTS.JOY_START_POPUP);
                    break;
                case 1 : 
                    return(CONSTANTS.SADNESS_START_POPUP);
                    break;
                case 2 : 
                    return(CONSTANTS.ANGER_START_POPUP);
                    break;
                case 3 : 
                    return(CONSTANTS.DISGUST_START_POPUP);
                    break;
                case 4 : 
                    return(CONSTANTS.FEAR_START_POPUP);
                    break;
            }
        }
        static function getItemCollectPopup(taskNum) {
            switch (taskNum) {
                case 0 : 
                    return(CONSTANTS.JOY_COLLECT_POPUP);
                    break;
                case 1 : 
                    return(CONSTANTS.SADNESS_COLLECT_POPUP);
                    break;
                case 2 : 
                    return(CONSTANTS.ANGER_COLLECT_POPUP);
                    break;
                case 3 : 
                    return(CONSTANTS.DISGUST_COLLECT_POPUP);
                    break;
                case 4 : 
                    return(CONSTANTS.FEAR_COLLECT_POPUP);
                    break;
            }
        }
        static function getMemoryPopup(id) {
            switch (id) {
                case 0 : 
                    return(CONSTANTS.JOY_MEMORY_POPUP);
                    break;
                case 1 : 
                    return(CONSTANTS.SADNESS_MEMORY_POPUP);
                    break;
                case 2 : 
                    return(CONSTANTS.ANGER_MEMORY_POPUP);
                    break;
                case 3 : 
                    return(CONSTANTS.DISGUST_MEMORY_POPUP);
                    break;
                case 4 : 
                    return(CONSTANTS.FEAR_MEMORY_POPUP);
                    break;
            }
        }
        static function getTaskCompletePopup(id) {
            switch (id) {
                case 0 : 
                    return(CONSTANTS.JOY_COMPLETE_POPUP);
                    break;
                case 1 : 
                    return(CONSTANTS.SADNESS_COMPLETE_POPUP);
                    break;
                case 2 : 
                    return(CONSTANTS.ANGER_COMPLETE_POPUP);
                    break;
                case 3 : 
                    return(CONSTANTS.DISGUST_COMPLETE_POPUP);
                    break;
                case 4 : 
                    return(CONSTANTS.FEAR_COMPLETE_POPUP);
                    break;
            }
        }
        static function getPartyIconFrame(num) {
            switch (num) {
                case -1 : 
                    return("none");
                    break;
                case 0 : 
                    return("joyFind");
                    break;
                case 1 : 
                    return("sadFind");
                    break;
                case 2 : 
                    return("angerFind");
                    break;
                case 3 : 
                    return("disgustFind");
                    break;
                case 4 : 
                    return("fearFind");
                    break;
                case 5 : 
                    return("joyFound");
                    break;
                case 6 : 
                    return("sadFound");
                    break;
                case 7 : 
                    return("angerFound");
                    break;
                case 8 : 
                    return("disgustFound");
                    break;
                case 9 : 
                    return("fearFound");
                    break;
            }
        }
        static function unequipCurrentPuffle() {
            puffleIDBeingWalked = (_shell.getMyPlayerObject().attachedPuffle.id);
            if (puffleIDBeingWalked != undefined) {
                _airtower.send(_airtower.PLAY_EXT, (_airtower.PET_HANDLER + "#") + _airtower.WALK_PUFFLE, [puffleIDBeingWalked, 0], "str", _shell.getCurrentServerRoomId());
            }
            addListenerForRewalkingPuffle();
        }
        static function reequipCurrentPuffle() {
            if (puffleIDBeingWalked != undefined) {
                _airtower.send(_airtower.PLAY_EXT, (_airtower.PET_HANDLER + "#") + _airtower.WALK_PUFFLE, [puffleIDBeingWalked, 1], "str", _shell.getCurrentServerRoomId());
                puffleIDBeingWalked = (null);
                _engine.penguinTransformComplete.remove(_joinRoomDelegate);
            }
        }
        static function addListenerForRewalkingPuffle() {
            _joinRoomDelegate = com.clubpenguin.util.Delegate.create(_this, handleJoinRoom);
            _engine.penguinTransformComplete.add(_joinRoomDelegate);
        }
        static function handleJoinRoom(playerObj) {
            if (_shell.getMyPlayerId() != playerObj.player_id) {
                return(undefined);
            }
            reequipCurrentPuffle();
        }
        static function initPartyAvatars() {
            var _local_2 = _engine.avatarManager.model;
            var _local_1 = _local_2.createAvatarFromTemplate(com.clubpenguin.engine.avatar.transformation.AvatarTypeEnum.DEFAULT_ID);
            _local_1.isSpriteTransformed = true;
            _local_1.defaultTransitionEffect = com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.SMOKE_POOF_BLUE;
            _local_1.defaultRevertEffect = com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.SMOKE_POOF_BLUE;
            _local_1.hasCustomPlayerCard = true;
            _local_1.canRevertToDefault = true;
            _local_1.attachItems = false;
            _local_1.hasColorVersions = false;
            _local_1.isMemberOnly = true;
            _local_1.spritePath = CONSTANTS.BINGBONG_TRANSFORMATION_TOKEN;
            _local_2.setAvatarTemplate(CONSTANTS.TRANSFORMATION_ID_BINGBONG, _local_1);
            var _local_3 = _local_1.clone();
            _local_3.spritePath = CONSTANTS.UNICORN_TRANSFORMATION_TOKEN;
            _local_2.setAvatarTemplate(CONSTANTS.TRANSFORMATION_ID_UNICORN, _local_3);
        }
        static function sendTransformation(id) {
            _airtower.send(_airtower.PLAY_EXT, (com.clubpenguin.world.rooms2015.july.vo.JulyPartyCookieVO.JULY_COOKIE_HANDLER_NAME + "#") + CONSTANTS.SET_TRANSFORM, [id], "str", _shell.getCurrentServerRoomId());
            if (id == CONSTANTS.TRANSFORMATION_ID_BINGBONG) {
                currentTransformName = "BingBong";
            }
            if (id == CONSTANTS.TRANSFORMATION_ID_UNICORN) {
                currentTransformName = "RainbowUnicorn";
            }
            if (currentTransformName != "") {
                sendTransformBI(currentTransformName);
            }
            _interface.closeContent();
        }
        static function get localPlayerAvatarID() {
            return(_shell.getPlayerObjectById(_shell.getMyPlayerId()).avatarVO.avatar_id);
        }
        static function get snowballCoolDownExpirationDate() {
            return(((_snowballCoolDownExpirationDate == undefined) ? (_shell.getPenguinStandardTime().getTime()) : (_snowballCoolDownExpirationDate)));
        }
        static function startSnowballCoolDown() {
            _snowballCoolDownExpirationDate = _shell.getPenguinStandardTime().getTime() + CONSTANTS.SNOWBALL_COOLDOWN;
        }
        static function get isSnowballEnabled() {
            if (snowballCoolDownExpirationDate <= _shell.getPenguinStandardTime().getTime()) {
                return(true);
            }
            return(false);
        }
        static function activateInterfaceOverrides() {
            pebug("Activate interface overrides");
            _interface.doCrossHairRelease = com.clubpenguin.util.Delegate.create(_interface, interfaceOverrides.doCrossHairRelease);
            _interface.updateAvatarCard = com.clubpenguin.util.Delegate.create(_interface, interfaceOverrides.updateAvatarCard);
            _interface.revertAvatar = com.clubpenguin.util.Delegate.create(_interface, interfaceOverrides.revertAvatar);
        }
        static function activateEngineOverrides() {
            _engine.updatePlayerFrame = com.clubpenguin.util.Delegate.create(_engine, engineOverrides.updatePlayerFrame);
        }
        static function activateSnowballOverrides() {
            _engine.snowballManager = new com.clubpenguin.world.rooms2015.july.party.JulyPartySnowballManager(_shell, _engine, _interface);
        }
        static function sendTransformBI(currentTransformName) {
            com.clubpenguin.util.TrackerAS2.getInstance().trackGameAction(currentTransformName, "avatar_transform");
            com.clubpenguin.util.TrackerAS2.getInstance().trackStepTimingEvent("avatar_transform_" + currentTransformName.toLowerCase(), "start");
        }
        static function sendUnTransformBI() {
            com.clubpenguin.util.TrackerAS2.getInstance().trackStepTimingEvent("avatar_transform_" + currentTransformName, "end");
        }
        static var CONSTANTS = com.clubpenguin.world.rooms2015.july.party.JulyPartyConstants;
        static var CLASS_NAME = "JulyParty";
        static var PARTY_COOKIE_ID = "20150702";
        static var _this = com.clubpenguin.world.rooms2015.july.party.JulyParty;
        static var _isActive = false;
        static var _uiSelectionNum = 0;
        static var _currentQuestTaskId = 0;
        static var _currentOrbNum = 0;
        static var currentTransformName = "";
        static var testString = "TEST STRING!!!";
    }
