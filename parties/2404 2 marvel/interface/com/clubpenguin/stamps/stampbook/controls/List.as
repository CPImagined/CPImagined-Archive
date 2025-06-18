//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.stamps.stampbook.controls.List extends MovieClip
    {
        var _dataProvider, _x, _y, _listWidth, _listHeight, _itemRendererLinkage, _rendererWidth, _rendererHeight, _padding, _useHandCursor, _selectedIndex, _shell, _gridHolder, createEmptyMovieClip, getNextHighestDepth, scrollBar, _rendererPaddedWidth, _rendererPaddedHeight, _numberOfColumns, _totalRenderersPerPage, _height, dispatchEvent, _itemRendererList;
        function List () {
            super();
            com.clubpenguin.util.EventDispatcher.initialize(this);
        }
        function onLoad() {
            configUI();
        }
        function get dataProvider() {
            return(_dataProvider);
        }
        function set dataProvider(value) {
            _dataProvider = value;
            loadContent();
            //return(dataProvider);
        }
        function move(x, y) {
            _x = x;
            _y = y;
        }
        function init(w, h, renderer, rendererW, rendererH, padding, useHandCursor) {
            _listWidth = w;
            _listHeight = h;
            _itemRendererLinkage = renderer;
            _rendererWidth = rendererW;
            _rendererHeight = rendererH;
            _padding = padding;
            _useHandCursor = ((useHandCursor != undefined) ? (useHandCursor) : true);
            if (_initialized) {
                populateUI();
            }
        }
        function reset() {
            _selectedIndex = 0;
        }
        function configUI() {
            if (_dataProvider == null) {
                _dataProvider = [];
            }
            _shell = com.clubpenguin.stamps.stampbook.util.ShellLookUp.shell;
            _gridHolder = this.createEmptyMovieClip("gridHolder", getNextHighestDepth());
            scrollBar.addEventListener("down", onNextPage, this);
            scrollBar.addEventListener("up", onPreviousPage, this);
            _initialized = true;
            if (_itemRendererLinkage != undefined) {
                populateUI();
            }
        }
        function onPreviousPage(event) {
            _selectedIndex--;
            loadContent();
        }
        function onNextPage(event) {
            _selectedIndex++;
            loadContent();
        }
        function populateUI() {
            drawGrid();
        }
        function drawGrid() {
            _rendererPaddedWidth = _rendererWidth + _padding;
            _rendererPaddedHeight = _rendererHeight + _padding;
            _numberOfColumns = Math.floor(_listWidth / _rendererPaddedWidth);
            var _local_2 = Math.floor(_listHeight / _rendererPaddedHeight);
            _selectedIndex = 0;
            _totalRenderersPerPage = _numberOfColumns * _local_2;
            if (_dataProvider.length > 0) {
                loadContent();
            }
            onListInitiated();
        }
        function onListInitiated() {
            scrollBar.setSize(_scrollBarWidth, _height);
            scrollBar._x = (_gridHolder._x + _gridHolder._width) + _rendererWidth;
            scrollBar._y = 0;
            dispatchEvent({type:"loadInit"});
        }
        function onItemRollOver(event) {
            dispatchEvent(event);
        }
        function onItemRollOut(event) {
            dispatchEvent(event);
        }
        function loadContent() {
            if (!_initialized) {
                return(undefined);
            }
            var _local_7 = _selectedIndex + 1;
            var _local_8 = Math.ceil(_dataProvider.length / _totalRenderersPerPage);
            scrollBar.downBtn.enabled = _local_7 < _local_8;
            scrollBar.downBtn._visible = _local_7 < _local_8;
            scrollBar.upBtn.enabled = _local_7 > 1;
            scrollBar.upBtn._visible = _local_7 > 1;
            scrollBar._visible = _dataProvider.length > _totalRenderersPerPage;
            var _local_6 = _dataProvider.slice(_selectedIndex * _totalRenderersPerPage, (_selectedIndex * _totalRenderersPerPage) + _totalRenderersPerPage);
            if (_itemRendererList != undefined) {
                var _local_5 = _itemRendererList.length;
                var _local_3 = 0;
                while (_local_3 < _local_5) {
                    _itemRendererList[_local_3].removeEventListener("over", onItemRollOver, this);
                    _itemRendererList[_local_3].removeEventListener("out", onItemRollOut, this);
                    _local_3++;
                }
            }
            _itemRendererList = [];
            var _local_3 = 0;
            while (_local_3 < _totalRenderersPerPage) {
                var _local_2 = _gridHolder["itemRenderer" + _local_3];
                if (_local_2) {
                    _local_2.removeMovieClip();
                }
                _local_2 = _gridHolder.attachMovie(_itemRendererLinkage, "itemRenderer" + _local_3, _gridHolder.getNextHighestDepth());
                _local_2.useHandCursor = _useHandCursor;
                _local_2.addEventListener("over", onItemRollOver, this);
                _local_2.addEventListener("out", onItemRollOut, this);
                _local_2.move(((_local_3 % _numberOfColumns) * _rendererPaddedWidth) + (_rendererWidth / 2), (Math.floor(_local_3 / _numberOfColumns) * _rendererPaddedHeight) + (_rendererHeight / 2));
                var _local_4 = _local_6[_local_3];
                if ((_local_4.getID() == undefined) && (_local_4.id == undefined)) {
                    _local_2._visible = false;
                } else {
                    _local_2._visible = true;
                    _local_2.setModel(_local_4);
                    _itemRendererList.push(_local_2);
                }
                _local_3++;
            }
        }
        static var CLASS_REF = com.clubpenguin.stamps.stampbook.controls.List;
        static var LINKAGE_ID = "List";
        var _initialized = false;
        var _scrollBarWidth = 30;
        var _scrollBarPadding = 5;
    }
