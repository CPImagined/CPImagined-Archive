//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.ui.itembuttons.BuyPaperItemButton extends com.clubpenguin.ui.itembuttons.BuyItemButtonBase
    {
        var _customPurchase, __get__customPurchase, _itemID, _itemMC, checkPurchaseOfItem, CLAIM_BUTTON_INSTANCE_NAME, CLAIM_BUTTON_TEXT_LABEL, ITEM_PURCHASE_EVENT, addItemPurchasedListener, _prompt, __get__itemID, _callback, _purchaseCallback;
        function BuyPaperItemButton (item, itemMC, prompt, customPurchase, callback, buttonName, oopsMsgPath, sound, isEquipable) {
            super(item, itemMC, prompt, callback, String(_global.getCurrentShell().BUY_INVENTORY), buttonName, ((oopsMsgPath != undefined) ? (oopsMsgPath) : (DEFAULT_OOPS_MESSAGE)), sound);
            _customPurchase = customPurchase;
            _isEquipable = isEquipable;
        }
        function get type() {
            return(ITEM_TYPE);
        }
        function set customPurchase(customPurchase) {
            _customPurchase = customPurchase;
            //return(__get__customPurchase());
        }
        function setCustomPurchase(customPurchase) {
            _customPurchase = customPurchase;
            return(this);
        }
        function setIsEquipable(value) {
            _isEquipable = value;
        }
        function create() {
            if (com.clubpenguin.ui.itembuttons.BuyItemButtonBase._shell.isItemInMyInventory(_itemID)) {
                _itemMC.gotoAndStop(_itemMC._totalframes);
                if (_isEquipable) {
                    trace("BuyPaperItemButton.create: isEquipable: " + _itemID);
                    configureEquipButton();
                }
                return(undefined);
            }
            _itemMC[CLAIM_BUTTON_INSTANCE_NAME].onRelease = com.clubpenguin.util.Delegate.create(this, checkPurchaseOfItem);
            _itemMC[CLAIM_BUTTON_TEXT_LABEL].text = com.clubpenguin.ui.itembuttons.BuyItemButtonBase._shell.getLocalizedString("w.party.dialogue.claim");
        }
        function buyItem() {
            com.clubpenguin.ui.itembuttons.BuyItemButtonBase._buyItemDelegate = null;
            if (ITEM_PURCHASE_EVENT != undefined) {
                addItemPurchasedListener();
            }
            if (_customPurchase != undefined) {
                _customPurchase(_itemID, _itemMC, ITEM_TYPE);
                return(undefined);
            }
            if (_prompt) {
                com.clubpenguin.ui.itembuttons.BuyItemButtonBase._interface.buyInventory(_itemID);
            } else {
                com.clubpenguin.ui.itembuttons.BuyItemButtonBase._shell.sendBuyInventory(_itemID);
            }
        }
        function configureEquipButton() {
            trace((("BuyPaperItemButton.configureEquipButton " + __get__itemID()) + " ") + _itemMC[WEAR_BUTTON_INSTANCE_NAME]);
            _itemMC[WEAR_BUTTON_INSTANCE_NAME].onRelease = com.clubpenguin.util.Delegate.create(this, equipButton_Click_Handler);
            _itemMC[WEAR_BUTTON_TEXT_LABEL].text = com.clubpenguin.ui.itembuttons.BuyItemButtonBase._shell.getLocalizedString("w.party.dialogue.wear");
        }
        function equipButton_Click_Handler() {
            trace("BuyPaperItemButton.equipButton_Click_Handler: " + __get__itemID());
            var _local_3 = _global.getCurrentInterface().getInventoryObjectById(__get__itemID());
            setTimeout(com.clubpenguin.util.Delegate.create(this, equipItem, _local_3.type, __get__itemID()), 800);
        }
        function equipItem(itemType, itemID) {
            switch (itemType) {
                case _global.getCurrentInterface().getShellConstant("INVENTORY_TYPE_HEAD") : 
                    _global.getCurrentShell().sendUpdatePlayerHead(itemID);
                    break;
                case _global.getCurrentInterface().getShellConstant("INVENTORY_TYPE_FACE") : 
                    _global.getCurrentShell().sendUpdatePlayerFace(itemID);
                    break;
                case _global.getCurrentInterface().getShellConstant("INVENTORY_TYPE_BODY") : 
                    _global.getCurrentShell().sendUpdatePlayerBody(itemID);
                    break;
                case _global.getCurrentInterface().getShellConstant("INVENTORY_TYPE_HAND") : 
                    _global.getCurrentShell().sendUpdatePlayerHand(itemID);
                    break;
                case _global.getCurrentInterface().getShellConstant("INVENTORY_TYPE_FEET") : 
                    _global.getCurrentShell().sendUpdatePlayerFeet(itemID);
                    break;
                case _global.getCurrentInterface().getShellConstant("INVENTORY_TYPE_NECK") : 
                    _global.getCurrentShell().sendUpdatePlayerNeck(itemID);
                    break;
            }
            _global.getCurrentParty().BaseParty.handleWearButtonClicked();
        }
        function onInventoryBought(event) {
            trace("BuyPaperItemButton.onInventoryBought");
            _global.getCurrentShell().removeListener(ITEM_PURCHASE_EVENT, com.clubpenguin.ui.itembuttons.BuyItemButtonBase._buyItemDelegate);
            if (event.success) {
                _itemMC.gotoAndStop(_itemMC._totalframes);
                if (_callback != undefined) {
                    trace("BuyItemButtonBase run callback function");
                    setTimeout(_callback, 20);
                }
                if (_purchaseCallback != undefined) {
                    trace("BuyItemButtonBase run callback function");
                    setTimeout(_purchaseCallback, 20);
                }
                if (_isEquipable) {
                    trace("BuyPaperItemButton.create: isEquipable: " + _itemID);
                    configureEquipButton();
                }
            }
        }
        static var DEFAULT_OOPS_MESSAGE = "oops_inventory";
        static var ITEM_TYPE = "paper";
        static var WEAR_BUTTON_INSTANCE_NAME = "wear_btn";
        static var WEAR_BUTTON_TEXT_LABEL = "wear_text";
        var _isEquipable = false;
    }
