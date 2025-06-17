//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2015.may.party.MayPurchasePartyItems
    {
        static var _shell, _airtower, _interface, _engine, _doesPlayerOwnPuffleItemDelegate, _bundleBoughtDelegate, _purchaseItemThrottler, _questInterfaceReference, _buyItemDelegate, _partycookieTicketUpdateDelegate, _buyFurnitureDelegate, _buyIglooDelegate, _buyPuffleItemDelegate;
        function MayPurchasePartyItems () {
        }
        static function init() {
            com.clubpenguin.world.rooms2015.may.party.MayParty.pebug("MayPurchasePartyItems.init()");
            _shell = _global.getCurrentShell();
            _airtower = _global.getCurrentAirtower();
            _interface = _global.getCurrentInterface();
            _engine = _global.getCurrentEngine();
        }
        static function configurePurchaseableItem(itemMC, itemID, itemType, memberItem, prompt, partyPurchase) {
            if ((itemType == PAPER_ITEM_TAG) && (_shell.isItemInMyInventory(itemID))) {
                itemMC.nextFrame();
                return(undefined);
            }
            if ((itemType == FURNITURE_ITEM_TAG) && (_shell.isFurnitureInMyInventory(itemID))) {
                itemMC.nextFrame();
                return(undefined);
            }
            if ((itemType == IGLOO_ITEM_TAG) && (_shell.isIglooBuildingInMyInventory(itemID))) {
                itemMC.nextFrame();
                return(undefined);
            }
            if (itemType == PUFFLE_ITEM_TAG) {
                _doesPlayerOwnPuffleItemDelegate = com.clubpenguin.util.Delegate.create(_this, handleDoesPlayerOwnPuffleItem, itemID, itemMC, partyPurchase);
                _shell.receivedDoesPlayerOwnPuffleItem.add(_doesPlayerOwnPuffleItemDelegate, _this);
                _shell.sendGetDoesPlayerOwnPuffleItem(itemID, "head");
                return(undefined);
            }
            itemMC[CLAIM_BUTTON_INSTANCE_NAME].onRelease = com.clubpenguin.util.Delegate.create(_this, checkPurchaseOfItem, itemMC, itemID, itemType, memberItem, prompt, partyPurchase);
        }
        static function handleDoesPlayerOwnPuffleItem(itemID, itemCategory, hasItem, quantity, expectedItemId, itemMC, partyPurchase) {
            if ((itemID == expectedItemId) && (itemCategory == "head")) {
                _puffleItemCounter++;
                if (_puffleItemCounter == NUM_PUFFLE_ITEMS) {
                    _puffleItemCounter = 0;
                    _shell.receivedDoesPlayerOwnPuffleItem.remove(_doesPlayerOwnPuffleItemDelegate, _this);
                }
                itemMC.quantityText.text = (quantity + "/") + MAX_PUFFLE_ITEM_QUANTITY;
                if (quantity >= MAX_PUFFLE_ITEM_QUANTITY) {
                    itemMC.nextFrame();
                    return(undefined);
                }
                itemMC[CLAIM_BUTTON_INSTANCE_NAME].onRelease = com.clubpenguin.util.Delegate.create(_this, checkPurchaseOfItem, itemMC, itemID, PUFFLE_ITEM_TAG, true, false, partyPurchase);
            }
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
        static function checkPurchaseOfItem(itemMC, itemID, itemType, memberItem, prompt, partyPurchase) {
            _purchaseItemThrottler = new com.clubpenguin.util.EventThrottler();
            _purchaseItemThrottler.delayBetweenEvents = 500;
            if (memberItem) {
                if (_shell.isMyPlayerMember()) {
                    com.clubpenguin.world.rooms2015.may.party.MayParty.pebug("checkPurchaseOfItem _shell.isMyPlayerMember() " + _shell.isMyPlayerMember());
                    _purchaseItemThrottler.queueFunction(com.clubpenguin.util.Delegate.create(_this, buyItem, itemID, itemMC, itemType, prompt, partyPurchase));
                } else if (com.clubpenguin.world.rooms2015.may.party.MayParty != undefined) {
                    _interface.showContent(com.clubpenguin.world.rooms2015.may.party.MayParty.CONSTANTS.OOPS_CATALOGUE_MESSAGE);
                }
            } else {
                _purchaseItemThrottler.queueFunction(com.clubpenguin.util.Delegate.create(_this, buyItem, itemID, itemMC, itemType, prompt, partyPurchase));
            }
            com.clubpenguin.world.rooms2015.may.party.MayParty.playSound(itemMC, SFX_ITEM_PURCHASE);
        }
        static function buyItem(itemID, itemMC, itemType, prompt, partyPurchase) {
            _questInterfaceReference = itemMC._parent._parent._parent._parent;
            _shell.removeListener(_shell.BUY_INVENTORY, _buyItemDelegate);
            _airtower.removeListener("partycookie", _partycookieTicketUpdateDelegate);
            _buyItemDelegate = null;
            _buyFurnitureDelegate = null;
            _buyIglooDelegate = null;
            _buyPuffleItemDelegate = null;
            _doesPlayerOwnPuffleItemDelegate = null;
            var _local_4 = (partyPurchase != undefined) && (partyPurchase);
            switch (itemType) {
                case "item" : 
                    if (_local_4) {
                        com.clubpenguin.world.rooms2015.may.party.MayParty.sendPurchaseItem(itemID, itemMC, itemType);
                    } else if (prompt) {
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
                    if (_local_4) {
                        com.clubpenguin.world.rooms2015.may.party.MayParty.sendPurchaseItem(itemID, itemMC, itemType);
                    } else if (prompt) {
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
                    if (_local_4) {
                        com.clubpenguin.world.rooms2015.may.party.MayParty.sendPurchaseItem(itemID, itemMC, itemType);
                    } else if (prompt) {
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
                    if (_local_4) {
                        com.clubpenguin.world.rooms2015.may.party.MayParty.sendPurchaseItem(itemID, itemMC, itemType);
                    } else {
                        _shell.sendBuyPuffleCareItem(itemID);
                    }
                    if (!prompt) {
                        _buyPuffleItemDelegate = com.clubpenguin.util.Delegate.create(_this, onPuffleItemBought, itemMC, itemID);
                        _shell.addListener(_shell.BUY_PUFFLE_CARE_ITEM, _buyPuffleItemDelegate);
                    }
                    break;
            }
            _partycookieTicketUpdateDelegate = com.clubpenguin.util.Delegate.create(_this, partycookieTicketUpdateDelegate);
            _airtower.addListener("partycookie", _partycookieTicketUpdateDelegate);
        }
        static function partycookieTicketUpdateDelegate() {
            com.clubpenguin.world.rooms2015.may.party.MayParty.pebug("MayPurchasePartyItems.partycookieTicketUpdateDelegate() - UPDATED TICKETS:  " + com.clubpenguin.world.rooms2015.may.party.MayParty.tickets, "MayPurchasePartyItems");
            _airtower.removeListener("partycookie", _partycookieTicketUpdateDelegate);
            _questInterfaceReference.fair_tickets_mc.numTickets.text = String(com.clubpenguin.world.rooms2015.may.party.MayParty.tickets);
        }
        static function onInventoryBought(event, itemMC, itemID) {
            if (event.success) {
                com.clubpenguin.world.rooms2015.may.party.MayParty.pebug("MayPurchasePartyItems.onInventoryBought() - itemID : " + itemID, "MayPurchasePartyItems");
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
        static function onPuffleItemBought(event, itemMC) {
            com.clubpenguin.world.rooms2015.may.party.MayParty.pebug("onPuffleItemBought():" + event.toString());
            com.clubpenguin.world.rooms2015.may.party.MayParty.pebug("onPuffleItemBought():event.quantity====" + event.quantity);
            _shell.removeListener(_shell.BUY_PUFFLE_CARE_ITEM, _buyPuffleItemDelegate);
            if (event.success) {
                if (Number(event.quantity) >= MAX_PUFFLE_ITEM_QUANTITY) {
                    event.quantity = MAX_PUFFLE_ITEM_QUANTITY;
                    itemMC.nextFrame();
                }
                itemMC.quantityText.text = (event.quantity + "/") + MAX_PUFFLE_ITEM_QUANTITY;
                _interface.showBuyPuffleCareItemSuccessPrompt = false;
            }
        }
        static var CLASS_NAME = "MayPurchasePartyItems";
        static var FURNITURE_ITEM_TAG = "furniture";
        static var PAPER_ITEM_TAG = "item";
        static var IGLOO_ITEM_TAG = "igloo";
        static var PUFFLE_ITEM_TAG = "puffle";
        static var CLAIM_BUTTON_INSTANCE_NAME = "claim_btn";
        static var NUM_PUFFLE_ITEMS = 0;
        static var _puffleItemCounter = 0;
        static var SFX_ITEM_PURCHASE = "sfx_item_purchase";
        static var MAX_PUFFLE_ITEM_QUANTITY = 40;
        static var _this = com.clubpenguin.world.rooms2015.may.party.MayPurchasePartyItems;
    }
