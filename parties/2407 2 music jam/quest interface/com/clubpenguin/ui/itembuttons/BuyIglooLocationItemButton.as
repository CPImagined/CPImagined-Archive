﻿//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.ui.itembuttons.BuyIglooLocationItemButton extends com.clubpenguin.ui.itembuttons.BuyItemButtonBase
    {
        var _customPurchase, __get__customPurchase, _itemID, _itemMC, checkPurchaseOfItem, CLAIM_BUTTON_INSTANCE_NAME, ITEM_PURCHASE_EVENT, addItemPurchasedListener, _prompt;
        function BuyIglooLocationItemButton (item, itemMC, prompt, customPurchase, callback, buttonName, oopsMsgPath, sound) {
            super(item, itemMC, prompt, callback, _global.getCurrentShell().BUY_IGLOO_LOCATION, buttonName, ((oopsMsgPath != undefined) ? (oopsMsgPath) : (DEFAULT_OOPS_MESSAGE)), sound);
            _customPurchase = customPurchase;
        }
        function set customPurchase(customPurchase) {
            _customPurchase = customPurchase;
            //return(__get__customPurchase());
        }
        function setCustomPurchase(customPurchase) {
            _customPurchase = customPurchase;
            return(this);
        }
        function create() {
            if (com.clubpenguin.ui.itembuttons.BuyItemButtonBase._shell.isIglooLocationInMyInventory(_itemID)) {
                _itemMC.gotoAndStop(_itemMC._totalframes);
                return(undefined);
            }
            _itemMC[CLAIM_BUTTON_INSTANCE_NAME].onRelease = com.clubpenguin.util.Delegate.create(this, checkPurchaseOfItem);
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
                com.clubpenguin.ui.itembuttons.BuyItemButtonBase._interface.buyIglooLocation(_itemID, true);
            } else {
                com.clubpenguin.ui.itembuttons.BuyItemButtonBase._shell.sendBuyIglooLocation(_itemID);
            }
        }
        static var DEFAULT_OOPS_MESSAGE = "oops_catalog_igloofurniture";
        static var ITEM_TYPE = "iglooLocation";
    }
