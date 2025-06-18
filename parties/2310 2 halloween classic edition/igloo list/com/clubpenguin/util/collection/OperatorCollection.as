//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.util.collection.OperatorCollection extends com.clubpenguin.util.collection.Collection
    {
        var _operatorList, _cachedItems, changed, itemsAdded, itemsRemoved, itemUpdated;
        function OperatorCollection (itemType) {
            super(itemType);
            _operatorList = [];
            _cachedItems = null;
            changed.add(com.clubpenguin.util.Delegate.create(this, onChanged));
            itemsAdded.add(com.clubpenguin.util.Delegate.create(this, onChanged));
            itemsRemoved.add(com.clubpenguin.util.Delegate.create(this, onChanged));
            itemUpdated.add(com.clubpenguin.util.Delegate.create(this, onChanged));
        }
        function onChanged() {
            _cachedItems = null;
        }
        function clearOperators() {
            _operatorList = [];
            _cachedItems = null;
        }
        function addOperator(operator) {
            _operatorList.push(operator);
            _cachedItems = null;
        }
        function setOperators(operatorList) {
            _operatorList = operatorList.slice();
            if (operatorList == null) {
                _operatorList = [];
            }
            _cachedItems = null;
        }
        function getItems() {
            var _local_5 = super.getItems();
            if (_cachedItems != null) {
                return(_cachedItems);
            }
            var _local_3 = 0;
            while (_local_3 < _operatorList.length) {
                var _local_4 = _operatorList[_local_3];
                _local_5 = _local_4.apply(_local_5);
                _local_3++;
            }
            _cachedItems = _local_5;
            return(_local_5);
        }
        function getAllItems() {
            return(super.getItems());
        }
        function getSize() {
            return(getItems().length);
        }
        function toString() {
            return("[OperatorCollection]");
        }
    }
