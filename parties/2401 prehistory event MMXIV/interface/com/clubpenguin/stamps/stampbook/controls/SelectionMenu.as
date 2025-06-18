//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.stamps.stampbook.controls.SelectionMenu extends com.clubpenguin.stamps.stampbook.controls.AbstractControl
    {
        var _type, background, _renderers, _dividers, mouseBlocker, _data, _rows, _columns, placeHolder, mask, rollOverBg, dispatchEvent;
        function SelectionMenu () {
            super();
        }
        function setType(type) {
            _type = type;
        }
        function getHeight() {
            return(background._height);
        }
        function configUI() {
            _renderers = [];
            _dividers = [];
            var _this = this;
            mouseBlocker.onRelease = function () {
                _this.dispatchEvent({type:"close"});
            };
            mouseBlocker.useHandCursor = false;
            super.configUI();
        }
        function populateUI() {
            var _local_2 = 0;
            if (_data.length > 0) {
                _local_2 = _data.length;
            } else {
                for (var _local_3 in _data) {
                    _local_2 = _local_2 + 1;
                }
            }
            _rows = NUMBER_OF_ROWS;
            _columns = Math.ceil(_local_2 / _rows);
            cleanUp();
            drawUI();
        }
        function cleanUp() {
            var _local_5 = ((_renderers.length > _dividers.length) ? (_renderers.length) : (_dividers.length));
            if (_local_5 > 0) {
                var _local_2 = 0;
                while (_local_2 < _local_5) {
                    var _local_3 = MovieClip(_renderers.pop());
                    _local_3.removeMovieClip();
                    var _local_4 = MovieClip(_dividers.pop());
                    _local_4.removeMovieClip();
                    _local_2++;
                }
            }
        }
        function drawUI() {
            placeHolder._x = PADDING;
            placeHolder._y = PADDING;
            var _local_11 = _columns * RENDERER_WIDTH;
            var _local_10 = _rows * RENDERER_HEIGHT;
            background._width = _local_11 + (PADDING * 2);
            background._height = _local_10 + (PADDING * 2);
            mask._width = _local_11;
            mask._height = _local_10;
            mask._x = PADDING;
            mask._y = PADDING;
            var _local_8 = _columns - 1;
            var _local_7 = _rows - 1;
            var _local_6 = _data.length;
            if (_local_6 > 0) {
                var _local_2 = 0;
                while (_local_2 < _local_6) {
                    var _local_4 = placeHolder.attachMovie(_type + "Renderer", "renderer" + _local_2, placeHolder.getNextHighestDepth());
                    _local_4.addEventListener("onRollOver", onItemRollOver, this);
                    _local_4.addEventListener("onClick", onItemSelected, this);
                    _local_4.addEventListener("onRollOut", onItemRollOut, this);
                    _local_4.setModel(_data[_local_2]);
                    _local_4._x = (_local_2 % _columns) * RENDERER_WIDTH;
                    _local_4._y = Math.floor(_local_2 / _columns) * RENDERER_HEIGHT;
                    _renderers.push(_local_4);
                    _local_2++;
                }
            } else {
                var _local_5 = 0;
                for (var _local_9 in _data) {
                    var _local_4 = placeHolder.attachMovie(_type + "Renderer", "renderer" + _local_5, placeHolder.getNextHighestDepth());
                    _local_4.addEventListener("onRollOver", onItemRollOver, this);
                    _local_4.addEventListener("onClick", onItemSelected, this);
                    _local_4.addEventListener("onRollOut", onItemRollOut, this);
                    _local_4.setModel(_local_9);
                    _local_4._x = (_local_5 % _columns) * RENDERER_WIDTH;
                    _local_4._y = Math.floor(_local_5 / _columns) * RENDERER_HEIGHT;
                    _renderers.push(_local_4);
                    _local_5 = _local_5 + 1;
                }
            }
            var _local_2 = 0;
            while (_local_2 < _local_8) {
                var _local_3 = placeHolder.attachMovie(VERTICAL_DIVIDER_LINKAGE, VERTICAL_DIVIDER_LINKAGE + _local_2, placeHolder.getNextHighestDepth());
                _local_3._x = RENDERER_WIDTH * (_local_2 + 1);
                _local_3._y = mask._y;
                _local_3._height = mask._height - PADDING;
                _dividers.push(_local_3);
                _local_2++;
            }
            _local_2 = 0;
            while (_local_2 < _local_7) {
                var _local_3 = placeHolder.attachMovie(HORIZONTAL_DIVIDER_LINKAGE, HORIZONTAL_DIVIDER_LINKAGE + _local_2, placeHolder.getNextHighestDepth());
                _local_3._x = mask._x;
                _local_3._y = RENDERER_HEIGHT * (_local_2 + 1);
                _local_3._width = mask._width - PADDING;
                _dividers.push(_local_3);
                _local_2++;
            }
            rollOverBg._x = -1000;
            rollOverBg._y = -1000;
            rollOverBg._width = RENDERER_WIDTH;
            rollOverBg._height = RENDERER_HEIGHT;
        }
        function onItemRollOver(event) {
            var _local_2 = MovieClip(event.target);
            rollOverBg._x = _local_2._x + PADDING;
            rollOverBg._y = _local_2._y + PADDING;
        }
        function onItemRollOut(event) {
            rollOverBg._x = -1000;
            rollOverBg._y = -1000;
        }
        function onItemSelected(event) {
            rollOverBg._x = -1000;
            rollOverBg._y = -1000;
            dispatchEvent({type:"onItemClick", data:event.data, dataType:_type});
        }
        static var CLASS_REF = com.clubpenguin.stamps.stampbook.controls.SelectionMenu;
        static var LINKAGE_ID = "SelectionMenu";
        static var NUMBER_OF_ROWS = 3;
        static var RENDERER_WIDTH = 57;
        static var RENDERER_HEIGHT = 37;
        static var PADDING = 1;
        static var HORIZONTAL_OFFSET = 1.7;
        static var HORIZONTAL_DIVIDER_LINKAGE = "SelectionMenuHorizontalDivider";
        static var VERTICAL_DIVIDER_LINKAGE = "SelectionMenuVerticalDivider";
    }
