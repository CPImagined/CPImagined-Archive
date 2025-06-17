//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2014.muppets.MuppetsParty
    {
        static var _shell, _airtower, _interface, _engine, _party, _serverCookieService, _serverCookie, _purchaseItemThrottler, _quests, _engineOverrides, muppetDialogueIndex;
        function MuppetsParty () {
        }
        static function init() {
            pebug("MUPPETS PARTY - INIT");
            com.clubpenguin.party.BaseParty.CLASS_NAME = _this.CLASS_NAME;
            com.clubpenguin.party.BaseParty.CURRENT_PARTY = _this;
            _isActive = true;
            _shell = _global.getCurrentShell();
            _airtower = _global.getCurrentAirtower();
            _interface = _global.getCurrentInterface();
            _engine = _global.getCurrentEngine();
            _party = _global.getCurrentParty();
            _serverCookieService = _shell.getServerCookieService();
            _serverCookie = new com.clubpenguin.world.rooms2014.muppets.vo.MuppetsPartyCookieVO(PARTY_COOKIE_ID);
            _serverCookieService.registerCookieVO(_serverCookie.getID(), _serverCookie);
            _purchaseItemThrottler = new com.clubpenguin.util.EventThrottler();
            _purchaseItemThrottler.delayBetweenEvents = 2000;
            com.clubpenguin.party.BaseParty.setConditionalPartyIconVisibility();
            engineOverrides.init();
            activateEngineOverrides();
            _airtower.addListener(CONSTANTS.PARTY_SETTINGS_RESPONSE_NAME, com.clubpenguin.util.Delegate.create(_this, handleUpdatePartySettings));
            _shell.addListener(_shell.ROOM_INITIATED, com.clubpenguin.util.Delegate.create(_this, onRoomInitialized));
            _shell.addListener(_shell.SEND_EMOTE, com.clubpenguin.util.Delegate.create(_this, onPlayerEmote));
            com.clubpenguin.world.rooms2014.muppets.MuppetsSounds.init();
            initKermitAvatar();
        }
        static function onRoomInitialized() {
        }
        static function onPlayerEmote(event) {
            if (_shell.isMyPlayer(event.player_id)) {
                if (event.emote_id == 32) {
                    var _local_3 = random(2) + 1;
                    var _local_1 = new Sound(_interface);
                    _local_1.attachSound("sfx_emote_clapping_" + _local_3);
                    _local_1.start();
                } else if (event.emote_id == 33) {
                    var _local_3 = random(2) + 1;
                    var _local_1 = new Sound(_interface);
                    _local_1.attachSound("sfx_emote_pie_" + _local_3);
                    _local_1.start();
                }
            }
        }
        static function get partyCookie() {
            return(_serverCookie);
        }
        static function handleUpdatePartySettings(data) {
            var _local_5 = com.clubpenguin.util.JSONParser.parse(data[1]);
            _airtower.removeListener(CONSTANTS.PARTY_SETTINGS_RESPONSE_NAME, handleUpdatePartySettings);
            CONSTANTS.PARTY_DAY = _local_5.partySettings.unlockDayIndex;
            _quests = new Array();
            var _local_4 = _local_5.muppetList;
            var _local_3 = 0;
            while (_local_3 < _local_4.length) {
                var _local_1 = new com.clubpenguin.world.rooms2014.muppets.vo.MuppetQuestInfoVO();
                var _local_2 = _local_4[_local_3];
                _local_1.id = _local_2.id;
                _local_1.name = _local_2.name;
                _local_1.roomId = _local_2.roomId;
                _local_1.interactiveItemId = _local_2.interactiveItemId;
                _local_1.hatId = _local_2.hatId;
                _quests.push(_local_1);
                _local_3++;
            }
        }
        static function get isActive() {
            return(_isActive);
        }
        static function pebug(msg, prefix) {
            com.clubpenguin.party.BaseParty.pebug(msg, prefix);
        }
        static function playSound(ui, soundId) {
            com.clubpenguin.party.BaseParty.playSound(ui, soundId);
        }
        static function checkForFirstTimeLogin(playerObj) {
            if ((_shell.getMyPlayerId() != playerObj.player_id) || (_shell.getRoomObject().room_id == 112)) {
                return(undefined);
            }
            if (partyCookie.login == 0) {
                _interface.showContent(CONSTANTS.LOGIN_PROMPT_PATH);
            }
        }
        static function showMemberContentOopsMessage() {
        }
        static function showConstantineWantedPoster() {
            _interface.showContent(CONSTANTS.CONSTANTINE_WANTED_POSTER_PATH);
        }
        static function get engineOverrides() {
            if (_engineOverrides == null) {
                _engineOverrides = new com.clubpenguin.world.rooms2014.muppets.MuppetsParty_EngineOverrides();
            }
            return(_engineOverrides);
        }
        static function get partyIconVisible() {
            if (partyCookie.login == 1) {
                return(true);
            }
            return(false);
        }
        static function getMuppetByName(muppetName) {
            var _local_1 = 0;
            while (_local_1 < _quests.length) {
                if (_quests[_local_1].name == muppetName) {
                    return(_quests[_local_1]);
                }
                _local_1++;
            }
            return(null);
        }
        static function getInteractiveItemByMuppet(muppetName) {
            var _local_1 = 0;
            while (_local_1 < _quests.length) {
                if (_quests[_local_1].name == muppetName) {
                    return(_quests[_local_1].interactiveItemId);
                }
                _local_1++;
            }
            return(-1);
        }
        static function getRewardByUnlockDay(day) {
            var _local_1 = 0;
            while (_local_1 < _quests.length) {
                if (_quests[_local_1].id == day) {
                    return(_quests[_local_1].hatId);
                }
                _local_1++;
            }
            return(undefined);
        }
        static function getRewardByInteractiveItem(itemID) {
            var _local_1 = 0;
            while (_local_1 < _quests.length) {
                if (_quests[_local_1].interactiveItemId == itemID) {
                    return(_quests[_local_1].hatId);
                }
                _local_1++;
            }
            return(undefined);
        }
        static function getMuppetByInteractiveItem(itemID) {
            var _local_1 = 0;
            while (_local_1 < _quests.length) {
                if (_quests[_local_1].interactiveItemId == itemID) {
                    return(_quests[_local_1].name);
                }
                _local_1++;
            }
            return(undefined);
        }
        static function getInteractiveItemByUnlockDay(day) {
            var _local_1 = 0;
            while (_local_1 < _quests.length) {
                if (_quests[_local_1].id == day) {
                    return(_quests[_local_1].interactiveItemId);
                }
                _local_1++;
            }
            return(-1);
        }
        static function getUnlockDayByInteractiveItem(itemID) {
            var _local_1 = 0;
            while (_local_1 < _quests.length) {
                if (_quests[_local_1].interactiveItemId == itemID) {
                    return(_quests[_local_1].id);
                }
                _local_1++;
            }
            return(-1);
        }
        static function get itemOnIglooList() {
            return(new com.clubpenguin.party.items.IglooPartyItem(CONSTANTS.IGLOO_LIST_ITEM_ID));
        }
        static function openQuestUI() {
            _interface.showContent(com.clubpenguin.world.rooms2014.muppets.MuppetsPartyConstants.QUEST_UI_PATH);
        }
        static function showMuppetsIglooList() {
            com.clubpenguin.util.TrackerAS2.getInstance().trackGameAction("muppets_igloo_list", "view");
            _interface.showContent(CONSTANTS.IGLOO_LIST_PATH);
        }
        static function showIglooPrompt() {
            _interface.showContent(CONSTANTS.IGLOO_PROMPT_PATH);
        }
        static function checkAllQuestsCompleted() {
            if (CONSTANTS.PARTY_DAY < (CONSTANTS.NUM_MUPPET_QUESTS - 1)) {
                return(false);
            }
            var _local_1 = 0;
            while (_local_1 < CONSTANTS.NUM_MUPPET_QUESTS) {
                if ((!partyCookie.isMuppetMessageViewed(_local_1, 0)) || (!partyCookie.isMuppetMessageViewed(_local_1, 1))) {
                    return(false);
                }
                _local_1++;
            }
            return(true);
        }
        static function getQuestInfo(questIndex) {
            return(_quests[questIndex]);
        }
        static function configureMuppet(muppetMC, muppetTriggerMC, muppetName) {
            var _local_1 = getMuppetByName(muppetName);
            pebug(((("configureMuppet(" + muppetMC) + ",") + muppetName) + ")");
            if (_local_1 != null) {
                if ((CONSTANTS.PARTY_DAY < _local_1.id) || (!isMuppetViewable(_local_1))) {
                    muppetMC.gotoAndStop("empty");
                } else {
                    muppetTriggerMC.triggerFunction = com.clubpenguin.util.Delegate.create(com.clubpenguin.world.rooms2014.muppets.MuppetsParty, handleMuppetClicked, muppetMC, _local_1);
                }
            }
        }
        static function isMuppetViewable(muppetQuestInfo) {
            if (_shell.isMyPlayerMember() && (!_shell.isItemInMyInventory(muppetQuestInfo.interactiveItemId))) {
                return(true);
            } else if ((!_shell.isMyPlayerMember()) && (!partyCookie.isMuppetMessageViewed(muppetQuestInfo.id, 0))) {
                return(true);
            }
            return(false);
        }
        static function handleMuppetClicked(muppetMC, muppetQuestInfo) {
            logMuppetClick(muppetQuestInfo.name);
            muppetMC.gotoAndStop("inactive");
            muppetDialogueIndex = muppetQuestInfo.id;
            _interface.showContent(CONSTANTS.MUPPETS_INSTRUCTIONS_DIALOGUE_PATH);
        }
        static function activateEngineOverrides() {
            pebug("Activate engine overrides");
            _engine.sendPlayerFrame = com.clubpenguin.util.Delegate.create(_engine, engineOverrides.sendPlayerFrame);
        }
        static function setLoginPromptViewed() {
            _airtower.send(_airtower.PLAY_EXT, (CONSTANTS.MUPPETS_COOKIE_HANDLER_NAME + "#") + CONSTANTS.LOGIN_VIEWED_COMMAND, [0], "str", _global.getCurrentShell().getCurrentServerRoomId());
        }
        static function determineInteractiveItemIcon(player_id) {
            pebug("player_id " + player_id);
            pebug("_shell " + _shell);
            var _local_2 = _shell.getPlayerObjectById(player_id);
            var _local_1 = _local_2.hand;
            pebug("Hand item is " + _local_1);
            if (_local_1 == getInteractiveItemByMuppet(CONSTANTS.FOZZIE)) {
                return(com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.MUPPETS_PIE_JOIN_ICON);
            }
            if (_local_1 == getInteractiveItemByMuppet(CONSTANTS.MISS_PIGGY)) {
                return(com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.MUPPETS_MIC_JOIN_ICON);
            }
            if (_local_1 == getInteractiveItemByMuppet(CONSTANTS.GONZO)) {
                return(com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.MUPPETS_CAPE_JOIN_ICON);
            }
            if (_local_1 == getInteractiveItemByMuppet(CONSTANTS.SWEDISH_CHEF)) {
                return(com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.MUPPETS_TONGS_JOIN_ICON);
            }
            if (_local_1 == getInteractiveItemByMuppet(CONSTANTS.WALTER)) {
                return(com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.MUPPETS_CANE_JOIN_ICON);
            }
            if (_local_1 == getInteractiveItemByMuppet(CONSTANTS.BUNSEN_BEAKER)) {
                return(com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.MUPPETS_BEAKERS_JOIN_ICON);
            }
            if (_local_1 == getInteractiveItemByMuppet(CONSTANTS.ANIMAL)) {
                return(com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.MUPPETS_DRUM_JOIN_ICON);
            }
            if (_local_1 == getInteractiveItemByMuppet(CONSTANTS.PEPE)) {
                return(com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.MUPPETS_MARACAS_JOIN_ICON);
            }
            return(undefined);
        }
        static function isWearingInteractiveItem(player_id) {
            if (player_id == null) {
                return(false);
            }
            var _local_3 = _shell.getPlayerObjectById(player_id);
            var _local_2 = _local_3.hand;
            var _local_1 = 0;
            while (_local_1 < _quests.length) {
                pebug("_quests[i].interactiveItemId " + _quests[_local_1].interactiveItemId);
                if (Number(_quests[_local_1].interactiveItemId) == _local_2) {
                    pebug("It's a match");
                    return(true);
                }
                _local_1++;
            }
            return(false);
        }
        static function checkForFirstTimePerformance(hostID) {
            var _local_3 = _shell.getPlayerObjectById(hostID);
            var _local_2 = _local_3.hand;
            var _local_1 = getUnlockDayByInteractiveItem(_local_2);
            pebug("index " + _local_1);
            pebug("partyCookie.isMuppetMessageViewed(index, 1) " + partyCookie.isMuppetMessageViewed(_local_1, 1));
            if (!partyCookie.isMuppetMessageViewed(_local_1, 1)) {
                muppetDialogueIndex = _local_1;
                pebug("Player's first time performance with this item " + _shell.getMyPlayerId());
                _interface.showContent(CONSTANTS.MUPPETS_REWARDS_DIALOGUE_PATH);
            }
        }
        static function logPerformanceMessage(msg) {
            _performanceLog.push(msg + newline);
            if (_performanceLog.length > 300) {
                _performanceLog.shift();
            }
        }
        static function logMuppetClick(muppetName) {
            com.clubpenguin.util.TrackerAS2.getInstance().trackGameAction(muppetName, "muppet_click");
        }
        static function logMuppetDanceEvent(hostId) {
            var _local_2 = _shell.getPlayerObjectById(hostId).hand;
            var _local_1 = getInteractiveItemNameByItemID(_local_2);
            if (_local_1 != null) {
                com.clubpenguin.util.TrackerAS2.getInstance().trackGameAction(_local_1, "muppet_dance_invite");
            }
        }
        static function logMuppetDanceJoinEvent(hostId) {
            var _local_2 = _shell.getPlayerObjectById(hostId).hand;
            var _local_1 = getInteractiveItemNameByItemID(_local_2);
            if (_local_1 != null) {
                com.clubpenguin.util.TrackerAS2.getInstance().trackGameAction(_local_1, "muppet_dance_join");
            }
        }
        static function getInteractiveItemNameByItemID(itemID) {
            if (itemID == 5429) {
                return("cream_pie");
            }
            if (itemID == 5428) {
                return("pink_microphone");
            }
            if (itemID == 5427) {
                return("bull_cape");
            }
            if (itemID == 5432) {
                return("salad_tongs");
            }
            if (itemID == 5434) {
                return("gold_cane");
            }
            if (itemID == 5431) {
                return("beakers");
            }
            if (itemID == 5430) {
                return("drum_sticks");
            }
            if (itemID == 5433) {
                return("maracas");
            }
            return(null);
        }
        static function initKermitAvatar() {
            var _local_2 = _engine.avatarManager.model;
            var _local_1 = _local_2.createAvatarFromTemplate(com.clubpenguin.engine.avatar.transformation.AvatarTypeEnum.DEFAULT_ID);
            _local_1.spritePath = "w.avatarsprite.mascot.kermit";
            _local_2.setAvatarTemplate(CONSTANTS.KERMIT_AVATAR_ID, _local_1);
        }
        static var CONSTANTS = com.clubpenguin.world.rooms2014.muppets.MuppetsPartyConstants;
        static var CLASS_NAME = "MuppetsParty";
        static var PARTY_COOKIE_ID = "20140301";
        static var _this = com.clubpenguin.world.rooms2014.muppets.MuppetsParty;
        static var _isActive = false;
        static var _performanceLog = new Array();
    }
