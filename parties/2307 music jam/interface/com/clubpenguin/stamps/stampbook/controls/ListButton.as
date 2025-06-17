//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.stamps.stampbook.controls.ListButton extends MovieClip
    {
        var _shell, stampIconLoader, _model, _filePath, load_mc, label_field, btnHitArea, _initialized, stampIconHolder, dispatchEvent;
        function ListButton () {
            super();
            com.clubpenguin.util.EventDispatcher.initialize(this);
            _shell = com.clubpenguin.stamps.stampbook.util.ShellLookUp.shell;
        }
        function onLoad() {
            configUI();
        }
        function populateUI() {
            stampIconLoader.loadClip((_filePath + _model.getID()) + ".swf", load_mc, "ListButton.as populateUI()");
            label_field.text = _model.getName();
            label_field.autoSize = "left";
            btnHitArea._width = (label_field._x + label_field._width) + PADDING;
            label_field.textColor = ROLLOUT_COLOR;
        }
        function setModel(model) {
            _model = model;
            if (_initialized) {
                populateUI();
            }
        }
        function configUI() {
            _filePath = _shell.getPath("stampbook_category");
            stampIconLoader = new com.clubpenguin.hybrid.HybridMovieClipLoader();
            stampIconLoader.addEventListener(com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_INIT, com.clubpenguin.util.Delegate.create(this, onLoadInit));
            load_mc = stampIconHolder.createEmptyMovieClip("load_mc", stampIconHolder.getNextHighestDepth());
            _initialized = true;
            if (_model != null) {
                populateUI();
            }
        }
        function onLoadInit(event) {
            var _local_1 = event.target;
            _local_1.btnIcon._alpha = ROLLOUT_ALPHA;
        }
        function onRollOver() {
            var _local_2 = load_mc.btnIcon;
            _local_2._alpha = ROLLOVER_ALPHA;
            label_field.textColor = ROLLOVER_COLOR;
            dispatchEvent({type:"over"});
        }
        function onRollOut() {
            var _local_2 = load_mc.btnIcon;
            _local_2._alpha = ROLLOUT_ALPHA;
            label_field.textColor = ROLLOUT_COLOR;
            dispatchEvent({type:"out"});
        }
        function onPress() {
            dispatchEvent({type:"press", data:_model});
        }
        function onRelease() {
            dispatchEvent({type:"release", data:_model});
        }
        static var CLASS_REF = com.clubpenguin.stamps.stampbook.controls.ListButton;
        static var LINKAGE_ID = "ListButton";
        static var ROLLOVER_ALPHA = 100;
        static var ROLLOUT_ALPHA = 50;
        static var ROLLOVER_COLOR = 3355443;
        static var ROLLOUT_COLOR = 6184542;
        static var PADDING = 10;
    }
