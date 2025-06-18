//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.party.BaseParty
    {
        static var _shell, _airtower, _interface, _engine, _party, _purchaseItemThrottler, _updatePlayerFrame, _currentParty, _interfaceOverrides;
        function BaseParty () {
        }
        static function init() {
            pebug("BASE PARTY - INIT");
            _shell = _global.getCurrentShell();
            _airtower = _global.getCurrentAirtower();
            _interface = _global.getCurrentInterface();
            _engine = _global.getCurrentEngine();
            _party = _global.getCurrentParty();
            _purchaseItemThrottler = new com.clubpenguin.util.EventThrottler();
            _purchaseItemThrottler.delayBetweenEvents = 2000;
        }
        static function pebug(msg, prefix) {
            if (undefined == prefix) {
                prefix = CLASS_NAME;
            }
            com.clubpenguin.util.Log.debug((prefix + "::") + msg, com.clubpenguin.util.Log.PARTY);
        }
        static function addListenerForPartySettings(listenerName) {
            pebug("addListenerForPartySettings " + listenerName);
            _airtower.addListener(listenerName, com.clubpenguin.util.Delegate.create(_this, handleUpdatePartySettings));
        }
        static function handleUpdatePartySettings(data) {
            pebug("Handle Party Settings");
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
        static function showPartyIcon() {
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
        static function sendBIIglooVisit(isPartyIgloo, itemId) {
            var _local_2 = "party_igloo_visit";
            var _local_3 = String("iglooID_" + itemId);
            var _local_1 = new Object();
            _local_1.message = (isPartyIgloo ? "party_item_present" : "party_item_missing");
            com.clubpenguin.util.TrackerAS2.getInstance().trackGameAction(_local_3, _local_2, _local_1);
        }
        static var OBJECT_UNDEFINED = "****[ERROR:Object Undefined]**** ";
        static var CLASS_NAME = "BaseParty";
        static var FURNITURE_ITEM_TAG = "furniture";
        static var PAPER_ITEM_TAG = "item";
        static var IGLOO_ITEM_TAG = "igloo";
        static var PUFFLE_ITEM_TAG = "puffle";
        static var CLAIM_BUTTON_INSTANCE_NAME = "claim_btn";
        static var SFX_ITEM_PURCHASE = "sfx_item_purchase";
        static var MAX_PUFFLE_ITEM_QUANTITY = 40;
        static var _this = com.clubpenguin.party.BaseParty;
        static var NUM_PUFFLE_ITEMS = 0;
        static var _puffleItemCounter = 0;
    }
