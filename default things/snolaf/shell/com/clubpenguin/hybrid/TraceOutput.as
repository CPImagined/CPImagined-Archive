//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.hybrid.TraceOutput
    {
        function TraceOutput () {
        }
        static function getInstance() {
            if (__instance == null) {
                __instance = new com.clubpenguin.hybrid.TraceOutput();
            }
            return(__instance);
        }
        function init(base_loc) {
            setBaseLoc(base_loc);
            setTextfield(base_loc.debugText);
            setScrollArrows();
            setupDragging();
            setupButtons();
            this.hide();
        }
        function setBaseLoc(base_loc) {
            __baseLoc = base_loc;
        }
        function setTextfield(text_field) {
            __textField = text_field;
        }
        function setScrollArrows() {
            __upArrow = __baseLoc.upArrow_mc;
            __downArrow = __baseLoc.downArrow_mc;
            __upArrow.useHandCursor = false;
            __downArrow.useHandCursor = false;
            __upArrow.onPress = mx.utils.Delegate.create(__instance, scrollUp);
            __downArrow.onPress = mx.utils.Delegate.create(__instance, scrollDown);
            __upArrow.onRelease = (__downArrow.onRelease = (__downArrow.onReleaseOutside = (__downArrow.onReleaseOutside = mx.utils.Delegate.create(__instance, stopScrolling))));
        }
        function setupDragging() {
            __dragHandle = __baseLoc.dragHandle_mc;
            __dragHandle.useHandCursor = false;
            __dragHandle.onPress = mx.utils.Delegate.create(__instance, startDragging);
            __dragHandle.onRelease = (__dragHandle.onReleaseOutside = mx.utils.Delegate.create(__instance, stopDragging));
        }
        function startDragging() {
            __baseLoc.startDrag();
        }
        function stopDragging() {
            __baseLoc.stopDrag();
        }
        function trace(msg, clear_traces, trace_graphic) {
            this.show();
            clear_traces = ((clear_traces != undefined) ? (clear_traces) : false);
            trace_graphic = ((trace_graphic != undefined) ? (trace_graphic) : (DEFAULT_TRACE_GRAPHIC));
            var _local_3 = getTraceGraphicLine(trace_graphic);
            var _local_2 = _local_3;
            _local_2 = _local_2 + _local_3;
            _local_2 = _local_2 + (msg + newline);
            _local_2 = _local_2 + _local_3;
            _local_2 = _local_2 + _local_3;
            if (clear_traces) {
                clearTraces();
                __textField.text = _local_2;
            } else {
                __textField.text = __textField.text + newline;
                __textField.text = __textField.text + _local_2;
            }
            __textField.scroll = __textField.maxscroll;
        }
        function clearTraces() {
            __textField.text = "";
        }
        function getTraceGraphicLine(trace_graphic) {
            var _local_2 = "";
            var _local_1 = 0;
            while (_local_1 < LINE_WIDTH) {
                _local_2 = _local_2 + trace_graphic;
                _local_1++;
            }
            _local_2 = _local_2 + newline;
            return(_local_2);
        }
        function hide() {
            __baseLoc._visible = false;
            __baseLoc.x = -2000;
        }
        function show() {
            __baseLoc._visible = true;
            __baseLoc.x = 0;
        }
        function scrollUp() {
            __upArrow.gotoAndStop(2);
            __scrollInterval = setInterval(__instance, SCROLL_METHOD, SCROLL_SPEED, UP);
        }
        function scrollDown() {
            __downArrow.gotoAndStop(2);
            __scrollInterval = setInterval(__instance, SCROLL_METHOD, SCROLL_SPEED, DOWN);
        }
        function scroll(scroll_dir) {
            if (scroll_dir == UP) {
                __textField.scroll--;
            } else {
                __textField.scroll++;
            }
        }
        function stopScrolling() {
            __upArrow.gotoAndStop(1);
            __downArrow.gotoAndStop(1);
            clearInterval(__scrollInterval);
        }
        function getCanvas() {
            return(__baseLoc);
        }
        function setupButtons() {
            __clearButton = __baseLoc.clearBtn;
            __closeButton = __baseLoc.closeBtn;
            __clearButton.onRelease = mx.utils.Delegate.create(this, clearTraces);
            __closeButton.onRelease = mx.utils.Delegate.create(this, hide);
        }
        static var DEFAULT_TRACE_GRAPHIC = "^";
        static var LINE_WIDTH = 45;
        static var SCROLL_SPEED = 100;
        static var UP = "up";
        static var DOWN = "down";
        static var SCROLL_METHOD = "scroll";
        static var __instance = null;
        var __baseLoc = null;
        var __textField = null;
        var __upArrow = null;
        var __downArrow = null;
        var __scrollInterval = null;
        var __dragHandle = null;
        var __clearButton = null;
        var __closeButton = null;
    }
