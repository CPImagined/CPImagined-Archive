//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.stamps.stampbook.controls.BaseItemRenderer extends MovieClip
    {
        var _shell, _data, _initialized, _filePath, _iconHolderClip, _scaleX, _scaleY, _x, _y, loader, loader_mc, attachMovie, enabled, hitArea, dispatchEvent;
        function BaseItemRenderer () {
            super();
            com.clubpenguin.util.EventDispatcher.initialize(this);
            _shell = com.clubpenguin.stamps.stampbook.util.ShellLookUp.shell;
        }
        function onLoad() {
            configUI();
        }
        function get data() {
            return(_data);
        }
        function setModel(data) {
            _data = data;
            if (!_initialized) {
                configUI();
            }
            _filePath = getPath(_data.getType());
            this.load();
        }
        function showShadow() {
            _iconHolderClip.stamp.shadow._visible = true;
        }
        function hideShadow() {
            _iconHolderClip.stamp.shadow._visible = false;
        }
        function setScale(scaleX, scaleY) {
            _scaleX = scaleX;
            _scaleY = scaleY;
        }
        function move(x, y) {
            _x = x;
            _y = y;
        }
        function getPath(type) {
            var _local_2;
            switch (type) {
                case com.clubpenguin.stamps.StampBookItemType.STAMP : 
                    _local_2 = _shell.getPath("stampbook_stamps");
                    break;
                case com.clubpenguin.stamps.StampBookItemType.AWARD : 
                case com.clubpenguin.stamps.StampBookItemType.PIN : 
                    _local_2 = _shell.getPath("clothing_icons");
                    break;
            }
            return(_local_2);
        }
        function configUI() {
            loader = new com.clubpenguin.hybrid.HybridMovieClipLoader();
            loader.addEventListener(com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_INIT, com.clubpenguin.util.Delegate.create(this, onLoadInit));
            loader.addEventListener(com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_ERROR, com.clubpenguin.util.Delegate.create(this, onLoadError));
            _initialized = true;
        }
        function load() {
            loader_mc.gotoAndStop("loading");
            if (_data) {
                var _local_2 = _data.getID();
                if (_data.getType() == com.clubpenguin.stamps.StampBookItemType.AWARD) {
                    _local_2 = com.clubpenguin.stamps.StampManager.AWARD_STAMP_IDS_TO_DB_IDS[_data.getID()];
                }
                if (_iconHolderClip) {
                    _iconHolderClip.removeMovieClip();
                }
                _iconHolderClip = this.attachMovie(BLANK_CLIP_LINKAGE_ID, "iconHolderClip", 1, {_x:0, _y:0});
                _iconHolderClip._xscale = _scaleX;
                _iconHolderClip._yscale = _scaleY;
                loader.loadClip((_filePath + _local_2) + ".swf", _iconHolderClip, "BaseItemRenderer.as load()");
            }
        }
        function onLoadInit(event) {
            var _local_2 = event.target;
            enabled = true;
            _local_2._parent.loader_mc.gotoAndStop("complete");
            if (_local_2.stamp) {
                _local_2.stamp.shadow._alpha = DROPSHADOW_ALPHA;
            }
            if (_local_2.hitArea_mc) {
                hitArea = _local_2.hitArea_mc;
                _local_2.hitArea_mc._alpha = 0;
            }
            dispatchEvent({type:"loadInit"});
        }
        function onLoadError(event) {
            var _local_2 = event.target;
            _local_2._parent._parent.loader_mc.gotoAndStop("loading");
            enabled = false;
            dispatchEvent({type:"loadError"});
        }
        function onMouseMove() {
            dispatchEvent({type:"mouseMove"});
        }
        function onMouseUp() {
            dispatchEvent({type:"mouseUp"});
        }
        function onMouseDown() {
            dispatchEvent({type:"mouseDown"});
        }
        function onPress() {
            dispatchEvent({type:"press", data:_data});
        }
        function onRelease() {
            dispatchEvent({type:"release"});
        }
        function onRollOver() {
            dispatchEvent({type:"over", data:_data});
        }
        function onRollOut() {
            dispatchEvent({type:"out"});
        }
        static var CLASS_REF = com.clubpenguin.stamps.stampbook.controls.BaseItemRenderer;
        static var LINKAGE_ID = "BaseItemRenderer";
        static var BLANK_CLIP_LINKAGE_ID = "Blank";
        static var DROPSHADOW_ALPHA = 30;
    }
