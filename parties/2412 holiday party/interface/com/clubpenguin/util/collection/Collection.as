//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.util.collection.Collection implements com.clubpenguin.util.collection.ICollection
    {
        var _itemLookup, _itemType, _itemCount, _totalItemCount, changed, itemsAdded, itemsRemoved;
        function Collection (itemType) {
            _itemLookup = {};
            _itemType = itemType;
            _itemCount = 0;
            _totalItemCount = 0;
            changed = new org.osflash.signals.Signal();
            itemsAdded = new org.osflash.signals.Signal(Array);
            itemsRemoved = new org.osflash.signals.Signal(Array);
        }
        function destroy(destroyItems) {
            for (var _local_2 in _itemLookup) {
                if (destroyItems) {
                    _itemLookup[_local_2].destroy();
                }
                _itemLookup[_local_2] = null;
            }
            _itemCount = 0;
            _itemLookup = {};
        }
        function refresh() {
            changed.dispatch();
        }
        function getType() {
            return(_itemType);
        }
        function getSize() {
            return(_itemCount);
        }
        function isEmpty() {
            return(_itemCount == 0);
        }
        function addItem(item, suppressSignal) {
            if (_itemLookup[item.getID()] == null) {
                _itemLookup[item.getID()] = item;
                if (org.osflash.signals.Signal(_itemLookup[item.getID()].removed)) {
                    org.osflash.signals.Signal(_itemLookup[item.getID()].removed).add(onItemRemoved, this);
                }
                _itemCount++;
            } else {
                updateItem(item);
            }
            if (suppressSignal != true) {
                changed.dispatch();
                itemsAdded.dispatch([item]);
            }
            return(item);
        }
        function updateItem(item) {
            _itemLookup[item.getID()].update(item);
        }
        function onItemRemoved(itemToremove, surpressSignal) {
            removeItem(itemToremove, false, surpressSignal);
        }
        function add(itemsToAdd) {
            var _local_4 = [];
            var _local_2 = 0;
            while (_local_2 < itemsToAdd.length) {
                addItem(itemsToAdd[_local_2], true);
                _local_4.push(itemsToAdd[_local_2]);
                _local_2++;
            }
            changed.dispatch();
            itemsAdded.dispatch(_local_4);
        }
        function removeItem(item, destroyItem, suppressSignal) {
            var _local_3 = _itemLookup[item.getID()];
            if (destroyItem) {
                item.destroy();
            }
            if (_itemLookup[item.getID()]) {
                _itemCount--;
            }
            _itemLookup[item.getID()] = null;
            delete _itemLookup[item.getID()];
            if (suppressSignal != true) {
                changed.dispatch();
                itemsRemoved.dispatch([item]);
            }
            return(_local_3);
        }
        function remove(itemsToRemove, destroyItems) {
            var _local_4 = [];
            var _local_2 = 0;
            while (_local_2 < itemsToRemove.length) {
                _local_4.push(removeItem(itemsToRemove[_local_2], destroyItems, true));
                _local_2++;
            }
            changed.dispatch();
            itemsRemoved.dispatch([_local_4]);
        }
        function clear(destroyItems) {
            _itemLookup = {};
        }
        function getItems() {
            var _local_2 = [];
            for (var _local_3 in _itemLookup) {
                if (_itemLookup[_local_3]) {
                    _local_2.push(_itemLookup[_local_3]);
                }
            }
            return(_local_2);
        }
        function getItemByID(itemID) {
            return(_itemLookup[itemID]);
        }
        function toString() {
            return("[Collection] " + _itemType);
        }
        function getChanged() {
            return(changed);
        }
        function getItemsAdded() {
            return(itemsAdded);
        }
        function getItemsRemoved() {
            return(itemsRemoved);
        }
        function contains(vo) {
            return(getItemByID(vo.getID()) != null);
        }
        var name = "noname";
    }
