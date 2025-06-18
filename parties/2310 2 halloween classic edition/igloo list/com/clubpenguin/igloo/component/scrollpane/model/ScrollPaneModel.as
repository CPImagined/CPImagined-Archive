//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.igloo.component.scrollpane.model.ScrollPaneModel
    {
        var _collection, _style, itemsUpdated, itemsPerPageChanged, postionUpdated, scrollPaneReset, _currentPositionAsPercentage, _numberOfItemsPerRow, _numberOfItemsPerColumn;
        function ScrollPaneModel (collection, style) {
            _collection = collection;
            com.clubpenguin.util.collection.Collection(_collection).changed.add(onCollectionChanged, this);
            _style = style;
            trace("[Igloo] ScrollPaneModel size:" + _collection.getSize());
            itemsUpdated = new org.osflash.signals.Signal();
            itemsPerPageChanged = new org.osflash.signals.Signal();
            postionUpdated = new org.osflash.signals.Signal(Number, Number);
            scrollPaneReset = new org.osflash.signals.Signal();
        }
        function get currentPosition() {
            return(_currentPositionAsPercentage);
        }
        function destroy() {
            itemsUpdated.removeAll();
            itemsUpdated = null;
            postionUpdated.removeAll();
            postionUpdated = null;
            scrollPaneReset.removeAll();
            scrollPaneReset = null;
            itemsPerPageChanged.removeAll();
            itemsPerPageChanged = null;
            com.clubpenguin.util.collection.Collection(_collection).changed.remove(onCollectionChanged, this);
            _collection = null;
        }
        function onCollectionChanged() {
            trace("[Igloo] ScrollPaneModel.onCollectionChanged size:" + _collection.getSize());
            itemsUpdated.dispatch();
            updatePosition(_currentPositionAsPercentage);
        }
        function refresh() {
            itemsUpdated.dispatch();
        }
        function addItems() {
        }
        function getVisibleItems() {
            return(_collection.getItems());
        }
        function getTotalNumberOfItems() {
            return(_collection.getSize());
        }
        function updatePosition(newPos) {
            _currentPositionAsPercentage = newPos;
            postionUpdated.dispatch(_currentPositionAsPercentage);
        }
        function setNumberOfItemsPerPage(itemsPerRow, itemsPerColumn) {
            trace("ScrollPaneModel.setNumberOfItemsPerPage");
            _numberOfItemsPerRow = itemsPerRow;
            _numberOfItemsPerColumn = itemsPerColumn;
            itemsPerPageChanged.dispatch();
        }
        function getNumberOfItemsPerRow() {
            return(_numberOfItemsPerRow);
        }
        function getNumberOfItemsPerColumn() {
            return(_numberOfItemsPerColumn);
        }
        function resetScrollPane() {
            updatePosition(0);
            scrollPaneReset.dispatch();
        }
        function getStyle() {
            return(_style);
        }
        function get isVertical() {
            return(_style.isVertical);
        }
        function get isHorizontal() {
            return(_style.isHorizontal);
        }
        function toString() {
            return("[ScrollPaneModel]");
        }
        static var ICON_CONTAINER_LINKAGE_ID = "";
    }
