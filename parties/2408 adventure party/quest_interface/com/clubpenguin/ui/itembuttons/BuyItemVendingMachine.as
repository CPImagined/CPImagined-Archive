//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.ui.itembuttons.BuyItemVendingMachine
    {
        var _purchaseItemThrottler, _itemButtonsList, itemTimout;
        function BuyItemVendingMachine () {
            _purchaseItemThrottler = new com.clubpenguin.util.EventThrottler();
            _purchaseItemThrottler.delayBetweenEvents = 2000;
            _itemButtonsList = new Object();
        }
        function add(itemButton) {
            itemButton.customPurchase = com.clubpenguin.util.Delegate.create(this, onPurchaseButtonClicked, itemButton.itemID);
            itemButton.purchaseCallback = com.clubpenguin.util.Delegate.create(this, handleItemPurchased, itemButton.itemID);
            itemButton.create();
            _itemButtonsList["item_" + itemButton.itemID] = itemButton;
        }
        function onPurchaseButtonClicked(id) {
            var _local_2 = _itemButtonsList["item_" + id];
            var _local_4 = _local_2.itemID;
            var _local_3 = _local_2.itemMC;
            _local_2.removeItemPurchasedListener();
            _local_2.customPurchase = undefined;
            if (_local_3.loadingMC != undefined) {
                _local_3.loadingMC._visible = true;
            } else {
                _local_3.attachMovie("loadingMC", "loadingMC", _local_3.getNextHighestDepth(), {_x:_local_3._width / 2, _y:_local_3._height / 2});
            }
            Button(_local_3[_local_2.CLAIM_BUTTON_INSTANCE_NAME]).enabled = false;
            _local_3[_local_2.CLAIM_BUTTON_INSTANCE_NAME]._alpha = 50;
            _purchasedItemsInQueue.push(_local_4);
            _purchaseItemThrottler.queueFunction(com.clubpenguin.util.Delegate.create(_local_2, _local_2.buyItem));
            itemTimout = setTimeout(com.clubpenguin.util.Delegate.create(this, handleItemPurchased, _local_4), TIMEOUT_PERIOD);
        }
        function handleItemPurchased(id) {
            clearTimeout(itemTimout);
            var _local_2 = _itemButtonsList["item_" + id];
            var _local_4 = _local_2.itemID;
            var _local_3 = _local_2.itemMC;
            if (_local_2.type == "puffle") {
                _local_2.customPurchase = com.clubpenguin.util.Delegate.create(this, onPurchaseButtonClicked, _local_2.itemID);
                _local_3.loadingMC._visible = false;
            } else {
                _local_3.loadingMC.removeMovieClip();
                _local_3.loadingMC = undefined;
            }
            removePurchasedItemFromQueue(_local_4);
            Button(_local_3[_local_2.CLAIM_BUTTON_INSTANCE_NAME]).enabled = true;
            _local_3[_local_2.CLAIM_BUTTON_INSTANCE_NAME]._alpha = 100;
        }
        function isItemInLoadingQueue(itemID) {
            if (_purchasedItemsInQueue.length == 0) {
                return(false);
            }
            var _local_2 = 0;
            while (_local_2 < _purchasedItemsInQueue.length) {
                if (_purchasedItemsInQueue[_local_2] == itemID) {
                    return(true);
                }
                _local_2++;
            }
            return(false);
        }
        function removePurchasedItemFromQueue(itemID) {
            var _local_2 = 0;
            while (_local_2 < _purchasedItemsInQueue.length) {
                if (_purchasedItemsInQueue[_local_2] == itemID) {
                    _purchasedItemsInQueue.splice(_local_2, 1);
                    break;
                }
                _local_2++;
            }
            trace("The current queue consists of " + _purchasedItemsInQueue);
        }
        static var TIMEOUT_PERIOD = 5000;
        var _purchasedItemsInQueue = new Array();
    }
