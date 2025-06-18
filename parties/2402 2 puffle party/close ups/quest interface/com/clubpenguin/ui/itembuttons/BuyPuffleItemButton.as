//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.ui.itembuttons.BuyPuffleItemButton extends com.clubpenguin.ui.itembuttons.BuyItemButtonBase
    {
        static var _doesPlayerOwnPuffleItemDelegate;
        var _customPurchase, __get__customPurchase, __get__puffleItemsInView, __get__quantityTextName, _itemID, _itemMC, checkPurchaseOfItem, CLAIM_BUTTON_INSTANCE_NAME, ITEM_PURCHASE_EVENT, addItemPurchasedListener, _purchaseCallback, _callback;
        function BuyPuffleItemButton (item, itemMC, puffleItemsInView, prompt, customPurchase, callback, buttonName, quantityTextName, oopsMsgPath, sound) {
            super(item, itemMC, prompt, callback, _global.getCurrentShell().BUY_PUFFLE_CARE_ITEM, buttonName, ((oopsMsgPath != undefined) ? (oopsMsgPath) : (DEFAULT_OOPS_MESSAGE)), sound);
            NUM_PUFFLE_ITEMS = puffleItemsInView;
            if (quantityTextName != undefined) {
                QUANTITY_TEXTFIELD_NAME = quantityTextName;
            }
            _customPurchase = customPurchase;
        }
        function get type() {
            return(ITEM_TYPE);
        }
        function set customPurchase(customPurchase) {
            _customPurchase = customPurchase;
            //return(__get__customPurchase());
        }
        function set puffleItemsInView(puffleItemsInView) {
            NUM_PUFFLE_ITEMS = puffleItemsInView;
            //return(__get__puffleItemsInView());
        }
        function set quantityTextName(quantityTextName) {
            QUANTITY_TEXTFIELD_NAME = quantityTextName;
            //return(__get__quantityTextName());
        }
        function setCustomPurchase(customPurchase) {
            _customPurchase = customPurchase;
            return(this);
        }
        function setPuffleItemsInView(puffleItemsInView) {
            NUM_PUFFLE_ITEMS = puffleItemsInView;
            return(this);
        }
        function setQuantityTextName(quantityTextName) {
            QUANTITY_TEXTFIELD_NAME = quantityTextName;
            return(this);
        }
        function create() {
            _doesPlayerOwnPuffleItemDelegate = com.clubpenguin.util.Delegate.create(this, handleDoesPlayerOwnPuffleItem);
            com.clubpenguin.ui.itembuttons.BuyItemButtonBase._shell.receivedDoesPlayerOwnPuffleItem.add(_doesPlayerOwnPuffleItemDelegate, this);
            com.clubpenguin.ui.itembuttons.BuyItemButtonBase._shell.sendGetDoesPlayerOwnPuffleItem(_itemID, "head");
        }
        function handleDoesPlayerOwnPuffleItem(itemID, itemCategory, hasItem, quantity) {
            if ((itemID == _itemID) && (itemCategory == "head")) {
                _puffleItemCounter++;
                if (_puffleItemCounter == NUM_PUFFLE_ITEMS) {
                    _puffleItemCounter = 0;
                    com.clubpenguin.ui.itembuttons.BuyItemButtonBase._shell.receivedDoesPlayerOwnPuffleItem.remove(_doesPlayerOwnPuffleItemDelegate, this);
                }
                var _local_4 = com.clubpenguin.ui.itembuttons.BuyItemButtonBase._shell.puffleManager.myPuffles;
                var _local_5 = 0;
                var _local_2 = 0;
                while (_local_2 < _local_4.length) {
                    var _local_3 = _local_4[_local_2];
                    if (_local_3.hat.id == _itemID) {
                        _local_5++;
                    }
                    _local_2++;
                }
                var _local_6 = Number(quantity + _local_5);
                _itemMC[QUANTITY_TEXTFIELD_NAME].text = (_local_6 + "/") + MAX_PUFFLE_ITEM_QUANTITY;
                if (_local_6 >= MAX_PUFFLE_ITEM_QUANTITY) {
                    _itemMC.gotoAndStop(_itemMC._totalframes);
                    return(undefined);
                }
                _itemMC[CLAIM_BUTTON_INSTANCE_NAME].onRelease = com.clubpenguin.util.Delegate.create(this, checkPurchaseOfItem);
            }
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
            com.clubpenguin.ui.itembuttons.BuyItemButtonBase._shell.sendBuyPuffleCareItem(_itemID);
        }
        function onInventoryBought(event) {
            com.clubpenguin.ui.itembuttons.BuyItemButtonBase._shell.removeListener(ITEM_PURCHASE_EVENT, com.clubpenguin.ui.itembuttons.BuyItemButtonBase._buyItemDelegate);
            if (event.success) {
                if (Number(event.quantity) >= MAX_PUFFLE_ITEM_QUANTITY) {
                    event.quantity = MAX_PUFFLE_ITEM_QUANTITY;
                    _itemMC.gotoAndStop(_itemMC._totalframes);
                }
                _itemMC[QUANTITY_TEXTFIELD_NAME].text = (event.quantity + "/") + MAX_PUFFLE_ITEM_QUANTITY;
                _purchaseCallback();
                _callback();
            }
        }
        static var DEFAULT_OOPS_MESSAGE = "oops_puffle";
        static var ITEM_TYPE = "puffle";
        static var QUANTITY_TEXTFIELD_NAME = "quantityText";
        static var MAX_PUFFLE_ITEM_QUANTITY = 50;
        static var NUM_PUFFLE_ITEMS = 0;
        static var _puffleItemCounter = 0;
    }
