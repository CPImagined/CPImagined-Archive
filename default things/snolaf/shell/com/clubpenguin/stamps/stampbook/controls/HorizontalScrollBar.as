//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.stamps.stampbook.controls.HorizontalScrollBar extends MovieClip
    {
        var _x, _y, _scrollBarWidth, _scrollBarHeight, upBtn, downBtn, _yscale, _xscale, dispatchEvent;
        function HorizontalScrollBar () {
            super();
            com.clubpenguin.util.EventDispatcher.initialize(this);
        }
        function onLoad() {
            configUI();
        }
        function move(x, y) {
            _x = x;
            _y = y;
        }
        function setSize(w, h) {
            if ((_scrollBarWidth == w) && (_scrollBarHeight == h)) {
                return(undefined);
            }
            _scrollBarWidth = w;
            _scrollBarHeight = h;
            handleResize();
        }
        function configUI() {
            upBtn.addEventListener("press", onUpButtonPressed, this);
            downBtn.addEventListener("press", onDownButtonPressed, this);
        }
        function handleResize() {
            _yscale = 100;
            _xscale = 100;
            upBtn._x = upBtn._width / 2;
            upBtn._y = upBtn._height / 2;
            downBtn._x = _scrollBarWidth - (downBtn._width / 2);
            downBtn._y = downBtn._height / 2;
        }
        function onDownButtonPressed(event) {
            dispatchEvent({type:"down"});
        }
        function onUpButtonPressed(event) {
            dispatchEvent({type:"up"});
        }
        static var CLASS_REF = com.clubpenguin.stamps.stampbook.controls.HorizontalScrollBar;
        static var LINKAGE_ID = "HorizontalScrollBar";
    }
