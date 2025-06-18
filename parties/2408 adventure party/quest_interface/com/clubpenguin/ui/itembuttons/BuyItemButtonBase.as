//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.ui.itembuttons.BuyItemButtonBase
    {
        static var _shell, _airtower, _interface, _engine, _party, _buyItemDelegate;
        var _itemID, _member, _itemMC, _prompt, _callback, ITEM_PURCHASE_EVENT, _customPurchaseHandler, _purchaseSFX, __get__customPurchase, __get__prompt, __get__callback, _purchaseCallback, __get__purchaseCallback, __get__purchaseSound, __get__purchaseEventName, __get__buttonName, __get__oopsMsgPath, __get__customPurchaseHandler;
        function BuyItemButtonBase (item, itemMC, prompt, callback, purchaseEventName, buttonName, oopsMsgPath, purchaseSound, customPurchaseHandler) {
            _shell = _global.getCurrentShell();
            _airtower = _global.getCurrentAirtower();
            _interface = _global.getCurrentInterface();
            _engine = _global.getCurrentEngine();
            _party = _global.getCurrentParty();
            _itemID = item.id;
            _member = item.member;
            _itemMC = itemMC;
            _prompt = ((prompt != undefined) ? (prompt) : true);
            _callback = callback;
            ITEM_PURCHASE_EVENT = purchaseEventName;
            if (buttonName != undefined) {
                CLAIM_BUTTON_INSTANCE_NAME = buttonName;
            }
            if (oopsMsgPath != OOPS_MESSAGE_PATH) {
                OOPS_MESSAGE_PATH = oopsMsgPath;
            }
            _customPurchaseHandler = customPurchaseHandler;
            _purchaseSFX = purchaseSound;
        }
        function get type() {
            return(undefined);
        }
        function get itemMC() {
            return(_itemMC);
        }
        function get itemID() {
            return(_itemID);
        }
        function set customPurchase(customPurchase) {
            //return(__get__customPurchase());
        }
        function set itemMC(itemMC) {
            _itemMC = itemMC;
            //return(this.itemMC);
        }
        function set prompt(prompt) {
            _prompt = prompt;
            //return(__get__prompt());
        }
        function set callback(callback) {
            _callback = callback;
            //return(__get__callback());
        }
        function set purchaseCallback(callback) {
            _purchaseCallback = callback;
            //return(__get__purchaseCallback());
        }
        function set purchaseSound(purchaseSFX) {
            _purchaseSFX = purchaseSFX;
            //return(__get__purchaseSound());
        }
        function set purchaseEventName(purchaseEventName) {
            ITEM_PURCHASE_EVENT = purchaseEventName;
            //return(__get__purchaseEventName());
        }
        function set buttonName(buttonName) {
            CLAIM_BUTTON_INSTANCE_NAME = buttonName;
            //return(__get__buttonName());
        }
        function set oopsMsgPath(oopsMsgPath) {
            OOPS_MESSAGE_PATH = oopsMsgPath;
            //return(__get__oopsMsgPath());
        }
        function set customPurchaseHandler(handler) {
            _customPurchaseHandler = handler;
            //return(__get__customPurchaseHandler());
        }
        function setCustomPurchase(customPurchase) {
            return(this);
        }
        function setItemMC(itemMC) {
            _itemMC = itemMC;
            return(this);
        }
        function setPrompt(prompt) {
            _prompt = prompt;
            return(this);
        }
        function setCallback(callback) {
            _callback = callback;
            return(this);
        }
        function setPurchaseCallback(callback) {
            _purchaseCallback = callback;
            return(this);
        }
        function setPurchaseSound(purchaseSFX) {
            _purchaseSFX = purchaseSFX;
            return(this);
        }
        function setPurchaseEventName(purchaseEventName) {
            ITEM_PURCHASE_EVENT = purchaseEventName;
            return(this);
        }
        function setButtonName(buttonName) {
            CLAIM_BUTTON_INSTANCE_NAME = buttonName;
            return(this);
        }
        function setOopsMsgPath(oopsMsgPath) {
            OOPS_MESSAGE_PATH = oopsMsgPath;
            return(this);
        }
        function setCustomPurchaseHandler(handler) {
            _customPurchaseHandler = handler;
            return(this);
        }
        function create() {
        }
        function checkPurchaseOfItem() {
            if (_purchaseSFX != undefined) {
                _party.BaseParty.playSound(_itemMC, _purchaseSFX);
            }
            if (_member && (!_shell.isMyPlayerMember())) {
                _shell.showAs3Content(_interface.getFilePath(OOPS_MESSAGE_PATH), OOPS_MESSAGE_PATH);
            } else {
                buyItem();
            }
        }
        function buyItem() {
        }
        function addItemPurchasedListener() {
            trace("BuyItemButtonBase.addItemPurchasedListener");
            _buyItemDelegate = com.clubpenguin.util.Delegate.create(this, ((_customPurchaseHandler != undefined) ? (_customPurchaseHandler) : (onInventoryBought)));
            _shell.addListener(ITEM_PURCHASE_EVENT, _buyItemDelegate);
        }
        function removeItemPurchasedListener() {
            com.clubpenguin.util.Log.debug("BuyItemButtonBase.removeItemPurchasedListener");
            _shell.removeListener(ITEM_PURCHASE_EVENT, _buyItemDelegate);
        }
        function onInventoryBought(event) {
            trace("BuyItemButtonBase.onInventoryBought");
            _shell.removeListener(ITEM_PURCHASE_EVENT, _buyItemDelegate);
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
            }
        }
        function destroy() {
            _shell.removeListener(ITEM_PURCHASE_EVENT, _buyItemDelegate);
            _itemMC[CLAIM_BUTTON_INSTANCE_NAME].onRelease = null;
        }
        var CLASSNAME = "BuyItemButtonBase";
        var CLAIM_BUTTON_INSTANCE_NAME = "claim_btn";
        var CLAIM_BUTTON_TEXT_LABEL = "claim_text";
        var OOPS_MESSAGE_PATH = "oops_general";
    }
