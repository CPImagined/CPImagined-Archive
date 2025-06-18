//Created by Action Script Viewer - https://www.buraks.com/asv
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
        static function get partyIglooListItems() {
            return(CURRENT_PARTY.iglooFurnitureItems);
        }
        static function configurePurchaseableItem(itemMC, itemID, itemType, member, prompt) {
            pebug("configurePurchaseableItem itemID " + itemID);
            pebug("configurePurchaseableItem itemType " + itemType);
            if ((itemType == "item") && (_shell.isItemInMyInventory(itemID))) {
                itemMC.nextFrame();
                return(undefined);
            }
            if ((itemType == "furniture") && (_shell.isFurnitureInMyInventory(itemID))) {
                itemMC.nextFrame();
                return(undefined);
            }
            if ((itemType == "igloo") && (_shell.isIglooBuildingInMyInventory(itemID))) {
                itemMC.nextFrame();
                return(undefined);
            }
            itemMC[CLAIM_BUTTON_INSTANCE_NAME].onRelease = com.clubpenguin.util.Delegate.create(_this, checkPurchaseOfItem, itemMC, itemID, itemType, member, prompt);
        }
        static function configureFurnitureBundle(itemMC, itemIDSet) {
            if (_shell.isFurnitureInMyInventory(itemIDSet[0][0].id)) {
                itemMC.nextFrame();
                return(undefined);
            }
            itemMC[CLAIM_BUTTON_INSTANCE_NAME].onRelease = com.clubpenguin.util.Delegate.create(_this, buyFurnitureBundle, itemMC, itemIDSet);
        }
        static function buyFurnitureBundle(itemMC, itemIDSet) {
            _bundleBoughtDelegate = com.clubpenguin.util.Delegate.create(_this, onBundleBought, itemMC);
            _airtower.addListener(_airtower.BUY_MULTIPLE_FURNITURE, _bundleBoughtDelegate, _this);
            _airtower.send(_airtower.PLAY_EXT, "g#" + _airtower.BUY_MULTIPLE_FURNITURE, [(itemIDSet[0][0].id + "|") + itemIDSet[0][0].quantity, (itemIDSet[0][1].id + "|") + itemIDSet[0][1].quantity, (itemIDSet[0][2].id + "|") + itemIDSet[0][2].quantity, (itemIDSet[0][3].id + "|") + itemIDSet[0][3].quantity], "str", _shell.getCurrentServerRoomId());
        }
        static function checkPurchaseOfItem(itemMC, itemID, itemType, member, prompt) {
            playSound(itemMC, SFX_ITEM_PURCHASE);
            if (member) {
                if (_shell.isMyPlayerMember()) {
                    buyItem(itemID, itemMC, itemType, prompt);
                } else if (CURRENT_PARTY != undefined) {
                    _interface.showContent(CURRENT_PARTY.CONSTANTS.OOPS_CATALOGUE_MESSAGE);
                }
            } else {
                buyItem(itemID, itemMC, itemType, prompt);
            }
        }
        static function buyItem(itemID, itemMC, itemType, prompt) {
            _buyItemDelegate = null;
            _buyFurnitureDelegate = null;
            _buyIglooDelegate = null;
            switch (itemType) {
                case "item" : 
                    if (prompt) {
                        _interface.buyInventory(itemID);
                    } else {
                        _shell.sendBuyInventory(itemID);
                    }
                    if (!prompt) {
                        _buyItemDelegate = com.clubpenguin.util.Delegate.create(_this, onInventoryBought, itemMC, itemID);
                        _shell.addListener(_shell.BUY_INVENTORY, _buyItemDelegate, _this);
                    }
                    break;
                case "furniture" : 
                    if (prompt) {
                        _interface.buyFurniture(itemID);
                    } else {
                        _shell.sendBuyFurniture(itemID);
                    }
                    if (!prompt) {
                        _buyFurnitureDelegate = com.clubpenguin.util.Delegate.create(_this, onFurnitureBought, itemMC, itemID);
                        _shell.addListener(_shell.BUY_FURNITURE, _buyFurnitureDelegate);
                    }
                    break;
                case "igloo" : 
                    if (prompt) {
                        _interface.buyIglooType(itemID);
                    } else {
                        _shell.sendBuyIglooType(itemID);
                    }
                    if (!prompt) {
                        _buyIglooDelegate = com.clubpenguin.util.Delegate.create(_this, onIglooBought, itemMC, itemID);
                        _shell.addListener(_shell.BUY_IGLOO_TYPE, _buyIglooDelegate);
                    }
                    break;
                case "puffle" : 
                    break;
            }
        }
        static function onInventoryBought(event, itemMC, itemID) {
            _shell.removeListener(_shell.BUY_INVENTORY, _buyItemDelegate);
            if (event.success) {
                itemMC.nextFrame();
            }
        }
        static function onFurnitureBought(event, itemMC, itemID) {
            _shell.removeListener(_shell.BUY_FURNITURE, _buyFurnitureDelegate);
            if (event.success) {
                itemMC.nextFrame();
            }
        }
        static function onIglooBought(event, itemMC, itemID) {
            _shell.removeListener(_shell.BUY_IGLOO_TYPE, _buyIglooDelegate);
            if (event.success) {
                itemMC.nextFrame();
            }
        }
        static function onBundleBought(event, itemMC) {
            _airtower.removeListener("buy_multiple_furniture", _bundleBoughtDelegate, _this);
            itemMC.nextFrame();
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
