//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.ui.components.Pagination extends com.clubpenguin.util.EventDispatcher
    {
        var _rows, _columns, _itemWidth, _itemHeight, _xPadding, _yPadding, _itemsPerPage, _items, dispatchEvent;
        function Pagination (rows, columns, itemWidth, itemHeight, xPadding, yPadding) {
            super();
            _rows = rows || 5;
            _columns = columns || 5;
            _itemWidth = itemWidth || 50;
            _itemHeight = itemHeight || 50;
            _xPadding = xPadding || 15;
            _yPadding = yPadding || 15;
            _itemsPerPage = _rows * _columns;
            _items = [];
        }
        function addItem(item) {
            if ((item != undefined) && (typeof(item) == "movieclip")) {
                _items.push(item);
                item._visible = false;
            }
        }
        function getItems() {
            var _local_3 = new Array();
            var _local_2 = 0;
            while (_local_2 < _items.length) {
                _local_3.push(_items[_local_2]);
                _local_2++;
            }
            return(_local_3);
        }
        function positionItems() {
            var _local_3 = 0;
            var _local_6 = 0;
            var _local_4;
            var _local_5 = 0;
            var _local_2 = 0;
            while (_local_2 < _items.length) {
                _local_4 = _items[_local_2];
                _local_4._x = (_local_2 % _columns) * (_itemWidth + _xPadding);
                _local_4._y = _local_3 * (_itemHeight + _yPadding);
                if ((_local_2 % _columns) == (_columns - 1)) {
                    _local_3++;
                }
                _local_5++;
                if (_local_5 == _itemsPerPage) {
                    _local_5 = 0;
                    _local_3 = 0;
                    _local_6++;
                }
                _local_2++;
            }
        }
        function hideAllItems() {
            var _local_2 = 0;
            while (_local_2 < _items.length) {
                _items[_local_2]._visible = false;
                _local_2++;
            }
        }
        function showNextPage() {
            if ((currentPage == null) || (currentPage == numPages)) {
                return(undefined);
            }
            var _local_2 = currentPage + 1;
            hidePage(currentPage);
            showPage(_local_2);
        }
        function showPreviousPage() {
            if ((currentPage == null) || (currentPage == 1)) {
                return(undefined);
            }
            var _local_2 = currentPage - 1;
            hidePage(currentPage);
            showPage(_local_2);
        }
        function showPage(pageNumber) {
            if (((pageNumber == undefined) || (pageNumber < 1)) || (pageNumber > numPages)) {
                return(undefined);
            }
            if (currentPage != null) {
                hidePage(currentPage);
            }
            var _local_3 = _itemsPerPage * (pageNumber - 1);
            var _local_4 = _local_3 + _itemsPerPage;
            var _local_7 = [];
            var _local_2 = _local_3;
            while (_local_2 < _local_4) {
                _local_7.push(_items[_local_2]);
                _items[_local_2]._visible = true;
                _local_2++;
            }
            _currentPage = pageNumber;
            dispatchEvent({type:CHANGE, currentPage:currentPage, items:_local_7});
        }
        function hidePage(pageNumber) {
            if (((pageNumber == undefined) || (pageNumber < 1)) || (pageNumber > numPages)) {
                return(undefined);
            }
            if ((currentPage != null) && (pageNumber == currentPage)) {
                _currentPage = null;
            }
            var _local_3 = _itemsPerPage * (pageNumber - 1);
            var _local_4 = _local_3 + _itemsPerPage;
            var _local_2 = _local_3;
            while (_local_2 < _local_4) {
                _items[_local_2]._visible = false;
                _local_2++;
            }
        }
        function get currentPage() {
            return(_currentPage);
        }
        function get numPages() {
            return(Math.ceil(_items.length / _itemsPerPage));
        }
        static var CHANGE = "change";
        var _currentPage = null;
    }
