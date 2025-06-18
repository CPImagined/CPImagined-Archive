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
            var _local_4 = CONSTANTS.PARTY_SERVICE.questSettingList;
            pebug("PARTY_SERVICE " + CONSTANTS.PARTY_SERVICE);
            pebug("questSettingList " + _local_4);
            if (_local_4 == undefined) {
                return(undefined);
            }
            _questTaskVOs = new Array();
            var _local_3 = 0;
            while (_local_3 < _local_4.length) {
                var _local_1 = new com.clubpenguin.world.rooms.common.party.PartyQuestTaskVO();
                var _local_2 = _local_4[_local_3];
                _local_1.roomId = _local_2.roomId;
                _local_1.unlockDay = _local_2.unlockDay;
                _local_1.questItemIndex = _local_2.questItemIndex;
                _local_1.setMemberItemId(_local_2.memberItemId, com.clubpenguin.party.items.PaperItem.TYPE);
                _local_1.setNonMemberItemId(_local_2.nonmemberItemId, com.clubpenguin.party.items.PaperItem.TYPE);
                pebug("vo.memberItemId " + _local_1.memberItemId);
                pebug("vo.nonMemberItemId " + _local_1.nonMemberItemId);
                pebug("vo.memberItemVO " + _local_1.memberItemVO);
                pebug("vo.nonMemberItemVO " + _local_1.nonMemberItemVO);
                _questTaskVOs.push(_local_1);
                _local_3++;
            }
        }
        static function getQuestVOByRoomID(roomId) {
            pebug("HOLIDAY PARTY- getQuestVOByRoomID - roomId " + roomId);
            var _local_1 = 0;
            while (_local_1 < _questTaskVOs.length) {
                var _local_2 = _questTaskVOs[_local_1];
                pebug((("HOLIDAY PARTY -- roomId : " + roomId) + " / questVO.roomId : ") + _local_2.roomId);
                if (roomId == _local_2.roomId) {
                    pebug((("MATCH -- roomId : " + roomId) + " / questVO.roomId : ") + _local_2.roomId);
                    return(_questTaskVOs[_local_1]);
                    return(undefined);
                }
                _local_1++;
            }
            return(undefined);
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
            var _local_2 = _engine.avatarManager.model;
            var _local_1 = _local_2.createAvatarFromTemplate(com.clubpenguin.engine.avatar.transformation.AvatarTypeEnum.DEFAULT_ID);
            _local_1.spritePath = "w.avatarsprite.mascot.merrywalrus";
            _local_1.speechBubbleOffsetY = -30;
            _local_2.setAvatarTemplate(CONSTANTS.MERRY_WALRUS_AVATAR_ID, _local_1);
        }
        static function sendTaskCompleteBI(taskID) {
            var _local_1 = CONSTANTS.TASKID_TO_TASKNAME[taskID];
            com.clubpenguin.party.BaseParty.sendTaskCompleteBI(taskID, _local_1);
        }
        static function sendOpenDonationInterfaceBI() {
            com.clubpenguin.util.TrackerAS2.getInstance().trackGameAction(null, "cfc_donation");
        }
        static function sendCFCDonationBI(donation) {
            com.clubpenguin.util.TrackerAS2.getInstance().trackRewardEarned(com.clubpenguin.util.TrackerAS2.CURRENCY_COINS, donation, "cfc_donation", "donation_amount", _global.getCurrentShell().getMyPlayerTotalCoins());
        }
        static function sendCrystalCollected(roomId) {
            pebug("HolidayParty.sendCrystalCollected() - roomId : " + sendCrystalCollected);
            _partycookieUpdateHandlerDelegate = com.clubpenguin.util.Delegate.create(_this, crystalQuestUpdated);
            _airtower.addListener("partycookie", _partycookieUpdateHandlerDelegate);
            var _local_2 = _shell.getCurrentRoomId();
            var _local_1 = partyCookie.crystalQuestTaskStatusIndexForRoom(_local_2);
            partyCookie.sendItemCollected(_local_1);
        }
        static function crystalQuestUpdated() {
            pebug("CRYSTAL HAS BEEN COLLECTED AND THE SERVER HAS BEEN UPDATED!!!");
            _airtower.removeListener("partycookie", _partycookieUpdateHandlerDelegate);
            var _local_3 = partyCookie.questItems;
            pebug("CRYSTAL QUEST STATUS - questStatus : " + _local_3);
            var _local_2 = 0;
            var _local_1 = 3;
            while (_local_1 < 10) {
                if (_local_3[_local_1] == 1) {
                    _local_2++;
                }
                _local_1++;
            }
            pebug("CRYSTAL QUEST STATUS - cnt : " + _local_2);
            if (_local_2 == 6) {
                pebug("GO TO THE SOLO ROOM!!!");
                _shell.sendJoinRoom("partysolo1");
            }
        }
        static var _this = com.clubpenguin.world.rooms2014.holiday.party.HolidayParty;
        static var _isActive = false;
    }
