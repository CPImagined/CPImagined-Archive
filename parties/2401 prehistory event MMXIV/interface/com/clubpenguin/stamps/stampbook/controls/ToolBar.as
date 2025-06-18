//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.stamps.stampbook.controls.ToolBar extends com.clubpenguin.stamps.stampbook.controls.AbstractControl
    {
        var _coverCrumbs, _shell, _changingCategory, _stampLookUp, _masterList, categorySelectorBtn, colourTool, highlightTool, patternTool, iconTool, selectionMenu, colourLabel, highlightLabel, patternLabel, iconLabel, specificCategoryBG, specificCategoryArrow, _data, dispatchEvent, _editing, categorySelectorTier1, categoryMenuHolder, categorySelectorTier2, _currentBtnPressed;
        function ToolBar () {
            super();
            _coverCrumbs = _shell.getStampManager().stampBookCoverCrumbs;
        }
        function get changingCategory() {
            return(_changingCategory);
        }
        function closeCategorySelector() {
            hideCategorySelector();
        }
        function configUI() {
            _stampLookUp = com.clubpenguin.stamps.stampbook.util.StampLookUp.getInstance();
            _masterList = _stampLookUp.getMasterList();
            categorySelectorBtn.swapDepths(TOP_LEVEL + 1);
            categorySelectorBtn.addEventListener("press", onCategorySelectorPress, this);
            colourTool.addEventListener("press", onToolItemPressed, this);
            highlightTool.addEventListener("press", onToolItemPressed, this);
            patternTool.addEventListener("press", onToolItemPressed, this);
            iconTool.addEventListener("press", onToolItemPressed, this);
            selectionMenu.addEventListener("onItemClick", onSelectionChange, this);
            selectionMenu.addEventListener("close", onSelectionMenuClose, this);
            super.configUI();
        }
        function populateUI() {
            colourLabel.text = _shell.getLocalizedString("colour");
            highlightLabel.text = _shell.getLocalizedString("highlight");
            patternLabel.text = _shell.getLocalizedString("pattern");
            iconLabel.text = _shell.getLocalizedString("icon");
            _stampLookUp.setCategorySelected(com.clubpenguin.stamps.StampManager.ALL_CATEGORY_ID);
            specificCategoryBG._visible = false;
            specificCategoryArrow._visible = false;
            categorySelectorBtn.setModel(_data);
            var _local_2 = com.clubpenguin.stamps.stampbook.util.ColorHelper.getInstance();
            _local_2.setColourIndex(_data.getColourID());
            _local_2.setHighlightIndex(_data.getHighlightID());
            _local_2.setPatternIndex(_data.getPatternID());
            _local_2.setIconIndex(_data.getClaspIconArtID());
            colourTool.setModel(_data.getColourID());
            highlightTool.setModel(_data.getHighlightID());
            patternTool.setModel(_data.getPatternID());
            iconTool.setModel(_data.getClaspIconArtID());
        }
        function onSelectionMenuClose(event) {
            hideSelectionMenu();
        }
        function onSelectionChange(event) {
            var _local_3 = com.clubpenguin.stamps.stampbook.util.ColorHelper.getInstance();
            var _local_2 = event.data;
            switch (event.dataType) {
                case COLOUR : 
                    _local_3.setColourIndex(_local_2);
                    var _local_6 = _coverCrumbs.getHighlightByColourID(_local_2);
                    var _local_4 = _local_6[0];
                    _local_3.setHighlightIndex(_local_4);
                    highlightTool.setModel(_local_4);
                    break;
                case HIGHLIGHT : 
                    _local_3.setHighlightIndex(_local_2);
                    highlightTool.setModel(_local_2);
                    break;
                case PATTERN : 
                    _local_2 = ((_local_2 == _local_3.getPatternIndex()) ? undefined : (_local_2));
                    _local_3.setPatternIndex(_local_2);
                    patternTool.setModel(_local_2);
                    break;
                case ICON : 
                    _local_3.setIconIndex(_local_2);
                    iconTool.setModel(_local_2);
                    break;
            }
            hideSelectionMenu();
            dispatchEvent({type:"change", data:_local_2, dataType:event.dataType});
        }
        function onCategorySelectorPress(event) {
            if (_editing) {
                hideSelectionMenu();
            }
            if (!_changingCategory) {
                if (!categorySelectorTier1) {
                    categorySelectorTier1 = com.clubpenguin.stamps.stampbook.controls.CategorySelectorMenu(categoryMenuHolder.attachMovie(CATEGORY_SELECTOR_MENU_LINKAGE, CATEGORY_SELECTOR_MENU_LINKAGE, categoryMenuHolder.getNextHighestDepth(), {includeAllCategoriesButton:true, includeBlankTopSpace:true}));
                    categorySelectorTier1.addEventListener("onItemPress", onCategorySelected, this);
                    categorySelectorTier1.addEventListener("showMenu", showSubCategories, this);
                }
                categorySelectorTier1.setModel(_masterList);
                categorySelectorTier1._x = CATEGORY_SELECTOR_TIER1_X;
                categorySelectorTier1._y = CATEGORY_SELECTOR_TIER1_Y;
                _changingCategory = !_changingCategory;
            } else {
                hideCategorySelector();
            }
            categoryMenuHolder.swapDepths(TOP_LEVEL);
            colourTool.swapDepths(BOTTOM_LEVEL);
            highlightTool.swapDepths(BOTTOM_LEVEL);
            patternTool.swapDepths(BOTTOM_LEVEL);
            iconTool.swapDepths(BOTTOM_LEVEL);
        }
        function onCategorySelected(event) {
            var _local_2 = event.data;
            var _local_3 = (_local_2.getID() ? (_local_2.getID()) : (com.clubpenguin.stamps.StampManager.ALL_CATEGORY_ID));
            specificCategoryBG._visible = ((_local_3 == com.clubpenguin.stamps.StampManager.ALL_CATEGORY_ID) ? false : true);
            specificCategoryArrow._visible = ((_local_3 == com.clubpenguin.stamps.StampManager.ALL_CATEGORY_ID) ? false : true);
            categorySelectorBtn.setModel(_local_2);
            com.clubpenguin.stamps.stampbook.util.StampLookUp.getInstance().setCategorySelected(_local_3);
            dispatchEvent({type:"filter", data:_local_2});
            hideCategorySelector();
        }
        function showSubCategories(event) {
            var _local_2 = event.data;
            if (_local_2.length <= 0) {
                categorySelectorTier2._x = -1000;
                categorySelectorTier2._y = -1000;
                return(undefined);
            }
            if (!categorySelectorTier2) {
                categorySelectorTier2 = com.clubpenguin.stamps.stampbook.controls.CategorySelectorMenuWide(categoryMenuHolder.attachMovie(CATEGORY_SELECTOR_WIDE_MENU_LINKAGE, CATEGORY_SELECTOR_WIDE_MENU_LINKAGE + 1, categoryMenuHolder.getNextHighestDepth()));
                categorySelectorTier2.addEventListener("onItemPress", onCategorySelected, this);
            }
            var _local_4 = MovieClip(event.target);
            var _local_5 = MovieClip(event.currentTarget);
            categorySelectorTier2.setModel(_local_2);
            categorySelectorTier2._x = (categorySelectorTier1._x + categorySelectorTier1._width) - CATEGORY_SELECTOR_MENU_OFFSET;
            categorySelectorTier2._y = _local_4._y + _local_5._y;
        }
        function onToolItemPressed(event) {
            var _local_2 = event.target;
            var _local_4;
            var _local_3;
            selectionMenu.swapDepths(BOTTOM_LEVEL);
            switch (_local_2) {
                case colourTool : 
                    _local_4 = COLOUR;
                    _local_3 = _coverCrumbs.colour;
                    break;
                case highlightTool : 
                    _local_4 = HIGHLIGHT;
                    _local_3 = _coverCrumbs.getHighlightByColourID(com.clubpenguin.stamps.stampbook.util.ColorHelper.getInstance().getColourIndex());
                    break;
                case patternTool : 
                    _local_4 = PATTERN;
                    _local_3 = _coverCrumbs.pattern;
                    break;
                case iconTool : 
                    _local_4 = ICON;
                    _local_3 = _coverCrumbs.clasp;
                    break;
            }
            if (_changingCategory) {
                hideCategorySelector();
            }
            if (!_editing) {
                selectionMenu._x = SELECTION_MENU_X;
                selectionMenu._y = _local_2._y - (TOOLBAR_BTN_HEIGHT / 2);
                selectionMenu.setType(_local_4);
                selectionMenu.setModel(_local_3);
                selectionMenu._visible = true;
                _editing = true;
                _currentBtnPressed = _local_2;
            } else if (_editing && (_local_2 != _currentBtnPressed)) {
                selectionMenu._x = SELECTION_MENU_X;
                selectionMenu._y = _local_2._y - (TOOLBAR_BTN_HEIGHT / 2);
                selectionMenu.setType(_local_4);
                selectionMenu.setModel(_local_3);
                _currentBtnPressed = _local_2;
            } else if (_editing) {
                hideSelectionMenu();
            }
            _local_2.swapDepths(TOP_LEVEL);
        }
        function hideSelectionMenu() {
            selectionMenu._visible = false;
            _editing = false;
            _currentBtnPressed = null;
        }
        function hideCategorySelector() {
            categorySelectorTier1._x = -1000;
            categorySelectorTier1._y = -1000;
            categorySelectorTier2._x = -1000;
            categorySelectorTier2._y = -1000;
            _changingCategory = false;
        }
        static var CLASS_REF = com.clubpenguin.stamps.stampbook.controls.ToolBar;
        static var LINKAGE_ID = "ToolBar";
        static var COLOUR = "Colour";
        static var HIGHLIGHT = "Highlight";
        static var PATTERN = "Pattern";
        static var ICON = "Icon";
        static var CATEGORY_SELECTOR_MENU_LINKAGE = "CategorySelectorMenu";
        static var CATEGORY_SELECTOR_WIDE_MENU_LINKAGE = "CategorySelectorMenuWide";
        static var CATEGORY_SELECTOR_MENU_OFFSET = 4;
        static var TOP_LEVEL = 10001;
        static var BOTTOM_LEVEL = 10000;
        static var SELECTION_MENU_X = 61.85;
        static var TOOLBAR_BTN_HEIGHT = 70;
        static var CATEGORY_SELECTOR_TIER1_X = 36;
        static var CATEGORY_SELECTOR_TIER1_Y = 42;
    }
