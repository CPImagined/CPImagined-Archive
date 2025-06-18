//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.party.BaseParty
    {
        static var _shell, _airtower, _interface, _engine, _party, CONSTANTS, _serverCookieService, _serverCookie, _updatePlayerFrame, _currentParty, _interfaceOverrides;
        function BaseParty () {
        }
        static function init(cookieVO) {
            pebug("BASE PARTY - INIT");
            _shell = _global.getCurrentShell();
            _airtower = _global.getCurrentAirtower();
            _interface = _global.getCurrentInterface();
            _engine = _global.getCurrentEngine();
            _party = _global.getCurrentParty();
            initServerCookie(cookieVO);
            addListenerForPartySettings(CONSTANTS.PARTY_SETTINGS_RESPONSE_NAME);
        }
        static function initServerCookie(cookieVO) {
            _serverCookieService = _shell.getServerCookieService();
            _serverCookie = cookieVO;
            _serverCookieService.registerCookieVO(_serverCookie.getID(), _serverCookie);
        }
        static function get serverCookie() {
            return(_serverCookie);
        }
        static function pebug(msg, prefix) {
            if (undefined == prefix) {
                prefix = CLASS_NAME;
            }
            com.clubpenguin.util.Log.debug((prefix + "::") + msg, com.clubpenguin.util.Log.PARTY);
        }
        static function addListenerForPartySettings(listenerName) {
            _airtower.addListener(listenerName, com.clubpenguin.util.Delegate.create(_this, handleUpdatePartySettings));
        }
        static function handleUpdatePartySettings(data) {
            pebug("BaseParty.handleUpdatePartySettings");
            var _local_1 = com.clubpenguin.util.JSONParser.parse(data[1]);
            CURRENT_PARTY.CONSTANTS.PARTY_SERVICE = _local_1;
            CURRENT_PARTY.configurePartySettings();
            CURRENT_PARTY.CONSTANTS.PARTY_DAY = CURRENT_PARTY.CONSTANTS.PARTY_SERVICE.partySettings.unlockDayIndex;
        }
        static function playSound(ui, soundId, volume) {
            if (volume == undefined) {
                volume = 100;
            }
            var _local_1 = new Sound(ui);
            _local_1.attachSound(soundId);
            _local_1.setVolume(volume);
            _local_1.start();
        }
        static function soundButton(ui, soundId, callback, timeout) {
            _this.playSound(ui, soundId);
            setTimeout(callback, timeout);
        }
        static function setConditionalPartyIconVisibility() {
            if (CURRENT_PARTY.partyIconVisible != undefined) {
                activatePartyIconOverrides();
            } else {
                pebug("setConditionalPartyIconVisibility(): The current party does not have a getter called partyIconVisible(), please define.", OBJECT_UNDEFINED);
            }
        }
        static function checkForFirstTimeLogin(playerObj) {
            pebug("Check for first time login");
            CURRENT_PARTY.checkForFirstTimeLogin(playerObj);
        }
        static function showPartyMap() {
            _interface.showContent(CURRENT_PARTY.CONSTANTS.PARTY_MAP_PATH);
        }
        static function openQuestUI() {
            _interface.showContent(CURRENT_PARTY.CONSTANTS.QUEST_UI_PATH);
        }
        static function showIglooList() {
            com.clubpenguin.util.TrackerAS2.getInstance().trackGameAction(CURRENT_PARTY.CONSTANTS.BI_IGLOOLIST_ACTION, "view");
            _interface.showContent(CURRENT_PARTY.CONSTANTS.IGLOO_LIST_PATH);
        }
        static function showIglooPrompt() {
            _interface.showContent(CURRENT_PARTY.CONSTANTS.IGLOO_PROMPT_PATH);
        }
        static function get updatePlayerFrame() {
            if (_updatePlayerFrame == undefined) {
                _updatePlayerFrame = new org.osflash.signals.Signal(Number);
            }
            return(_updatePlayerFrame);
        }
        static function dispatchUpdatePlayerFrame(player_id) {
            pebug("dispatchUpdatePlayerFrame");
            _updatePlayerFrame.dispatch(player_id);
        }
        static function set CURRENT_PARTY(party) {
            _currentParty = party;
            //return(CURRENT_PARTY);
        }
        static function get CURRENT_PARTY() {
            if (_currentParty != undefined) {
                return(_currentParty);
            }
            pebug("CURRENT_PARTY is undefined - make sure your main party class sets this value in its init function. Returning BaseParty.", OBJECT_UNDEFINED);
            return(_this);
        }
        static function get partySettings() {
            return(CURRENT_PARTY.CONSTANTS.PARTY_SERVICE);
        }
        static function get interfaceOverrides() {
            if (_interfaceOverrides == null) {
                _interfaceOverrides = new com.clubpenguin.party.Party_InterfaceOverrides();
            }
            return(_interfaceOverrides);
        }
        static function get isPartyRoom() {
            var _local_1 = _shell.getRoomObject().room_id;
            if (((_local_1 != undefined) && (_local_1 >= CURRENT_PARTY.CONSTANTS.FIRST_PARTY_ROOM_ID)) && (_local_1 <= CURRENT_PARTY.CONSTANTS.LAST_PARTY_ROOM_ID)) {
                return(true);
            }
            return(false);
        }
        static function get itemForSaleOnIglooList() {
            return(CURRENT_PARTY.itemOnIglooList);
        }
        static function get partyIglooListItems() {
            return(CURRENT_PARTY.CONSTANTS.IGLOO_LIST_ITEMS);
        }
        static function showPartyIcon(firstTimeLogin) {
            if ((firstTimeLogin != undefined) && (firstTimeLogin == true)) {
                _firstTimeLogin = true;
            }
            _interface.PARTY_ICON._visible = true;
            if (_firstTimeLogin == true) {
                CURRENT_PARTY.activateFirstTimeUserPartyFunctionality();
            }
        }
        static function hidePartyIcon() {
            _interface.PARTY_ICON._visible = false;
        }
        static function partyIconState() {
            if (CURRENT_PARTY.partyIconVisible || (_firstTimeLogin)) {
                showPartyIcon();
            } else {
                hidePartyIcon();
            }
        }
        static function activatePartyIconOverrides() {
            pebug("Activate interface overrides");
            _interface.showPartyIcon = com.clubpenguin.util.Delegate.create(_interface, _party.BaseParty.interfaceOverrides.showPartyIcon);
            _interface.onPartyIconLoad = com.clubpenguin.util.Delegate.create(_interface, _party.BaseParty.interfaceOverrides.onPartyIconLoad);
        }
        static function sendBIIglooVisit(isPartyIgloo, itemId) {
            var _local_2 = "party_igloo_visit";
            var _local_3 = String("iglooID_" + itemId);
            var _local_1 = new Object();
            _local_1.message = (isPartyIgloo ? "party_item_present" : "party_item_missing");
            com.clubpenguin.util.TrackerAS2.getInstance().trackGameAction(_local_3, _local_2, _local_1);
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
        static function sendTaskCompleteBI(taskID, messageString) {
            var _local_1 = {message:messageString};
            com.clubpenguin.util.TrackerAS2.getInstance().trackGameAction(taskID.toString(), "quest_task", _local_1);
        }
        static var OBJECT_UNDEFINED = "****[ERROR:Object Undefined]**** ";
        static var CLASS_NAME = "BaseParty";
        static var _this = com.clubpenguin.party.BaseParty;
        static var _firstTimeLogin = false;
    }
