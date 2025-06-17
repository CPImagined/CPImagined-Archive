//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.party.BaseParty
    {
        static var _shell, _airtower, _interface, _engine, _party, _serverCookieService, _serverCookie, _updatePlayerFrame, _currentParty, _interfaceOverrides, _doesPlayerOwnPuffleItemDelegate, _bundleBoughtDelegate, _purchaseItemThrottler, _buyItemDelegate, _buyFurnitureDelegate, _buyIglooDelegate, _buyPuffleItemDelegate;
        function BaseParty () {
        }
        static function init(cookieVO) {
            pebug("BASE PARTY - INIT !!!");
            _shell = _global.getCurrentShell();
            _airtower = _global.getCurrentAirtower();
            _interface = _global.getCurrentInterface();
            _engine = _global.getCurrentEngine();
            _party = _global.getCurrentParty();
            initServerCookie(cookieVO);
            addListenerForPartySettings(PARTY_SETTINGS_RESPONSE_NAME);
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
        static function handleWearButtonClicked() {
            if (CURRENT_PARTY.handleWearButtonClicked != undefined) {
                CURRENT_PARTY.handleWearButtonClicked();
            } else {
                _global.getCurrentInterface().closeContent();
            }
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
            pebug("SHOW PARTY ICON");
        }
        static function hidePartyIcon() {
            pebug("HIDE PARTY ICON");
            pebug("\t\t_interface : " + _interface);
            pebug("\t\t_interface.PARTY_ICON : " + _interface.PARTY_ICON);
            _interface.PARTY_ICON._visible = false;
        }
        static function partyIconState() {
            pebug("PARTY ICON STATE - show it? :  " + CURRENT_PARTY.partyIconVisible);
            if (CURRENT_PARTY.partyIconVisible || (_firstTimeLogin)) {
                showPartyIcon();
                pebug(" - showPartyIcon()", CURRENT_PARTY.partyIconVisible);
            } else {
                hidePartyIcon();
                pebug(" - hidePartyIcon()", CURRENT_PARTY.partyIconVisible);
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
        static function configurePurchaseableItem(itemMC, itemID, itemType, member, prompt, partyPurchase) {
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
            if (itemType == PUFFLE_ITEM_TAG) {
                _doesPlayerOwnPuffleItemDelegate = com.clubpenguin.util.Delegate.create(_this, handleDoesPlayerOwnPuffleItem, itemID, itemMC, partyPurchase);
                _shell.receivedDoesPlayerOwnPuffleItem.add(_doesPlayerOwnPuffleItemDelegate, _this);
                _shell.sendGetDoesPlayerOwnPuffleItem(itemID, "head");
                return(undefined);
            }
            itemMC[CLAIM_BUTTON_INSTANCE_NAME].onRelease = com.clubpenguin.util.Delegate.create(_this, checkPurchaseOfItem, itemMC, itemID, itemType, member, prompt, partyPurchase);
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
        static function checkPurchaseOfItem(itemMC, itemID, itemType, member, prompt, partyPurchase) {
            if (member) {
                if (_shell.isMyPlayerMember()) {
                    _purchaseItemThrottler.queueFunction(com.clubpenguin.util.Delegate.create(com.clubpenguin.party.BaseParty, buyItem, itemID, itemMC, itemType, prompt, partyPurchase));
                } else if (CURRENT_PARTY != undefined) {
                    _interface.showContent(CURRENT_PARTY.CONSTANTS.OOPS_CATALOGUE_MESSAGE);
                }
            } else {
                _purchaseItemThrottler.queueFunction(com.clubpenguin.util.Delegate.create(com.clubpenguin.party.BaseParty, buyItem, itemID, itemMC, itemType, prompt, partyPurchase));
            }
        }
        static function buyItem(itemID, itemMC, itemType, prompt, partyPurchase) {
            _buyItemDelegate = null;
            _buyFurnitureDelegate = null;
            _buyIglooDelegate = null;
            _buyPuffleItemDelegate = null;
            _doesPlayerOwnPuffleItemDelegate = null;
            var _local_4 = (partyPurchase != undefined) && (partyPurchase);
            switch (itemType) {
                case "item" : 
                    if (_local_4) {
                        CURRENT_PARTY.sendPurchaseItem(itemID, itemMC, itemType);
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
                        CURRENT_PARTY.sendPurchaseItem(itemID, itemMC, itemType);
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
                        CURRENT_PARTY.sendPurchaseItem(itemID, itemMC, itemType);
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
                        CURRENT_PARTY.sendPurchaseItem(itemID, itemMC, itemType);
                    } else {
                        _shell.sendBuyPuffleCareItem(itemID);
                    }
                    if (!prompt) {
                        _buyPuffleItemDelegate = com.clubpenguin.util.Delegate.create(_this, onPuffleItemBought, itemMC, itemID);
                        _shell.addListener(_shell.BUY_PUFFLE_CARE_ITEM, _buyPuffleItemDelegate);
                    }
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
        static function onPuffleItemBought(event, itemMC) {
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
        static var OBJECT_UNDEFINED = "****[ERROR:Object Undefined]**** ";
        static var CLASS_NAME = "BaseParty";
        static var PARTY_SETTINGS_RESPONSE_NAME = "partyservice";
        static var FURNITURE_ITEM_TAG = "furniture";
        static var PAPER_ITEM_TAG = "item";
        static var IGLOO_ITEM_TAG = "igloo";
        static var PUFFLE_ITEM_TAG = "puffle";
        static var CLAIM_BUTTON_INSTANCE_NAME = "claim_btn";
        static var NUM_PUFFLE_ITEMS = 0;
        static var _puffleItemCounter = 0;
        static var SFX_ITEM_PURCHASE = "sfx_item_purchase";
        static var MAX_PUFFLE_ITEM_QUANTITY = 40;
        static var _this = com.clubpenguin.party.BaseParty;
        static var _firstTimeLogin = false;
    }
