//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2014.holiday.party.HolidayParty
    {
        static var CONSTANTS, _shell, _airtower, _interface, _engine, _party, _partycookieUpdateHandlerDelegate, _questTaskVOs, _interfaceOverrides, _engineOverrides, _previousWorldCoinTotal;
        function HolidayParty () {
            pebug("HolidayParty: Entering !!!!!");
        }
        static function init() {
            pebug("HolidayParty - INIT TRACE");
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
            engineOverrides.init();
            activateSnowballOverrides();
            activateEngineOverrides();
            initMerryWalrusAvatar();
            com.clubpenguin.world.rooms2014.holiday.party.HolidayPartySounds.init();
        }
        static function partycookieUpdateHandler() {
            _airtower.removeListener("partycookie", _partycookieUpdateHandlerDelegate);
            com.clubpenguin.party.BaseParty.partyIconState();
            com.clubpenguin.world.rooms2014.holiday.party.HolidayPartyQuestCommunicator.init();
            _engine.getRoomMovieClip().room.initializePartyCookieDependentAssets();
            _engine.getRoomMovieClip().roomFunctionality.initializePartyCookieDependentAssets();
        }
        static function configurePartySettings() {
            pebug("configurePartySettings");
            var questSettingList = CONSTANTS.PARTY_SERVICE.questSettingList;
            pebug("PARTY_SERVICE " + CONSTANTS.PARTY_SERVICE);
            pebug("questSettingList " + questSettingList);
            if (questSettingList == undefined) {
                return(undefined);
            }
            _questTaskVOs = new Array();
            var i = 0;
            while (i < questSettingList.length) {
                var vo = (new com.clubpenguin.world.rooms.common.party.PartyQuestTaskVO());
                var info = questSettingList[i];
                vo.roomId = info.roomId;
                vo.unlockDay = info.unlockDay;
                vo.questItemIndex = info.questItemIndex;
                vo.setMemberItemId(info.memberItemId, com.clubpenguin.party.items.PaperItem.TYPE);
                vo.setNonMemberItemId(info.nonmemberItemId, com.clubpenguin.party.items.PaperItem.TYPE);
                pebug("vo.memberItemId " + vo.memberItemId);
                pebug("vo.nonMemberItemId " + vo.nonMemberItemId);
                pebug("vo.memberItemVO " + vo.memberItemVO);
                pebug("vo.nonMemberItemVO " + vo.nonMemberItemVO);
                _questTaskVOs.push(vo);
                i++;
            }
        }
        static function getQuestVOByRoomID(roomId) {
            pebug("HOLIDAY PARTY- getQuestVOByRoomID - roomId " + roomId);
            var i = 0;
            while (i < _questTaskVOs.length) {
                var questVO = _questTaskVOs[i];
                pebug((("HOLIDAY PARTY -- roomId : " + roomId) + " / questVO.roomId : ") + questVO.roomId);
                if (roomId == questVO.roomId) {
                    pebug((("MATCH -- roomId : " + roomId) + " / questVO.roomId : ") + questVO.roomId);
                    return(_questTaskVOs[i]);
                    return(undefined);
                }
                i++;
            }
            return(undefined);
        }
        static function getQuestVOByQuestID(questIndex) {
            var i = 0;
            while (i < _questTaskVOs.length) {
                var questVO = _questTaskVOs[i];
                if (questIndex == questVO.questItemIndex) {
                    return(_questTaskVOs[i]);
                }
                i++;
            }
            return(undefined);
        }
        static function get partyCookie() {
            return(com.clubpenguin.world.rooms2014.holiday.vo.HolidayPartyCookieVO(com.clubpenguin.party.BaseParty.serverCookie));
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
        static function getTaskStatus(questVO) {
            return(partyCookie.questItems[questVO.questItemIndex] == 1);
        }
        static function get questTaskVOs() {
            return(_questTaskVOs);
        }
        static function setQuestTaskCompleted(index) {
            pebug("HOLIDAY PARTY setQuestTaskCompleted() index: " + index);
        }
        static function playPartyIconSparkles() {
            _interface.PARTY_ICON._visible = true;
            if (_interface.PARTY_ICON.collectedSparkles._currentframe == 1) {
                _interface.PARTY_ICON.collectedSparkles.gotoAndStop(2);
            }
        }
        static function get handleWearButtonClicked() {
            if (_shell.getRoomObject().room_id == CONSTANTS.SOLO_ROOM_ID) {
                _shell.sendJoinLastRoom();
            } else {
                _interface.closeContent();
            }
        }
        static function get interfaceOverrides() {
            if (_interfaceOverrides == null) {
                _interfaceOverrides = new com.clubpenguin.world.rooms2014.holiday.party.HolidayParty_InterfaceOverrides();
            }
            return(_interfaceOverrides);
        }
        static function get engineOverrides() {
            if (_engineOverrides == null) {
                _engineOverrides = new com.clubpenguin.world.rooms2014.holiday.party.HolidayParty_EngineOverrides();
            }
            return(_engineOverrides);
        }
        static function activateFirstTimeUserPartyFunctionality() {
            com.clubpenguin.world.rooms2014.holiday.party.HolidayPartyQuestCommunicator.clearTimeouts();
        }
        static function showPuffleAdoption() {
            if (_shell.puffleManager.myPuffles.length >= CONSTANTS.MAX_PUFFLES) {
                _shell.$e("HolidayParty -> Max Puffles Reached", {error_code:_shell.MAX_PUFFLE_LIMIT});
                return(undefined);
            }
            if (_shell.isMyPlayerMember()) {
                _interface.showContent(com.clubpenguin.modules.AS3ModuleConstants.PUFFLE_ADOPTION, null, null, {puffleAdoptionType:"1023"}, true);
            } else {
                _interface.showContent(CONSTANTS.OOPS_MEMBER_ITEM_MESSAGE);
            }
        }
        static function set previousWorldCoinTotal(num) {
            _previousWorldCoinTotal = num;
            //return(previousWorldCoinTotal);
        }
        static function get previousWorldCoinTotal() {
            return(0);
        }
        static function activateSnowballOverrides() {
            _interface.doCrossHairRelease = com.clubpenguin.util.Delegate.create(_interface, interfaceOverrides.doCrossHairRelease);
        }
        static function activateEngineOverrides() {
            pebug("Activate engine overrides _engine : " + _engine);
            pebug("Activate engine overrides engineOverrides : " + engineOverrides);
            _engine.startMouse = com.clubpenguin.util.Delegate.create(_engine, engineOverrides.startMouse);
        }
        static function deactivateEngineOverrides() {
            pebug("Deactivate engine overrides");
            _engine.startMouse = com.clubpenguin.util.Delegate.create(_engine, engineOverrides.defaultStartMouse);
        }
        static function initMerryWalrusAvatar() {
            var model = _engine.avatarManager.model;
            var merryWalrus = model.createAvatarFromTemplate(com.clubpenguin.engine.avatar.transformation.AvatarTypeEnum.DEFAULT_ID);
            merryWalrus.spritePath = "w.avatarsprite.mascot.merrywalrus";
            merryWalrus.speechBubbleOffsetY = -30;
            model.setAvatarTemplate(CONSTANTS.MERRY_WALRUS_AVATAR_ID, merryWalrus);
        }
        static function sendTaskCompleteBI(taskID) {
            var taskName = CONSTANTS.TASKID_TO_TASKNAME[taskID];
            com.clubpenguin.party.BaseParty.sendTaskCompleteBI(taskID, taskName);
        }
        static function sendOpenDonationInterfaceBI() {
        }
        static function sendCFCDonationBI(donation) {
        }
        static function sendCrystalCollected(roomId) {
            pebug("HolidayParty.sendCrystalCollected() - roomId : " + sendCrystalCollected);
            _partycookieUpdateHandlerDelegate = com.clubpenguin.util.Delegate.create(_this, crystalQuestUpdated);
            _airtower.addListener("partycookie", _partycookieUpdateHandlerDelegate);
            var currentRoomId = _shell.getCurrentRoomId();
            var crystalQuestTaskStatusIndex = partyCookie.crystalQuestTaskStatusIndexForRoom(currentRoomId);
            partyCookie.sendItemCollected(crystalQuestTaskStatusIndex);
        }
        static function crystalQuestUpdated() {
            pebug("CRYSTAL HAS BEEN COLLECTED AND THE SERVER HAS BEEN UPDATED!!!");
            _airtower.removeListener("partycookie", _partycookieUpdateHandlerDelegate);
            var questStatus = partyCookie.questItems;
            pebug("CRYSTAL QUEST STATUS - questStatus : " + questStatus);
            var cnt = 0;
            var i = 3;
            while (i < 10) {
                if (questStatus[i] == 1) {
                    cnt++;
                }
                i++;
            }
            pebug("CRYSTAL QUEST STATUS - cnt : " + cnt);
            if (cnt == 6) {
                pebug("GO TO THE SOLO ROOM!!!");
                _shell.sendJoinRoom("partysolo1");
            }
        }
        static var _this = com.clubpenguin.world.rooms2014.holiday.party.HolidayParty;
        static var _isActive = false;
    }
