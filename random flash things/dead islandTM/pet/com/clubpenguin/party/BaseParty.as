//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.party.BaseParty
    {
        static var _shell, _airtower, _interface, _engine, _party, CONSTANTS, _serverCookieService, _serverCookie, _updatePlayerFrame, _currentParty, _interfaceOverrides;
        function BaseParty () {
        }
        static function init(_arg_2) {
            pebug("BASE PARTY - INIT");
            _shell = _global.getCurrentShell();
            _airtower = _global.getCurrentAirtower();
            _interface = _global.getCurrentInterface();
            _engine = _global.getCurrentEngine();
            _party = _global.getCurrentParty();
            initServerCookie(_arg_2);
            addListenerForPartySettings(CONSTANTS.PARTY_SETTINGS_RESPONSE_NAME);
        }
        static function initServerCookie(_arg_1) {
            _serverCookieService = _shell.getServerCookieService();
            _serverCookie = _arg_1;
            _serverCookieService.registerCookieVO(_serverCookie.getID(), _serverCookie);
        }
        static function get serverCookie() {
            return(_serverCookie);
        }
        static function pebug(_arg_2, _arg_1) {
            if (undefined == _arg_1) {
                _arg_1 = CLASS_NAME;
            }
            com.clubpenguin.util.Log.debug((_arg_1 + "::") + _arg_2, com.clubpenguin.util.Log.PARTY);
        }
        static function addListenerForPartySettings(_arg_1) {
            pebug("addListenerForPartySettings " + _arg_1);
            _airtower.addListener(_arg_1, com.clubpenguin.util.Delegate.create(_this, handleUpdatePartySettings));
        }
        static function handleUpdatePartySettings(_arg_2) {
            pebug("Handle Party Settings");
            var _local_1 = com.clubpenguin.util.JSONParser.parse(_arg_2[1]);
            CURRENT_PARTY.CONSTANTS.PARTY_SERVICE = _local_1;
            CURRENT_PARTY.configurePartySettings();
            CURRENT_PARTY.CONSTANTS.PARTY_DAY = CURRENT_PARTY.CONSTANTS.PARTY_SERVICE.partySettings.unlockDayIndex;
        }
        static function playSound(_arg_3, _arg_4, _arg_2) {
            if (_arg_2 == undefined) {
                _arg_2 = 100;
            }
            var _local_1 = new Sound(_arg_3);
            _local_1.attachSound(_arg_4);
            _local_1.setVolume(_arg_2);
            _local_1.start();
        }
        static function soundButton(_arg_2, _arg_4, _arg_3, _arg_1) {
            _this.playSound(_arg_2, _arg_4);
            setTimeout(_arg_3, _arg_1);
        }
        static function setConditionalPartyIconVisibility() {
            if (CURRENT_PARTY.partyIconVisible != undefined) {
                activatePartyIconOverrides();
            } else {
                pebug("setConditionalPartyIconVisibility(): The current party does not have a getter called partyIconVisible(), please define.", OBJECT_UNDEFINED);
            }
        }
        static function checkForFirstTimeLogin(_arg_1) {
            pebug("Check for first time login");
            CURRENT_PARTY.checkForFirstTimeLogin(_arg_1);
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
        static function dispatchUpdatePlayerFrame(_arg_1) {
            pebug("dispatchUpdatePlayerFrame");
            _updatePlayerFrame.dispatch(_arg_1);
        }
        static function set CURRENT_PARTY(_arg_1) {
            _currentParty = _arg_1;
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
        static function showPartyIcon(_arg_1) {
            if ((_arg_1 != undefined) && (_arg_1 == true)) {
                _firstTimeLogin = true;
            }
            _interface.PARTY_ICON._visible = true;
        }
        static function hidePartyIcon() {
            _interface.PARTY_ICON._visible = false;
        }
        static function partyIconState() {
            if (CURRENT_PARTY.partyIconVisible) {
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
        static function sendBIIglooVisit(_arg_4, _arg_5) {
            var _local_2 = "party_igloo_visit";
            var _local_3 = String("iglooID_" + _arg_5);
            var _local_1 = new Object();
            _local_1.message = (_arg_4 ? "party_item_present" : "party_item_missing");
            com.clubpenguin.util.TrackerAS2.getInstance().trackGameAction(_local_3, _local_2, _local_1);
        }
        static var OBJECT_UNDEFINED = "****[ERROR:Object Undefined]**** ";
        static var CLASS_NAME = "BaseParty";
        static var _this = com.clubpenguin.party.BaseParty;
        static var _firstTimeLogin = false;
    }
