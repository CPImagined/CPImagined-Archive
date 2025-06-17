//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.hud.epfmission.vo.EPFInventoryItemVO implements com.clubpenguin.util.IVO
    {
        var _id, _itemID, _type, _assetURL, _isSelected, _isActivated, _isUsed, itemSelected, itemDeslected, itemActivated, itemDeactivated, itemUsed;
        function EPFInventoryItemVO (id, itemID, type, assetURL) {
            _id = id;
            _itemID = itemID;
            switch (type) {
                case ITEM_TYPE_EFFECT : 
                case ITEM_TYPE_USEABLE : 
                case ITEM_TYPE_TEMPORARY : 
                    _type = type;
                    break;
            }
            _assetURL = assetURL;
            _isSelected = false;
            _isActivated = false;
            _isUsed = false;
            itemSelected = new org.osflash.signals.Signal(com.clubpenguin.hud.epfmission.vo.EPFInventoryItemVO);
            itemDeslected = new org.osflash.signals.Signal(com.clubpenguin.hud.epfmission.vo.EPFInventoryItemVO);
            itemActivated = new org.osflash.signals.Signal(com.clubpenguin.hud.epfmission.vo.EPFInventoryItemVO);
            itemDeactivated = new org.osflash.signals.Signal(com.clubpenguin.hud.epfmission.vo.EPFInventoryItemVO);
            itemUsed = new org.osflash.signals.Signal(com.clubpenguin.hud.epfmission.vo.EPFInventoryItemVO);
        }
        function destroy() {
        }
        function getID() {
            return(_id);
        }
        function canBePutInInventory() {
            return(_type != ITEM_TYPE_TEMPORARY);
        }
        function get isActive() {
            if ((type == ITEM_TYPE_EFFECT) && (_isActivated)) {
                return(true);
            }
            return(false);
        }
        function activate() {
            if (type == ITEM_TYPE_EFFECT) {
                _isActivated = true;
                itemActivated.dispatch(this);
            }
        }
        function deactivate() {
            if (type == ITEM_TYPE_EFFECT) {
                _isActivated = false;
                itemDeactivated.dispatch(this);
            }
        }
        function set isUsed(used) {
            if ((type == ITEM_TYPE_USEABLE) && (_isUsed != used)) {
                _isUsed = used;
                itemUsed.dispatch(this);
            }
            //return(isUsed);
        }
        function set isSelected(selected) {
            if (_isSelected == selected) {
                return;
            }
            _isSelected = selected;
            if (selected) {
                itemSelected.dispatch(this);
            } else {
                itemDeslected.dispatch(this);
            }
            //return(isSelected);
        }
        function get isSelected() {
            return(_isSelected);
        }
        function get isUsed() {
            return(_isUsed);
        }
        function get itemID() {
            return(_itemID);
        }
        function get type() {
            return(_type);
        }
        function get assetURL() {
            return(_assetURL);
        }
        function update(vo) {
        }
        function toString() {
            return((((((((("[EPFInventoryItemVO] id: " + _id) + "  itemID: ") + _itemID) + "  isSelected: ") + isSelected) + "  isUsed: ") + _isUsed) + "  type: ") + _type);
        }
        function equals(vo) {
            var _local_2 = com.clubpenguin.hud.epfmission.vo.EPFInventoryItemVO(vo);
            return(_itemID == _local_2.itemID);
        }
        static var ITEM_TYPE_EFFECT = "effect";
        static var ITEM_TYPE_USEABLE = "useable";
        static var ITEM_TYPE_TEMPORARY = "temporary";
    }
