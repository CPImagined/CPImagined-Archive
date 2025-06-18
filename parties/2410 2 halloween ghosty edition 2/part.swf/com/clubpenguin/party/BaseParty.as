
//Created by Action Script Viewer - http://www.buraks.com/asv
    class com.clubpenguin.party.BaseParty
    {
        static var _shell, _airtower, _interface, _engine, _party, _purchaseItemThrottler, _currentParty, _interfaceOverrides, _bundleBoughtDelegate, _buyItemDelegate, _buyFurnitureDelegate, _buyIglooDelegate;
        function BaseParty () {
        }
        static function init() {
            pebug("SS: BASE PARTY - INIT");
            _shell = _global.getCurrentShell();
            _airtower = _global.getCurrentAirtower();
            _interface = _global.getCurrentInterface();
            _engine = _global.getCurrentEngine();
            _party = _global.getCurrentParty();
            _purchaseItemThrottler = new com.clubpenguin.util.EventThrottler();
            _purchaseItemThrottler.__set__delayBetweenEvents(2000);
        }
        static function pebug(_arg_2, _arg_1) {
            if (undefined == _arg_1) {
                _arg_1 = CLASS_NAME;
            }
            com.clubpenguin.util.Log.debug((_arg_1 + "::") + _arg_2, com.clubpenguin.util.Log.PARTY);
        }
        static function playSound(_arg_2, _arg_3) {
            var _local_1 = new Sound(_arg_2);
            _local_1.attachSound(_arg_3);
            _local_1.start();
        }
        static function setConditionalPartyIconVisibility() {
            if (CURRENT_PARTY.partyIconVisible != undefined) {
                activatePartyIconOverrides();
            } else {
                pebug("setConditionalPartyIconVisibility(): The current party does not have a getter called partyIconVisible(), please define.", OBJECT_UNDEFINED);
            }
        }
        static function checkForFirstTimeLogin(_arg_1) {
            pebug("Checking for first time login");
            CURRENT_PARTY.checkForFirstTimeLogin(_arg_1);
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
        static function get interfaceOverrides() {
            if (_interfaceOverrides == null) {
                _interfaceOverrides = new com.clubpenguin.party.Party_InterfaceOverrides();
            }
            return(_interfaceOverrides);
        }
        static function get partyIglooListItems() {
            return(CURRENT_PARTY.iglooFurnitureItems);
        }
        static function configurePurchaseableItem(_arg_1, _arg_2, _arg_3, _arg_5, _arg_6, _arg_4) {
            pebug("configurePurchaseableItem itemID " + _arg_2);
            pebug("configurePurchaseableItem itemType " + _arg_3);
            if ((_arg_3 == "item") && (_shell.isItemInMyInventory(_arg_2))) {
                _arg_1.nextFrame();
                return(undefined);
            }
            if ((_arg_3 == "furniture") && (_shell.isFurnitureInMyInventory(_arg_2))) {
                _arg_1.nextFrame();
                return(undefined);
            }
            if ((_arg_3 == "igloo") && (_shell.isIglooBuildingInMyInventory(_arg_2))) {
                _arg_1.nextFrame();
                return(undefined);
            }
            _arg_1[CLAIM_BUTTON_INSTANCE_NAME].onRelease = com.clubpenguin.util.Delegate.create(_this, checkPurchaseOfItem, _arg_1, _arg_2, _arg_3, _arg_5, _arg_6, _arg_4);
        }
        static function configureFurnitureBundle(_arg_1, _arg_2) {
            if (_shell.isFurnitureInMyInventory(_arg_2[0][0].id)) {
                _arg_1.nextFrame();
                return(undefined);
            }
            _arg_1[CLAIM_BUTTON_INSTANCE_NAME].onRelease = com.clubpenguin.util.Delegate.create(_this, buyFurnitureBundle, _arg_1, _arg_2);
        }
        static function buyFurnitureBundle(_arg_2, _arg_1) {
            _bundleBoughtDelegate = com.clubpenguin.util.Delegate.create(_this, onBundleBought, _arg_2);
            _airtower.addListener(_airtower.BUY_MULTIPLE_FURNITURE, _bundleBoughtDelegate, _this);
            _airtower.send(_airtower.PLAY_EXT, "g#" + _airtower.BUY_MULTIPLE_FURNITURE, [(_arg_1[0][0].id + "|") + _arg_1[0][0].quantity, (_arg_1[0][1].id + "|") + _arg_1[0][1].quantity, (_arg_1[0][2].id + "|") + _arg_1[0][2].quantity, (_arg_1[0][3].id + "|") + _arg_1[0][3].quantity], "str", _shell.getCurrentServerRoomId());
        }
        static function checkPurchaseOfItem(_arg_1, _arg_3, _arg_5, _arg_6, _arg_4, _arg_2) {
            playSound(_arg_1, SFX_ITEM_PURCHASE);
            if (_arg_6) {
                if (_shell.isMyPlayerMember()) {
                    buyItem(_arg_3, _arg_1, _arg_5, _arg_4, _arg_2);
                } else if (CURRENT_PARTY != undefined) {
                    _interface.showContent(CURRENT_PARTY.CONSTANTS.OOPS_CATALOGUE_MESSAGE);
                }
            } else {
                buyItem(_arg_3, _arg_1, _arg_5, _arg_4, _arg_2);
            }
        }
        static function buyItem(_arg_1, _arg_3, _arg_5, _arg_2, _arg_4) {
            _buyItemDelegate = null;
            _buyFurnitureDelegate = null;
            _buyIglooDelegate = null;
            switch (_arg_5) {
                case "item" : 
                    if (_arg_2) {
                        _interface.buyInventory(_arg_1);
                    } else {
                        _shell.sendBuyInventory(_arg_1);
                    }
                    if (!_arg_2) {
                        _buyItemDelegate = com.clubpenguin.util.Delegate.create(_this, onInventoryBought, _arg_3, _arg_1, _arg_4);
                        _shell.addListener(_shell.BUY_INVENTORY, _buyItemDelegate, _this);
                    }
                    break;
                case "furniture" : 
                    if (_arg_2) {
                        _interface.buyFurniture(_arg_1, null, com.clubpenguin.util.Delegate.create(com.clubpenguin.party.BaseParty, checkAddItemPurchasedListener, _arg_1, _arg_3, _arg_5, _arg_4));
                    } else {
                        checkAddItemPurchasedListener(true, _arg_1, _arg_3, _arg_5, _arg_4);
                        _shell.sendBuyFurniture(_arg_1);
                    }
                    break;
                case "igloo" : 
                    if (_arg_2) {
                        _interface.buyIglooType(_arg_1);
                    } else {
                        _shell.sendBuyIglooType(_arg_1);
                    }
                    if (!_arg_2) {
                        _buyIglooDelegate = com.clubpenguin.util.Delegate.create(_this, onIglooBought, _arg_3, _arg_1, _arg_4);
                        _shell.addListener(_shell.BUY_IGLOO_TYPE, _buyIglooDelegate);
                    }
                    break;
                case "puffle" : 
                    break;
            }
        }
        static function checkAddItemPurchasedListener(_arg_1, _arg_4, _arg_2, _arg_5, _arg_3) {
            if (!_arg_1) {
                return(undefined);
            }
            switch (_arg_5) {
                case "item" : 
                    break;
                case "furniture" : 
                    _buyFurnitureDelegate = com.clubpenguin.util.Delegate.create(_this, onFurnitureBought, _arg_2, _arg_4, _arg_3);
                    _shell.addListener(_shell.BUY_FURNITURE, _buyFurnitureDelegate);
                    break;
                case "igloo" : 
                    break;
                case "puffle" : 
                    break;
            }
        }
        static function onInventoryBought(_arg_1, _arg_2, itemID, _arg_3) {
            _shell.removeListener(_shell.BUY_INVENTORY, _buyItemDelegate);
            if (_arg_1.success) {
                _arg_2.nextFrame();
                _arg_3();
            }
        }
        static function onFurnitureBought(_arg_1, _arg_2, itemID, _arg_3) {
            _shell.removeListener(_shell.BUY_FURNITURE, _buyFurnitureDelegate);
            if (_arg_1.success) {
                _arg_2.nextFrame();
                _arg_3();
            }
        }
        static function onIglooBought(_arg_1, _arg_2, itemID, _arg_3) {
            _shell.removeListener(_shell.BUY_IGLOO_TYPE, _buyIglooDelegate);
            if (_arg_1.success) {
                _arg_2.nextFrame();
                _arg_3();
            }
        }
        static function onBundleBought(event, _arg_1, purchasedCallback) {
            _airtower.removeListener("buy_multiple_furniture", _bundleBoughtDelegate, _this);
            _arg_1.nextFrame();
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
        static var OBJECT_UNDEFINED = "****[ERROR:Object Undefined]**** ";
        static var CLASS_NAME = "BaseParty";
        static var FURNITURE_ITEM_TAG = "furniture";
        static var PAPER_ITEM_TAG = "item";
        static var IGLOO_ITEM_TAG = "igloo";
        static var CLAIM_BUTTON_INSTANCE_NAME = "claim_btn";
        static var SFX_ITEM_PURCHASE = "sfx_item_purchase";
        static var _this = com.clubpenguin.party.BaseParty;
    }
