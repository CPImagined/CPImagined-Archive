//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2015.automated.party.NovemberParty
    {
        static var CONSTANTS, _shell, _airtower, _interface, _engine, _party, _partycookieUpdateHandlerDelegate, _panelPositions, _puffleAdoptionVOs, _transformationVOs, _questTaskVOs, _avatarVOs;
        function NovemberParty () {
            pebug("NovemberParty: Entering");
        }
        static function init() {
            pebug("NovemberParty - INIT");
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
            configurePartyJSON();
        }
        static function configurePartyJSON() {
            _interface.showContent(CONSTANTS.FEATURES_SWF_PATH);
        }
        static function loadPartyFeatures() {
            _interface.closeContent();
            var _local_1 = new com.clubpenguin.world.rooms2015.automated.vo.PartyJSON_Parser();
            _local_1.deserialized.add(com.clubpenguin.util.Delegate.create(_this, partyJsonDeserialized, _local_1.jsonObject));
            _local_1.deserialize(CONSTANTS.PARTY_SERVICE);
        }
        static function partyJsonDeserialized(jsonObject) {
            if (jsonObject == undefined) {
                return(undefined);
            }
            CONSTANTS.PARTY_SERVICE = jsonObject;
            _panelPositions = CONSTANTS.PARTY_SERVICE.featureSettings.panelPositionsX;
            createPuffleAdoptionVOs();
            createTransformationVOs();
            createQuestVOs();
        }
        static function createPuffleAdoptionVOs() {
            _puffleAdoptionVOs = [];
            var _local_3 = CONSTANTS.PARTY_SERVICE.featureSettings.puffleAdoptionList;
            var _local_1 = 0;
            while (_local_1 < _local_3.length) {
                var _local_2 = new com.clubpenguin.world.rooms2015.automated.vo.TemplatedPuffleAdoptionVO();
                _local_2.puffleType = _local_3[_local_1].puffleType;
                _local_2.puffleId = _local_3[_local_1].puffleId;
                _local_2.unlockDay = _local_3[_local_1].adoptDateLock;
                _local_2.unlockTaskNumber = _local_3[_local_1].adoptTaskLock;
                _local_2.gothere = _local_3[_local_1].gothere;
                _local_2.isMember = _local_3[_local_1].adoptMember;
                _puffleAdoptionVOs.push(_local_2);
                _local_1++;
            }
        }
        static function getPuffleAdoptionVOs() {
            if (_puffleAdoptionVOs.length) {
                return(_puffleAdoptionVOs);
            }
            return(null);
        }
        static function createTransformationVOs() {
            _transformationVOs = [];
            var _local_3 = CONSTANTS.PARTY_SERVICE.featureSettings.transformationList;
            var _local_1 = 0;
            while (_local_1 < _local_3.length) {
                var _local_2 = new com.clubpenguin.world.rooms2015.automated.vo.TemplatedTransformationVO();
                _local_2.transformName = _local_3[_local_1].transformName;
                _local_2.transformId = _local_3[_local_1].transformId;
                _local_2.transformToken = _local_3[_local_1].transformToken;
                _local_2.unlockDay = _local_3[_local_1].transformDateLock;
                _local_2.unlockTaskNumber = _local_3[_local_1].transformTaskLock;
                _local_2.gothere = _local_3[_local_1].gothere;
                _local_2.isMember = _local_3[_local_1].transformMember;
                _transformationVOs.push(_local_2);
                _local_1++;
            }
            initPartyAvatars();
        }
        static function getTransformationVOs() {
            if (_transformationVOs.length) {
                return(_transformationVOs);
            }
            return(null);
        }
        static function createQuestVOs() {
            _questTaskVOs = [];
            var _local_3 = CONSTANTS.PARTY_SERVICE.featureSettings.questSettingList;
            var _local_1 = 0;
            while (_local_1 < _local_3.length) {
                var _local_2 = new com.clubpenguin.world.rooms2015.automated.vo.TemplatedQuestTaskVO();
                _local_2.questTaskIndex = _local_3[_local_1].questTaskId;
                _local_2.taskName = _local_3[_local_1].taskName;
                _local_2.unlockDay = _local_3[_local_1].dateLock;
                _local_2.taskLockNumber = _local_3[_local_1].taskLockNumber;
                _local_2.gothere = _local_3[_local_1].gothere;
                var _local_5 = 0;
                while (_local_5 < _local_3[_local_1].memberItems.length) {
                    _local_2.setMemberItemId(_local_3[_local_1].memberItems[_local_5], com.clubpenguin.party.items.PaperItem.TYPE);
                    _local_5++;
                }
                var _local_4 = 0;
                while (_local_4 < _local_3[_local_1].nonMemberItems.length) {
                    _local_2.setNonMemberItemId(_local_3[_local_1].nonMemberItems[_local_4], com.clubpenguin.party.items.PaperItem.TYPE);
                    _local_4++;
                }
                _questTaskVOs.push(_local_2);
                _local_1++;
            }
        }
        static function getQuestVOByTaskIndex(index) {
            if (_questTaskVOs.length) {
                var _local_1 = 0;
                while (_local_1 < _questTaskVOs.length) {
                    if (_questTaskVOs[_local_1].questTaskIndex == index) {
                        return(_questTaskVOs[_local_1]);
                    }
                    _local_1++;
                }
            }
            return(undefined);
        }
        static function getQuestVOByIndex(index) {
            if (_questTaskVOs.length) {
                return(_questTaskVOs[index]);
            }
            return(undefined);
        }
        static function getLengthOfQuestVOs() {
            return(_questTaskVOs.length);
        }
        static function partycookieUpdateHandler() {
            _airtower.removeListener("partycookie", _partycookieUpdateHandlerDelegate);
            pebug("partycookieUpdateHandler() - partyCookie.msgViewedArray : " + partyCookie.msgViewedArray);
            _engine.getRoomMovieClip().room.initializePartyCookieDependentAssets();
            _engine.getRoomMovieClip().roomFunctionality.initializePartyCookieDependentAssets();
        }
        static function configurePartySettings() {
            pebug("configurePartySettings() - CONSTANTS.PARTY_SERVICE: " + CONSTANTS.PARTY_SERVICE);
            CONSTANTS.TOTAL_PARTY_DAYS = Number(CONSTANTS.PARTY_SERVICE.partySettings.numOfDaysInParty);
            CONSTANTS.PARTY_DAY = Number(CONSTANTS.PARTY_SERVICE.partySettings.unlockDayIndex);
            pebug("configurePartySettings() - CONSTANTS.TOTAL_PARTY_DAYS: " + CONSTANTS.TOTAL_PARTY_DAYS);
            pebug("configurePartySettings() - CONSTANTS.PARTY_DAY: " + CONSTANTS.PARTY_DAY);
        }
        static function get partyCookie() {
            return(com.clubpenguin.world.rooms2015.automated.vo.TemplatePartyCookieVO(com.clubpenguin.party.BaseParty.serverCookie));
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
            checkDisplayLoginPrompt();
        }
        static function checkDisplayLoginPrompt() {
            pebug("checkDisplayLoginPrompt() - login message index: " + partyCookie.msgViewedArray[CONSTANTS.LOGIN_MESSAGE_INDEX]);
            pebug("checkDisplayLoginPrompt() - CONSTANTS.PARTY_DAY: " + CONSTANTS.PARTY_DAY);
            if (partyCookie.msgViewedArray[CONSTANTS.LOGIN_MESSAGE_INDEX] == 0) {
                _interface.showContent(CONSTANTS.LOGIN_PROMPT_PATH);
            } else if (isNextTaskAvailable()) {
                _interface.showContent(CONSTANTS.LOGIN_ALERT_PATH);
            }
        }
        static function isNextTaskAvailable() {
            var _local_2 = partyCookie.getNextAvailableTask();
            var _local_1 = getQuestVOByTaskIndex(_local_2).unlockDay;
            return(((CONSTANTS.PARTY_DAY >= _local_1) ? true : false));
        }
        static function get partyIconVisible() {
            pebug("CHECK PARTY ICON - GET - partyIconVisible() : " + partyCookie.hasPlayerViewedMessage(CONSTANTS.LOGIN_MESSAGE_INDEX));
            if (partyCookie.hasPlayerViewedMessage(CONSTANTS.LOGIN_MESSAGE_INDEX)) {
                return(true);
            }
            return(false);
        }
        static function activateFirstTimeUserPartyFunctionality() {
            partyCookie.sendRequestPartyCookie();
        }
        static function showMemberContentOopsMessage() {
            _interface.showContent(CONSTANTS.OOPS_MESSAGE);
        }
        static function openRoomPopup(index) {
            _interface.showContent((CONSTANTS.MESSAGE_PROMPT_PATH_PREFIX + ".room") + String(index));
            partyCookie.sendMessageViewed(index);
        }
        static function initPartyAvatars() {
            _avatarVOs = [];
            var _local_3 = _engine.avatarManager.model;
            var _local_2 = 0;
            while (_local_2 < _transformationVOs.length) {
                var _local_1 = _local_3.createAvatarFromTemplate(com.clubpenguin.engine.avatar.transformation.AvatarTypeEnum.DEFAULT_ID);
                _local_1.isSpriteTransformed = true;
                _local_1.defaultTransitionEffect = com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.NO_EFFECT;
                _local_1.defaultRevertEffect = com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.NO_EFFECT;
                _local_1.hasCustomPlayerCard = true;
                _local_1.canRevertToDefault = true;
                _local_1.attachItems = false;
                _local_1.hasColorVersions = false;
                _local_1.isMemberOnly = _transformationVOs[_local_2].isMember;
                _local_1.spritePath = _transformationVOs[_local_2].transformToken;
                _local_3.setAvatarTemplate(_transformationVOs[_local_2].transformId, _local_1);
                _local_2++;
            }
        }
        static function sendTransformation(index) {
            var _local_1 = 0;
            while (_local_1 < _transformationVOs.length) {
                if (index == _transformationVOs[_local_1].transformId) {
                    if (_transformationVOs[_local_1].isMember && (!_shell.isMyPlayerMember())) {
                        showMemberContentOopsMessage();
                        return(undefined);
                    } else {
                        _airtower.send(_airtower.PLAY_EXT, "party#" + CONSTANTS.SET_TRANSFORM, [_transformationVOs[_local_1].transformId], "str", _shell.getCurrentServerRoomId());
                    }
                    break;
                }
                _local_1++;
            }
            _interface.closeContent();
        }
        static function transformBackToPenguin() {
            _global.getCurrentEngine().avatarManager.transformationManager.sendTransformPlayer(0);
        }
        static function get localPlayerAvatarID() {
            return(_shell.getPlayerObjectById(_shell.getMyPlayerId()).avatarVO.avatar_id);
        }
        static function openAdoptionFlow() {
            _interface.showContent(CONSTANTS.CHOOSE_ALIEN_PUFFLE_COLOR_PATH);
        }
        static function sendPuffleAdoption(id) {
            if (_global.getCurrentShell().isMyPlayerMember() && (_shell.puffleManager.myPuffles.length >= CONSTANTS.MAX_PUFFLES)) {
                _shell.$e("PUFFLE ADOPTION --> Max Puffles Reached", {error_code:_shell.MAX_PUFFLE_LIMIT});
                return(undefined);
            } else if ((!_global.getCurrentShell().isMyPlayerMember()) && (_shell.puffleManager.myPuffles.length >= CONSTANTS.MAX_PUFFLES_NON_MEMBER)) {
                _shell.$e("PUFFLE ADOPTION --> Max Puffles Reached for Non-Member Penguin", {error_code:_shell.MAX_PUFFLE_LIMIT});
                return(undefined);
            }
            var _local_2 = 0;
            while (_local_2 < _puffleAdoptionVOs.length) {
                if (id == _puffleAdoptionVOs[_local_2].puffleId) {
                    if (_puffleAdoptionVOs[_local_2].isMember && (!_shell.isMyPlayerMember())) {
                        _interface.showContent(CONSTANTS.PUFFLE_ADOPT_OOPS_MESSAGE);
                        return(undefined);
                    } else {
                        _interface.showContent(com.clubpenguin.modules.AS3ModuleConstants.PUFFLE_ADOPTION, null, null, {puffleAdoptionType:_puffleAdoptionVOs[_local_2].puffleId}, true);
                        return(undefined);
                    }
                }
                _local_2++;
            }
        }
        static function sendBI(action, context, msg) {
            pebug((((("NovemberParty** SEND BI ** - context :  " + context) + " / action :  ") + action) + " / msg :  ") + msg);
            var _local_1 = String(_shell.getMyPlayerId());
            com.clubpenguin.util.TrackerAS2.getInstance().trackGameAction(action, context, {player_id:_local_1, message:msg});
        }
        static var _this = com.clubpenguin.world.rooms2015.automated.party.NovemberParty;
        static var _isActive = false;
    }
