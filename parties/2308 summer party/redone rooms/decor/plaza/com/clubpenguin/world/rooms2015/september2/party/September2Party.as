//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2015.september2.party.September2Party
    {
        static var _shell, _airtower, _interface, _engine, _partycookieUpdateHandlerDelegate, _questTaskVOs, _engineOverrides;
        function September2Party () {
        }
        static function init() {
            pebug("SEPTEMBER2 PARTY - INIT");
            com.clubpenguin.party.BaseParty.CLASS_NAME = _this.CLASS_NAME;
            com.clubpenguin.party.BaseParty.CURRENT_PARTY = _this;
            com.clubpenguin.party.BaseParty.setConditionalPartyIconVisibility();
            com.clubpenguin.party.BaseParty.addListenerForPartySettings(CONSTANTS.PARTY_SETTINGS_RESPONSE_NAME);
            _isActive = true;
            _shell = _global.getCurrentShell();
            _airtower = _global.getCurrentAirtower();
            _interface = _global.getCurrentInterface();
            _engine = _global.getCurrentEngine();
            engineOverrides.init();
            _partycookieUpdateHandlerDelegate = com.clubpenguin.util.Delegate.create(_this, partycookieUpdateHandler);
            _airtower.addListener("partycookie", _partycookieUpdateHandlerDelegate);
            partyCookie.sendRequestPartyCookie();
        }
        static function partycookieUpdateHandler() {
            pebug("*** September2Party.partycookieUpdateHandler() - partyCookie : " + partyCookie, CLASS_NAME + "()");
            _airtower.removeListener("partycookie", _partycookieUpdateHandlerDelegate);
            com.clubpenguin.party.BaseParty.partyIconState();
            _engine.getRoomMovieClip().room.initializePartyCookieDependentAssets();
            _engine.getRoomMovieClip().roomFunctionality.initializePartyCookieDependentAssets();
        }
        static function configurePartySettings() {
            pebug("September2.configurePartySettings()");
            CONSTANTS.PARTY_DAY = CONSTANTS.PARTY_SERVICE.partySettings.unlockDayIndex;
            var _local_4 = CONSTANTS.PARTY_SERVICE.questSettingList;
            if (_local_4 == undefined) {
                return(undefined);
            }
            _questTaskVOs = new Array();
            var _local_1 = 0;
            while (_local_1 < _local_4.length) {
                var _local_2 = new com.clubpenguin.world.rooms2015.september2.vo.September2QuestTaskVO();
                var _local_3 = _local_4[_local_1];
                _local_2.index = _local_3.Index;
                _local_2.setNonMemberItemId(_local_3.item, com.clubpenguin.party.items.PaperItem.TYPE);
                _questTaskVOs.push(_local_2);
                pebug((("VOs - index [i] : " + _questTaskVOs[_local_1].index) + " / nonMemberItemId [i] : ") + _questTaskVOs[_local_1].nonMemberItemId);
                _local_1++;
            }
            pebug("_questTaskVOs.length " + _questTaskVOs.length);
        }
        static function getVOByID(index) {
            pebug("September2 - getVOByID() - _questTaskVOs.length: " + _questTaskVOs.length);
            var _local_1 = 0;
            while (_local_1 < _questTaskVOs.length) {
                var _local_2 = _questTaskVOs[_local_1];
                if (index == _local_2.index) {
                    return(_questTaskVOs[_local_1]);
                }
                _local_1++;
            }
            return(undefined);
        }
        static function get partyCookie() {
            return(com.clubpenguin.world.rooms2015.september2.vo.September2PartyCookieVO(com.clubpenguin.party.BaseParty.serverCookie));
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
            if ((_shell.getMyPlayerId() != playerObj.player_id) || (_shell.getRoomObject().room_id == 112)) {
                return(undefined);
            }
            pebug("CHECK FOR FIRST TIME LOGIN!!!!!! - SEEN LOGIN PROMPT?? : " + partyCookie.hasPlayerViewedMessage(CONSTANTS.LOGIN_MESSAGE_INDEX));
            if (!partyCookie.hasPlayerViewedMessage(CONSTANTS.LOGIN_MESSAGE_INDEX)) {
                pebug("Show login prompt!!");
                _interface.showContent(CONSTANTS.LOGIN_PROMPT_PATH);
            }
        }
        static function showPartyCatalogue() {
            _global.getCurrentInterface().showContent(CONSTANTS.PARTY_CATALOGUE);
        }
        static function showMemberContentOopsMessage() {
            _global.getCurrentInterface().showContent(CONSTANTS.OOPS_CATALOGUE_MESSAGE);
        }
        static function invokeCoffeeRoomPopup() {
            pebug("invokeCoffeeRoomPopup()");
            if (!partyCookie.hasPlayerViewedMessage(CONSTANTS.COFFEESHOP_MESSAGE_INDEX)) {
                pebug("Show COFFEESHOP prompt!!");
                _interface.showContent(CONSTANTS.COFFEESHOP_PROMPT_PATH);
            }
        }
        static function invokeRobotPopup(path) {
            pebug("invokeBotPopup() - path : " + path);
            _interface.showContent(path);
        }
        static function get engineOverrides() {
            if (_engineOverrides == null) {
                _engineOverrides = new com.clubpenguin.world.rooms2015.september2.party.September2Party_EngineOverrides();
            }
            return(_engineOverrides);
        }
        static function get partyIconVisible() {
            if (partyCookie.msgViewedArray[0] == 1) {
                return(true);
            }
            return(false);
        }
        static function partyIconClickHandler() {
            _interface.showContent(CONSTANTS.QUEST_UI_PATH);
        }
        static function activateEngineOverrides() {
            _engine.updatePlayerFrame = com.clubpenguin.util.Delegate.create(_engine, engineOverrides.updatePlayerFrame);
        }
        static function deactivateEngineOverrides() {
            pebug("September2Party - Deactivate engine overrides");
            _engine.updatePlayerFrame = engineOverrides.defaultUpdatePlayerFrame;
        }
        static function isInValidSurfingState(mc, f) {
            var _local_1 = _shell.getRoomObject();
            if ((((_local_1.room_id == CONSTANTS.PARTY6) && (f >= CONSTANTS.PENGUIN_FIRST_WADDLE_FRAME)) && (f <= CONSTANTS.PENGUIN_LAST_WADDLE_FRAME)) && (!mc.art_mc.hitTest(_engine.getRoomMovieClip().triggers_mc.boatTrigger_mc))) {
                return(true);
            }
            return(false);
        }
        static function showPuffleAdoption(puffleID) {
            if (_shell.puffleManager.myPuffles.length >= CONSTANTS.MAX_PUFFLES) {
                _shell.$e("September2Party -> Max Puffles Reached", {error_code:_shell.MAX_PUFFLE_LIMIT});
                return(undefined);
            }
            if (_shell.isMyPlayerMember()) {
                _interface.showContent(com.clubpenguin.modules.AS3ModuleConstants.PUFFLE_ADOPTION, null, null, {puffleAdoptionType:puffleID}, true);
                sendOpenDinoPuffleAdoptionBI();
            } else {
                _interface.showContent(CONSTANTS.GENERIC_OOPS_MESSAGE);
            }
        }
        static function isInValidHighwayState(mc, f) {
            var _local_1 = _shell.getRoomObject();
            if ((_local_1.room_id == CONSTANTS.PARTY5) && (f <= CONSTANTS.PENGUIN_LAST_WADDLE_FRAME)) {
                return(true);
            }
            return(false);
        }
        static function hasVehicleItemEquipped(player_id) {
            return(isItemVehicle(player_id));
        }
        static function isItemVehicle(player_id) {
            var _local_3 = _shell.getPlayerObjectById(player_id);
            var _local_2 = _local_3.body;
            var _local_1 = 0;
            while (_local_1 < CONSTANTS.VEHICLE_BODY_ITEM_IDS.length) {
                if (_local_2 == CONSTANTS.VEHICLE_BODY_ITEM_IDS[_local_1]) {
                    return(true);
                }
                _local_1++;
            }
            _local_2 = _local_3.hand;
            _local_1 = 0;
            while (_local_1 < CONSTANTS.VEHICLE_HAND_ITEM_IDS.length) {
                if (_local_2 == CONSTANTS.VEHICLE_HAND_ITEM_IDS[_local_1]) {
                    return(true);
                }
                _local_1++;
            }
            _local_2 = _local_3.feet;
            _local_1 = 0;
            while (_local_1 < CONSTANTS.VEHICLE_FEET_ITEM_IDS.length) {
                if (_local_2 == CONSTANTS.VEHICLE_FEET_ITEM_IDS[_local_1]) {
                    return(true);
                }
                _local_1++;
            }
            return(false);
        }
        static function vehicleIsSkateboard(player_id) {
            var _local_2 = _shell.getPlayerObjectById(player_id);
            var _local_1 = _local_2.hand;
            if ((_local_1 >= 5471) && (_local_1 <= 5479)) {
                return(true);
            }
            return(false);
        }
        static function sendNpcClickBI(characterName, room) {
            com.clubpenguin.util.TrackerAS2.getInstance().trackGameAction(characterName, "npc", {message:"room event was in " + room});
        }
        static function sendSoundBoxClickBI(soundBoxName, room) {
            com.clubpenguin.util.TrackerAS2.getInstance().trackGameAction(soundBoxName, "sound_box", {message:"room event was in " + room});
        }
        static function sendOpenDinoPuffleAdoptionBI() {
            com.clubpenguin.util.TrackerAS2.getInstance().trackGameAction("open", "dino_adoption");
        }
        static function sendAdoptDinoPuffleBI(dinoType) {
            com.clubpenguin.util.TrackerAS2.getInstance().trackGameAction(dinoType, "dino_adoption");
        }
        static var CONSTANTS = com.clubpenguin.world.rooms2015.september2.party.September2PartyConstants;
        static var CLASS_NAME = "September2Party";
        static var PARTY_COOKIE_ID = "20150902";
        static var _this = com.clubpenguin.world.rooms2015.september2.party.September2Party;
        static var _isActive = false;
        static var _uiSelectionNum = 0;
        static var _currentQuestTaskId = 0;
        static var _currentOrbNum = 0;
        static var currentTransformName = "";
        static var testString = "TEST STRING SEPTEMBER2!!!";
    }
