//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.party.BaseParty
    {
        static var _shell, _airtower, _interface, _engine, _party, _purchaseItemThrottler, _currentParty, _interfaceOverrides;
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
        static function playSound(ui, soundId) {
            var _local_1 = new Sound(ui);
            _local_1.attachSound(soundId);
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
            pebug("Checking for first time login");
            CURRENT_PARTY.checkForFirstTimeLogin(playerObj);
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
        static function get interfaceOverrides() {
            if (_interfaceOverrides == null) {
                _interfaceOverrides = new com.clubpenguin.party.Party_InterfaceOverrides();
            }
            return(_interfaceOverrides);
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
        static function showIglooList() {
            com.clubpenguin.util.TrackerAS2.getInstance().trackGameAction(CURRENT_PARTY.CONSTANTS.BI_IGLOOLIST_ACTION, "view");
            _interface.showContent(CURRENT_PARTY.CONSTANTS.IGLOO_LIST_PATH);
        }
        static function showIglooPrompt() {
            _interface.showContent(CURRENT_PARTY.CONSTANTS.IGLOO_PROMPT_PATH);
        }
        static function activatePartyIconOverrides() {
            pebug("Activate interface overrides");
            _interface.showPartyIcon = com.clubpenguin.util.Delegate.create(_interface, _party.BaseParty.interfaceOverrides.showPartyIcon);
            _interface.onPartyIconLoad = com.clubpenguin.util.Delegate.create(_interface, _party.BaseParty.interfaceOverrides.onPartyIconLoad);
        }
        static var OBJECT_UNDEFINED = "****[ERROR:Object Undefined]**** ";
        static var CLASS_NAME = "BaseParty";
        static var _this = com.clubpenguin.party.BaseParty;
    }
