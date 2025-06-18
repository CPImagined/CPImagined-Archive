//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.stamps.stampbook.views.StampbookCoverView extends com.clubpenguin.stamps.stampbook.views.InsidePagesBaseView
    {
        var _stampManager, _shell, _coverCrumbs, _colourPath, _patternPath, _highlightPath, _iconPath, _wordmarkPath, _initialized, _closeStampBookFunction, closeClip, __get__closeStampBookFunction, clasp, save_btn, edit_btn, toolBar, coverList, _renderers, colourLoader, patternLoader, highlightClaspLoader, iconLoader, wordmarkLoader, removeDropArea, _dropShadowFilter, stageRect, stageArea, claspRect, dropAreaRect, dispatchEvent, _selectedCategory, _stampLookUp, _model, _masterList, colourLoaderHolder, patternLoaderHolder, highlightClaspLoaderHolder, iconLoaderHolder, wordmarkLoaderHolder, penguinName, penguinStamps, nameRect, stampsHolder, stampRect, _xmouse, _ymouse, _currentID, _currentTarget, _mousexOffset, _mouseyOffset, _lastxPosition, _lastyPosition, rect, _isPlaceableOnCover, _removeStamp, help_btn, editBackground, background;
        function StampbookCoverView () {
            super();
            _stampManager = _shell.getStampManager();
            _coverCrumbs = _stampManager.stampBookCoverCrumbs;
            _colourPath = _shell.getPath("stampbook_colour");
            _patternPath = _shell.getPath("stampbook_pattern");
            _highlightPath = _shell.getPath("stampbook_highlight");
            _iconPath = _shell.getPath("stampbook_clasp");
            _wordmarkPath = _shell.getPath("stampbook_wordmark");
        }
        function get toggleEditControls() {
            return(_toggleEditControls);
        }
        function set toggleEditControls(value) {
            if (_toggleEditControls == value) {
                return;
            }
            _toggleEditControls = value;
            if (_initialized) {
                toggleEditMode();
            }
            //return(toggleEditControls);
        }
        function set closeStampBookFunction(fcn) {
            _closeStampBookFunction = fcn;
            closeClip.onRelease = _closeStampBookFunction;
            //return(__get__closeStampBookFunction());
        }
        function cleanUp() {
            clasp.removeEventListener("press", onClaspClicked, this);
            save_btn.removeEventListener("release", onSaveStampbookCover, this);
            edit_btn.removeEventListener("release", onEditStampbookCover, this);
            toolBar.removeEventListener("change", onCoverSettingChange, this);
            toolBar.removeEventListener("filter", onFilterByCategory, this);
            coverList.removeEventListener("itemPress", onItemPressed, this);
            closeClip.removeEventListener("release", _closeStampBookFunction, this);
        }
        function configUI() {
            _renderers = [];
            colourLoader = new com.clubpenguin.hybrid.HybridMovieClipLoader();
            colourLoader.addEventListener(com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_INIT, com.clubpenguin.util.Delegate.create(this, onLoadInit));
            colourLoader.addEventListener(com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_ERROR, com.clubpenguin.util.Delegate.create(this, onLoadError));
            _numAssetsToLoad++;
            patternLoader = new com.clubpenguin.hybrid.HybridMovieClipLoader();
            patternLoader.addEventListener(com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_INIT, com.clubpenguin.util.Delegate.create(this, onLoadInit));
            patternLoader.addEventListener(com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_ERROR, com.clubpenguin.util.Delegate.create(this, onLoadError));
            _numAssetsToLoad++;
            highlightClaspLoader = new com.clubpenguin.hybrid.HybridMovieClipLoader();
            highlightClaspLoader.addEventListener(com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_INIT, com.clubpenguin.util.Delegate.create(this, onLoadInit));
            highlightClaspLoader.addEventListener(com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_ERROR, com.clubpenguin.util.Delegate.create(this, onLoadError));
            _numAssetsToLoad++;
            iconLoader = new com.clubpenguin.hybrid.HybridMovieClipLoader();
            iconLoader.addEventListener(com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_INIT, com.clubpenguin.util.Delegate.create(this, onLoadInit));
            iconLoader.addEventListener(com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_ERROR, com.clubpenguin.util.Delegate.create(this, onLoadError));
            _numAssetsToLoad++;
            wordmarkLoader = new com.clubpenguin.hybrid.HybridMovieClipLoader();
            wordmarkLoader.addEventListener(com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_INIT, com.clubpenguin.util.Delegate.create(this, onLoadInit));
            wordmarkLoader.addEventListener(com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_ERROR, com.clubpenguin.util.Delegate.create(this, onLoadError));
            _numAssetsToLoad++;
            removeDropArea.gotoAndStop(_shell.getLanguageAbbreviation());
            _dropShadowFilter = new flash.filters.DropShadowFilter(DROPSHADOW_DISTANCE, DROPSHADOW_ANGLE, DROPSHADOW_COLOR, DROPSHADOW_ALPHA, DROPSHADOW_BLUR_X, DROPSHADOW_BLUR_Y, DROPSHADOW_STRENGTH, DROPSHADOW_QUALITY);
            stageRect = new flash.geom.Rectangle(stageArea._x + PADDING, stageArea._y + PADDING, stageArea._width, stageArea._height);
            claspRect = new flash.geom.Rectangle(clasp._x, clasp._y, clasp._width, clasp._height);
            dropAreaRect = new flash.geom.Rectangle(removeDropArea._x, removeDropArea._y, removeDropArea._width, removeDropArea._height);
            coverList._visible = false;
            removeDropArea._visible = false;
            super.configUI();
        }
        function onClaspClicked() {
            dispatchEvent({type:"claspClicked"});
        }
        function onFilterByCategory(event) {
            _selectedCategory = event.data;
            coverList.reset();
            coverList.dataProvider = _stampLookUp.getStampsForCategory(_selectedCategory);
        }
        function attachClipToHolderClip(holderClip) {
            if (holderClip.clip) {
                holderClip.clip.removeMovieClip();
            }
            holderClip.attachMovie(BLANK_CLIP_LINKAGE_ID, "clip", 1, {_x:0, _y:0});
        }
        function populateUI() {
            var _local_8 = _model.getColourID();
            var _local_10 = _model.getPatternID();
            var _local_7 = _model.getHighlightID();
            var _local_9 = _model.getClaspIconArtID();
            var _local_11 = _coverCrumbs.getLogoByColourID(_local_8);
            var _local_12 = _coverCrumbs.getTextHighlightByHighlightID(_local_7);
            var _local_6 = _model.getCoverItems();
            var _local_5 = _local_6.length;
            _stampLookUp = com.clubpenguin.stamps.stampbook.util.StampLookUp.getInstance();
            _masterList = _stampLookUp.getMasterList();
            _numAssetsToLoad = _numAssetsToLoad + _local_5;
            toolBar.setModel(_model);
            _selectedCategory = _masterList;
            coverList.dataProvider = _stampLookUp.getStampsForCategory(_selectedCategory);
            if ((_local_8 != undefined) && (_local_8 != INVALID_ID)) {
                attachClipToHolderClip(colourLoaderHolder);
                colourLoader.loadClip((_colourPath + _local_8) + ".swf", colourLoaderHolder.clip, "StampbookCoverView.as populateUI()");
            } else {
                countAssetDoneLoading();
            }
            if ((_local_10 != undefined) && (_local_10 != INVALID_ID)) {
                attachClipToHolderClip(patternLoaderHolder);
                patternLoader.loadClip((_patternPath + _local_10) + ".swf", patternLoaderHolder.clip, "StampbookCoverView.as populateUI()");
            } else {
                countAssetDoneLoading();
            }
            if ((_local_7 != undefined) && (_local_7 != INVALID_ID)) {
                attachClipToHolderClip(highlightClaspLoaderHolder);
                highlightClaspLoader.loadClip((_highlightPath + _local_7) + ".swf", highlightClaspLoaderHolder.clip, "StampbookCoverView.as populateUI()");
            } else {
                countAssetDoneLoading();
            }
            if ((_local_9 != undefined) && (_local_9 != INVALID_ID)) {
                attachClipToHolderClip(iconLoaderHolder);
                iconLoader.loadClip((_iconPath + _local_9) + ".swf", iconLoaderHolder.clip, "StampbookCoverView.as populateUI()");
            } else {
                countAssetDoneLoading();
            }
            if ((_local_11 != undefined) && (_local_11 != INVALID_ID)) {
                attachClipToHolderClip(wordmarkLoaderHolder);
                wordmarkLoader.loadClip((_wordmarkPath + _local_11) + ".swf", wordmarkLoaderHolder.clip, "StampbookCoverView.as populateUI()");
            } else {
                countAssetDoneLoading();
            }
            penguinName.colorValue = _local_12;
            penguinName.label = _stampLookUp.getPlayerNickname();
            penguinStamps._x = penguinName._x + penguinName._width;
            penguinStamps._x = (penguinName._y + penguinName._height) - PADDING;
            penguinStamps.colorValue = _local_12;
            var _local_13 = _shell.getLocalizedString("total_stamps");
            penguinStamps.label = _shell.replace_m(_local_13, [_stampLookUp.getNumberOfUserStamps(), _stampLookUp.getNumberOfTotalStampsForCategory(_masterList)]);
            nameRect = new flash.geom.Rectangle(penguinName._x, penguinName._y, penguinName._width, penguinName._height);
            var _local_4 = 0;
            while (_local_4 < _local_5) {
                var _local_3 = _local_6[_local_4];
                var _local_2 = com.clubpenguin.stamps.stampbook.controls.BaseItemRenderer(stampsHolder.attachMovie(ITEM_RENDERER, "coverRenderer" + _local_4, _local_3.getItemDepth()));
                _local_2.addEventListener("loadError", onStampLoadError, this);
                _local_2.addEventListener("loadInit", onStampLoaded, this);
                _local_2.addEventListener("press", onStampPressed, this);
                _local_2.setScale(STAMP_BOOK_ITEM_ART_SCALE, STAMP_BOOK_ITEM_ART_SCALE);
                _local_2.move(_local_3.getItemPosition().x, _local_3.getItemPosition().y);
                _local_2._rotation = _local_3.getItemRotation();
                _local_2.setModel(_local_3.getItem());
                _local_2.hitArea_mc._visible = false;
                _renderers.push(_local_2);
                _local_4++;
            }
            clasp.addEventListener("press", onClaspClicked, this);
            save_btn.addEventListener("release", onSaveStampbookCover, this);
            edit_btn.addEventListener("release", onEditStampbookCover, this);
            toolBar.addEventListener("change", onCoverSettingChange, this);
            toolBar.addEventListener("filter", onFilterByCategory, this);
            coverList.addEventListener("itemPress", onItemPressed, this);
            toggleEditMode();
        }
        function onStampLoadError(event) {
            countAssetDoneLoading();
        }
        function onLoadError(event) {
            countAssetDoneLoading();
        }
        function onLoadInit(event) {
            var _local_3 = event.target;
            _totalAssetsBytes = _totalAssetsBytes + _local_3.getBytesTotal();
            countAssetDoneLoading();
            if (_local_3 == wordmarkLoaderHolder) {
                if (!stampRect) {
                    var _local_2 = _local_3._parent;
                    stampRect = new flash.geom.Rectangle(_local_2._x - (_local_2._width >> 1), _local_2._y - (_local_2._height >> 1), _local_2._width, _local_2._height);
                }
            }
        }
        function onItemPressed(event) {
            if (toolBar.changingCategory) {
                toolBar.closeCategorySelector();
                return(undefined);
            }
            var _local_5 = _renderers.length;
            if (_local_5 >= com.clubpenguin.stamps.StampManager.MAX_STAMPBOOK_COVER_ITEMS) {
                _shell.$e(("[stampbookCoverView] onItemPressed() You cant have more than " + com.clubpenguin.stamps.StampManager.MAX_STAMPBOOK_COVER_ITEMS) + " items on your cover! ", {error_code:_shell.MAX_STAMPBOOK_COVER_ITEMS});
                return(undefined);
            }
            var _local_3 = com.clubpenguin.stamps.IStampBookItem(event.data);
            var _local_2 = com.clubpenguin.stamps.stampbook.controls.BaseItemRenderer(stampsHolder.attachMovie(ITEM_RENDERER, "coverRendererNew" + new Date().getTime(), stampsHolder.getNextHighestDepth()));
            _local_2.setScale(STAMP_BOOK_ITEM_ART_SCALE, STAMP_BOOK_ITEM_ART_SCALE);
            _local_2.move(_xmouse, _ymouse);
            _local_2.setModel(_local_3);
            _renderers.push(_local_2);
            _stampLookUp.addStampToCover(_local_3.getID());
            coverList.dataProvider = _stampLookUp.getStampsForCategory(_selectedCategory);
            var _local_4 = {type:"press", data:_local_3, target:_local_2, newStamp:true};
            onStampPressed(_local_4);
        }
        function onCoverSettingChange(event) {
            var _local_3;
            var _local_2 = event.data;
            switch (event.dataType) {
                case com.clubpenguin.stamps.stampbook.controls.ToolBar.COLOUR : 
                    attachClipToHolderClip(colourLoaderHolder);
                    colourLoader.loadClip((_colourPath + _local_2) + ".swf", colourLoaderHolder.clip, "StampbookCoverView.as onCoverSettingChange()");
                    var _local_4 = _coverCrumbs.getHighlightByColourID(_local_2);
                    _local_3 = _coverCrumbs.getTextHighlightByHighlightID(_local_4[0]);
                    penguinName.colorValue = _local_3;
                    penguinStamps.colorValue = _local_3;
                    attachClipToHolderClip(highlightClaspLoaderHolder);
                    highlightClaspLoader.loadClip((_highlightPath + _local_4[0]) + ".swf", highlightClaspLoaderHolder.clip, "StampbookCoverView.as onCoverSettingChange()");
                    var _local_5 = _coverCrumbs.getLogoByColourID(_local_2);
                    attachClipToHolderClip(wordmarkLoaderHolder);
                    wordmarkLoader.loadClip((_wordmarkPath + _local_5) + ".swf", wordmarkLoaderHolder.clip, "StampbookCoverView.as onCoverSettingChange()");
                    break;
                case com.clubpenguin.stamps.stampbook.controls.ToolBar.HIGHLIGHT : 
                    _local_3 = _coverCrumbs.getTextHighlightByHighlightID(_local_2);
                    penguinName.colorValue = _local_3;
                    penguinStamps.colorValue = _local_3;
                    attachClipToHolderClip(highlightClaspLoaderHolder);
                    highlightClaspLoader.loadClip((_highlightPath + _local_2) + ".swf", highlightClaspLoaderHolder.clip, "StampbookCoverView.as onCoverSettingChange()");
                    break;
                case com.clubpenguin.stamps.stampbook.controls.ToolBar.PATTERN : 
                    if (_local_2 == undefined) {
                        patternLoaderHolder._visible = false;
                        break;
                    }
                    attachClipToHolderClip(patternLoaderHolder);
                    patternLoader.loadClip((_patternPath + _local_2) + ".swf", patternLoaderHolder.clip, "StampbookCoverView.as onCoverSettingChange()");
                    patternLoaderHolder._visible = true;
                    break;
                case com.clubpenguin.stamps.stampbook.controls.ToolBar.ICON : 
                    attachClipToHolderClip(iconLoaderHolder);
                    iconLoader.loadClip((_iconPath + _local_2) + ".swf", iconLoaderHolder.clip, "StampbookCoverView.as onCoverSettingChange()");
            }
        }
        function onStampLoaded(event) {
            var _local_4 = event.target;
            _totalAssetsBytes = _totalAssetsBytes + _local_4.getBytesTotal();
            countAssetDoneLoading();
            var _local_3 = com.clubpenguin.stamps.stampbook.controls.BaseItemRenderer(_local_4);
            var _local_2 = new flash.geom.Rectangle(_local_3._x - (_local_3._width / 2), _local_3._y - (_local_3._height / 2), _local_3._width, _local_3._height);
            var _local_5 = !intersects(_local_3, _local_2);
            if (!_local_5) {
                _local_3.move(Math.min(Math.max(_local_2.x + (_local_2.width / 2), stageRect.x + (_local_2.width / 2)), stageRect.width - _local_2.width), Math.min(Math.max(_local_2.y + (_local_2.height / 2), stageRect.y + (_local_2.height / 2)), stageRect.height - _local_2.height));
            }
        }
        function onStampPressed(event) {
            if (toolBar.changingCategory) {
                toolBar.closeCategorySelector();
                return(undefined);
            }
            var _local_3 = com.clubpenguin.stamps.IStampBookItem(event.data);
            _currentID = _local_3.getID();
            _currentTarget = com.clubpenguin.stamps.stampbook.controls.BaseItemRenderer(event.target);
            _currentTarget.hideShadow();
            _currentTarget.swapDepths(stampsHolder.getNextHighestDepth());
            _currentTarget.removeEventListener("press", onStampPressed, this);
            _currentTarget.filters = [_dropShadowFilter];
            _mousexOffset = Math.round(_xmouse - _currentTarget._x);
            _mouseyOffset = Math.round(_ymouse - _currentTarget._y);
            _lastxPosition = Math.round(_currentTarget._x);
            _lastyPosition = Math.round(_currentTarget._y);
            if (event.newStamp) {
                _lastxPosition = Math.round(_currentTarget._x);
                _lastyPosition = Math.round(stageRect.y + (_currentTarget._height >> 1));
            }
            Key.addListener(this);
            removeDropArea._visible = true;
            _currentTarget.addEventListener("mouseMove", handleDrag, this);
            _currentTarget.addEventListener("mouseUp", handleClick, this);
            _currentTarget.hitArea_mc._visible = true;
        }
        function intersects(sourceMc, sourceRect) {
            var _local_8 = (((((!stageRect.containsRectangle(sourceRect)) || (clasp.hitTest(sourceMc))) || (penguinName.hitTest(sourceMc))) || (wordmarkLoaderHolder.hitTest(sourceMc))) || (penguinStamps.hitTest(sourceMc))) || (closeClip.hitTest(sourceMc));
            if (!_local_8) {
                var _local_7 = _renderers.length;
                var _local_2 = 0;
                while (_local_2 < _local_7) {
                    var _local_3 = com.clubpenguin.stamps.stampbook.controls.BaseItemRenderer(_renderers[_local_2]);
                    var _local_4 = com.clubpenguin.stamps.IStampBookItem(_local_3.data);
                    var _local_5 = com.clubpenguin.stamps.IStampBookItem(sourceMc.data);
                    if ((_local_4.getID() != _local_5.getID()) && (_local_3.hitTest(sourceMc))) {
                        return(true);
                    }
                    _local_2++;
                }
            } else {
                return(true);
            }
        }
        function onKeyDown() {
            var _local_2 = Key.getCode();
            switch (_local_2) {
                case 39 : 
                    _currentTarget._rotation = _currentTarget._rotation + ROTATION_VALUE;
                    _currentTarget._rotation = _currentTarget._rotation % MAX_ROTATION;
                    break;
                case 37 : 
                    _currentTarget._rotation = _currentTarget._rotation - ROTATION_VALUE;
                    _currentTarget._rotation = _currentTarget._rotation % MAX_ROTATION;
            }
        }
        function handleDrag(event) {
            _currentTarget._x = Math.round(_xmouse - _mousexOffset);
            _currentTarget._y = Math.round(_ymouse - _mouseyOffset);
            rect = new flash.geom.Rectangle(_currentTarget._x - (_currentTarget._width / 2), _currentTarget._y - (_currentTarget._height / 2), _currentTarget._width, _currentTarget._height);
            _isPlaceableOnCover = !intersects(_currentTarget, rect);
            _removeStamp = dropAreaRect.intersects(rect);
            if (_isPlaceableOnCover || (_removeStamp)) {
                _currentTarget._alpha = ACTIVE_RENDERER;
            } else if (!_removeStamp) {
                _currentTarget._alpha = INACTIVE_RENDERER;
            }
            if (!_isDragging) {
                _currentTarget.removeEventListener("mouseUp", handleClick, this);
                _currentTarget.addEventListener("mouseUp", handleDrop, this);
            }
            _isDragging = true;
            _currentTarget.hitArea._visible = true;
        }
        function handleDrop() {
            _isDragging = false;
            Key.removeListener(this);
            _currentTarget.hitArea_mc._visible = false;
            if (_removeStamp || (!_isPlaceableOnCover)) {
                var _local_2 = this.indexOf(_renderers, _currentTarget);
                _renderers.splice(_local_2, 1);
                _currentTarget.removeMovieClip();
                _stampLookUp.removeStampFromCover(_currentID);
                coverList.dataProvider = _stampLookUp.getStampsForCategory(_selectedCategory);
            } else {
                _lastxPosition = Math.round(_currentTarget._x);
                _lastyPosition = Math.round(_currentTarget._y);
            }
            removeDropArea._visible = false;
            _currentTarget.filters = [];
            _currentTarget.showShadow();
            _currentTarget.removeEventListener("mouseMove", handleDrag, this);
            _currentTarget.removeEventListener("mouseUp", handleDrop, this);
            _currentTarget.removeEventListener("press", handleDrop, this);
            _currentTarget.addEventListener("press", onStampPressed, this);
        }
        function indexOf(array, searchElement) {
            var _local_2 = array.length;
            var _local_1 = 0;
            while (_local_1 < _local_2) {
                if (array[_local_1] == searchElement) {
                    return(_local_1);
                }
                _local_1++;
            }
            return(-1);
        }
        function handleClick() {
            _currentTarget.removeEventListener("mouseUp", handleClick, this);
            _currentTarget.addEventListener("press", handleDrop, this);
        }
        function toggleEditMode() {
            if (_toggleEditControls) {
                if (_editMode) {
                    showEditControls();
                } else {
                    hideEditControls();
                }
            } else {
                closeEditControls();
            }
        }
        function closeEditControls() {
            hideEditControls();
            edit_btn._visible = false;
        }
        function showEditControls() {
            edit_btn._visible = false;
            help_btn._visible = false;
            save_btn._visible = true;
            editBackground._visible = true;
            background._visible = false;
            toolBar._visible = true;
            coverList._visible = true;
            clasp.enabled = false;
            enableStampInteraction(true);
        }
        function hideEditControls() {
            edit_btn._visible = true;
            help_btn._visible = false;
            save_btn._visible = false;
            editBackground._visible = false;
            background._visible = true;
            toolBar._visible = false;
            coverList._visible = false;
            clasp.enabled = true;
            enableStampInteraction(false);
        }
        function enableStampInteraction(value) {
            var _local_5 = _renderers.length;
            var _local_3 = 0;
            while (_local_3 < _local_5) {
                var _local_2 = _renderers[_local_3];
                _local_2.enabled = value;
                _local_2.useHandCursor = value;
                if (value) {
                    _local_2.addEventListener("press", onStampPressed, this);
                } else {
                    _local_2.removeEventListener("press", onStampPressed, this);
                }
                _local_3++;
            }
        }
        function onEditStampbookCover(event) {
            _shell.updateListeners(com.clubpenguin.shell.events.MembershipEvent.MEMBER_ONLY_ACTIVITY, new com.clubpenguin.shell.events.MembershipEvent(com.clubpenguin.shell.events.MembershipEvent.MEMBER_ONLY_ACTIVITY, com.clubpenguin.shell.events.MembershipEventContext.STAMPBOOK_COVER, "clickedEditStampbook"));
            _editMode = true;
            toggleEditMode();
        }
        function onSaveStampbookCover(event) {
            if (toolBar.changingCategory) {
                toolBar.closeCategorySelector();
                return(undefined);
            }
            _editMode = false;
            var _local_11 = com.clubpenguin.stamps.stampbook.util.ColorHelper.getInstance();
            var _local_10 = _local_11.getPatternIndex();
            if ((_local_10 == undefined) || (isNaN(_local_10))) {
                _local_10 = com.clubpenguin.stamps.StampManager.COVER_PATTERN_NONE_ID;
            }
            _model.setColourID(_local_11.getColourIndex());
            _model.setPatternID(_local_10);
            _model.setHighlightID(_local_11.getHighlightIndex());
            _model.setClaspIconArtID(_local_11.getIconIndex());
            var _local_9 = [];
            var _local_4 = 0;
            while (_local_4 < _renderers.length) {
                var _local_2 = com.clubpenguin.stamps.stampbook.controls.BaseItemRenderer(_renderers[_local_4]);
                var _local_6 = com.clubpenguin.stamps.IStampBookItem(_local_2.data);
                var _local_3 = _local_2._rotation;
                var _local_7 = Math.round(_local_2._x);
                var _local_5 = Math.round(_local_2._y);
                if (_local_3 < 0) {
                    _local_3 = _local_3 + MAX_ROTATION;
                }
                var _local_8 = new com.clubpenguin.stamps.StampBookCoverItem(_local_6, new flash.geom.Point(_local_7, _local_5), _local_3, _local_2.getDepth());
                _local_9.push(_local_8);
                _local_4++;
            }
            _model.setCoverItems(_local_9);
            _stampManager.saveMyStampBookCover(com.clubpenguin.stamps.IStampBookCover(_model));
            toggleEditMode();
        }
        function countAssetDoneLoading() {
            _numAssetsDoneLoading++;
            if (_numAssetsDoneLoading == _numAssetsToLoad) {
                dispatchEvent({type:"stampbookCoverViewDoneLoading", totalAssetsBytes:_totalAssetsBytes});
            }
        }
        static var CLASS_REF = com.clubpenguin.stamps.stampbook.views.StampbookCoverView;
        static var LINKAGE_ID = "StampbookCoverView";
        static var BLANK_CLIP_LINKAGE_ID = "Blank";
        static var INVALID_ID = -1;
        static var ITEM_RENDERER = "BaseItemRenderer";
        static var ROTATION_VALUE = 15;
        static var ACTIVE_RENDERER = 100;
        static var INACTIVE_RENDERER = 50;
        static var PADDING = 10;
        static var MAX_ROTATION = 360;
        static var DROPSHADOW_DISTANCE = 4;
        static var DROPSHADOW_ANGLE = 45;
        static var DROPSHADOW_COLOR = 0;
        static var DROPSHADOW_ALPHA = 0.4;
        static var DROPSHADOW_BLUR_X = 10;
        static var DROPSHADOW_BLUR_Y = 10;
        static var DROPSHADOW_STRENGTH = 2;
        static var DROPSHADOW_QUALITY = 3;
        static var STAMP_BOOK_ITEM_ART_SCALE = 150;
        var _toggleEditControls = false;
        var _editMode = false;
        var _isDragging = false;
        var _numAssetsToLoad = 0;
        var _numAssetsDoneLoading = 0;
        var _totalAssetsBytes = 0;
    }
