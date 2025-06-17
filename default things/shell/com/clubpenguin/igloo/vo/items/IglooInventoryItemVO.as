//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.igloo.vo.items.IglooInventoryItemVO implements com.clubpenguin.igloo.component.vo.IIconVO
    {
        var _itemVO, typeValue, isSpecial, _usedCount, updated, totalCount, purchaseDate;
        function IglooInventoryItemVO (itemVO) {
            _itemVO = itemVO;
            typeValue = _itemVO.type.value;
            isSpecial = false;
            _usedCount = 0;
            updated = new org.osflash.signals.Signal(com.clubpenguin.util.IVO);
        }
        function get itemVO() {
            return(_itemVO);
        }
        function get usedCount() {
            return(_usedCount);
        }
        function set usedCount(value) {
            if (_usedCount != value) {
                _usedCount = value;
                updated.dispatch(this);
            }
            //return(usedCount);
        }
        function get type() {
            return(_itemVO.type);
        }
        function destroy() {
        }
        function getID() {
            return(_itemVO.type.value + _itemVO.getID());
        }
        function updateQuantity(newQuantity, lastPurchased) {
            totalCount = newQuantity;
            purchaseDate = lastPurchased;
            updated.dispatch(this);
        }
        function update(vo) {
            var _local_2 = com.clubpenguin.igloo.vo.items.IglooInventoryItemVO(vo);
            purchaseDate = _local_2.purchaseDate;
            usedCount = (_local_2.usedCount);
            _itemVO.update(_local_2.itemVO);
            typeValue = _local_2.type.value;
            updated.dispatch(this);
        }
        function equals(vo) {
            return(vo.getID() == getID());
        }
        function getURL() {
            return(_itemVO.iconURL);
        }
        function toString() {
            return((((((((("[IglooInventoryItemVO] " + _itemVO.name) + "  type: ") + type) + "  purchaseDate: ") + purchaseDate) + " count: ") + totalCount) + " usedCount: ") + usedCount);
        }
        var isRedeemed = false;
    }
