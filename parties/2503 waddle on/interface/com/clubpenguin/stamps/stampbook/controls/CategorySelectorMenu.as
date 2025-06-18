//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.stamps.stampbook.controls.CategorySelectorMenu extends com.clubpenguin.stamps.stampbook.controls.AbstractControl
    {
        var _renderers, _dividers, rollOverBg, placeHolder, bg, _data, mask, dispatchEvent;
        function CategorySelectorMenu () {
            super();
        }
        function configUI() {
            _renderers = [];
            _dividers = [];
            super.configUI();
        }
        function cleanUI() {
            var _local_5 = ((_renderers.length > _dividers.length) ? (_renderers.length) : (_dividers.length));
            var _local_3 = 0;
            while (_local_3 < _local_5) {
                var _local_2 = MovieClip(_renderers.pop());
                if (_local_2) {
                    _local_2.removeMovieClip();
                }
                var _local_4 = MovieClip(_dividers.pop());
                if (_local_4) {
                    _local_4.removeMovieClip();
                }
                _local_3++;
            }
        }
        function populateUI() {
            cleanUI();
            _maxWidth = 0;
            rollOverBg._x = OFF_STAGE_POSITION;
            rollOverBg._y = OFF_STAGE_POSITION;
            placeHolder._visible = false;
            bg._visible = false;
            var _local_8 = _data.length;
            var _local_4;
            var _local_3;
            var _local_2 = 0;
            while (_local_2 < _local_8) {
                var _local_6 = _data[_local_2];
                if (_local_6.getID() == com.clubpenguin.stamps.StampManager.MYSTERY_CATEGORY_ID) {
                } else {
                    if (includeBlankTopSpace) {
                        _local_4 = placeHolder.attachMovie(DIVIDER_RENDERER, DIVIDER_RENDERER + "-1", placeHolder.getNextHighestDepth());
                        _local_4._y = RENDERER_HEIGHT;
                        _dividers.push(_local_4);
                    }
                    _local_3 = com.clubpenguin.stamps.stampbook.controls.CategorySelectorRenderer(placeHolder.attachMovie(ITEM_RENDERER, ITEM_RENDERER + _local_2, placeHolder.getNextHighestDepth()));
                    _local_3.addEventListener("onRollOver", onItemRollOver, this);
                    _local_3.addEventListener("onRollOut", onItemRollOut, this);
                    _local_3.addEventListener("onPress", onItemPress, this);
                    _local_3.data = _data[_local_2];
                    var _local_5 = (includeBlankTopSpace ? (_local_2 + 1) : (_local_2));
                    _local_3._y = RENDERER_HEIGHT * _local_5;
                    _local_3._x = 0;
                    _renderers.push(_local_3);
                    _maxWidth = ((_local_3._width > _maxWidth) ? (_local_3._width) : (_maxWidth));
                    if ((!includeAllCategoriesButton) && (_local_2 == (_local_8 - 1))) {
                    } else {
                        _local_4 = placeHolder.attachMovie(DIVIDER_RENDERER, DIVIDER_RENDERER + _local_2, placeHolder.getNextHighestDepth());
                        _local_4._y = _local_3._y + RENDERER_HEIGHT;
                        _dividers.push(_local_4);
                    }
                }
                _local_2++;
            }
            if (includeAllCategoriesButton) {
                var _local_11 = _local_8 - 1;
                _local_3 = com.clubpenguin.stamps.stampbook.controls.CategorySelectorRenderer(placeHolder.attachMovie(ITEM_RENDERER, ITEM_RENDERER + _local_11, placeHolder.getNextHighestDepth()));
                _local_3.addEventListener("onRollOver", onItemRollOver, this);
                _local_3.addEventListener("onRollOut", onItemRollOut, this);
                _local_3.addEventListener("onPress", onItemPress, this);
                _local_3.data = _data;
                var _local_14 = (includeBlankTopSpace ? (_local_11 + 1) : (_local_11));
                _local_3._y = RENDERER_HEIGHT * _local_14;
                _local_3._x = 0;
                _renderers.push(_local_3);
                _maxWidth = ((_local_3._width > _maxWidth) ? (_local_3._width) : (_maxWidth));
            }
            var _local_7 = PADDING * 2;
            var _local_13 = _dividers.length;
            var _local_10 = _renderers.length;
            var _local_9 = ((_local_10 > _local_13) ? (_local_10) : (_local_13));
            _local_2 = 0;
            while (_local_2 < _local_9) {
                _local_3 = com.clubpenguin.stamps.stampbook.controls.CategorySelectorRenderer(_renderers[_local_2]);
                if (_local_3) {
                    _local_3.setWidth(_maxWidth);
                }
                _local_4 = MovieClip(_dividers[_local_2]);
                if (_local_4) {
                    _local_4._width = _maxWidth - _local_7;
                    _local_4._x = _local_7;
                }
                _local_2++;
            }
            rollOverBg._width = _maxWidth + _local_7;
            rollOverBg._height = RENDERER_HEIGHT;
            var _local_12 = (includeBlankTopSpace ? (RENDERER_HEIGHT * (_local_10 + 1)) : (RENDERER_HEIGHT * _local_10));
            bg._width = _maxWidth + _local_7;
            bg._height = _local_12 + _local_7;
            bg._visible = true;
            mask._width = _maxWidth;
            mask._height = _local_12;
            mask._x = PADDING;
            mask._y = PADDING;
            placeHolder._x = PADDING;
            placeHolder._y = PADDING;
            placeHolder._visible = true;
        }
        function onItemRollOver(event) {
            var _local_2 = MovieClip(event.target);
            _local_2.swapDepths(placeHolder.getNextHighestDepth());
            rollOverBg._y = _local_2._y + PADDING;
            rollOverBg._x = 0;
            var _local_3 = event.data;
            var _local_4 = _local_3.getSubCategories();
            dispatchEvent({type:"showMenu", data:_local_4, currentTarget:_local_2});
        }
        function onItemRollOut(event) {
            rollOverBg._x = OFF_STAGE_POSITION;
            rollOverBg._y = OFF_STAGE_POSITION;
        }
        function onItemPress(event) {
            var _local_3 = MovieClip(event.target);
            var _local_2 = event.data;
            var _local_7 = _local_2.getSubCategories();
            rollOverBg._x = OFF_STAGE_POSITION;
            rollOverBg._y = OFF_STAGE_POSITION;
            dispatchEvent({type:"onItemPress", data:_local_2, currentTarget:_local_3});
        }
        static var CLASS_REF = com.clubpenguin.stamps.stampbook.controls.CategorySelectorMenu;
        static var LINKAGE_ID = "CategorySelectorMenu";
        static var OFF_STAGE_POSITION = -1000;
        static var DIVIDER_RENDERER = "CategorySelectorDivider";
        static var ITEM_RENDERER = "CategorySelectorRenderer";
        static var RENDERER_HEIGHT = 25;
        static var PADDING = 1;
        static var DIVIDER_HEIGHT = 1;
        var _maxWidth = 0;
        var includeBlankTopSpace = false;
        var includeAllCategoriesButton = false;
    }
