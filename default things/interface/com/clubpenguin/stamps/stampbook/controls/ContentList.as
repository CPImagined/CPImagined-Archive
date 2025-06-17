//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.stamps.stampbook.controls.ContentList extends com.clubpenguin.stamps.stampbook.controls.List
    {
        var _padding, _rendererWidth, _listWidth, _rendererHeight, _listHeight, _selectedIndex, _totalRenderersPerPage, _dataProvider, scrollBar, _scrollBarWidth, _height, _scrollBarPadding, _gridHolder, dispatchEvent, _initialized, _itemRendererList, _itemRendererLinkage;
        function ContentList () {
            super();
        }
        function drawGrid() {
            var _local_3 = Math.floor(_listWidth / (_rendererWidth + _padding));
            var _local_2 = Math.floor(_listHeight / (_rendererHeight + _padding));
            _selectedIndex = 0;
            _totalRenderersPerPage = _local_3 * _local_2;
            if (_dataProvider.length > 0) {
                loadContent();
            }
            onListInitiated();
        }
        function onListInitiated() {
            scrollBar.setSize(_scrollBarWidth, _height);
            scrollBar._x = (_gridHolder._x + _gridHolder._width) + _scrollBarPadding;
            scrollBar._y = 0;
            dispatchEvent({type:"loadInit"});
        }
        function onItemClick(event) {
            var _local_2 = com.clubpenguin.stamps.stampbook.controls.ListButton(event.target);
            var _local_3 = event.data;
            dispatchEvent({type:"itemClick", category:_local_3.getName(), index:_local_2.indexNumber});
        }
        function loadContent() {
            if (!_initialized) {
                return(undefined);
            }
            var _local_5 = Math.floor(_listWidth / (_rendererWidth + _padding));
            var _local_10 = Math.floor(_listHeight / (_rendererHeight + _padding));
            var _local_8 = _selectedIndex + 1;
            var _local_9 = Math.ceil(_dataProvider.length / _totalRenderersPerPage);
            scrollBar.downBtn.enabled = _local_8 < _local_9;
            scrollBar.upBtn.enabled = _local_8 > 1;
            scrollBar._visible = _dataProvider.length > _totalRenderersPerPage;
            var _local_6 = _dataProvider.slice(_selectedIndex * _totalRenderersPerPage, (_selectedIndex * _totalRenderersPerPage) + _totalRenderersPerPage);
            if (_itemRendererList != undefined) {
                var _local_7 = _itemRendererList.length;
                var _local_2 = 0;
                while (_local_2 < _local_7) {
                    _itemRendererList[_local_2].removeEventListener("press", onItemClick, this);
                    _local_2++;
                }
            }
            _itemRendererList = [];
            var _local_2 = 0;
            while (_local_2 < _totalRenderersPerPage) {
                var _local_4 = _gridHolder["itemRenderer" + _local_2];
                if (_local_4) {
                    _local_4.removeMovieClip();
                }
                _local_4 = _gridHolder.attachMovie(_itemRendererLinkage, "itemRenderer" + _local_2, _gridHolder.getNextHighestDepth());
                var _local_3 = com.clubpenguin.stamps.stampbook.controls.ListButton(_local_4);
                _local_3.addEventListener("press", onItemClick, this);
                _local_3._x = (_local_2 % _local_5) * (_rendererWidth + _padding);
                _local_3._y = Math.floor(_local_2 / _local_5) * (_rendererHeight + _padding);
                if (_local_6[_local_2] == undefined) {
                    _local_3._visible = false;
                } else {
                    _local_3._visible = true;
                    _local_3.setModel(_local_6[_local_2]);
                    _local_3.indexNumber = (_totalRenderersPerPage * _selectedIndex) + _local_2;
                    _itemRendererList.push(_local_3);
                }
                _local_2++;
            }
        }
        static var CLASS_REF = com.clubpenguin.stamps.stampbook.controls.ContentList;
        static var LINKAGE_ID = "ContentList";
    }
