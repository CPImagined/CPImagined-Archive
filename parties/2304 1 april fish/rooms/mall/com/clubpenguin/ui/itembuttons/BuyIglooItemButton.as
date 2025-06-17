//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.ui.itembuttons.BuyIglooItemButton extends com.clubpenguin.ui.itembuttons.BuyItemButtonBase
    {
        var _customPurchase, _itemID, _itemMC, checkPurchaseOfItem, CLAIM_BUTTON_INSTANCE_NAME, _prompt, ITEM_PURCHASE_EVENT, addItemPurchasedListener;
        function BuyIglooItemButton (itemMC, itemID, member, prompt, customPurchase, callback, buttonName, oopsMsgPath, sound) {
            super(itemMC, itemID, member, prompt, callback, _global.getCurrentShell().BUY_IGLOO_TYPE, buttonName, ((oopsMsgPath != undefined) ? (oopsMsgPath) : (DEFAULT_OOPS_MESSAGE)), sound);
            _customPurchase = customPurchase;
        }
        function configurePurchaseableItem() {
            if (com.clubpenguin.ui.itembuttons.BuyItemButtonBase._shell.isIglooBuildingInMyInventory(_itemID)) {
                _itemMC.nextFrame();
                return(undefined);
            }
            _itemMC[CLAIM_BUTTON_INSTANCE_NAME].onRelease = com.clubpenguin.util.Delegate.create(this, checkPurchaseOfItem);
        }
        function buyItem() {
            com.clubpenguin.ui.itembuttons.BuyItemButtonBase._buyItemDelegate = null;
            if (_customPurchase != undefined) {
                _customPurchase(_itemID, _itemMC, ITEM_TYPE);
                return(undefined);
            }
            if (_prompt) {
                com.clubpenguin.ui.itembuttons.BuyItemButtonBase._interface.buyIglooType(_itemID);
            } else {
                com.clubpenguin.ui.itembuttons.BuyItemButtonBase._shell.sendBuyIglooType(_itemID);
            }
            if (ITEM_PURCHASE_EVENT != undefined) {
                addItemPurchasedListener();
            }
        }
        static var DEFAULT_OOPS_MESSAGE = "oops_catalog_igloofurniture";
        static var ITEM_TYPE = "igloo";
    }
