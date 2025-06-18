//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.ui.itembuttons.BuyMultipleItemsButton
    {
        var buyList, containerMC, __get__oopsMsgPath, buyItemTimeout;
        function BuyMultipleItemsButton (mc, member) {
            buyList = new Array();
            if (member != undefined) {
                _member = member;
            }
            containerMC = mc;
        }
        function set oopsMsgPath(oopsMsgPath) {
            OOPS_MESSAGE_PATH = oopsMsgPath;
            //return(__get__oopsMsgPath());
        }
        function add(buyButton) {
            buyList.push(buyButton);
        }
        function buyItems() {
            if (_member && (!_global.getCurrentShell().isMyPlayerMember())) {
                _global.getCurrentShell().showAs3Content(_global.getCurrentInterface().getFilePath(OOPS_MESSAGE_PATH), OOPS_MESSAGE_PATH);
                return(undefined);
            }
            if (itemsSuccessfullyPurchased == buyList.length) {
                return(undefined);
            }
            var _local_3 = com.clubpenguin.ui.itembuttons.BuyItemButtonBase(buyList[itemsAttemptedToPurchase]);
            _local_3.onInventoryBoughtSignal.addOnce(com.clubpenguin.util.Delegate.create(this, handleOnItemBought));
            _local_3.checkPurchaseOfItem();
            buyItemTimeout = setTimeout(com.clubpenguin.util.Delegate.create(this, buyItems), THROTTLE_INTERVAL);
            itemsAttemptedToPurchase++;
        }
        function handleOnItemBought(success) {
            if (success) {
                itemsSuccessfullyPurchased++;
            }
            if (itemsSuccessfullyPurchased == buyList.length) {
                containerMC.gotoAndStop(containerMC._totalframes);
            }
        }
        function create() {
            containerMC.claim_btn.onRelease = com.clubpenguin.util.Delegate.create(this, buyItems);
        }
        function clean() {
            clearTimeout(buyItemTimeout);
        }
        var OOPS_MESSAGE_PATH = "oops_general";
        static var THROTTLE_INTERVAL = 2000;
        var itemsAttemptedToPurchase = 0;
        var itemsSuccessfullyPurchased = 0;
        var _member = false;
    }
