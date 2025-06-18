//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.igloo.component.scrollpane.view.BufferedPaneView extends com.clubpenguin.igloo.component.scrollpane.view.PaneView
    {
        var _itemClips, _itemClipMap, _freeItemRenderers, _maxItemRenderers, getItemsPerRow, itemClipsHolderMC, _itemRendererLinkageID, onItemClicked, _style, _itemRendererWidth, _loadQueue, maskMC, itemClicked, _itemList, virtualWidth, _width, virtualHeight, getItemsPerColumn, _itemRendererHeight, _height, _currentPosition, _numItemRenderers, _currentStartIndex, _currentEndIndex;
        function BufferedPaneView (mc, width, height, itemRenderer, style) {
            super(mc, width, height, itemRenderer, style);
            _itemClips = [];
            _itemClipMap = {};
            _freeItemRenderers = [];
            _maxItemRenderers = getItemsPerRow() + (NUM_BUFFERED_ITEMS * 2);
            var _local_3 = 0;
            while (_local_3 < _maxItemRenderers) {
                var _local_4 = com.clubpenguin.igloo.component.renderer.IItemRenderer(itemClipsHolderMC.attachMovie(_itemRendererLinkageID, "item" + _local_3, _local_3));
                _local_4.getItemClickedSignal().add(onItemClicked, this);
                MovieClip(_local_4)._x = (_local_3 * _itemRendererWidth) + _style.itemRendererXOffset;
                MovieClip(_local_4)._y = _style.itemRendererYOffset;
                MovieClip(_local_4).cacheAsBitmap = true;
                setDebugIndex(_local_4, _local_3 - NUM_BUFFERED_ITEMS);
                _itemClipMap[_local_3 - NUM_BUFFERED_ITEMS] = _local_4;
                _local_3++;
            }
        }
        function setDebugIndex(clip, n) {
        }
        function destroy() {
            removeRenderers();
            _loadQueue.clear();
            com.clubpenguin.igloo.component.renderer.IconLoader.getInstance().clearInProgressLoads();
            itemClipsHolderMC.removeMovieClip();
            itemClipsHolderMC = null;
            maskMC.removeMovieClip();
            maskMC = null;
            itemClicked.removeAll();
            itemClicked = null;
        }
        function update(itemList, removeAllRenderers) {
            _reloadAll = true;
            _itemList = itemList;
            if (removeAllRenderers) {
                removeRenderers();
            }
            _loadQueue.clear();
            com.clubpenguin.igloo.component.renderer.IconLoader.getInstance().clearInProgressLoads();
            if (_style.isVertical) {
                virtualWidth = _width + _style.itemRendererXOffset;
                virtualHeight = (_itemRendererHeight * ((itemList.length - getItemsPerColumn()) + 2)) + _style.itemRendererYOffset;
            } else if (_style.isHorizontal) {
                virtualWidth = (_itemRendererWidth * ((itemList.length - getItemsPerRow()) + 2)) + _style.itemRendererXOffset;
                virtualHeight = _height + _style.itemRendererYOffset;
            }
            if (_currentPosition == undefined) {
                _currentPosition = 0;
            }
        }
        function removeRenderers() {
            if (_maxItemRenderers > 0) {
                var _local_2 = 0;
                while (_local_2 < _maxItemRenderers) {
                    MovieClip(_itemClipMap[_local_2]).destroy();
                    MovieClip(_itemClipMap[_local_2]).removeMovieClip();
                    _local_2++;
                }
            }
            _itemClips = [];
            _itemClipMap = {};
            _numItemRenderers = 0;
            virtualWidth = 0;
            virtualHeight = 0;
            _currentStartIndex = null;
            _currentEndIndex = null;
        }
        function pruneItemRenderers(startIndex, endIndex) {
            var _local_7 = {};
            var _local_3 = _currentStartIndex;
            while (_local_3 <= _currentEndIndex) {
                if (!((_local_3 <= endIndex) && (_local_3 >= startIndex))) {
                    var _local_4 = _itemClipMap[_local_3];
                    if (_local_4 != null) {
                        _freeItemRenderers.push(_local_4);
                        _itemClipMap[_local_3] = null;
                    }
                }
                _local_3++;
            }
            var _local_2 = startIndex;
            while (_local_2 <= endIndex) {
                if (_itemClipMap[_local_2] == null) {
                    var _local_4 = _freeItemRenderers.shift();
                    if (_local_4 != null) {
                        _itemClipMap[_local_2] = _local_4;
                        setDebugIndex(_local_4, _local_2);
                        _local_7[_local_2] = true;
                    }
                }
                _local_2++;
            }
            return(_local_7);
        }
        function updatePosition(newPosition) {
            if (newPosition == undefined) {
                newPosition = 0;
            }
            if (_style.scrollType == com.clubpenguin.igloo.component.scrollpane.style.ScrollPaneStyle.VERTICAL) {
                scrollVertically(newPosition);
            } else {
                scrollHorizontally(newPosition);
            }
        }
        function scrollHorizontally(newXPosition) {
            var _local_10 = Math.floor(newXPosition * ((_itemList.length - getItemsPerRow()) + 2));
            var _local_6 = _local_10 - NUM_BUFFERED_ITEMS;
            var _local_7 = (_local_6 + _maxItemRenderers) - 1;
            var _local_8 = ((-newXPosition) * virtualWidth) + _style.itemRendererXOffset;
            var _local_5 = 0;
            var _local_11 = 0;
            if (_currentStartIndex == undefined) {
                _currentStartIndex = _local_6;
                _currentEndIndex = _local_7;
            }
            var _local_9 = pruneItemRenderers(_local_6, _local_7);
            _currentStartIndex = _local_6;
            _currentEndIndex = _local_7;
            var _local_2 = _local_6;
            while (_local_2 <= _local_7) {
                var _local_4 = com.clubpenguin.igloo.component.renderer.IItemRenderer(_itemClipMap[_local_2]);
                var _local_3 = MovieClip(_local_4);
                _local_5 = _local_8 + (_itemRendererWidth * _local_2);
                _local_3._x = _local_5;
                _local_3._y = _style.itemRendererYOffset;
                if (((_local_2 >= 0) && (_local_2 < _itemList.length)) && ((_local_9[_local_2] == true) || (_reloadAll))) {
                    _local_4.setVO(_itemList[_local_2], _loadQueue);
                    _local_3._visible = true;
                } else if (_local_2 >= _itemList.length) {
                    _local_3._visible = false;
                }
                _local_2++;
            }
            _reloadAll = false;
        }
        function scrollVertically(newYPosition) {
        }
        function toString() {
            return("[BufferedPaneView]");
        }
        static var NUM_BUFFERED_ITEMS = 12;
        var _reloadAll = false;
    }
