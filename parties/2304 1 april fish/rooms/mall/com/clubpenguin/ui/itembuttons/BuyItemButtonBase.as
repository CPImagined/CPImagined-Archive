//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.ui.itembuttons.BuyItemButtonBase
    {
        static var _shell, _airtower, _interface, _engine, _party, _buyItemDelegate;
        var _itemMC, _itemID, _member, _prompt, _callback, ITEM_PURCHASE_EVENT, _purchaseSFX;
        function BuyItemButtonBase (itemMC, itemID, member, prompt, callback, purchaseEventName, buttonName, oopsMsgPath, purchaseSound) {
            _shell = _global.getCurrentShell();
            _airtower = _global.getCurrentAirtower();
            _interface = _global.getCurrentInterface();
            _engine = _global.getCurrentEngine();
            _party = _global.getCurrentParty();
            _itemMC = itemMC;
            _itemID = itemID;
            _member = member;
            _prompt = ((prompt != undefined) ? (prompt) : true);
            _callback = callback;
            ITEM_PURCHASE_EVENT = purchaseEventName;
            trace("ITEM_PURCHASE_EVENT " + ITEM_PURCHASE_EVENT);
            if (buttonName != undefined) {
                CLAIM_BUTTON_INSTANCE_NAME = buttonName;
            }
            if (oopsMsgPath != OOPS_MESSAGE_PATH) {
                OOPS_MESSAGE_PATH = oopsMsgPath;
            }
            _purchaseSFX = purchaseSound;
            configurePurchaseableItem();
        }
        function configurePurchaseableItem() {
        }
        function checkPurchaseOfItem() {
            if (_purchaseSFX != undefined) {
                _party.BaseParty.playSound(_itemMC, _purchaseSFX);
            }
            if (_member && (!_shell.isMyPlayerMember())) {
                _interface.showContent(OOPS_MESSAGE_PATH);
            } else {
                buyItem();
            }
        }
        function buyItem() {
        }
        function addItemPurchasedListener() {
            trace("BuyItemButtonBase.addItemPurchasedListener");
            _buyItemDelegate = com.clubpenguin.util.Delegate.create(this, onInventoryBought);
            _shell.addListener(ITEM_PURCHASE_EVENT, _buyItemDelegate);
        }
        function onInventoryBought(event) {
            trace("BuyItemButtonBase.onInventoryBought");
            _shell.removeListener(ITEM_PURCHASE_EVENT, _buyItemDelegate);
            if (event.success) {
                _itemMC.nextFrame();
                if (_callback != undefined) {
                    trace("BuyItemButtonBase run callback function");
                    setTimeout(_callback, 20);
                }
            }
        }
        function destroy() {
            _shell.removeListener(ITEM_PURCHASE_EVENT, _buyItemDelegate);
            _itemMC[CLAIM_BUTTON_INSTANCE_NAME].onRelease = null;
        }
        var CLAIM_BUTTON_INSTANCE_NAME = "claim_btn";
        var OOPS_MESSAGE_PATH = "oops_general";
    }
