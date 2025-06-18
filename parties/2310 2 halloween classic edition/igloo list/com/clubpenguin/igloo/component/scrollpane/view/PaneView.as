//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.igloo.component.scrollpane.view.PaneView extends MovieClip
    {
        var _width, _height, canvasMC, _itemClips, _style, _currentPosition, _itemRendererLinkageID, _itemRendererWidth, _itemRendererHeight, itemClipsHolderMC, maskMC, itemClicked, _loadQueue, _itemList, virtualWidth, virtualHeight;
        function PaneView (mc, width, height, itemRenderer, style) {
            super();
            _width = width;
            _height = height;
            canvasMC = mc;
            _itemClips = [];
            _style = style;
            _currentPosition = 0;
            _itemRendererLinkageID = itemRenderer.LINKAGE_ID;
            _itemRendererWidth = itemRenderer.WIDTH;
            _itemRendererHeight = itemRenderer.HEIGHT;
            itemClipsHolderMC = canvasMC.createEmptyMovieClip("itemClipsHolderMC", canvasMC.getNextHighestDepth());
            maskMC = canvasMC.createEmptyMovieClip("maskMC", canvasMC.getNextHighestDepth());
            draw();
            itemClipsHolderMC.setMask(maskMC);
            leftLimit = -_itemRendererWidth;
            rightLimit = _width + _itemRendererWidth;
            topLimit = -_itemRendererHeight;
            bottomLimit = _height + _itemRendererHeight;
            itemClicked = new org.osflash.signals.Signal();
            _loadQueue = new com.clubpenguin.igloo.util.HybridMovieClipLoaderQueue(com.clubpenguin.igloo.util.HybridMovieClipLoaderQueue.PRIORITY_NEWEST);
        }
        function destroy() {
            removeRenderers();
            itemClipsHolderMC.removeMovieClip();
            itemClipsHolderMC = null;
            maskMC.removeMovieClip();
            maskMC = null;
            itemClicked.removeAll();
            itemClicked = null;
        }
        function update(itemList, removeAllRenderers) {
            trace("[Igloo] PaneView.update " + itemList.length);
            _itemList = itemList;
            if (removeAllRenderers) {
                removeRenderers();
            }
            _loadQueue.clear();
            var _local_2 = 0;
            while (_local_2 < itemList.length) {
                if (_local_2 >= _numItemRenderers) {
                    var _local_5 = com.clubpenguin.igloo.component.renderer.IItemRenderer(itemClipsHolderMC.attachMovie(_itemRendererLinkageID, "item" + _local_2, _local_2));
                    _local_5.setVO(itemList[_local_2], _loadQueue);
                    _local_5.getItemClickedSignal().add(onItemClicked, this);
                    MovieClip(_local_5)._x = (_local_2 * _itemRendererWidth) + _style.itemRendererXOffset;
                    MovieClip(_local_5)._y = _style.itemRendererYOffset;
                    MovieClip(_local_5).cacheAsBitmap = true;
                    _itemClips.push(_local_5);
                } else {
                    var _local_5 = com.clubpenguin.igloo.component.renderer.IItemRenderer(_itemClips[_local_2]);
                    var _local_8 = com.clubpenguin.util.IVO(_local_5.getVO());
                    var _local_6 = com.clubpenguin.util.IVO(itemList[_local_2]);
                    _local_5.setVO(_local_6, _loadQueue);
                    MovieClip(_local_5)._visible = true;
                }
                _local_2++;
            }
            _numItemRenderers = ((itemList.length < _numItemRenderers) ? (_numItemRenderers) : (itemList.length));
            var _local_3 = 0;
            while (_local_3 < _numItemRenderers) {
                if (_local_3 >= itemList.length) {
                    var _local_7 = MovieClip(_itemClips[_local_3]);
                    _local_7._visible = false;
                }
                _local_3++;
            }
            if (_style.isVertical) {
                virtualWidth = _width + _style.itemRendererXOffset;
                virtualHeight = (_itemRendererHeight * itemList.length) + _style.itemRendererYOffset;
            } else if (_style.isHorizontal) {
                virtualWidth = (_itemRendererWidth * itemList.length) + _style.itemRendererXOffset;
                virtualHeight = _height + _style.itemRendererYOffset;
            }
            if (_currentPosition == undefined) {
                _currentPosition = 0;
            }
            updatePosition(_currentPosition);
        }
        function removeRenderers() {
            if (_itemClips.length > 0) {
                var _local_2 = 0;
                while (_local_2 < _itemClips.length) {
                    MovieClip(_itemClips[_local_2]).destroy();
                    MovieClip(_itemClips[_local_2]).removeMovieClip();
                    _local_2++;
                }
            }
            _itemClips = [];
            _numItemRenderers = 0;
            virtualWidth = 0;
            virtualHeight = 0;
        }
        function onItemClicked(item) {
            trace((this + " was clicked: ") + item);
            itemClicked.dispatch(item);
        }
        function draw() {
            maskMC.clear();
            com.clubpenguin.util.DrawUtil.drawRect(maskMC, new flash.geom.Rectangle(xOffset, yOffset, _width, _height), 65280, 30);
        }
        function updatePosition(newPosition) {
            trace((this + " update position: ") + newPosition);
            if (_style.scrollType == com.clubpenguin.igloo.component.scrollpane.style.ScrollPaneStyle.VERTICAL) {
                scrollVertically(newPosition);
            } else {
                scrollHorizontally(newPosition);
            }
        }
        function scrollHorizontally(newXPosition) {
            var _local_5 = ((-newXPosition) * virtualWidth) + _style.itemRendererXOffset;
            var _local_3 = 0;
            var _local_4 = 0;
            var _local_2 = 0;
            while (_local_2 < _itemList.length) {
                _local_3 = _local_5 + _local_4;
                _local_4 = _local_4 + _itemClips[_local_2].getWidth();
                if (_local_3 < leftLimit) {
                    _local_3 = leftLimit;
                    _itemClips[_local_2]._visible = false;
                } else if (_local_3 > rightLimit) {
                    _local_3 = rightLimit;
                    _itemClips[_local_2]._visible = false;
                } else {
                    _itemClips[_local_2]._visible = true;
                }
                _itemClips[_local_2]._x = _local_3;
                _itemClips[_local_2]._y = _style.itemRendererYOffset;
                _local_2++;
            }
            _currentPosition = newXPosition;
        }
        function scrollVertically(newYPosition) {
            var _local_5 = ((-newYPosition) * (virtualHeight - _height)) + _style.itemRendererYOffset;
            var _local_3 = 0;
            var _local_4 = 0;
            var _local_2 = 0;
            while (_local_2 < _itemList.length) {
                _local_3 = _local_5 + _local_4;
                _local_4 = _local_4 + _itemClips[_local_2].getHeight();
                if (_local_3 < topLimit) {
                    _local_3 = topLimit;
                    _itemClips[_local_2]._visible = false;
                } else if (_local_3 > bottomLimit) {
                    _local_3 = bottomLimit;
                    _itemClips[_local_2]._visible = false;
                } else {
                    _itemClips[_local_2]._visible = true;
                }
                _itemClips[_local_2]._x = _style.itemRendererXOffset;
                _itemClips[_local_2]._y = _local_3;
                _local_2++;
            }
            _currentPosition = newYPosition;
        }
        function getItemsPerRow() {
            return(Math.ceil(_width / _itemRendererWidth));
        }
        function getItemsPerColumn() {
            return(Math.ceil(_height / _itemRendererHeight));
        }
        function getWidth() {
            return(_width);
        }
        function getHeight() {
            return(_height);
        }
        function toString() {
            return("[PaneView]");
        }
        var xOffset = 0;
        var yOffset = 0;
        var leftLimit = 0;
        var rightLimit = 0;
        var topLimit = 0;
        var bottomLimit = 0;
        var _numItemRenderers = 0;
    }
