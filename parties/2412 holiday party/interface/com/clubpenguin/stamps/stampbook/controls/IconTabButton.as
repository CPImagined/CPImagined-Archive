//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.stamps.stampbook.controls.IconTabButton extends com.clubpenguin.stamps.stampbook.controls.BaseButton
    {
        static var ICON_SCALE_OUT, ICON_SCALE_OVER;
        var _shell, _filePath, stampIconLoader, stampIconLoadMc, stampIconHolder, _initialized, _data, _enabled, gotoAndStop, _toggle, _selected, dispatchEvent, useHandCursor, __get__enabled, __get__selected;
        function IconTabButton () {
            super();
            _shell = com.clubpenguin.stamps.stampbook.util.ShellLookUp.shell;
        }
        function configUI() {
            _filePath = _shell.getPath("stampbook_category");
            stampIconLoader = new com.clubpenguin.hybrid.HybridMovieClipLoader();
            stampIconLoader.addEventListener(com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_INIT, com.clubpenguin.util.Delegate.create(this, onLoadInit));
            stampIconLoadMc = stampIconHolder.createEmptyMovieClip("stampIconLoadMc", stampIconHolder.getNextHighestDepth());
            _initialized = true;
            if (_data != null) {
                populateUI();
            }
        }
        function get data() {
            return(_data);
        }
        function set data(value) {
            _data = value;
            if (_initialized) {
                populateUI();
            }
            //return(data);
        }
        function onLoadInit(event) {
            var _local_2 = event.target;
            _local_2._xscale = ICON_ART_SCALE;
            _local_2._yscale = ICON_ART_SCALE;
            ICON_SCALE_OUT = ((stampIconLoadMc._xscale + _SCALE_OFFSET) + (stampIconLoadMc._yscale + _SCALE_OFFSET)) >> 1;
            ICON_SCALE_OVER = ICON_SCALE_OUT + (_SCALE_OFFSET * 1.5);
            stampIconLoadMc._xscale = ICON_SCALE_OUT;
            stampIconLoadMc._yscale = ICON_SCALE_OUT;
        }
        function populateUI() {
            stampIconLoader.loadClip((_filePath + _data.getID()) + ".swf", stampIconLoadMc, "IconTabButton.as populateUI()");
        }
        function onPress() {
            if (!_enabled) {
                return(undefined);
            }
            this.gotoAndStop((_toggle ? (((!_selected) ? "down" : "selected_down")) : "down"));
            dispatchEvent({type:"press", data:_data});
        }
        function onRollOver() {
            if (!_enabled) {
                return(undefined);
            }
            stampIconLoadMc._xscale = ICON_SCALE_OVER;
            stampIconLoadMc._yscale = ICON_SCALE_OVER;
            this.gotoAndStop((_toggle ? (((!_selected) ? "over" : "selected_over")) : "over"));
            dispatchEvent({type:"over"});
        }
        function onRollOut() {
            if (!_enabled) {
                return(undefined);
            }
            stampIconLoadMc._xscale = ICON_SCALE_OUT;
            stampIconLoadMc._yscale = ICON_SCALE_OUT;
            this.gotoAndStop((_toggle ? (((!_selected) ? "up" : "selected_up")) : "up"));
            dispatchEvent({type:"out"});
        }
        function set enabled(value) {
            _enabled = value;
            useHandCursor = value;
            this.gotoAndStop((_selected ? "selected_up" : "up"));
            //return(__get__enabled());
        }
        function set selected(value) {
            _selected = value;
            stampIconLoadMc._xscale = ICON_SCALE_OUT;
            stampIconLoadMc._yscale = ICON_SCALE_OUT;
            this.gotoAndStop((_selected ? "selected_up" : "up"));
            //return(__get__selected());
        }
        static var CLASS_REF = com.clubpenguin.stamps.stampbook.controls.IconTabButton;
        static var LINKAGE_ID = "IconTabButton";
        static var ICON_ART_SCALE = 65;
        static var ICON_WIDTH = 21;
        static var ICON_HEIGHT = 21;
        static var _SCALE_OFFSET = 10;
    }
