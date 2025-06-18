//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.stamps.stampbook.controls.CategorySelectorWideRenderer extends MovieClip
    {
        var _shell, _stampLookUp, _data, _categoryID, labelField, arrow, bg, stampIconLoader, load_mc, stampIconHolder, _rendererHeight, _rendererWidth, dispatchEvent;
        function CategorySelectorWideRenderer () {
            super();
            com.clubpenguin.util.EventDispatcher.initialize(this);
            _shell = com.clubpenguin.stamps.stampbook.util.ShellLookUp.shell;
            _stampLookUp = com.clubpenguin.stamps.stampbook.util.StampLookUp.getInstance();
        }
        function onLoad() {
        }
        function get data() {
            return(_data);
        }
        function set data(value) {
            _data = value;
            setText();
            setIcon();
            //return(data);
        }
        function setText(value) {
            _categoryID = (_data.getID() ? (_data.getID()) : (com.clubpenguin.stamps.StampManager.ALL_CATEGORY_ID));
            var _local_2 = ((_categoryID == com.clubpenguin.stamps.StampManager.ALL_CATEGORY_ID) ? (_shell.getLocalizedString("all_stamps_category_title")) : (_data.getName()));
            labelField.text = _local_2;
            if (_stampLookUp.isCategorySelected(_categoryID)) {
                labelField._alpha = CATEGORY_SELECTED_ALPHA;
            }
            labelField._width = labelField.textWidth + PADDING;
            arrow._x = (labelField._x + labelField._width) + PADDING;
            bg._width = ((STAMP_ICON_WIDTH + labelField._width) + arrow._width) + (PADDING * PADDING_MULTIPLIER);
            arrow._visible = ((_data.getSubCategories().length > 0) ? true : false);
        }
        function setIcon() {
            stampIconLoader = new com.clubpenguin.hybrid.HybridMovieClipLoader();
            stampIconLoader.addEventListener(com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_INIT, com.clubpenguin.util.Delegate.create(this, onLoadInit));
            load_mc = stampIconHolder.createEmptyMovieClip("load_mc", stampIconHolder.getNextHighestDepth());
            var _local_2 = _shell.getPath("stampbook_category");
            stampIconLoader.loadClip((_local_2 + _categoryID) + ".swf", load_mc, "CategorySelectorWideRenderer.as setIcon()");
        }
        function onLoadInit(event) {
            load_mc._xscale = ICON_SCALE_OUT;
            load_mc._yscale = ICON_SCALE_OUT;
        }
        function setHeight(h) {
            _rendererHeight = h;
            bg._height = _rendererHeight;
        }
        function setWidth(w) {
            _rendererWidth = w;
            arrow._x = (_rendererWidth - PADDING) - arrow._width;
            bg._width = _rendererWidth;
        }
        function onPress() {
            dispatchEvent({type:"onPress", data:_data});
        }
        function onRollOver() {
            load_mc._xscale = ICON_SCALE_OVER;
            load_mc._yscale = ICON_SCALE_OVER;
            dispatchEvent({type:"onRollOver", data:_data});
        }
        function onRollOut() {
            load_mc._xscale = ICON_SCALE_OUT;
            load_mc._yscale = ICON_SCALE_OUT;
            dispatchEvent({type:"onRollOut", data:_data});
        }
        static var CLASS_REF = com.clubpenguin.stamps.stampbook.controls.CategorySelectorWideRenderer;
        static var LINKAGE_ID = "CategorySelectorWideRenderer";
        static var ICON_SCALE_OVER = 105;
        static var ICON_SCALE_OUT = 70;
        static var STAMP_ICON_WIDTH = 22;
        static var PADDING = 5;
        static var PADDING_MULTIPLIER = 4;
        static var CATEGORY_SELECTED_ALPHA = 50;
    }
